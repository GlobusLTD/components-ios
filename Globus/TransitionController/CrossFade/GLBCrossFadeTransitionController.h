/*--------------------------------------------------*/

#import "GLBTransitionController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBCrossFadeTransitionController : GLBTransitionController

@end

/*--------------------------------------------------*/
/* Legacy                                           */
/*--------------------------------------------------*/

@interface GLBTransitionControllerCrossFade : GLBCrossFadeTransitionController
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
