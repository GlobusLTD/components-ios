/*--------------------------------------------------*/

#include "GLBRect.h"

/*--------------------------------------------------*/

#import "GLBTransitionController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBSlideTransitionController : GLBTransitionController

@property(nonatomic) CGFloat ratio;

- (instancetype)initWithRatio:(CGFloat)ratio;

@end

/*--------------------------------------------------*/
/* Legacy                                           */
/*--------------------------------------------------*/

GLB_DEPRECATED
@interface GLBTransitionControllerSlide : GLBSlideTransitionController
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
