/*--------------------------------------------------*/

#import "UIImage+GLBUI.h"

/*--------------------------------------------------*/

#import "GLBApiResponse.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class UIImage;

/*--------------------------------------------------*/

@interface GLBImageDownloadResponse : GLBApiResponse

@property(nonatomic, nullable, readonly, strong) UIImage* image;

- (nullable UIImage*)imageWithData:(nonnull NSData*)data mimetype:(nonnull NSString*)mimetype;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/

