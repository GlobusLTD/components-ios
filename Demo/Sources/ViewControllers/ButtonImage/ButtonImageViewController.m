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
    
    _button.glb_normalImage = [UIImage imageNamed:@"ButtonIcon"];
}

#pragma mark - Actions

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
