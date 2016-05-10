/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBNotificationView;

/*--------------------------------------------------*/

typedef void(^GLBNotificationPressed)(GLBNotificationView* notificationView);

/*--------------------------------------------------*/

@interface GLBNotificationManager : NSObject

+ (void)setParentWindow:(UIWindow*)parentWindow;
+ (UIWindow*)parentWindow;

+ (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle;
+ (UIStatusBarStyle)statusBarStyle;

+ (void)setStatusBarHidden:(BOOL)statusBarHidden;
+ (BOOL)statusBarHidden;

+ (GLBNotificationView*)showView:(UIView*)view;
+ (GLBNotificationView*)showView:(UIView*)view pressed:(GLBNotificationPressed)pressed;
+ (GLBNotificationView*)showView:(UIView*)view duration:(NSTimeInterval)duration;
+ (GLBNotificationView*)showView:(UIView*)view duration:(NSTimeInterval)duration pressed:(GLBNotificationPressed)pressed;

+ (void)hideNotificationView:(GLBNotificationView*)notificationView animated:(BOOL)animated;
+ (void)hideAllAnimated:(BOOL)animated;

@end

/*--------------------------------------------------*/

@interface GLBNotificationView : UIView

@property(nonatomic, readonly, strong) UIView* view;
@property(nonatomic, readonly, assign) NSTimeInterval duration;
@property(nonatomic, readonly, copy) GLBNotificationPressed pressed;

- (void)hideAnimated:(BOOL)animated;

- (void)willShow;
- (void)didShow;
- (void)willHide;
- (void)didHide;

@end

/*--------------------------------------------------*/

@interface UIView (GLBNotification)

@property(nonatomic, weak) GLBNotificationView* glb_notificationView;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
