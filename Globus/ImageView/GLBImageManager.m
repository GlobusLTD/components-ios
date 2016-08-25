/*--------------------------------------------------*/

#import "GLBImageManager.h"
#import "GLBImageDownloadRequest.h"
#import "GLBImageDownloadResponse.h"
#import "GLBApiProvider.h"
#import "GLBCache.h"

/*--------------------------------------------------*/

#import "UIImage+GLBUI.h"
#import "NSString+GLBNS.h"

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
    id< GLBImageManagerTarget > _target;
    NSURL* _url;
    NSString* _processing;
}

@property(nonatomic, weak) GLBImageManager* manager;
@property(nonatomic, strong) id< GLBImageManagerTarget > target;
@property(nonatomic, strong) NSURL* url;
@property(nonatomic, strong) NSString* processing;

- (instancetype)initWithManager:(GLBImageManager*)manager target:(id< GLBImageManagerTarget >)target url:(NSURL*)url processing:(NSString*)processing;

- (void)setup NS_REQUIRES_SUPER;

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

static GLBImageManager* GLBImageManagerDefaultInstance;

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBImageManager

#pragma mark - Synthesize

@synthesize provider = _provider;
@synthesize cache = _cache;

#pragma mark - Singleton

+ (instancetype)defaultImageManager {
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        GLBImageManagerDefaultInstance = [self new];
    });
    return GLBImageManagerDefaultInstance;
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
    if(_provider == nil) {
        _provider = [[GLBApiProvider alloc] initWithName:self.glb_className];
    }
    return _provider;
}

- (GLBCache*)cache {
    if(_cache == nil) {
        _cache = [GLBCache shared];
    }
    return _cache;
}

#pragma mark - Public

- (BOOL)existImageByUrl:(NSURL*)url {
    NSString* uniqueKey = url.absoluteString;
    return [self.cache existDataForKey:uniqueKey];
}

- (BOOL)existImageByUrl:(NSURL*)url processing:(NSString*)processing {
    NSString* uniqueKey = url.absoluteString;
    if(processing != nil) {
        uniqueKey = [processing stringByAppendingString:uniqueKey];
    }
    return [self.cache existDataForKey:uniqueKey];
}

- (UIImage*)imageByUrl:(NSURL*)url {
    return [self imageByUrl:url processing:nil];
}

- (UIImage*)imageByUrl:(NSURL*)url processing:(NSString*)processing {
    NSString* uniqueKey = url.absoluteString;
    if(processing != nil) {
        uniqueKey = [processing stringByAppendingString:uniqueKey];
    }
    UIImage* image = nil;
    @synchronized(_imagesCache) {
        image = _imagesCache[uniqueKey];
    }
    if(image == nil) {
        NSData* data = [self.cache dataForKey:uniqueKey];
        image = [self _imageWithData:data];
        if(image != nil) {
            @synchronized(_imagesCache) {
                _imagesCache[uniqueKey] = image;
            }
        } else {
            [self.cache removeDataForKey:uniqueKey];
        }
    }
    return image;
}

- (void)imageByUrl:(NSURL*)url complete:(GLBImageDownloadImageBlock)complete {
    [self imageByUrl:url complete:complete];
}

- (void)imageByUrl:(NSURL*)url processing:(NSString*)processing complete:(GLBImageDownloadImageBlock)complete {
    if(complete == nil) {
        return;
    }
    NSString* uniqueKey = url.absoluteString;
    if(processing != nil) {
        uniqueKey = [processing stringByAppendingString:uniqueKey];
    }
    UIImage* existImage = nil;
    @synchronized(_imagesCache) {
        existImage = _imagesCache[uniqueKey];
    }
    if(existImage == nil) {
    } else {
        complete(existImage);
    }
    __weak typeof(self) weakSelf = self;
    [self.cache dataForKey:uniqueKey complete:^(NSData* data) {
        [weakSelf _imageByUrl:url processing:processing complete:complete];
    }];
}

- (void)setImage:(UIImage*)image url:(NSURL*)url complete:(GLBSimpleBlock)complete {
    [self setImage:image url:url processing:nil complete:complete];
}

