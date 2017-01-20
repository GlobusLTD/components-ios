//
//  Globus
//

#import "ButtonViewController.h"

@interface ButtonViewController ()

@property(nonatomic, weak) IBOutlet GLBButton* fillButton;
@property(nonatomic, weak) IBOutlet GLBButton* strokeButton;
@property(nonatomic, weak) IBOutlet GLBButton* tintFillButton;
@property(nonatomic, weak) IBOutlet GLBButton* tintStrokeButton;

@property(nonatomic) GLBTextStyle* fillNormalStyle;
@property(nonatomic) GLBTextStyle* fillHighlightedStyle;
@property(nonatomic) GLBTextStyle* strokeNormalStyle;
@property(nonatomic) GLBTextStyle* strokeHighlightedStyle;

@end

@implementation ButtonViewController

#pragma mark - Synthesize

@synthesize fillNormalStyle = _fillNormalStyle;
@synthesize fillHighlightedStyle = _fillHighlightedStyle;
@synthesize strokeNormalStyle = _strokeNormalStyle;
@synthesize strokeHighlightedStyle = _strokeHighlightedStyle;

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _fillButton.contentEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    _fillButton.normalTitleStyle = self.fillNormalStyle;
    _fillButton.normalBackgroundColor = UIColor.lightGrayColor;
    _fillButton.normalCornerRadius = 4.0f;
    _fillButton.highlightedTitleStyle = self.fillHighlightedStyle;
    _fillButton.highlightedBackgroundColor = UIColor.darkGrayColor;
    _fillButton.highlightedCornerRadius = 8.0f;
    
    _strokeButton.contentEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    _strokeButton.normalTitleStyle = self.strokeNormalStyle;
    _strokeButton.normalBorderWidth = 1.0f;
    _strokeButton.normalBorderColor = UIColor.lightGrayColor;
    _strokeButton.normalCornerRadius = 4.0f;
    _strokeButton.highlightedTitleStyle = self.strokeHighlightedStyle;
    _strokeButton.highlightedBorderColor = UIColor.darkGrayColor;
    _strokeButton.highlightedBorderWidth = 2.0f;
    _strokeButton.highlightedCornerRadius = 8.0f;
    
    _tintFillButton.contentEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    _tintFillButton.glb_normalImage = [UIImage glb_imageNamed:@"ButtonIcon" renderingMode:UIImageRenderingModeAlwaysTemplate];
    _tintFillButton.normalTitleStyle = self.fillNormalStyle;
    _tintFillButton.normalBackgroundColor = UIColor.lightGrayColor;
    _tintFillButton.normalCornerRadius = 4.0f;
    _tintFillButton.normalTintColor = UIColor.darkGrayColor;
    _tintFillButton.highlightedTitleStyle = self.fillHighlightedStyle;
    _tintFillButton.highlightedBackgroundColor = UIColor.darkGrayColor;
    _tintFillButton.highlightedCornerRadius = 8.0f;
    _tintFillButton.highlightedTintColor = UIColor.blackColor;
    
    _tintStrokeButton.contentEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    _tintStrokeButton.glb_normalImage = [UIImage glb_imageNamed:@"ButtonIcon" renderingMode:UIImageRenderingModeAlwaysTemplate];
    _tintStrokeButton.normalTitleStyle = self.strokeNormalStyle;
    _tintStrokeButton.normalBorderWidth = 1.0f;
    _tintStrokeButton.normalBorderColor = UIColor.lightGrayColor;
    _tintStrokeButton.normalCornerRadius = 4.0f;
    _tintStrokeButton.normalTintColor = UIColor.lightGrayColor;
    _tintStrokeButton.highlightedTitleStyle = self.strokeHighlightedStyle;
    _tintStrokeButton.highlightedBorderColor = UIColor.darkGrayColor;
    _tintStrokeButton.highlightedBorderWidth = 2.0f;
    _tintStrokeButton.highlightedCornerRadius = 8.0f;
    _tintStrokeButton.highlightedTintColor = UIColor.darkGrayColor;
}

#pragma mark - Property

- (GLBTextStyle*)fillNormalStyle {
    if(_fillNormalStyle == nil) {
        _fillNormalStyle = [GLBTextStyle new];
        _fillNormalStyle.font = [UIFont boldSystemFontOfSize:16];
        _fillNormalStyle.color = UIColor.darkGrayColor;
    }
    return _fillNormalStyle;
}

- (GLBTextStyle*)fillHighlightedStyle {
    if(_fillHighlightedStyle == nil) {
        _fillHighlightedStyle = [GLBTextStyle new];
        _fillHighlightedStyle.font = [UIFont boldSystemFontOfSize:16];
        _fillHighlightedStyle.color = UIColor.blackColor;
    }
    return _fillHighlightedStyle;
}

- (GLBTextStyle*)strokeNormalStyle {
    if(_strokeNormalStyle == nil) {
        _strokeNormalStyle = [GLBTextStyle new];
        _strokeNormalStyle.font = [UIFont italicSystemFontOfSize:16];
        _strokeNormalStyle.color = UIColor.lightGrayColor;
    }
    return _strokeNormalStyle;
}

- (GLBTextStyle*)strokeHighlightedStyle {
    if(_strokeHighlightedStyle == nil) {
        _strokeHighlightedStyle = [GLBTextStyle new];
        _strokeHighlightedStyle.font = [UIFont italicSystemFontOfSize:16];
        _strokeHighlightedStyle.color = UIColor.darkGrayColor;
    }
    return _strokeHighlightedStyle;
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

@end
