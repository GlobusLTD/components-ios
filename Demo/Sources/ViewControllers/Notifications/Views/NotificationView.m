//
//  Globus
//

#import "NotificationView.h"

@interface NotificationView ()

@property(nonatomic, weak) IBOutlet GLBLabel* titleLabel;

@end

@implementation NotificationView

- (void)setTitle:(NSString*)title {
    _titleLabel.text = title;
}

- (NSString*)title {
    return _titleLabel.text;
}

#pragma mark - GLBNotificationViewProtocol

- (void)willShowNotificationView:(GLBNotificationView*)notificationView {
    NSLog(@"willShowNotificationView");
}

- (void)didShowNotificationView:(GLBNotificationView*)notificationView {
    NSLog(@"didShowNotificationView");
}

- (void)willHideNotificationView:(GLBNotificationView*)notificationView {
    NSLog(@"willHideNotificationView");
}

- (void)didHideNotificationView:(GLBNotificationView*)notificationView {
    NSLog(@"didHideNotificationView");
}

@end
