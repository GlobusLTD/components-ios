/*--------------------------------------------------*/

#import "GLBCache.h"
#import "GLBTimer.h"
#import "GLBModel.h"
#import "GLBCG.h"
#import "NSString+GLBNS.h"
#import "NSBundle+GLBNS.h"
#import "NSFileManager+GLBNS.h"

/*--------------------------------------------------*/

#if defined(GLB_TARGET_IOS)
#import <UIKit/UIKit.h>
#endif

/*--------------------------------------------------*/

@interface GLBCache ()

@property(nonatomic, copy) NSString* name;
@property(nonatomic, strong) NSString* fileName;
@property(nonatomic, strong) NSString* filePath;
@property(nonatomic) NSTimeInterval memoryStorageInterval;
@property(nonatomic) NSTimeInterval discStorageInterval;
@property(nonatomic) NSUInteger currentMemoryUsage;
@property(nonatomic) NSUInteger currentDiscUsage;

@property(nonatomic, strong) GLBTimer* timer;
@property(nonatomic, strong) NSMutableArray* items;

- (void)_removeObsoleteItemsInViewOfReserveSize:(NSUInteger)reserveSize;
- (void)_removeObsoleteItems;
- (void)_saveItems;

- (void)_notificationReceiveMemoryWarning:(NSNotification*)notification;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface GLBCacheItem : GLBModel

@property(nonatomic, weak) GLBCache* cache;
@property(nonatomic, strong) NSString* key;
@property(nonatomic, strong) NSString* fileName;
@property(nonatomic, readonly, strong) NSString* filePath;
@property(nonatomic, readonly, strong) NSData* data;
@property(nonatomic, readonly, assign) NSUInteger size;
@property(nonatomic, readonly, assign) NSTimeInterval memoryStorageInterval;
@property(nonatomic, readonly, assign) NSTimeInterval memoryStorageTime;
@property(nonatomic, readonly, assign) NSTimeInterval discStorageInterval;
@property(nonatomic, readonly, assign) NSTimeInterval discStorageTime;
@property(nonatomic, readonly, assign, getter=isInMemory) BOOL inMemory;

- (instancetype)initWithCache:(GLBCache*)cache key:(NSString*)key data:(NSData*)data memoryStorageInterval:(NSTimeInterval)memoryStorageInterval discStorageInterval:(NSTimeInterval)discStorageInterval;

- (void)updateData:(NSData*)data memoryStorageInterval:(NSTimeInterval)memoryStorageInterval discStorageInterval:(NSTimeInterval)discStorageInterval;

- (void)saveToDiscCache;
- (void)clearFromMemoryCache;
- (void)clearFromDiscCache;
- (void)clearFromAllCache;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

#define GLB_CACHE_NAME                           @"GLBCache"
#define GLB_CACHE_EXTENSION                      @"cache"
#define GLB_CACHE_MEMORY_CAPACITY                (1024 * 1024) * 30
#define GLB_CACHE_MEMORY_STORAGE_INTERVAL        (60 * 10)
#define GLB_CACHE_DISC_CAPACITY                  (1024 * 1024) * 500
#define GLB_CACHE_DISC_STORAGE_INTERVAL          ((60 * 60) * 24) * 90

/*--------------------------------------------------*/

@implementation GLBCache

#pragma mark - Singleton

+ (instancetype)shared {
    static id shared = nil;
    if(shared == nil) {
        @synchronized(self) {
            if(shared == nil) {
                NSBundle* bundle = NSBundle.mainBundle;
                NSString* name = [bundle glb_objectForInfoDictionaryKey:@"GLBCacheName" defaultValue:GLB_CACHE_NAME];
                NSNumber* memoryCapacity = [bundle glb_objectForInfoDictionaryKey:@"GLBCacheMemoryCapacity" defaultValue:@(GLB_CACHE_MEMORY_CAPACITY)];
                NSNumber* memoryStorageInterval = [bundle glb_objectForInfoDictionaryKey:@"GLBCacheMemoryStorageInterval" defaultValue:@(GLB_CACHE_MEMORY_STORAGE_INTERVAL)];
                NSNumber* discCapacity = [bundle glb_objectForInfoDictionaryKey:@"GLBCacheDiscCapacity" defaultValue:@(GLB_CACHE_DISC_CAPACITY)];
                NSNumber* discStorageInterval = [bundle glb_objectForInfoDictionaryKey:@"GLBCacheDiscStorageInterval" defaultValue:@(GLB_CACHE_DISC_STORAGE_INTERVAL)];
                shared = [[self alloc] initWithName:name memoryCapacity:memoryCapacity.unsignedIntegerValue memoryStorageInterval:memoryStorageInterval.doubleValue discCapacity:discCapacity.unsignedIntegerValue discStorageInterval:discStorageInterval.doubleValue];
            }
        }
    }
    return shared;
}

