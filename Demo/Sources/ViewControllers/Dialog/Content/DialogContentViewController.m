//
//  Globus
//

#import "DialogContentViewController.h"

@interface DialogContentViewController ()
@end

@implementation DialogContentViewController

#pragma mark - Actions

- (IBAction)pressedHide:(id)sender {
    [self.glb_dialogViewController dismissWithCompletion:nil];
}

@end
