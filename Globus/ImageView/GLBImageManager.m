/*--------------------------------------------------*/

#import "GLBImageManager.h"
#import "GLBImageDownloadRequest.h"
#import "GLBImageDownloadResponse.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBImageManager () {
    dispatch_queue_t _queue;
    NSOperationQueue* _operationQueue;
    NSMutableDictionary* _imagesCache;
}

@end

/*--------------------------------------------------*/

@interface GLBImageManagerOperation : NSOperation {
    __weak GLBImageManager* _manager;
    NSMutableArray< id< GLBImageManagerTarget > >* _targets;
    NSURL* _url;
    NSString* _processing;
}

@property(nonatomic, weak) GLBImageManager* manager;
@property(nonatomic, strong) NSURL* url;
@property(nonatomic, strong) NSString* processing;

- (instancetype)initWithManager:(GLBImageManager*)manager target:(id< GLBImageManagerTarget >)target url:(NSURL*)url processing:(NSString*)processing;

- (void)addTarget:(id< GLBImageManagerTarget >)target;
- (void)removeTarget:(id< GLBImageManagerTarget >)target;
- (BOOL)containsTarget:(id< GLBImageManagerTarget >)target;

@end

/*--------------------------------------------------*/

@interface GLBImageManagerCacheOperation : GLBImageManagerOperation
@end

/*--------------------------------------------------*/

@interface GLBImageManagerDownloadOperation : GLBImageManagerOperation {
    dispatch_semaphore_t _semaphore;
    GLBImageDownloadRequest* _request;
}

@end

/*--------------------------------------------------*/

static NSUInteger GLBImageManagerDefaultMemoryCapacity = (1024 * 1024) * 4;
static NSUInteger GLBImageManagerDefaultDiscCapacity = (1024 * 1024) * 512;

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBImageManager

#pragma mark - Synthesize

@synthesize provider = _provider;
@synthesize urlCache = _urlCache;
@synthesize durableCache = _durableCache;

#pragma mark - Singleton

+ (instancetype)defaultImageManager {
    static GLBImageManager* instance = nil;
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
    _queue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL);
    
    _operationQueue = [NSOperationQueue new];
    _operationQueue.maxConcurrentOperationCount = 5;
    
    _imagesCache = [NSMutableDictionary dictionary];
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(_receiveMemoryWarning:)
                                               name:UIApplicationDidReceiveMemoryWarningNotification
                                             object:nil];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

#pragma mark - Property

- (GLBApiProvider*)provider {
    @synchronized(self) {
        if(_provider == nil) {
            _provider = [[GLBApiProvider alloc] initWithName:self.glb_className];
            _provider.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
            _provider.cache = self.urlCache;
        }
    }
    return _provider;
}

- (NSURLCache*)urlCache {
    @synchronized(self) {
        if(_urlCache == nil) {
            _urlCache = [[NSURLCache alloc] initWithMemoryCapacity:GLBImageManagerDefaultMemoryCapacity
                                                      diskCapacity:GLBImageManagerDefaultDiscCapacity
                                                          diskPath:nil];
        }
    }
    return _urlCache;
}

- (GLBCache*)durableCache {
    @synchronized(self) {
        if(_durableCache == nil) {
            _durableCache = [GLBCache shared];
        }
    }
    return _durableCache;
}

#pragma mark - Public

- (BOOL)existImageByUrl:(NSURL*)url {
    NSString* uniqueKey = url.absoluteString;
    return [self.durableCache existDataForKey:uniqueKey];
}

- (BOOL)existImageByUrl:(NSURL*)url processing:(NSString*)processing {
    NSString* uniqueKey = url.absoluteString;
    if(processing != nil) {
        uniqueKey = [processing stringByAppendingString:uniqueKey];
    }
    return [self.durableCache existDataForKey:uniqueKey];
}

- (UIImage*)imageByUrl:(NSURL*)url {
    return [self imageByUrl:url processing:nil];
}

- (UIImage*)imageByUrl:(NSURL*)url processing:(NSString*)processing {
    NSString* uniqueKey = [self _uniqueKeyWithUrl:url processing:processing];
    UIImage* image = nil;
    @synchronized(self) {
        image = _imagesCache[uniqueKey];
    }
    if(image == nil) {
        NSData* data = [self.durableCache dataForKey:uniqueKey];
        if(data != nil) {
            image = [self _imageWithData:data];
            if(image != nil) {
                @synchronized(self) {
                    _imagesCache[uniqueKey] = image;
                }
            } else {
                [self.durableCache removeDataForKey:uniqueKey];
            }
        }
    }
    return image;
}