- (void)setImage:(UIImage*)image url:(NSURL*)url processing:(NSString*)processing complete:(GLBSimpleBlock)complete {
    if(complete == nil) {
        return;
    }
    NSString* uniqueKey = url.absoluteString;
    if(processing != nil) {
        uniqueKey = [processing stringByAppendingString:uniqueKey];
    }
    __weak typeof(self) weakSelf = self;
    dispatch_async(_queue, ^{
        [weakSelf _setImage:image url:url processing:processing complete:complete];
    });
}

- (void)removeImageByUrl:(NSURL*)url complete:(GLBSimpleBlock)complete {
    [self removeImageByUrl:url processing:nil complete:complete];
}

- (void)removeImageByUrl:(NSURL*)url processing:(NSString*)processing complete:(GLBSimpleBlock)complete {
    if(complete == nil) {
        return;
    }
    NSString* uniqueKey = url.absoluteString;
    if(processing != nil) {
        uniqueKey = [processing stringByAppendingString:uniqueKey];
    };
    __weak typeof(self) weakSelf = self;
    [self.cache removeDataForKey:uniqueKey complete:^{
        [weakSelf _removeImageByUrl:url processing:processing complete:complete];
    }];
}

- (void)cleanupImagesComplete:(GLBSimpleBlock)complete {
    if(complete == nil) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [self.cache removeAllDataComplete:^{
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
    GLBImageManagerOperation* op = nil;
    if([self existImageByUrl:url] == YES) {
        op = [[GLBImageManagerCacheOperation alloc] initWithManager:self
                                                             target:target
                                                                url:url
                                                         processing:processing];
    } else {
        op = [[GLBImageManagerDownloadOperation alloc] initWithManager:self
                                                                target:target
                                                                   url:url
                                                            processing:processing];
    }
    if(op != nil) {
        @synchronized(_operationQueue) {
            _operationQueue.suspended = YES;
            [_operationQueue addOperation:op];
            _operationQueue.suspended = NO;
        }
    }
}

- (void)cancelByTarget:(id< GLBImageManagerTarget >)target {
    @synchronized(_operationQueue) {
        _operationQueue.suspended = YES;
        for(GLBImageManagerOperation* op in _operationQueue.operations) {
            if(op.target == target) {
                [op cancel];
            }
        }
        _operationQueue.suspended = NO;
    }
}

#pragma mark - Private

- (void)_imageByUrl:(NSURL*)url processing:(NSString*)processing complete:(GLBImageDownloadImageBlock)complete {
    UIImage* image = [self _imageWithData:data];
    if(image != nil) {
        @synchronized(_imagesCache) {
            _imagesCache[uniqueKey] = image;
        }
    } else {
        [self.cache removeDataForKey:uniqueKey];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        complete(image);
    });
}

- (void)_setImage:(UIImage*)image url:(NSURL*)url processing:(NSString*)processing complete:(GLBSimpleBlock)complete {
    NSData* data = [self _dataWithImage:image];
    [self.cache setData:data forKey:uniqueKey];
    @synchronized(_imagesCache) {
        _imagesCache[uniqueKey] = image;
    }
    dispatch_async(dispatch_get_main_queue(), complete);
}

- (void)_removeImageByUrl:(NSURL*)url processing:(NSString*)processing complete:(GLBSimpleBlock)complete {
    @synchronized(_imagesCache) {
        [_imagesCache removeObjectForKey:uniqueKey];
    }
    dispatch_async(dispatch_get_main_queue(), complete);
}

- (void)_cleanupImagesComplete:(GLBSimpleBlock)complete {
    @synchronized(_imagesCache) {
        [_imagesCache removeAllObjects];
    }
    dispatch_async(dispatch_get_main_queue(), complete);
}

- (void)_setImage:(UIImage*)image data:(NSData*)data url:(NSURL*)url {
    [self _setImage:image data:data url:url processing:nil];
}

- (void)_setImage:(UIImage*)image data:(NSData*)data url:(NSURL*)url processing:(NSString*)processing {
    NSString* uniqueKey = url.absoluteString;
    if(processing != nil) {
        uniqueKey = [processing stringByAppendingString:uniqueKey];
    };
    [self.cache setData:data forKey:uniqueKey];
    @synchronized(_imagesCache) {
        _imagesCache[uniqueKey] = image;
    }
}

- (NSData*)_dataWithImage:(UIImage*)image {
    return UIImagePNGRepresentation(image);
}

- (UIImage*)_imageWithData:(NSData*)data {
    return [UIImage glb_imageWithData:data];
}

#pragma mark - NSNotificationCenter

- (void)_receiveMemoryWarning:(NSNotification*)notification {
    @synchronized(_imagesCache) {
        [_imagesCache removeAllObjects];
    }
}

@end

/*--------------------------------------------------*/

@implementation GLBImageManagerOperation

#pragma mark - Synthesize

@synthesize manager = _manager;
@synthesize target = _target;
@synthesize url = _url;

#pragma mark - Init / Free

- (instancetype)initWithManager:(GLBImageManager*)manager target:(id< GLBImageManagerTarget >)target url:(NSURL*)url processing:(NSString*)processing {
    self = [super init];
    if(self != nil) {
        _manager = manager;
        _target = target;
        _url = url;
        _processing = processing;
        [self setup];
    }
    return self;
}

- (void)setup {
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
                [_target imageManager:_manager cacheImage:image];
            });
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                if(self.isCancelled == YES) {
                    return;
                }
                [_target imageManager:_manager cacheImage:image];
            });
        }
    }
}

