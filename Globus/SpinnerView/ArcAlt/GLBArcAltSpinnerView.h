/*--------------------------------------------------*/

#import "GLBSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBArcAltSpinnerView : GLBSpinnerView
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/

#if __has_include("GLBSpinnerViewArcAlt.h")
#import "GLBSpinnerViewArcAlt.h"
#endif

/*--------------------------------------------------*/
