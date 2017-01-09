/*--------------------------------------------------*/

#import "NSArray+GLBNS.h"

/*--------------------------------------------------*/

#import "UIApplication+GLBUI.h"
#import "UIWindow+GLBUI.h"
#import "UIView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBNotificationView;

/*--------------------------------------------------*/

typedef void(^GLBNotificationPressed)(GLBNotificationView* _Nonnull notificationView);

/*--------------------------------------------------*/

@interface GLBNotificationManager : NSObject

+ (void)setParentWindow:(UIWindow* _Nullable)parentWindow;
+ (UIWindow* _Nullable)parentWindow;

+ (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle;
+ (UIStatusBarStyle)statusBarStyle;

+ (void)setStatusBarHidden:(BOOL)statusBarHidden;
+ (BOOL)statusBarHidden;

+ (GLBNotificationView* _Nonnull)showView:(UIView* _Nonnull)view;
+ (GLBNotificationView* _Nonnull)showView:(UIView* _Nonnull)view pressed:(GLBNotificationPressed _Nullable)pressed;
+ (GLBNotificationView* _Nonnull)showView:(UIView* _Nonnull)view duration:(NSTimeInterval)duration;
+ (GLBNotificationView* _Nonnull)showView:(UIView* _Nonnull)view duration:(NSTimeInterval)duration pressed:(GLBNotificationPressed _Nullable)pressed;

+ (void)hideNotificationView:(GLBNotificationView* _Nonnull)notificationView animated:(BOOL)animated;
+ (void)hideAllAnimated:(BOOL)animated;

@end

/*--------------------------------------------------*/

@interface GLBNotificationView : UIView

@property(nonatomic, nonnull, readonly, strong) UIView* view;
@property(nonatomic, readonly, assign) NSTimeInterval duration;
@property(nonatomic, nullable, readonly, copy) GLBNotificationPressed pressed;

- (void)hideAnimated:(BOOL)animated;

- (void)willShow;
- (void)didShow;
- (void)willHide;
- (void)didHide;

@end

/*--------------------------------------------------*/

@interface UIView (GLBNotification)

@property(nonatomic, nullable, weak) GLBNotificationView* glb_notificationView;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
