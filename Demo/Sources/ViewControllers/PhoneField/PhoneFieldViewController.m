//
//  Globus
//

#import "PhoneFieldViewController.h"

@interface PhoneFieldViewController ()

@property(nonatomic, weak) IBOutlet GLBPhoneField* phoneField;
@property(nonatomic, weak) IBOutlet UILabel* regionLabel;
@property(nonatomic, weak) IBOutlet UILabel* phoneNumberLabel;
@property(nonatomic, weak) IBOutlet UILabel* phoneNumberWithoutPrefixLabel;

@end

@implementation PhoneFieldViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GLBTextStyle* textStyle = [GLBTextStyle new];
    textStyle.font = [UIFont boldSystemFontOfSize:16.0f];
    textStyle.color = UIColor.darkGrayColor;
    _phoneField.textStyle = textStyle;
    
    _phoneField.prefix = @"+";
    [_phoneField setDefaultOutputPattern:@"############"];
    [_phoneField addOutputPattern:@"# (###) ###-##-##" forRegExp:@"^7\\d{10}$" userInfo:@"RU"];
    [_phoneField addOutputPattern:@"## (####) ##-##-##" forRegExp:@"^44\\d{10}$" userInfo:@"UK"];
    
    [self changedPhone:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_phoneField becomeFirstResponder];
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

- (IBAction)changedPhone:(id)sender {
    NSString* region = _phoneField.userInfo;
    if(region.glb_isString == YES) {
        _regionLabel.text = region;
    } else {
        _regionLabel.text = @"NONE";
    }
    _phoneNumberLabel.text = _phoneField.phoneNumber;
    _phoneNumberWithoutPrefixLabel.text = _phoneField.phoneNumberWithoutPrefix;
}

@end
