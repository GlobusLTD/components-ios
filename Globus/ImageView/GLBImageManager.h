/*--------------------------------------------------*/

#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

#import "UIImage+GLBUI.h"

/*--------------------------------------------------*/

#import "GLBApiProvider.h"
#import "GLBCache.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBApiProvider;
@class GLBCache;

/*--------------------------------------------------*/

@protocol GLBImageManagerTarget;

/*--------------------------------------------------*/

typedef void(^GLBImageDownloadImageBlock)(UIImage* _Nonnull image);

/*--------------------------------------------------*/

@interface GLBImageManager : NSObject

@property(nonatomic, nonnull, readonly, strong) GLBApiProvider* provider;
@property(nonatomic, nonnull, readonly, strong) NSURLCache* urlCache;
@property(nonatomic, nonnull, readonly, strong) GLBCache* durableCache;

+ (nullable instancetype)defaultImageManager;

- (void)setup NS_REQUIRES_SUPER;

- (BOOL)existImageByUrl:(nonnull NSURL*)url;
- (BOOL)existImageByUrl:(nonnull NSURL*)url processing:(nullable NSString*)processing;
- (nullable UIImage*)imageByUrl:(nonnull NSURL*)url;
- (nullable UIImage*)imageByUrl:(nonnull NSURL*)url processing:(nullable NSString*)processing;
- (void)imageByUrl:(nonnull NSURL*)url complete:(nullable GLBImageDownloadImageBlock)complete;
- (void)imageByUrl:(nonnull NSURL*)url processing:(nullable NSString*)processing complete:(nullable GLBImageDownloadImageBlock)complete;
- (void)setImage:(nonnull UIImage*)image url:(nonnull NSURL*)url complete:(nullable GLBSimpleBlock)complete;
- (void)setImage:(nonnull UIImage*)image url:(nonnull NSURL*)url processing:(nullable NSString*)processing complete:(nullable GLBSimpleBlock)complete;
- (void)removeImageByUrl:(nonnull NSURL*)url complete:(nullable GLBSimpleBlock)complete;
- (void)removeImageByUrl:(nonnull NSURL*)url processing:(nullable NSString*)processing complete:(nullable GLBSimpleBlock)complete;
- (void)cleanupImagesComplete:(nullable GLBSimpleBlock)complete;

- (void)imageByUrl:(nonnull NSURL*)url target:(nullable id< GLBImageManagerTarget >)target;
- (void)imageByUrl:(nonnull NSURL*)url processing:(nullable NSString*)processing target:(nullable id< GLBImageManagerTarget >)target;
- (void)cancelByTarget:(nonnull id< GLBImageManagerTarget >)target;

@end

/*--------------------------------------------------*/

@protocol GLBImageManagerTarget < NSObject >

@required
- (void)imageManager:(nonnull GLBImageManager*)imageManager cacheImage:(nullable UIImage*)image;

@required
- (nullable UIImage*)imageManager:(nonnull GLBImageManager*)imageManager processing:(nullable NSString*)processing image:(nonnull UIImage*)image;

@required
- (void)startDownloadInImageManager:(nonnull GLBImageManager*)imageManager;
- (void)finishDownloadInImageManager:(nonnull GLBImageManager*)imageManager;
- (void)imageManager:(nonnull GLBImageManager*)imageManager downloadProgress:(nonnull NSProgress*)progress;
- (void)imageManager:(nonnull GLBImageManager*)imageManager downloadImage:(nonnull UIImage*)image;
- (void)imageManager:(nonnull GLBImageManager*)imageManager downloadError:(nullable NSError*)error;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
