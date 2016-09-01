/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/

#include "GLBTransitionController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBMaterialTransitionController : GLBTransitionController

@property(nonatomic, weak) UIView* sourceView;
@property(nonatomic) CGRect sourceFrame;

@property(nonatomic, strong) UIColor* backgroundColor;

@end

/*--------------------------------------------------*/
/* Legacy                                           */
/*--------------------------------------------------*/

GLB_DEPRECATED
@interface GLBTransitionControllerMaterial : GLBMaterialTransitionController
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
