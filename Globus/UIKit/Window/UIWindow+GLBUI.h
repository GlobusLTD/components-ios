/*--------------------------------------------------*/

#import "UIViewController+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface UIWindow (GLB_UI)

@property(nonatomic, readonly, strong) UIViewController* glb_currentViewController;
@property(nonatomic, readonly, strong) UIViewController* glb_controllerForStatusBarStyle;
@property(nonatomic, readonly, strong) UIViewController* glb_controllerForStatusBarHidden;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
