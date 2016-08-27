/*--------------------------------------------------*/

#include "GLBTransitionController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBCardsTransitionController : GLBTransitionController
@end

/*--------------------------------------------------*/
/* Legacy                                           */
/*--------------------------------------------------*/

@interface GLBTransitionControllerCards : GLBCardsTransitionController
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