#pragma mark - Init / Free

- (instancetype)init {
    return [self initWithName:GLB_CACHE_NAME memoryCapacity:GLB_CACHE_MEMORY_CAPACITY memoryStorageInterval:GLB_CACHE_MEMORY_STORAGE_INTERVAL discCapacity:GLB_CACHE_DISC_CAPACITY discStorageInterval:GLB_CACHE_DISC_STORAGE_INTERVAL];
}

- (instancetype)initWithName:(NSString*)name {
    return [self initWithName:name memoryCapacity:GLB_CACHE_MEMORY_CAPACITY memoryStorageInterval:GLB_CACHE_MEMORY_STORAGE_INTERVAL discCapacity:GLB_CACHE_DISC_CAPACITY discStorageInterval:GLB_CACHE_DISC_STORAGE_INTERVAL];
}

- (instancetype)initWithName:(NSString*)name memoryCapacity:(NSUInteger)memoryCapacity discCapacity:(NSUInteger)discCapacity {
    return [self initWithName:name memoryCapacity:memoryCapacity memoryStorageInterval:GLB_CACHE_MEMORY_STORAGE_INTERVAL discCapacity:discCapacity discStorageInterval:GLB_CACHE_DISC_STORAGE_INTERVAL];
}

- (instancetype)initWithName:(NSString*)name memoryCapacity:(NSUInteger)memoryCapacity memoryStorageInterval:(NSTimeInterval)memoryStorageInterval discCapacity:(NSUInteger)discCapacity discStorageInterval:(NSTimeInterval)discStorageInterval {
    self = [super init];
    if(self != nil) {
        _name = name;
        _fileName = [[[_name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString] glb_stringByMD5];
        _filePath = [NSFileManager.glb_cachesDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", _fileName, GLB_CACHE_EXTENSION]];
        _memoryCapacity = (memoryCapacity > discCapacity) ? discCapacity : memoryCapacity;
        _memoryStorageInterval = (memoryStorageInterval > discStorageInterval) ? discStorageInterval : memoryStorageInterval;
        _discCapacity = (discCapacity > memoryCapacity) ? discCapacity : memoryCapacity;
        _discStorageInterval = (discStorageInterval > memoryStorageInterval) ? discStorageInterval : memoryStorageInterval;
        _timer = [GLBTimer timerWithInterval:MIN(_memoryStorageInterval, _discStorageInterval) repeat:NSNotFound];
        _items = NSMutableArray.array;
        if([NSFileManager.defaultManager fileExistsAtPath:_filePath] == YES) {
            id items = [NSKeyedUnarchiver unarchiveObjectWithFile:_filePath];
            if([items isKindOfClass:NSArray.class] == YES) {
                _items.array = items;
            }
        }
        for(GLBCacheItem* item in _items) {
            item.cache = self;
        }
        [self _removeObsoleteItems];
        [self setup];
    }
    return self;
}

- (void)setup {
#if defined(GLB_TARGET_IOS)
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(_notificationReceiveMemoryWarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
#endif

    if(_timer != nil) {
        _timer.actionRepeat = [GLBAction actionWithTarget:self action:@selector(timerDidRepeat:)];
        [_timer start];
    }
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

#pragma mark - Property

- (void)setMemoryCapacity:(NSUInteger)memoryCapacity {
    if(_memoryCapacity != memoryCapacity) {
        BOOL needRemoveObsoleteItems = (_memoryCapacity > memoryCapacity);
        _memoryCapacity = memoryCapacity;
        if(needRemoveObsoleteItems == YES) {
            [self _removeObsoleteItems];
        }
    }
}

- (void)setDiscCapacity:(NSUInteger)discCapacity {
    if(_discCapacity != discCapacity) {
        BOOL needRemoveObsoleteItems = (_discCapacity > discCapacity);
        _discCapacity = discCapacity;
        if(needRemoveObsoleteItems == YES) {
            [self _removeObsoleteItems];
        }
    }
}

#pragma mark - Public

- (void)setData:(NSData*)data forKey:(NSString*)key {
    [self setData:data forKey:key memoryStorageInterval:_memoryStorageInterval discStorageInterval:_discStorageInterval];
}

- (void)setData:(NSData*)data forKey:(NSString*)key complete:(GLBCacheComplete)complete {
    [self setData:data forKey:key memoryStorageInterval:_memoryStorageInterval discStorageInterval:_discStorageInterval complete:complete];
}

- (void)setData:(NSData*)data forKey:(NSString*)key memoryStorageInterval:(NSTimeInterval)memoryStorageInterval {
    [self setData:data forKey:key memoryStorageInterval:memoryStorageInterval discStorageInterval:_discStorageInterval];
}

- (void)setData:(NSData*)data forKey:(NSString*)key memoryStorageInterval:(NSTimeInterval)memoryStorageInterval complete:(GLBCacheComplete)complete {
    [self setData:data forKey:key memoryStorageInterval:memoryStorageInterval discStorageInterval:_discStorageInterval complete:complete];
}

- (void)setData:(NSData*)data forKey:(NSString*)key discStorageInterval:(NSTimeInterval)discStorageInterval {
    [self setData:data forKey:key memoryStorageInterval:_memoryStorageInterval discStorageInterval:discStorageInterval];
}

- (void)setData:(NSData*)data forKey:(NSString*)key discStorageInterval:(NSTimeInterval)discStorageInterval complete:(GLBCacheComplete)complete {
    [self setData:data forKey:key memoryStorageInterval:_memoryStorageInterval discStorageInterval:discStorageInterval complete:complete];
}

- (void)setData:(NSData*)data forKey:(NSString*)key memoryStorageInterval:(NSTimeInterval)memoryStorageInterval discStorageInterval:(NSTimeInterval)discStorageInterval {
    @synchronized(_items) {
        GLBCacheItem* foundedItem = nil;
        for(GLBCacheItem* item in _items) {
            if([item.key isEqualToString:key] == YES) {
                foundedItem = item;
                break;
            }
        }
        if(((_currentMemoryUsage + data.length) > _memoryCapacity) || ((_currentDiscUsage + data.length) > _discCapacity)) {
            [self _removeObsoleteItemsInViewOfReserveSize:data.length];
        }
        if(foundedItem == nil) {
            [_items addObject:[[GLBCacheItem alloc] initWithCache:self key:key data:data memoryStorageInterval:(memoryStorageInterval > discStorageInterval) ? discStorageInterval : memoryStorageInterval discStorageInterval:discStorageInterval]];
        } else {
            [foundedItem updateData:data memoryStorageInterval:(memoryStorageInterval > discStorageInterval) ? discStorageInterval : memoryStorageInterval discStorageInterval:discStorageInterval];
        }
        [self _saveItems];
    }
}

- (void)setData:(NSData*)data forKey:(NSString*)key memoryStorageInterval:(NSTimeInterval)memoryStorageInterval discStorageInterval:(NSTimeInterval)discStorageInterval complete:(GLBCacheComplete)complete {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self setData:data forKey:key memoryStorageInterval:memoryStorageInterval discStorageInterval:discStorageInterval];
        if(complete != nil) {
            complete();
        }
    });
}

- (NSData*)dataForKey:(NSString*)key {
    NSData* result = nil;
    @synchronized(_items) {
        for(GLBCacheItem* item in _items) {
            if([item.key isEqualToString:key] == YES) {
                result = item.data;
                break;
            }
        }
    }
    return result;
}

- (void)dataForKey:(NSString*)key complete:(GLBCacheDataForKey)complete {
    if(complete != nil) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            complete([self dataForKey:key]);
        });
    }
}

