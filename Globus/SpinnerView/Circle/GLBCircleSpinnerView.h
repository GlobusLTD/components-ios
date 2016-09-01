/*--------------------------------------------------*/

#import "GLBSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBCircleSpinnerView : GLBSpinnerView
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/

#if __has_include("GLBSpinnerViewCircle.h")
#import "GLBSpinnerViewCircle.h"
#endif

/*--------------------------------------------------*/
