/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBRoundView : UIView

@property(nonatomic) IBInspectable BOOL roundCorners;
@property(nonatomic) IBInspectable BOOL automaticShadowPath;

- (void)setup NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
