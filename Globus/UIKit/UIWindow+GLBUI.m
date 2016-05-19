/*--------------------------------------------------*/

#import "UIWindow+GLBUI.h"
#import "UIViewController+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import <objc/runtime.h>

/*--------------------------------------------------*/

@implementation UIWindow (GLB_UI)

#pragma mark - Property

- (void)setGlb_userWindow:(BOOL)glb_userWindow {
    objc_setAssociatedObject(self, @selector(glb_userWindow), @(glb_userWindow), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)glb_userWindow {
    return [objc_getAssociatedObject(self, @selector(glb_userWindow)) boolValue];
}

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
