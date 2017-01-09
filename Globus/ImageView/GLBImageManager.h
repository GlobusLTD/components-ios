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

+ (instancetype _Nullable)defaultImageManager;

- (void)setup NS_REQUIRES_SUPER;

- (BOOL)existImageByUrl:(NSURL* _Nonnull)url;
- (BOOL)existImageByUrl:(NSURL* _Nonnull)url processing:(NSString* _Nullable)processing;
- (UIImage* _Nullable)imageByUrl:(NSURL* _Nonnull)url;
- (UIImage* _Nullable)imageByUrl:(NSURL* _Nonnull)url processing:(NSString* _Nullable)processing;
- (void)imageByUrl:(NSURL* _Nonnull)url complete:(GLBImageDownloadImageBlock _Nullable)complete;
- (void)imageByUrl:(NSURL* _Nonnull)url processing:(NSString* _Nullable)processing complete:(GLBImageDownloadImageBlock _Nullable)complete;
- (void)setImage:(UIImage* _Nonnull)image url:(NSURL* _Nonnull)url complete:(GLBSimpleBlock _Nullable)complete;
- (void)setImage:(UIImage* _Nonnull)image url:(NSURL* _Nonnull)url processing:(NSString* _Nullable)processing complete:(GLBSimpleBlock _Nullable)complete;
- (void)removeImageByUrl:(NSURL* _Nonnull)url complete:(GLBSimpleBlock _Nullable)complete;
- (void)removeImageByUrl:(NSURL* _Nonnull)url processing:(NSString* _Nullable)processing complete:(GLBSimpleBlock _Nullable)complete;
- (void)cleanupImagesComplete:(GLBSimpleBlock _Nullable)complete;

- (void)imageByUrl:(NSURL* _Nonnull)url target:(id< GLBImageManagerTarget > _Nonnull)target;
- (void)imageByUrl:(NSURL* _Nonnull)url processing:(NSString* _Nullable)processing target:(id< GLBImageManagerTarget > _Nonnull)target;
- (void)cancelByTarget:(id< GLBImageManagerTarget > _Nonnull)target;

@end

/*--------------------------------------------------*/

@protocol GLBImageManagerTarget < NSObject >

@required
- (void)imageManager:(GLBImageManager* _Nonnull)imageManager cacheImage:(UIImage* _Nullable)image;

@required
- (UIImage* _Nullable)imageManager:(GLBImageManager* _Nonnull)imageManager processing:(NSString* _Nullable)processing image:(UIImage* _Nonnull)image;

@required
- (void)startDownloadInImageManager:(GLBImageManager* _Nonnull)imageManager;
- (void)finishDownloadInImageManager:(GLBImageManager* _Nonnull)imageManager;
- (void)imageManager:(GLBImageManager* _Nonnull)imageManager downloadProgress:(NSProgress* _Nonnull)progress;
- (void)imageManager:(GLBImageManager* _Nonnull)imageManager downloadImage:(UIImage* _Nonnull)image;
- (void)imageManager:(GLBImageManager* _Nonnull)imageManager downloadError:(NSError* _Nullable)error;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