- (void)imageByUrl:(NSURL*)url complete:(GLBImageDownloadImageBlock)complete {
    [self imageByUrl:url processing:nil complete:complete];
}

- (void)imageByUrl:(NSURL*)url processing:(NSString*)processing complete:(GLBImageDownloadImageBlock)complete {
    if(complete == nil) {
        return;
    }
    NSString* uniqueKey = [self _uniqueKeyWithUrl:url processing:processing];
    UIImage* existImage = nil;
    @synchronized(self) {
        existImage = _imagesCache[uniqueKey];
    }
    if(existImage == nil) {
    } else {
        complete(existImage);
    }
    __weak typeof(self) weakSelf = self;
    [self.durableCache dataForKey:uniqueKey complete:^(NSData* data) {
        [weakSelf _imageByData:data uniqueKey:uniqueKey complete:complete];
    }];
}

- (void)setImage:(UIImage*)image url:(NSURL*)url complete:(GLBSimpleBlock)complete {
    [self setImage:image url:url processing:nil complete:complete];
}

- (void)setImage:(UIImage*)image url:(NSURL*)url processing:(NSString*)processing complete:(GLBSimpleBlock)complete {
    if(complete == nil) {
        return;
    }
    NSString* uniqueKey = [self _uniqueKeyWithUrl:url processing:processing];
    __weak typeof(self) weakSelf = self;
    dispatch_async(_queue, ^{
        [weakSelf _setImage:image uniqueKey:uniqueKey complete:complete];
    });
}

- (void)removeImageByUrl:(NSURL*)url complete:(GLBSimpleBlock)complete {
    [self removeImageByUrl:url processing:nil complete:complete];
}

- (void)removeImageByUrl:(NSURL*)url processing:(NSString*)processing complete:(GLBSimpleBlock)complete {
    if(complete == nil) {
        return;
    }
    NSString* uniqueKey = [self _uniqueKeyWithUrl:url processing:processing];
    __weak typeof(self) weakSelf = self;
    [self.durableCache removeDataForKey:uniqueKey complete:^{
        [weakSelf _removeImageByUniqueKey:uniqueKey complete:complete];
    }];
}

- (void)cleanupImagesComplete:(GLBSimpleBlock)complete {
    if(complete == nil) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [self.durableCache removeAllDataComplete:^{
        [weakSelf _cleanupImagesComplete:complete];
    }];
}

- (void)imageByUrl:(NSURL*)url target:(id< GLBImageManagerTarget >)target {
    [self imageByUrl:url processing:nil target:target];
}

- (void)imageByUrl:(NSURL*)url processing:(NSString*)processing target:(id< GLBImageManagerTarget >)target {
    if((url == nil) || (target == nil)) {
        return;
    }
    GLBImageManagerOperation* existOperation = nil;
    @synchronized(self) {
        _operationQueue.suspended = YES;
        for(GLBImageManagerOperation* operation in _operationQueue.operations) {
            if(operation.isCancelled == YES) {
                continue;
            }
            if([url isEqual:operation.url] == YES) {
                if(processing == operation.processing) {
                    existOperation = operation;
                    break;
                } else if([processing isEqualToString:operation.processing] == YES) {
                    existOperation = operation;
                    break;
                }
            }
        }
        _operationQueue.suspended = NO;
    }
    if(existOperation == nil) {
        GLBImageManagerOperation* newOperation = nil;
        if([self existImageByUrl:url] == YES) {
            newOperation = [[GLBImageManagerCacheOperation alloc] initWithManager:self
                                                                           target:target
                                                                              url:url
                                                                       processing:processing];
        } else {
            newOperation = [[GLBImageManagerDownloadOperation alloc] initWithManager:self
                                                                              target:target
                                                                                 url:url
                                                                          processing:processing];
        }
        if(newOperation != nil) {
            @synchronized(self) {
                _operationQueue.suspended = YES;
                [_operationQueue addOperation:newOperation];
                _operationQueue.suspended = NO;
            }
        }
    } else {
        [existOperation addTarget:target];
    }
}

