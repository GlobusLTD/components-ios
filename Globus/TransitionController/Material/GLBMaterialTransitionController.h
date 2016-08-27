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

@interface GLBTransitionControllerMaterial : GLBMaterialTransitionController
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
