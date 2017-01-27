/*--------------------------------------------------*/

#import "GLBDataViewCellCache.h"
#import "GLBDataViewCell.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#define GLB_DATA_VIEW_CACHE_PRELOAD

/*--------------------------------------------------*/

@interface GLBDataViewCellCache () {
#ifdef GLB_DATA_VIEW_CACHE_PRELOAD
    NSMutableDictionary< NSString*, NSNumber* >* _preload;
#endif
    NSMutableDictionary< NSString*, NSMutableArray< GLBDataViewCell* >* >* _cache;
}

@end

/*--------------------------------------------------*/


@implementation GLBDataViewCellCache

#pragma mark - Singleton

+ (instancetype)shared {
    static GLBDataViewCellCache* instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [self new];
    });
    return instance;
}

#pragma mark - Init / Free

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
#ifdef GLB_DATA_VIEW_CACHE_PRELOAD
    _preload = [NSMutableDictionary dictionaryWithDictionary:[NSUserDefaults.standardUserDefaults dictionaryForKey:self.glb_className]];
#endif
    _cache = [NSMutableDictionary dictionary];
    
#ifdef GLB_DATA_VIEW_CACHE_PRELOAD
    [_preload enumerateKeysAndObjectsUsingBlock:^(NSString* identifier, NSNumber* number, BOOL* stop) {
        NSLog(@"Preloaded: %@ (%@)", identifier, number);
    }];
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(_terminate)
                                               name:UIApplicationWillTerminateNotification
                                             object:nil];
#endif
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(_receiveMemoryWarning)
                                               name:UIApplicationDidReceiveMemoryWarningNotification
                                             object:nil];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

#pragma mark - Public

- (GLBDataViewCell*)dequeueCellClass:(Class)cellClass {
    NSString* identifier = NSStringFromClass(cellClass);
    NSMutableArray< GLBDataViewCell* >* cache = _cache[identifier];
#ifdef GLB_DATA_VIEW_CACHE_PRELOAD
    if(cache == nil) {
        NSNumber* preload = _preload[identifier];
        if(preload != nil) {
            NSUInteger preloadCount = preload.unsignedIntegerValue;
            cache = [NSMutableArray arrayWithCapacity:preloadCount];
            _cache[identifier] = cache;
            for(NSUInteger i = 0; i < preloadCount; i++) {
                GLBDataViewCell* cell = [cellClass new];
                if(cell != nil) {
                    [cache addObject:cell];
                }
            }
        }
    }
#endif
    GLBDataViewCell* cell = cache.lastObject;
    if(cell == nil) {
        cell = [cellClass new];
        if(cell != nil) {
            NSNumber* preload = _preload[identifier];
            _preload[identifier] = @(preload.unsignedIntegerValue + 1);
        }
    } else {
        [cache removeLastObject];
    }
    return cell;
}

- (void)enqueueCell:(GLBDataViewCell*)cell {
    NSString* identifier = NSStringFromClass(cell.class);
    NSMutableArray* cache = _cache[identifier];
    if(cache == nil) {
        _cache[identifier] = [NSMutableArray arrayWithObject:cell];
    } else {
        [cache addObject:cell];
    }
}

#pragma mark - Private

- (void)_receiveMemoryWarning {
    [_cache removeAllObjects];
}

#ifdef GLB_DATA_VIEW_CACHE_PRELOAD

- (void)_terminate {
    [NSUserDefaults.standardUserDefaults setObject:_preload forKey:self.glb_className];
}

#endif

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