- (void)removeDataForKey:(NSString*)key {
    @synchronized(_items) {
        GLBCacheItem* foundedItem = nil;
        for(GLBCacheItem* item in _items) {
            if([item.key isEqualToString:key] == YES) {
                foundedItem = item;
                break;
            }
        }
        if(foundedItem != nil) {
            [foundedItem clearFromAllCache];
            [_items removeObject:foundedItem];
            [self _saveItems];
        }
    }
}

- (void)removeDataForKey:(NSString*)key complete:(GLBCacheComplete)complete {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self removeDataForKey:key];
        if(complete != nil) {
            complete();
        }
    });
}

- (void)removeAllData {
    @synchronized(_items) {
        if(_items.count > 0) {
            for(GLBCacheItem* item in _items) {
                [item clearFromAllCache];
            }
            [_items removeAllObjects];
            [self _saveItems];
        }
    }
}

- (void)removeAllDataComplete:(GLBCacheComplete)complete {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self removeAllData];
        if(complete != nil) {
            complete();
        }
    });
}

#pragma mark - Private

- (void)_removeObsoleteItemsInViewOfReserveSize:(NSUInteger)reserveSize {
    NSUInteger currentMemoryUsage = 0;
    NSUInteger currentDiscUsage = 0;
    if(_items.count > 0) {
        NSTimeInterval now = NSDate.timeIntervalSinceReferenceDate;
        NSMutableArray* removedMemoryItems = NSMutableArray.array;
        NSMutableArray* removedDiscItems = NSMutableArray.array;
        [_items sortUsingComparator:^NSComparisonResult(GLBCacheItem* item1, GLBCacheItem* item2) {
            if(item1.discStorageTime > item2.discStorageTime) {
                return NSOrderedDescending;
            } else if(item1.discStorageTime < item2.discStorageTime) {
                return NSOrderedAscending;
            } else {
                if(item1.memoryStorageTime > item2.memoryStorageTime) {
                    return NSOrderedDescending;
                } else if(item1.memoryStorageTime < item2.memoryStorageTime) {
                    return NSOrderedAscending;
                } else {
                    if(item1.size > item2.size) {
                        return NSOrderedDescending;
                    } else if(item1.size < item2.size) {
                        return NSOrderedAscending;
                    }
                }
            }
            return NSOrderedSame;
        }];
        for(GLBCacheItem* item in _items) {
            if((item.discStorageTime > now) && (((currentDiscUsage + reserveSize) + item.size) <= _discCapacity)) {
                if((item.memoryStorageTime > now) && (((currentMemoryUsage + reserveSize) + item.size) <= _memoryCapacity)) {
                    if([item isInMemory] == YES) {
                        currentMemoryUsage += item.size;
                    }
                } else {
                    [removedMemoryItems addObject:item];
                }
                currentDiscUsage += item.size;
            } else {
                [removedDiscItems addObject:item];
            }
        }
        if(removedMemoryItems.count > 0) {
            for(GLBCacheItem* item in removedMemoryItems) {
                [item clearFromMemoryCache];
            }
        }
        if(removedDiscItems.count > 0) {
            for(GLBCacheItem* item in removedDiscItems) {
                [item clearFromAllCache];
            }
            [_items removeObjectsInArray:removedDiscItems];
            [self _saveItems];
        }
    }
    self.currentMemoryUsage = currentMemoryUsage;
    self.currentDiscUsage = currentDiscUsage;
}

