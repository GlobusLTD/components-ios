//
//  Globus
//

#import "TransitionChildViewController.h"

@implementation TransitionChildViewController

#pragma mark - Actions

- (IBAction)pressedClose:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pressedModal:(id)sender {
    TransitionChildViewController* vc = [TransitionChildViewController instantiate];
    GLBNavigationViewController* nvc = [GLBNavigationViewController viewControllerWithRootViewController:vc];
    nvc.transitionNavigation = self.transition;
    nvc.transitionModal = self.transition;
    [self presentViewController:nvc animated:YES completion:nil];
}

- (IBAction)pressedPush:(id)sender {
    TransitionChildViewController* vc = [TransitionChildViewController instantiate];
    vc.transitionModal = self.transition;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)pressedPop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
