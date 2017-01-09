/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBImageManager;

/*--------------------------------------------------*/

@interface GLBImageView : UIImageView

@property(nonatomic, nullable, strong) GLBImageManager* manager;
@property(nonatomic, readonly, getter=isDownloading) BOOL downloading;

@property(nonatomic) IBInspectable BOOL roundCorners;
@property(nonatomic, nullable, strong) IBInspectable UIImage* defaultImage;
@property(nonatomic, nullable, strong) IBInspectable NSURL* imageUrl;

- (void)setup NS_REQUIRES_SUPER;

- (void)startDownload NS_REQUIRES_SUPER;
- (void)downloadProgress:(NSProgress* _Nullable)progress NS_REQUIRES_SUPER;
- (void)finishDownload NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
