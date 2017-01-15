//
//  Globus
//

#import "TextViewViewController.h"

@interface TextViewViewController ()

@property(nonatomic, weak) IBOutlet GLBTextView* textView;

@end

@implementation TextViewViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textView.glb_borderColor = UIColor.darkGrayColor;
    _textView.glb_borderWidth = 1.0f;
    _textView.glb_cornerRadius = 4.0f;
    
    _textView.minimumHeight = 48.0f;
    _textView.maximumHeight = 96.0f;

    GLBTextStyle* placeholderStyle = [GLBTextStyle new];
    placeholderStyle.font = [UIFont boldSystemFontOfSize:16.0f];
    placeholderStyle.color = UIColor.lightGrayColor;
    _textView.placeholderStyle = placeholderStyle;
    _textView.placeholder = @"Placeholder";
    _textView.actionValueChanged = [GLBAction actionWithTarget:self action:@selector(changedText:)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_textView becomeFirstResponder];
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

- (IBAction)changedText:(id)sender {
    NSLog(@"ChangedText: %@", _textView.text);
}

@end
