/*--------------------------------------------------*/

#import "NSArray+GLBNS.h"

/*--------------------------------------------------*/

#import "UIApplication+GLBUI.h"
#import "UIWindow+GLBUI.h"
#import "UIView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@protocol GLBNotificationDecorViewProtocol;
@protocol GLBNotificationViewProtocol;
@class GLBNotificationView;

/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBNotificationManagerDisplayType) {
    GLBNotificationManagerDisplayTypeList,
    GLBNotificationManagerDisplayTypeStack
};

/*--------------------------------------------------*/

typedef void(^GLBNotificationViewBlock)(GLBNotificationView* _Nonnull notificationView);

/*--------------------------------------------------*/

@interface GLBNotificationManager : NSObject

+ (void)setParentWindow:(UIWindow* _Nullable)parentWindow;
+ (UIWindow* _Nullable)parentWindow;

+ (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle;
+ (UIStatusBarStyle)statusBarStyle;

+ (void)setStatusBarHidden:(BOOL)statusBarHidden;
+ (BOOL)statusBarHidden;

+ (void)setDisplayType:(GLBNotificationManagerDisplayType)displayType;
+ (GLBNotificationManagerDisplayType)displayType;

+ (void)setTopDecorView:(UIView< GLBNotificationDecorViewProtocol >* _Nullable)topDecorView;
+ (UIView< GLBNotificationDecorViewProtocol >* _Nullable)topDecorView;

+ (void)setBottomDecorView:(UIView< GLBNotificationDecorViewProtocol >* _Nullable)bottomDecorView;
+ (UIView< GLBNotificationDecorViewProtocol >* _Nullable)bottomDecorView;

+ (NSArray< GLBNotificationView* >* _Nonnull)visibleViews;

+ (GLBNotificationView* _Nonnull)showView:(UIView< GLBNotificationViewProtocol >* _Nonnull)view;
+ (GLBNotificationView* _Nonnull)showView:(UIView< GLBNotificationViewProtocol >* _Nonnull)view complete:(GLBNotificationViewBlock _Nullable)complete;
+ (GLBNotificationView* _Nonnull)showView:(UIView< GLBNotificationViewProtocol >* _Nonnull)view pressed:(GLBNotificationViewBlock _Nullable)pressed;
+ (GLBNotificationView* _Nonnull)showView:(UIView< GLBNotificationViewProtocol >* _Nonnull)view pressed:(GLBNotificationViewBlock _Nullable)pressed complete:(GLBNotificationViewBlock _Nullable)complete;
+ (GLBNotificationView* _Nonnull)showView:(UIView< GLBNotificationViewProtocol >* _Nonnull)view duration:(NSTimeInterval)duration;
+ (GLBNotificationView* _Nonnull)showView:(UIView< GLBNotificationViewProtocol >* _Nonnull)view duration:(NSTimeInterval)duration complete:(GLBNotificationViewBlock _Nullable)complete;
+ (GLBNotificationView* _Nonnull)showView:(UIView< GLBNotificationViewProtocol >* _Nonnull)view duration:(NSTimeInterval)duration pressed:(GLBNotificationViewBlock _Nullable)pressed;
+ (GLBNotificationView* _Nonnull)showView:(UIView< GLBNotificationViewProtocol >* _Nonnull)view duration:(NSTimeInterval)duration pressed:(GLBNotificationViewBlock _Nullable)pressed complete:(GLBNotificationViewBlock _Nullable)complete;

+ (void)hideNotificationView:(GLBNotificationView* _Nonnull)notificationView animated:(BOOL)animated;
+ (void)hideNotificationView:(GLBNotificationView* _Nonnull)notificationView animated:(BOOL)animated complete:(GLBSimpleBlock _Nullable)complete;

+ (void)hideAllAnimated:(BOOL)animated;
+ (void)hideAllAnimated:(BOOL)animated complete:(GLBSimpleBlock _Nullable)complete;

@end

/*--------------------------------------------------*/

@interface GLBNotificationView : UIView

@property(nonatomic, nonnull, readonly, strong) UIView< GLBNotificationViewProtocol >* view;
@property(nonatomic, readonly, assign) NSTimeInterval duration;
@property(nonatomic, nullable, readonly, copy) GLBNotificationViewBlock pressed;

- (void)hideAnimated:(BOOL)animated;
- (void)hideAnimated:(BOOL)animated complete:(GLBNotificationViewBlock _Nullable)complete;

- (void)willShow;
- (void)didShow;
- (void)willHide;
- (void)didHide;

@end

/*--------------------------------------------------*/

@protocol GLBNotificationDecorViewProtocol < NSObject >

@property(nonatomic, readonly, assign) CGFloat height;

@end

/*--------------------------------------------------*/

@protocol GLBNotificationViewProtocol < NSObject >

@required
- (void)willShowNotificationView:(GLBNotificationView* _Nonnull)notificationView;
- (void)didShowNotificationView:(GLBNotificationView* _Nonnull)notificationView;
- (void)willHideNotificationView:(GLBNotificationView* _Nonnull)notificationView;
- (void)didHideNotificationView:(GLBNotificationView* _Nonnull)notificationView;

@end

/*--------------------------------------------------*/

@interface UIView (GLBNotification)

@property(nonatomic, nullable, weak) GLBNotificationView* glb_notificationView;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
