/*--------------------------------------------------*/

#import "UIViewController+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation UIViewController (GLB_UI)

#pragma mark - Public

- (UIViewController*)glb_currentViewController {
    if(self.presentedViewController != nil) {
        return [self.presentedViewController glb_currentViewController];
    }
    if([self conformsToProtocol:@protocol(GLBViewControllerExtension)]) {
        return [(id< GLBViewControllerExtension >)self currentViewController];
    }
    return self;
}


- (void)glb_loadViewIfNeed {
    if(self.isViewLoaded == NO) {
        [self loadView];
    }
}

- (void)glb_unloadViewIfPossible {
    if(self.isViewLoaded) {
        if(self.view.window == nil) {
            self.view = nil;
        }
    }
}

- (void)glb_unloadView {
    if(self.isViewLoaded) {
        self.view = nil;
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
