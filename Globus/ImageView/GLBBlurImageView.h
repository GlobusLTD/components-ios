/*--------------------------------------------------*/

#import "UIImage+GLBUI.h"
#import "UIColor+GLBUI.h"

/*--------------------------------------------------*/

#import "GLBImageView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBBlurImageView : GLBImageView

@property(nonatomic, getter = isBlurEnabled) IBInspectable BOOL blurEnabled;
@property(nonatomic) IBInspectable CGFloat blurRadius;
@property(nonatomic) IBInspectable NSUInteger blurIterations;
@property(nonatomic, nullable, strong) IBInspectable UIColor* blurTintColor;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
