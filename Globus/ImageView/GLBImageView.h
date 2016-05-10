/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/

@class GLBApiProvider;
@class GLBCache;

/*--------------------------------------------------*/

@interface GLBImageView : UIImageView

@property(nonatomic) IBInspectable BOOL roundCorners;
@property(nonatomic, strong) IBInspectable UIImage* defaultImage;
@property(nonatomic, strong) IBInspectable NSURL* imageUrl;

- (void)setup NS_REQUIRES_SUPER;

- (void)didStart;
- (void)didProgress:(NSProgress*)progress;
- (void)didFinish;

@end

/*--------------------------------------------------*/

@protocol GLBImageDownloadManagerTarget;

/*--------------------------------------------------*/

@interface GLBImageDownloadManager : NSObject

@property(nonatomic, readonly, strong) GLBApiProvider* provider;
@property(nonatomic, readonly, strong) GLBCache* cache;

+ (instancetype)shared;

- (BOOL)existImageByUrl:(NSURL*)url;
- (UIImage*)imageByUrl:(NSURL*)url;
- (BOOL)setImage:(UIImage*)image byUrl:(NSURL*)url;
- (void)removeImageByUrl:(NSURL*)url;
- (void)cleanupImages;

- (void)downloadImageByUrl:(NSURL*)url byTarget:(id< GLBImageDownloadManagerTarget >)target;
- (void)cancelDownloadByTarget:(id< GLBImageDownloadManagerTarget >)target;
- (void)cancelDownloadByUrl:(NSURL*)url;

@end

/*--------------------------------------------------*/

@protocol GLBImageDownloadManagerTarget < NSObject >

@optional
- (void)imageDownloadManager:(GLBImageDownloadManager*)imageDownloadManager url:(NSURL*)url progress:(NSProgress*)progress;
- (void)imageDownloadManager:(GLBImageDownloadManager*)imageDownloadManager url:(NSURL*)url image:(UIImage*)image;
- (void)imageDownloadManager:(GLBImageDownloadManager*)imageDownloadManager url:(NSURL*)url error:(NSError*)error;

@end

/*--------------------------------------------------*/
