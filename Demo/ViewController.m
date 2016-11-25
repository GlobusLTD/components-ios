/*--------------------------------------------------*/

#import "ViewController.h"
#import "GLBCocoaPods.h"

/*--------------------------------------------------*/

@interface ViewController ()

@property(nonatomic, weak) IBOutlet GLBLabel* label;

@end

/*--------------------------------------------------*/

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GLBTextStyle* textStyle = [GLBTextStyle new];
    textStyle.font = [UIFont systemFontOfSize:14.0f];
    _label.textStyle = textStyle;
    
    _label.text = @"This is normal text.\nThis is highlight text.\nThis is pressed text.";
    _label.textAlignment = NSTextAlignmentCenter;
    _label.lineBreakMode = NSLineBreakByWordWrapping;
    _label.numberOfLines = 0;
    
    GLBTextStyle* normalStyle = [GLBTextStyle new];
    normalStyle.font = [UIFont systemFontOfSize:12.0f];
    normalStyle.color = UIColor.blueColor;
    
    GLBTextStyle* highlightStyle = [GLBTextStyle new];
    highlightStyle.font = [UIFont systemFontOfSize:16.0f];
    highlightStyle.color = UIColor.redColor;
    
    [_label addLink:@"highlight" normalStyle:normalStyle highlightStyle:highlightStyle pressed:^{
        NSLog(@"highlight");
    }];
    [_label addLink:@"pressed" normalStyle:normalStyle highlightStyle:highlightStyle pressed:^{
        NSLog(@"pressed");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

/*--------------------------------------------------*/
