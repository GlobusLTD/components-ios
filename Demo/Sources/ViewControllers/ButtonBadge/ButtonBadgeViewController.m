//
//  Globus
//

#import "ButtonBadgeViewController.h"

@interface ButtonBadgeViewController ()

@property(nonatomic, weak) IBOutlet GLBButton* button;

@end

@implementation ButtonBadgeViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _button.glb_normalImage = [UIImage imageNamed:@"ButtonIcon"];
    _button.normalBackgroundColor = UIColor.lightGrayColor;
    _button.normalCornerRadius = 4.0;
    _button.adjustsImageWhenHighlighted = NO;
    _button.imageView.backgroundColor = UIColor.darkGrayColor;
    _button.titleLabel.backgroundColor = UIColor.darkGrayColor;
    _button.badgeView.text = @"X";
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

- (IBAction)pressed:(id)sender {
    switch(_button.badgeAlias) {
        case GLBButtonBadgeAliasTitle:
            _button.badgeAlias = GLBButtonBadgeAliasImage;
            break;
        case GLBButtonBadgeAliasImage:
            _button.badgeAlias = GLBButtonBadgeAliasContent;
            break;
        case GLBButtonBadgeAliasContent:
            _button.badgeAlias = GLBButtonBadgeAliasTitle;
            break;
    }
}

@end
