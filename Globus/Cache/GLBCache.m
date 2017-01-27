/*--------------------------------------------------*/

#import "GLBCache.h"

/*--------------------------------------------------*/

@interface GLBCache () {
    dispatch_queue_t _queue;
    NSMutableArray* _items;
}

@property(nonatomic, readonly, strong) NSString* filePath;
@property(nonatomic, assign) NSUInteger currentUsage;

- (void)_removeObsoleteItemsInViewOfReserveSize:(NSUInteger)reserveSize;
- (void)_removeObsoleteItems;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface GLBCacheItem : NSObject

@property(nonatomic, readonly, weak) GLBCache* cache;
@property(nonatomic, readonly, strong) NSString* fileName;
@property(nonatomic, readonly, strong) NSString* filePath;
@property(nonatomic, readonly, strong) NSData* data;
@property(nonatomic, readonly, assign) NSUInteger size;
@property(nonatomic, readonly, strong) NSDate* updateDate;

- (instancetype)initWithCache:(GLBCache*)cache fileName:(NSString*)fileName data:(NSData*)data;
- (instancetype)initWithCache:(GLBCache*)cache fileName:(NSString*)fileName attributes:(NSDictionary< NSString*, id >*)attributes;

- (void)updateData:(NSData*)data;
- (void)clear;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

static NSString* GLBCacheName = @"GLBCache";
static NSUInteger GLBCacheCapacity = (1024 * 1024) * 512;
static NSTimeInterval GLBCacheStorageInterval = ((60 * 60) * 24) * 90;

/*--------------------------------------------------*/

@implementation GLBCache

#pragma mark - Singleton

