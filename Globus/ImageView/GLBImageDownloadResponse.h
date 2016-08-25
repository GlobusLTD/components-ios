/*--------------------------------------------------*/

#import "GLBApiResponse.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class UIImage;

/*--------------------------------------------------*/

@interface GLBImageDownloadResponse : GLBApiResponse

@property(nonatomic, readonly, strong) UIImage* image;

- (UIImage*)imageWithData:(NSData*)data mimetype:(NSString*)mimetype;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/

