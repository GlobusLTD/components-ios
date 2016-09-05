/*--------------------------------------------------*/

#import "GLBSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBFadingCircleSpinnerView : GLBSpinnerView
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/

#if __has_include("GLBSpinnerViewFadingCircle.h")
#import "GLBSpinnerViewFadingCircle.h"
#endif

/*--------------------------------------------------*/
