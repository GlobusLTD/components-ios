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

- (UIImage* _Nullable)imageWithData:(NSData* _Nonnull)data mimetype:(NSString* _Nonnull)mimetype;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/

