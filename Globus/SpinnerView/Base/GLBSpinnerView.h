/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBSpinnerView : UIView

@property(nonatomic, nullable, strong) IBInspectable UIColor* color;
@property(nonatomic) IBInspectable CGFloat size;
@property(nonatomic) IBInspectable BOOL hidesWhenStopped;
@property(nonatomic, readonly, getter=isAnimating) BOOL animating;

- (void)setup NS_REQUIRES_SUPER;

- (void)startAnimating;
- (void)stopAnimating;

- (void)prepareAnimation NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