- (void)_removeObsoleteItems {
    [self _removeObsoleteItemsInViewOfReserveSize:0];
}

- (void)_saveItems {
    [NSKeyedArchiver archiveRootObject:_items toFile:_filePath];
}

#pragma mark - NSNotificationCenter

- (void)_notificationReceiveMemoryWarning:(NSNotification* __unused)notification {
    for(GLBCacheItem* item in _items) {
        [item clearFromMemoryCache];
    }
    self.currentMemoryUsage = 0;
}

#pragma mark - GLBTimerDelegate

-(void)timerDidRepeat:(GLBTimer* __unused)timer {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self _removeObsoleteItems];
    });
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

#define GLB_CACHE_ITEM_EXTENSION                 @"data"

/*--------------------------------------------------*/

@implementation GLBCacheItem

#pragma mark - Synthesize

@synthesize cache = _cache;
@synthesize key = _key;
@synthesize fileName = _fileName;
@synthesize filePath = _filePath;
@synthesize data = _data;
@synthesize size = _size;
@synthesize memoryStorageInterval = _memoryStorageInterval;
@synthesize memoryStorageTime =_memoryStorageTime;
@synthesize discStorageInterval = _discStorageInterval;
@synthesize discStorageTime = _discStorageTime;
@synthesize inMemory = _inMemory;

