/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/

#import "GLBTransitionController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBMaterialTransitionController : GLBTransitionController

@property(nonatomic, weak) UIView* sourceView;
@property(nonatomic) CGRect sourceFrame;

@property(nonatomic, strong) UIColor* backgroundColor;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/

#if __has_include("GLBTransitionControllerMaterial.h")
#import "GLBTransitionControllerMaterial.h"
#endif

/*--------------------------------------------------*/