#pragma mark - Private

- (UIImage*)_processingImage:(UIImage*)image {
    if(self.isCancelled == YES) {
        return nil;
    }
    UIImage* processingImage = [_target imageManager:_manager processing:_processing image:image];
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

- (void)setup {
    [super setup];
    
    _semaphore = dispatch_semaphore_create(0);
}

#pragma mark - Public

- (void)main {
    @autoreleasepool {
        if(self.isCancelled == YES) {
            return;
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            [_target startDownloadInImageManager:_manager];
        });
        __block NSData* data = nil;
        __block UIImage* image = nil;
        __block NSError* error = nil;
        _request = [GLBImageDownloadRequest requestWithUrl:_url];
        [_manager.provider sendRequest:_request byTarget:_target downloadBlock:^(NSProgress* progress) {
            [_target imageManager:_manager downloadProgress:progress];
        } completeBlock:^(GLBImageDownloadRequest* request, GLBImageDownloadResponse* response) {
            _request = nil;
            if((response.isValid == YES) && (response.data != nil) && (response.image != nil)) {
                data = response.data;
                image = response.image;
            } else {
                error = response.error;
            }
            dispatch_semaphore_signal(_semaphore);
        }];
        dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
        if(self.isCancelled == YES) {
            return;
        }
        if(error == nil) {
            [_manager _setImage:image data:data url:_url];
            if(self.isCancelled == YES) {
                return;
            }
            if(_processing != nil) {
                UIImage* processingImage = [self _processingImage:image];
                if(processingImage == nil) {
                    processingImage = image;
                }
                if(self.isCancelled == YES) {
                    return;
                }
                dispatch_sync(dispatch_get_main_queue(), ^{
                    if(self.isCancelled == YES) {
                        return;
                    }
                    [_target imageManager:_manager downloadImage:image];
                    [_target finishDownloadInImageManager:_manager];
                });
            } else {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    if(self.isCancelled == YES) {
                        return;
                    }
                    [_target imageManager:_manager downloadImage:image];
                    [_target finishDownloadInImageManager:_manager];
                });
            }
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                if(self.isCancelled == YES) {
                    return;
                }
                [_target imageManager:_manager downloadError:error];
                [_target finishDownloadInImageManager:_manager];
            });
        }
    }
}

- (void)cancel {
    [_manager.provider cancelRequest:_request];
    dispatch_semaphore_signal(_semaphore);
}

#pragma mark - Private

- (UIImage*)_processingImage:(UIImage*)image {
    if(self.isCancelled == YES) {
        return nil;
    }
    UIImage* processingImage = [_target imageManager:_manager processing:_processing image:image];
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