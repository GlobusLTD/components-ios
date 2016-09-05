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

typedef void(^GLBImageDownloadImageBlock)(UIImage* image);

/*--------------------------------------------------*/

@interface GLBImageManager : NSObject

@property(nonatomic, readonly, strong) GLBApiProvider* provider;
@property(nonatomic, readonly, strong) NSURLCache* urlCache;
@property(nonatomic, readonly, strong) GLBCache* durableCache;

+ (instancetype)defaultImageManager;

- (void)setup NS_REQUIRES_SUPER;

- (BOOL)existImageByUrl:(NSURL*)url;
- (BOOL)existImageByUrl:(NSURL*)url processing:(NSString*)processing;
- (UIImage*)imageByUrl:(NSURL*)url;
- (UIImage*)imageByUrl:(NSURL*)url processing:(NSString*)processing;
- (void)imageByUrl:(NSURL*)url complete:(GLBImageDownloadImageBlock)complete;
- (void)imageByUrl:(NSURL*)url processing:(NSString*)processing complete:(GLBImageDownloadImageBlock)complete;
- (void)setImage:(UIImage*)image url:(NSURL*)url complete:(GLBSimpleBlock)complete;
- (void)setImage:(UIImage*)image url:(NSURL*)url processing:(NSString*)processing complete:(GLBSimpleBlock)complete;
- (void)removeImageByUrl:(NSURL*)url complete:(GLBSimpleBlock)complete;
- (void)removeImageByUrl:(NSURL*)url processing:(NSString*)processing complete:(GLBSimpleBlock)complete;
- (void)cleanupImagesComplete:(GLBSimpleBlock)complete;

- (void)imageByUrl:(NSURL*)url target:(id< GLBImageManagerTarget >)target;
- (void)imageByUrl:(NSURL*)url processing:(NSString*)processing target:(id< GLBImageManagerTarget >)target;
- (void)cancelByTarget:(id< GLBImageManagerTarget >)target;

@end

/*--------------------------------------------------*/

@protocol GLBImageManagerTarget < NSObject >

@required
- (void)imageManager:(GLBImageManager*)imageManager cacheImage:(UIImage*)image;

@required
- (UIImage*)imageManager:(GLBImageManager*)imageManager processing:(NSString*)processing image:(UIImage*)image;

@required
- (void)startDownloadInImageManager:(GLBImageManager*)imageManager;
- (void)finishDownloadInImageManager:(GLBImageManager*)imageManager;
- (void)imageManager:(GLBImageManager*)imageManager downloadProgress:(NSProgress*)progress;
- (void)imageManager:(GLBImageManager*)imageManager downloadImage:(UIImage*)image;
- (void)imageManager:(GLBImageManager*)imageManager downloadError:(NSError*)error;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
