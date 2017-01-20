//
//  Globus
//

#import "NotificationsViewController.h"
#import "NotificationTopDecorView.h"
#import "NotificationBottomDecorView.h"
#import "NotificationView.h"

@interface NotificationsViewController ()

@property(nonatomic, weak) IBOutlet UISegmentedControl* segmentedControl;
@property(nonatomic, weak) IBOutlet UISwitch* useTopDecorView;
@property(nonatomic, weak) IBOutlet UISwitch* useBottomDecorView;;
@property(nonatomic, weak) IBOutlet UITextField* textField;

@end

@implementation NotificationsViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GLBNotificationManager setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [_segmentedControl removeAllSegments];
    [_segmentedControl insertSegmentWithTitle:@"List" atIndex:_segmentedControl.numberOfSegments animated:NO];
    [_segmentedControl insertSegmentWithTitle:@"Stack" atIndex:_segmentedControl.numberOfSegments animated:NO];
    switch ([GLBNotificationManager displayType]) {
        case GLBNotificationManagerDisplayTypeList:
            _segmentedControl.selectedSegmentIndex = 0;
            break;
        case GLBNotificationManagerDisplayTypeStack:
            _segmentedControl.selectedSegmentIndex = 1;
            break;
    }
    
    _useTopDecorView.on = ([GLBNotificationManager topDecorView] != nil);
    _useBottomDecorView.on = ([GLBNotificationManager bottomDecorView] != nil);
    
    _textField.text = @"Сообщение";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_textField becomeFirstResponder];
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

- (IBAction)changeDisplayType:(id)sender {
    [GLBNotificationManager hideAllAnimated:YES complete:^{
        switch(_segmentedControl.selectedSegmentIndex) {
            case 0:
                [GLBNotificationManager setDisplayType:GLBNotificationManagerDisplayTypeList];
                break;
            case 1:
                [GLBNotificationManager setDisplayType:GLBNotificationManagerDisplayTypeStack];
                break;
        }
    }];
}

- (IBAction)changeTopDecorView:(id)sender {
    if(_useTopDecorView.on == YES) {
        [GLBNotificationManager setTopDecorView:[NotificationTopDecorView new]];
    } else {
        [GLBNotificationManager setTopDecorView:nil];
    }
}

- (IBAction)changeBottomDecorView:(id)sender {
    if(_useBottomDecorView.on == YES) {
        [GLBNotificationManager setBottomDecorView:[NotificationBottomDecorView new]];
    } else {
        [GLBNotificationManager setBottomDecorView:nil];
    }
}

- (IBAction)pressedShow:(id)sender {
    NotificationView* view = [NotificationView new];
    view.title = _textField.text;
    [GLBNotificationManager showView:view];
}

@end
