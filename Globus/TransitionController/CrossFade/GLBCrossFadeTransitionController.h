/*--------------------------------------------------*/

#import "GLBTransitionController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBCrossFadeTransitionController : GLBTransitionController

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/

#if __has_include("GLBTransitionControllerCrossFade.h")
#import "GLBTransitionControllerCrossFade.h"
#endif

/*--------------------------------------------------*/
