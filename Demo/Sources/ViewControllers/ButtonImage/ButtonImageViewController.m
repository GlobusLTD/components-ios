//
//  Globus
//

#import "ButtonImageViewController.h"

@interface ButtonImageViewController ()

@property(nonatomic, weak) IBOutlet GLBButton* button;

@end

@implementation ButtonImageViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _button.adjustsImageWhenHighlighted = NO;
    _button.imageEdgeInsets = UIEdgeInsetsMake(8.0f, 8.0f, 8.0f, 8.0f);
    _button.titleEdgeInsets = UIEdgeInsetsMake(8.0f, 8.0f, 8.0f, 8.0f);
    _button.glb_normalImage = [UIImage imageNamed:@"ButtonIcon"];
    _button.glb_normalTitleColor = UIColor.darkGrayColor;
    _button.normalBackgroundColor = UIColor.lightGrayColor;
    _button.normalCornerRadius = 4.0f;
    _button.glb_highlightedTitleColor = UIColor.blackColor;
    _button.highlightedBackgroundColor = UIColor.darkGrayColor;
    _button.highlightedCornerRadius = 8.0f;
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

- (IBAction)pressed:(id)sender {
    switch(_button.imageAlignment) {
        case GLBButtonImageAlignmentLeft:
            _button.imageAlignment = GLBButtonImageAlignmentRight;
            break;
        case GLBButtonImageAlignmentRight:
            _button.imageAlignment = GLBButtonImageAlignmentTop;
            break;
        case GLBButtonImageAlignmentTop:
            _button.imageAlignment = GLBButtonImageAlignmentBottom;
            break;
        case GLBButtonImageAlignmentBottom:
            _button.imageAlignment = GLBButtonImageAlignmentLeft;
            break;
    }
}

@end
