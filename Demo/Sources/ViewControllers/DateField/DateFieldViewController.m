//
//  Globus
//

#import "DateFieldViewController.h"

@interface DateFieldViewController ()

@property(nonatomic, weak) IBOutlet GLBDateField* dateField;

@end

@implementation DateFieldViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GLBTextStyle* textStyle = [GLBTextStyle new];
    textStyle.font = [UIFont boldSystemFontOfSize:16.0f];
    textStyle.color = UIColor.darkGrayColor;
    _dateField.textStyle = textStyle;
    
    GLBTextStyle* placeholderStyle = [GLBTextStyle new];
    placeholderStyle.font = [UIFont boldSystemFontOfSize:16.0f];
    placeholderStyle.color = UIColor.lightGrayColor;
    _dateField.placeholderStyle = placeholderStyle;
    
    _dateField.placeholder = @"Placeholder";
    _dateField.datePickerMode = UIDatePickerModeDate;
    _dateField.dateFormatter = [NSDateFormatter glb_dateFormatterWithFormat:@"DD-MM-yyyy"];
    _dateField.date = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_dateField becomeFirstResponder];
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

- (IBAction)changedDate:(id)sender {
    NSLog(@"changedDate: %@", _dateField.date);
}

@end