#pragma mark - Init / Free

- (instancetype)initWithCache:(GLBCache*)cache key:(NSString*)key data:(NSData*)data memoryStorageInterval:(NSTimeInterval)memoryStorageInterval discStorageInterval:(NSTimeInterval)discStorageInterval {
    self = [super init];
    if(self != nil) {
        _cache = cache;
        _key = [key stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _fileName = _key.lowercaseString.glb_stringByMD5;
        _filePath = [NSFileManager.glb_cachesDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", _fileName, GLB_CACHE_ITEM_EXTENSION]];
        _data = data;
        _size = _data.length;
        _memoryStorageInterval = memoryStorageInterval;
        _memoryStorageTime = GLB_CEIL(NSDate.timeIntervalSinceReferenceDate + memoryStorageInterval);
        _discStorageInterval = discStorageInterval;
        _discStorageTime = GLB_CEIL(NSDate.timeIntervalSinceReferenceDate + discStorageInterval);
        
        _cache.currentMemoryUsage = _cache.currentMemoryUsage + _size;
        [self saveToDiscCache];
    }
    return self;
}

- (void)dealloc {
    [self clearFromMemoryCache];
}

#pragma mark - GLBModel

+ (NSArray*)compareMap {
    return @[
        @"key",
    ];
}

+ (NSArray*)serializeMap {
    return @[
        @"key",
        @"fileName",
        @"size",
        @"memoryStorageInterval",
        @"memoryStorageTime",
        @"discStorageInterval",
        @"discStorageTime"
    ];
}

#pragma mark - Property

- (void)setFileName:(NSString*)fileName {
    if([_fileName isEqualToString:fileName] == NO) {
        _fileName = fileName;
        if(_fileName != nil) {
            _filePath = [NSFileManager.glb_cachesDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", _fileName, GLB_CACHE_ITEM_EXTENSION]];
        } else {
            _filePath = nil;
        }
    }
}

- (NSData*)data {
    if((_data == nil) && (_filePath != nil)) {
        _data = [NSData dataWithContentsOfFile:_filePath];
        if(_data != nil) {
            _cache.currentMemoryUsage = _cache.currentMemoryUsage + _size;
        }
    }
    return _data;
}

- (BOOL)isInMemory {
    return (_data != nil);
}

#pragma mark - Private

- (void)updateData:(NSData*)data memoryStorageInterval:(NSTimeInterval)memoryStorageInterval discStorageInterval:(NSTimeInterval)discStorageInterval {
    _cache.currentMemoryUsage = _cache.currentMemoryUsage - _size;
    _data = data;
    _size = data.length;
    _cache.currentMemoryUsage = _cache.currentMemoryUsage + _size;
    _memoryStorageInterval = memoryStorageInterval;
    _memoryStorageTime = GLB_CEIL(NSDate.timeIntervalSinceReferenceDate + memoryStorageInterval);
    _discStorageInterval = discStorageInterval;
    _discStorageTime = GLB_CEIL(NSDate.timeIntervalSinceReferenceDate + discStorageInterval);
    [self saveToDiscCache];
}

- (void)saveToDiscCache {
    if([_data writeToFile:_filePath atomically:YES] == YES) {
        _cache.currentDiscUsage = _cache.currentDiscUsage + _size;
    }
}

- (void)clearFromMemoryCache {
    _cache.currentMemoryUsage = _cache.currentMemoryUsage - _size;
    _data = nil;
}

- (void)clearFromDiscCache {
    if([NSFileManager.defaultManager removeItemAtPath:_filePath error:nil] == YES) {
        _cache.currentDiscUsage = _cache.currentDiscUsage - _size;
    }
}

- (void)clearFromAllCache {
    [self clearFromMemoryCache];
    [self clearFromDiscCache];
}

@end

/*--------------------------------------------------*/
