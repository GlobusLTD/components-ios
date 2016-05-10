/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBSpinnerView : UIView

@property(nonatomic, strong) IBInspectable UIColor* color;
@property(nonatomic) IBInspectable CGFloat size;
@property(nonatomic) IBInspectable BOOL hidesWhenStopped;
@property(nonatomic, readonly, assign, getter=isAnimating) BOOL animating;

- (void)setup NS_REQUIRES_SUPER;

- (void)startAnimating;
- (void)stopAnimating;

- (void)prepareAnimation NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/

@interface GLBSpinnerViewPlane : GLBSpinnerView
@end

/*--------------------------------------------------*/

@interface GLBSpinnerViewCircleFlip : GLBSpinnerView
@end

/*--------------------------------------------------*/

@interface GLBSpinnerViewBounce : GLBSpinnerView
@end

/*--------------------------------------------------*/

@interface GLBSpinnerViewWave : GLBSpinnerView
@end

/*--------------------------------------------------*/

@interface GLBSpinnerViewWanderingCubes : GLBSpinnerView
@end

/*--------------------------------------------------*/

@interface GLBSpinnerViewPulse : GLBSpinnerView
@end

/*--------------------------------------------------*/

@interface GLBSpinnerViewChasingDots : GLBSpinnerView
@end

/*--------------------------------------------------*/

@interface GLBSpinnerViewThreeBounce : GLBSpinnerView
@end

/*--------------------------------------------------*/

@interface GLBSpinnerViewCircle : GLBSpinnerView
@end

/*--------------------------------------------------*/

@interface GLBSpinnerView9CubeGrid : GLBSpinnerView
@end

/*--------------------------------------------------*/

@interface GLBSpinnerViewWordPress : GLBSpinnerView
@end

/*--------------------------------------------------*/

@interface GLBSpinnerViewFadingCircle : GLBSpinnerView
@end

/*--------------------------------------------------*/

@interface GLBSpinnerViewFadingCircleAlt : GLBSpinnerView

@property(nonatomic) IBInspectable NSUInteger numberOfCircle;
@property(nonatomic) IBInspectable CGFloat factorCircle;
@property(nonatomic) IBInspectable CGFloat factorRadius;
@property(nonatomic) IBInspectable CGFloat minScale;
@property(nonatomic) IBInspectable CGFloat minOpacity;

@end

/*--------------------------------------------------*/

@interface GLBSpinnerViewArc : GLBSpinnerView
@end

/*--------------------------------------------------*/

@interface GLBSpinnerViewArcAlt : GLBSpinnerView
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