+ (instancetype)shared {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

#pragma mark - Init / Free

- (instancetype)init {
    return [self initWithName:GLBCacheName capacity:GLBCacheCapacity storageInterval:GLBCacheStorageInterval];
}

- (instancetype)initWithName:(NSString*)name {
    return [self initWithName:name capacity:GLBCacheCapacity storageInterval:GLBCacheStorageInterval];
}

- (instancetype)initWithName:(NSString*)name capacity:(NSUInteger)capacity {
    return [self initWithName:name capacity:capacity storageInterval:GLBCacheStorageInterval];
}

- (instancetype)initWithName:(NSString*)name capacity:(NSUInteger)capacity storageInterval:(NSTimeInterval)storageInterval {
    self = [super init];
    if(self != nil) {
        _name = [name stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        _capacity = capacity;
        _storageInterval = storageInterval;
        
        _queue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL);
        _filePath = [NSFileManager.glb_cachesDirectory stringByAppendingPathComponent:_name];
        _items = NSMutableArray.array;
        if([NSFileManager.defaultManager fileExistsAtPath:_filePath] == NO) {
            NSError* error = nil;
            BOOL success = [NSFileManager.defaultManager createDirectoryAtPath:_filePath withIntermediateDirectories:YES attributes:nil error:&error];
            if((success == NO) || (error != nil)) {
                NSLog(@"GLBCache::Init::Error %@", error);
            }
        } else {
            NSString* fileName = nil;
            NSDirectoryEnumerator* dirEnumerator = [NSFileManager.defaultManager enumeratorAtPath:_filePath];
            while((fileName = dirEnumerator.nextObject)) {
                GLBCacheItem* item = [[GLBCacheItem alloc] initWithCache:self fileName:fileName attributes:dirEnumerator.fileAttributes];
                if(item != nil) {
                    [_items addObject:item];
                }
            };
        }
        [self setup];
    }
    return self;
}

- (void)setup {
    [self _removeObsoleteItems];
}

- (void)dealloc {
}

#pragma mark - Property

- (void)setCapacity:(NSUInteger)capacity {
    if(_capacity != capacity) {
        BOOL needRemoveObsoleteItems = (_capacity > capacity);
        _capacity = capacity;
        if(needRemoveObsoleteItems == YES) {
            [self _removeObsoleteItems];
        }
    }
}

#pragma mark - Public

- (BOOL)existDataForKey:(NSString*)key {
    NSString* fileName = key.glb_stringByMD5;
    @synchronized(_items) {
        for(GLBCacheItem* item in _items) {
            if([item.fileName isEqualToString:fileName] == YES) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)setData:(NSData*)data forKey:(NSString*)key {
    NSString* fileName = key.glb_stringByMD5;
    @synchronized(_items) {
        GLBCacheItem* foundedItem = nil;
        for(GLBCacheItem* item in _items) {
            if([item.fileName isEqualToString:fileName] == YES) {
                foundedItem = item;
                break;
            }
        }
        if((_currentUsage + data.length) > _capacity) {
            [self _removeObsoleteItemsInViewOfReserveSize:data.length];
        }
        if(foundedItem == nil) {
            GLBCacheItem* newItem = [[GLBCacheItem alloc] initWithCache:self fileName:fileName data:data];
            if(newItem != nil) {
                [_items addObject:newItem];
            }
        } else {
            [foundedItem updateData:data];
        }
    }
}

- (void)setData:(NSData*)data forKey:(NSString*)key complete:(GLBCacheComplete)complete {
    dispatch_async(_queue, ^{
        [self setData:data forKey:key];
        if(complete != nil) {
            complete();
        }
    });
}

- (NSData*)dataForKey:(NSString*)key {
    NSData* result = nil;
    NSString* fileName = key.glb_stringByMD5;
    @synchronized(_items) {
        for(GLBCacheItem* item in _items) {
            if([item.fileName isEqualToString:fileName] == YES) {
                result = item.data;
                break;
            }
        }
    }
    return result;
}

- (void)dataForKey:(NSString*)key complete:(GLBCacheDataForKey)complete {
    if(complete != nil) {
        dispatch_async(_queue, ^{
            complete([self dataForKey:key]);
        });
    }
}

- (void)removeDataForKey:(NSString*)key {
    @synchronized(_items) {
        GLBCacheItem* foundedItem = nil;
        NSString* fileName = key.glb_stringByMD5;
        for(GLBCacheItem* item in _items) {
            if([item.fileName isEqualToString:fileName] == YES) {
                foundedItem = item;
                break;
            }
        }
        if(foundedItem != nil) {
            [foundedItem clear];
            [_items removeObject:foundedItem];
        }
    }
}

- (void)removeDataForKey:(NSString*)key complete:(GLBCacheComplete)complete {
    dispatch_async(_queue, ^{
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
                [item clear];
            }
            [_items removeAllObjects];
        }
    }
}

- (void)removeAllDataComplete:(GLBCacheComplete)complete {
    dispatch_async(_queue, ^{
        [self removeAllData];
        if(complete != nil) {
            complete();
        }
    });
}

#pragma mark - Private

- (void)_removeObsoleteItemsInViewOfReserveSize:(NSUInteger)reserveSize {
    NSUInteger currentUsage = reserveSize;
    if(_items.count > 0) {
        NSMutableArray* removedItems = NSMutableArray.array;
        [_items sortUsingComparator:^NSComparisonResult(GLBCacheItem* item1, GLBCacheItem* item2) {
            NSComparisonResult cr = [item1.updateDate compare:item2.updateDate];
            if(cr == NSOrderedSame) {
                if(item1.size > item2.size) {
                    cr = NSOrderedDescending;
                } else if(item1.size < item2.size) {
                    cr = NSOrderedAscending;
                }
            }
            return cr;
        }];
        NSDate* now = NSDate.date;
        for(GLBCacheItem* item in _items) {
            NSDate* itemRemoveDate = [item.updateDate dateByAddingTimeInterval:_storageInterval];
            if([itemRemoveDate glb_isEarlier:now] == YES) {
                [removedItems addObject:item];
            } else if((currentUsage + item.size) > _capacity) {
                [removedItems addObject:item];
            } else {
                currentUsage += item.size;
            }
        }
        if(removedItems.count > 0) {
            for(GLBCacheItem* item in removedItems) {
                [item clear];
            }
            [_items removeObjectsInArray:removedItems];
        }
    }
    _currentUsage = currentUsage;
}

- (void)_removeObsoleteItems {
    [self _removeObsoleteItemsInViewOfReserveSize:0];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBCacheItem

#pragma mark - Synthesize

@synthesize cache = _cache;
@synthesize fileName = _fileName;
@synthesize filePath = _filePath;
@synthesize size = _size;
@synthesize updateDate = _updateDate;

#pragma mark - Init / Free

- (instancetype)initWithCache:(GLBCache*)cache fileName:(NSString*)fileName data:(NSData*)data {
    self = [super init];
    if(self != nil) {
        _cache = cache;
        _fileName = fileName;
        _filePath = [cache.filePath stringByAppendingPathComponent:_fileName];
        if([data writeToFile:_filePath atomically:YES] == YES) {
            _size = data.length;
            _updateDate = NSDate.date;
            _cache.currentUsage += _size;
        } else {
            self = nil;
        }
    }
    return self;
}

- (instancetype)initWithCache:(GLBCache*)cache fileName:(NSString*)fileName attributes:(NSDictionary< NSString*, id >*)attributes {
    self = [super init];
    if(self != nil) {
        _cache = cache;
        _fileName = fileName;
        _filePath = [cache.filePath stringByAppendingPathComponent:fileName];
        _size = (NSUInteger)attributes.fileSize;
        _updateDate = attributes.fileModificationDate;
        _cache.currentUsage += _size;
    }
    return self;
}

#pragma mark - Property

- (NSData*)data {
    return [NSData dataWithContentsOfFile:_filePath];
}

#pragma mark - Private

- (void)updateData:(NSData*)data {
    if([data writeToFile:_filePath atomically:YES] == YES) {
        _cache.currentUsage += (_size - data.length);
        _size = data.length;
        _updateDate = NSDate.date;
    }
}

- (void)clear {
    if([NSFileManager.defaultManager removeItemAtPath:_filePath error:nil] == YES) {
        _cache.currentUsage -= _size;
    }
}

@end

/*--------------------------------------------------*/