- (void)cancelByTarget:(id< GLBImageManagerTarget >)target {
    @synchronized(self) {
        _operationQueue.suspended = YES;
        for(GLBImageManagerOperation* operation in _operationQueue.operations) {
            if([operation containsTarget:target] == YES) {
                [operation removeTarget:target];
            }
        }
        _operationQueue.suspended = NO;
    }
}

#pragma mark - Private

- (void)_imageByData:(NSData*)data uniqueKey:(NSString*)uniqueKey complete:(GLBImageDownloadImageBlock)complete {
    UIImage* image = [self _imageWithData:data];
    if(image != nil) {
        @synchronized(self) {
            _imagesCache[uniqueKey] = image;
        }
    } else {
        [self.durableCache removeDataForKey:uniqueKey];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        complete(image);
    });
}

- (void)_setImage:(UIImage*)image uniqueKey:(NSString*)uniqueKey complete:(GLBSimpleBlock)complete {
    NSData* data = [self _dataWithImage:image];
    [self.durableCache setData:data forKey:uniqueKey];
    @synchronized(self) {
        _imagesCache[uniqueKey] = image;
    }
    dispatch_async(dispatch_get_main_queue(), complete);
}

- (void)_removeImageByUniqueKey:(NSString*)uniqueKey complete:(GLBSimpleBlock)complete {
    @synchronized(self) {
        [_imagesCache removeObjectForKey:uniqueKey];
    }
    dispatch_async(dispatch_get_main_queue(), complete);
}

- (void)_cleanupImagesComplete:(GLBSimpleBlock)complete {
    @synchronized(self) {
        [_imagesCache removeAllObjects];
    }
    dispatch_async(dispatch_get_main_queue(), complete);
}

- (void)_setImage:(UIImage*)image data:(NSData*)data url:(NSURL*)url {
    [self _setImage:image data:data url:url processing:nil];
}

- (void)_setImage:(UIImage*)image data:(NSData*)data url:(NSURL*)url processing:(NSString*)processing {
    NSString* uniqueKey = [self _uniqueKeyWithUrl:url processing:processing];
    [self.durableCache setData:data forKey:uniqueKey];
    @synchronized(self) {
        _imagesCache[uniqueKey] = image;
    }
}

- (NSString*)_uniqueKeyWithUrl:(NSURL*)url processing:(NSString*)processing {
    NSString* uniqueKey = url.absoluteString;
    if(processing != nil) {
        uniqueKey = [processing stringByAppendingString:uniqueKey];
    };
    return uniqueKey;
}

- (NSData*)_dataWithImage:(UIImage*)image {
    if(image.images.count > 0) {
        return GLBImageGIFRepresentation(image, 0, nil);
    }
    return UIImagePNGRepresentation(image);
}

- (UIImage*)_imageWithData:(NSData*)data {
    if(GLBImageIsGifData(data) == YES) {
        return GLBImageWithGIFDataDefault(data);
    }
    return [UIImage glb_imageWithData:data];
}

#pragma mark - NSNotificationCenter

- (void)_receiveMemoryWarning:(NSNotification*)notification {
    @synchronized(self) {
        [_imagesCache removeAllObjects];
    }
}

@end

/*--------------------------------------------------*/

@implementation GLBImageManagerOperation

#pragma mark - Synthesize

@synthesize manager = _manager;
@synthesize url = _url;

#pragma mark - Init / Free

- (instancetype)initWithManager:(GLBImageManager*)manager target:(id< GLBImageManagerTarget >)target url:(NSURL*)url processing:(NSString*)processing {
    self = [super init];
    if(self != nil) {
        _manager = manager;
        _targets = [NSMutableArray arrayWithObject:target];
        _url = url;
        _processing = processing;
    }
    return self;
}

#pragma mark - Public

- (void)addTarget:(id< GLBImageManagerTarget >)target {
    @synchronized(self) {
        [_targets addObject:target];
    }
}

- (void)removeTarget:(id< GLBImageManagerTarget >)target {
    @synchronized(self) {
        [_targets removeObject:target];
        if(_targets.count < 1) {
            [self cancel];
        }
    }
}

- (BOOL)containsTarget:(id< GLBImageManagerTarget >)target {
    BOOL result = NO;
    @synchronized(self) {
        result =  [_targets containsObject:target];
    }
    return result;
}

@end

/*--------------------------------------------------*/

@implementation GLBImageManagerCacheOperation

#pragma mark - Public

