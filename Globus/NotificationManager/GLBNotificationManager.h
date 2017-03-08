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

+ (void)setParentWindow:(nullable UIWindow*)parentWindow;
+ (nullable UIWindow*)parentWindow;

+ (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle;
+ (UIStatusBarStyle)statusBarStyle;

+ (void)setStatusBarHidden:(BOOL)statusBarHidden;
+ (BOOL)statusBarHidden;

+ (void)setDisplayType:(GLBNotificationManagerDisplayType)displayType;
+ (GLBNotificationManagerDisplayType)displayType;

+ (void)setTopDecorView:(nullable UIView< GLBNotificationDecorViewProtocol >*)topDecorView;
+ (nullable UIView< GLBNotificationDecorViewProtocol >*)topDecorView;

+ (void)setBottomDecorView:(nullable UIView< GLBNotificationDecorViewProtocol >*)bottomDecorView;
+ (nullable UIView< GLBNotificationDecorViewProtocol >*)bottomDecorView;

+ (nonnull NSArray< GLBNotificationView* >*)visibleViews;

+ (nonnull GLBNotificationView*)showView:(nonnull UIView< GLBNotificationViewProtocol >*)view;
+ (nonnull GLBNotificationView*)showView:(nonnull UIView< GLBNotificationViewProtocol >*)view complete:(nullable GLBNotificationViewBlock)complete;
+ (nonnull GLBNotificationView*)showView:(nonnull UIView< GLBNotificationViewProtocol >*)view pressed:(nullable GLBNotificationViewBlock)pressed;
+ (nonnull GLBNotificationView*)showView:(nonnull UIView< GLBNotificationViewProtocol >*)view pressed:(nullable GLBNotificationViewBlock)pressed complete:(nullable GLBNotificationViewBlock)complete;
+ (nonnull GLBNotificationView*)showView:(nonnull UIView< GLBNotificationViewProtocol >*)view duration:(NSTimeInterval)duration;
+ (nonnull GLBNotificationView*)showView:(nonnull UIView< GLBNotificationViewProtocol >*)view duration:(NSTimeInterval)duration complete:(nullable GLBNotificationViewBlock)complete;
+ (nonnull GLBNotificationView*)showView:(nonnull UIView< GLBNotificationViewProtocol >*)view duration:(NSTimeInterval)duration pressed:(nullable GLBNotificationViewBlock)pressed;
+ (nonnull GLBNotificationView*)showView:(nonnull UIView< GLBNotificationViewProtocol >*)view duration:(NSTimeInterval)duration pressed:(nullable GLBNotificationViewBlock)pressed complete:(nullable GLBNotificationViewBlock)complete;

+ (void)hideNotificationView:(nonnull GLBNotificationView*)notificationView animated:(BOOL)animated;
+ (void)hideNotificationView:(nonnull GLBNotificationView*)notificationView animated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;

+ (void)hideAllAnimated:(BOOL)animated;
+ (void)hideAllAnimated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;

@end

/*--------------------------------------------------*/

@interface GLBNotificationView : UIView

@property(nonatomic, nonnull, readonly, strong) UIView< GLBNotificationViewProtocol >* view;
@property(nonatomic, readonly) NSTimeInterval duration;
@property(nonatomic, nullable, readonly, copy) GLBNotificationViewBlock pressed;

- (void)hideAnimated:(BOOL)animated;
- (void)hideAnimated:(BOOL)animated complete:(nullable GLBNotificationViewBlock)complete;

- (void)willShow;
- (void)didShow;
- (void)willHide;
- (void)didHide;

@end

/*--------------------------------------------------*/

@protocol GLBNotificationDecorViewProtocol < NSObject >

@property(nonatomic, readonly) CGFloat height;

@end

/*--------------------------------------------------*/

@protocol GLBNotificationViewProtocol < NSObject >

@required
- (void)willShowNotificationView:(nonnull GLBNotificationView*)notificationView;
- (void)didShowNotificationView:(nonnull GLBNotificationView*)notificationView;
- (void)willHideNotificationView:(nonnull GLBNotificationView*)notificationView;
- (void)didHideNotificationView:(nonnull GLBNotificationView*)notificationView;

@end

/*--------------------------------------------------*/

@interface UIView (GLBNotification)

@property(nonatomic, nullable, weak) GLBNotificationView* glb_notificationView;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
