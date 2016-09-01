/*--------------------------------------------------*/

#import "GLBImageDownloadResponse.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBImageDownloadResponse

#pragma mark - Public

- (BOOL)fromData:(NSData*)data mimetype:(NSString*)mimetype {
    _image = [self imageWithData:data mimetype:mimetype];
    return YES;
}

- (UIImage*)imageWithData:(NSData*)data mimetype:(NSString*)mimetype {
    return [UIImage glb_imageWithData:data];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