- (void)main {
    @autoreleasepool {
        if(self.isCancelled == YES) {
            return;
        }
        UIImage* image = [_manager imageByUrl:_url];
        if(self.isCancelled == YES) {
            return;
        }
        if((_processing != nil) && (image != nil)) {
            UIImage* processingImage = [_manager imageByUrl:_url processing:_processing];
            if(processingImage == nil) {
                processingImage = [self _processingImage:image];
                if(processingImage == nil) {
                    processingImage = image;
                }
            }
            dispatch_sync(dispatch_get_main_queue(), ^{
                if(self.isCancelled == YES) {
                    return;
                }
                for(id< GLBImageManagerTarget > target in _targets) {
                    [target imageManager:_manager cacheImage:processingImage];
                }
            });
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                if(self.isCancelled == YES) {
                    return;
                }
                for(id< GLBImageManagerTarget > target in _targets) {
                    [target imageManager:_manager cacheImage:image];
                }
            });
        }
    }
}

#pragma mark - Private

- (UIImage*)_processingImage:(UIImage*)image {
    UIImage* processingImage = [_targets.firstObject imageManager:_manager processing:_processing image:image];
    if(processingImage != nil) {
        NSData* processingData = [_manager _dataWithImage:processingImage];
        [_manager _setImage:processingImage data:processingData url:_url processing:_processing];
    }
    return processingImage;
}

@end

/*--------------------------------------------------*/

@implementation GLBImageManagerDownloadOperation

#pragma mark - Init / Free

- (instancetype)initWithManager:(GLBImageManager*)manager target:(id< GLBImageManagerTarget >)target url:(NSURL*)url processing:(NSString*)processing {
    self = [super initWithManager:manager target:target url:url processing:processing];
    if(self != nil) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return self;
}

#pragma mark - Public

- (void)main {
    @autoreleasepool {
        if(self.isCancelled == YES) {
            return;
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            for(id< GLBImageManagerTarget > target in _targets) {
                [target startDownloadInImageManager:_manager];
            }
        });
        __block NSData* data = nil;
        __block UIImage* image = nil;
        __block NSError* error = nil;
        _request = [GLBImageDownloadRequest requestWithUrl:_url];
        [_manager.provider sendRequest:_request byTarget:self downloadBlock:^(NSProgress* progress) {
            for(id< GLBImageManagerTarget > target in _targets) {
                [target imageManager:_manager downloadProgress:progress];
            }
        } completeBlock:^(GLBImageDownloadRequest* request, GLBImageDownloadResponse* response) {
            _request = nil;
            data = response.data;
            image = response.image;
            error = response.error;
            dispatch_semaphore_signal(_semaphore);
        }];
        dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
        if(self.isCancelled == YES) {
            return;
        }
        if((error == nil) && (image != nil) && (data != nil)) {
            [_manager _setImage:image data:data url:_url];
            if(_processing != nil) {
                UIImage* processingImage = [self _processingImage:image];
                if(processingImage == nil) {
                    processingImage = image;
                }
                dispatch_sync(dispatch_get_main_queue(), ^{
                    if(self.isCancelled == YES) {
                        return;
                    }
                    for(id< GLBImageManagerTarget > target in _targets) {
                        [target imageManager:_manager downloadImage:processingImage];
                        [target finishDownloadInImageManager:_manager];
                    }
                });
            } else {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    if(self.isCancelled == YES) {
                        return;
                    }
                    for(id< GLBImageManagerTarget > target in _targets) {
                        [target imageManager:_manager downloadImage:image];
                        [target finishDownloadInImageManager:_manager];
                    }
                });
            }
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                if(self.isCancelled == YES) {
                    return;
                }
                for(id< GLBImageManagerTarget > target in _targets) {
                    [target imageManager:_manager downloadError:error];
                    [target finishDownloadInImageManager:_manager];
                }
            });
        }
    }
}

- (void)cancel {
    [super cancel];
    
    [_manager.provider cancelRequest:_request];
    _request = nil;
    dispatch_semaphore_signal(_semaphore);
}

#pragma mark - Private

- (UIImage*)_processingImage:(UIImage*)image {
    UIImage* processingImage = [_targets.firstObject imageManager:_manager processing:_processing image:image];
    if(processingImage != nil) {
        NSData* processingData = [_manager _dataWithImage:processingImage];
        [_manager _setImage:processingImage data:processingData url:_url processing:_processing];
    }
    return processingImage;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
