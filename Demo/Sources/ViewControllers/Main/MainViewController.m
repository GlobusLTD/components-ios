//
//  Globus
//

#import "MainViewController.h"

@interface MainViewController ()
@end

@implementation MainViewController

#pragma mark - Init / Free

- (void)setup {
    [super setup];
    
    self.allowsDoneBarButton = NO;
    self.toolbarHidden = YES;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.URL == nil) {
        self.URL = [NSURL URLWithString:@"http://globus-ltd.ru"];
    }
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

@end
