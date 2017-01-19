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
    
    GLBTextStyle* fillNormalTitleStyle = [GLBTextStyle new];
    fillNormalTitleStyle.font = [UIFont boldSystemFontOfSize:16];
    fillNormalTitleStyle.color = UIColor.darkGrayColor;
    
    GLBTextStyle* fillHighlightedTitleStyle = [GLBTextStyle new];
    fillHighlightedTitleStyle.font = [UIFont boldSystemFontOfSize:16];
    fillHighlightedTitleStyle.color = UIColor.blackColor;
    
    _fillButton.normalTitleStyle = fillNormalTitleStyle;
    _fillButton.normalBackgroundColor = UIColor.lightGrayColor;
    _fillButton.normalCornerRadius = 4.0f;
    
    _fillButton.highlightedTitleStyle = fillHighlightedTitleStyle;
    _fillButton.highlightedBackgroundColor = UIColor.darkGrayColor;
    _fillButton.highlightedCornerRadius = 8.0f;
    
    GLBTextStyle* strokeNormalTitleStyle = [GLBTextStyle new];
    strokeNormalTitleStyle.font = [UIFont italicSystemFontOfSize:16];
    strokeNormalTitleStyle.color = UIColor.lightGrayColor;
    
    GLBTextStyle* strokeHighlightedTitleStyle = [GLBTextStyle new];
    strokeHighlightedTitleStyle.font = [UIFont italicSystemFontOfSize:16];
    strokeHighlightedTitleStyle.color = UIColor.darkGrayColor;
    
    _strokeButton.normalTitleStyle = strokeNormalTitleStyle;
    _strokeButton.normalBorderWidth = 1.0f;
    _strokeButton.normalBorderColor = UIColor.lightGrayColor;
    _strokeButton.normalCornerRadius = 4.0f;
    
    _strokeButton.highlightedTitleStyle = strokeHighlightedTitleStyle;
    _strokeButton.highlightedBorderColor = UIColor.darkGrayColor;
    _strokeButton.highlightedBorderWidth = 2.0f;
    _strokeButton.highlightedCornerRadius = 8.0f;
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

@end
