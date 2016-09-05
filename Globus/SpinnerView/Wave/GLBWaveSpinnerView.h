/*--------------------------------------------------*/

#import "GLBSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBWaveSpinnerView : GLBSpinnerView
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/

#if __has_include("GLBSpinnerViewWave.h")
#import "GLBSpinnerViewWave.h"
#endif

/*--------------------------------------------------*/
