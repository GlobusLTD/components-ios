//
//  Globus
//

#import "LabelViewController.h"

@interface LabelViewController ()

@property(nonatomic, weak) IBOutlet GLBLabel* label;

@end

@implementation LabelViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GLBTextStyle* textStyle = [GLBTextStyle new];
    textStyle.font = [UIFont systemFontOfSize:16.0f];
    _label.textStyle = textStyle;
    
    _label.text = @"This is normal text.\nThis is highlight text.\nThis is pressed text.";
    _label.textAlignment = NSTextAlignmentCenter;
    _label.lineBreakMode = NSLineBreakByWordWrapping;
    _label.numberOfLines = 0;
    
    GLBTextStyle* normalStyle = [GLBTextStyle new];
    normalStyle.font = [UIFont systemFontOfSize:15.0f];
    normalStyle.color = UIColor.darkGrayColor;
    
    GLBTextStyle* highlightStyle = [GLBTextStyle new];
    highlightStyle.font = [UIFont systemFontOfSize:17.0f];
    highlightStyle.color = UIColor.darkGrayColor;
    
    [_label addLink:@"highlight" normalStyle:normalStyle highlightStyle:highlightStyle pressed:^{
        NSLog(@"highlight");
    }];
    [_label addLink:@"pressed" normalStyle:normalStyle highlightStyle:highlightStyle pressed:^{
        NSLog(@"pressed");
    }];
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

@end
