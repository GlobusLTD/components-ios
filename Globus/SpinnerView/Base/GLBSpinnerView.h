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
#endif
/*--------------------------------------------------*/

#if __has_include("GLBArcSpinnerView.h")
#import "GLBArcSpinnerView.h"
#endif

#if __has_include("GLBArcAltSpinnerView.h")
#import "GLBArcAltSpinnerView.h"
#endif

#if __has_include("GLBBounceSpinnerView.h")
#import "GLBBounceSpinnerView.h"
#endif

#if __has_include("GLBChasingDotsSpinnerView.h")
#import "GLBChasingDotsSpinnerView.h"
#endif

#if __has_include("GLBChasingDotsSpinnerView.h")
#import "GLBChasingDotsSpinnerView.h"
#endif

#if __has_include("GLBCircleSpinnerView.h")
#import "GLBCircleSpinnerView.h"
#endif

#if __has_include("GLBCircleFlipSpinnerView.h")
#import "GLBCircleFlipSpinnerView.h"
#endif

#if __has_include("GLBFadingCircleSpinnerView.h")
#import "GLBFadingCircleSpinnerView.h"
#endif

#if __has_include("GLBFadingCircleAltSpinnerView.h")
#import "GLBFadingCircleAltSpinnerView.h"
#endif

#if __has_include("GLBNineCubeGridSpinnerView.h")
#import "GLBNineCubeGridSpinnerView.h"
#endif

#if __has_include("GLBPlaneSpinnerView.h")
#import "GLBPlaneSpinnerView.h"
#endif

#if __has_include("GLBPulseSpinnerView.h")
#import "GLBPulseSpinnerView.h"
#endif

#if __has_include("GLBThreeBounceSpinnerView.h")
#import "GLBThreeBounceSpinnerView.h"
#endif

#if __has_include("GLBWanderingCubesSpinnerView.h")
#import "GLBWanderingCubesSpinnerView.h"
#endif

#if __has_include("GLBWaveSpinnerView.h")
#import "GLBWaveSpinnerView.h"
#endif

#if __has_include("GLBWordPressSpinnerView.h")
#import "GLBWordPressSpinnerView.h"
#endif

/*--------------------------------------------------*/
