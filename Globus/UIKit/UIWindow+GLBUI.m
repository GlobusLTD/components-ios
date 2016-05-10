/*--------------------------------------------------*/

#import "UIWindow+GLBUI.h"
#import "UIViewController+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation UIWindow (GLB_UI)

#pragma mark - Property

- (UIViewController*)glb_currentViewController {
    return self.rootViewController.glb_currentViewController;
}

- (UIViewController*)glb_controllerForStatusBarStyle {
    UIViewController* currentViewController = self.glb_currentViewController;
    while(currentViewController.childViewControllerForStatusBarStyle != nil) {
        currentViewController = currentViewController.childViewControllerForStatusBarStyle;
    }
    return currentViewController;
}

- (UIViewController*)glb_controllerForStatusBarHidden {
    UIViewController* currentViewController = self.glb_currentViewController;
    while(currentViewController.childViewControllerForStatusBarHidden != nil) {
        currentViewController = currentViewController.childViewControllerForStatusBarHidden;
    }
    return currentViewController;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
