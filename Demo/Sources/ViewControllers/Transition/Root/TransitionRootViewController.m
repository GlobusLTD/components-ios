//
//  Globus
//

#import "TransitionRootViewController.h"
#import "TransitionChildViewController.h"

@implementation TransitionRootViewController

#pragma mark - Actions

- (IBAction)pressedPresent:(id)sender {
    TransitionChildViewController* vc = [TransitionChildViewController instantiate];
    GLBNavigationViewController* nvc = [GLBNavigationViewController viewControllerWithRootViewController:vc];
    nvc.transitionNavigation = self.transition;
    nvc.transitionModal = self.transition;
    [self presentViewController:nvc animated:YES completion:nil];
}

@end
