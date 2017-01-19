//
//  Globus
//

#import "PageControlViewController.h"

@interface PageControlViewController ()

@property(nonatomic, weak) IBOutlet GLBPageControl* pageControl;

@end

@implementation PageControlViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pageControl.tapBehavior = GLBPageControlTapBehaviorJump;
    _pageControl.numberOfPages = 10;
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

@end
