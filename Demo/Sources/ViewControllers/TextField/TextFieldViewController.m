//
//  Globus
//

#import "TextFieldViewController.h"

@interface TextFieldViewController ()

@property(nonatomic, weak) IBOutlet GLBTextField* textField;

@end

@implementation TextFieldViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GLBTextStyle* textStyle = [GLBTextStyle new];
    textStyle.font = [UIFont boldSystemFontOfSize:16.0f];
    textStyle.color = UIColor.darkGrayColor;
    _textField.textStyle = textStyle;
    
    GLBTextStyle* placeholderStyle = [GLBTextStyle new];
    placeholderStyle.font = [UIFont boldSystemFontOfSize:16.0f];
    placeholderStyle.color = UIColor.lightGrayColor;
    _textField.placeholderStyle = placeholderStyle;
    
    _textField.placeholder = @"Placeholder";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_textField becomeFirstResponder];
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

- (IBAction)changedText:(id)sender {
    NSLog(@"ChangedText: %@", _textField.text);
}

@end
