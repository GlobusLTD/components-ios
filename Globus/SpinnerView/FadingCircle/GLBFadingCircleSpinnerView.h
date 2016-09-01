/*--------------------------------------------------*/

#import "GLBSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBFadingCircleSpinnerView : GLBSpinnerView
@end

/*--------------------------------------------------*/
/* Legacy                                           */
/*--------------------------------------------------*/

GLB_DEPRECATED
@interface GLBSpinnerViewFadingCircle : GLBFadingCircleSpinnerView
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
