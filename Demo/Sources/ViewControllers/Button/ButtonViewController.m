//
//  Globus
//

#import "ButtonViewController.h"

@interface ButtonViewController ()

@property(nonatomic, weak) IBOutlet GLBButton* fillButton;
@property(nonatomic, weak) IBOutlet GLBButton* strokeButton;

@end

@implementation ButtonViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _fillButton.glb_normalTitleColor = UIColor.darkGrayColor;
    _fillButton.normalBackgroundColor = UIColor.lightGrayColor;
    _fillButton.normalCornerRadius = 4.0f;
    
    _fillButton.glb_highlightedTitleColor = UIColor.blackColor;
    _fillButton.highlightedBackgroundColor = UIColor.darkGrayColor;
    _fillButton.highlightedCornerRadius = 8.0f;
    
    _strokeButton.glb_normalTitleColor = UIColor.lightGrayColor;
    _strokeButton.normalBorderWidth = 1.0f;
    _strokeButton.normalBorderColor = UIColor.lightGrayColor;
    _strokeButton.normalCornerRadius = 4.0f;
    
    _strokeButton.glb_highlightedTitleColor = UIColor.darkGrayColor;
    _strokeButton.highlightedBorderColor = UIColor.darkGrayColor;
    _strokeButton.highlightedBorderWidth = 2.0f;
    _strokeButton.highlightedCornerRadius = 8.0f;
}

@end
