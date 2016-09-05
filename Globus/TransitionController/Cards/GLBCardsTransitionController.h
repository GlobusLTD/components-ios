/*--------------------------------------------------*/

#import "GLBTransitionController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBCardsTransitionController : GLBTransitionController
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/

#if __has_include("GLBTransitionControllerCards.h")
#import "GLBTransitionControllerCards.h"
#endif

/*--------------------------------------------------*/
