/*--------------------------------------------------*/

#import "UIImage+GLBUI.h"
#import "UIColor+GLBUI.h"

/*--------------------------------------------------*/

#import "GLBImageView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBGrayscaleImageView : GLBImageView

@property(nonatomic, getter = isEnabled) IBInspectable BOOL enabled;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
