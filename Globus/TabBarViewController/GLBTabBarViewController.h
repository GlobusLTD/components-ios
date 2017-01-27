/*--------------------------------------------------*/

#import "UIViewController+GLBUI.h"
#import "UIDevice+GLBUI.h"

/*--------------------------------------------------*/

#import "GLBTransitionController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBTabBarViewController : UITabBarController< GLBViewControllerExtension >

@property(nonatomic, readonly, assign, getter=isAppeared) BOOL appeared;
@property(nonatomic, getter=isNavigationBarHidden) BOOL navigationBarHidden;
@property(nonatomic, getter=isToolbarHidden) BOOL toolbarHidden;
@property(nonatomic) BOOL hidesBarsWhenKeyboardAppears;
@property(nonatomic) BOOL hidesBarsOnSwipe;
@property(nonatomic) BOOL hidesBarsWhenVerticallyCompact;
@property(nonatomic) BOOL hidesBarsOnTap;
@property(nonatomic, nullable, strong) __kindof GLBTransitionController* transitionModal;
@property(nonatomic, nullable, strong) __kindof GLBTransitionController* transitionNavigation;

+ (nullable instancetype)viewControllerWithViewControllers:(nullable NSArray< __kindof UIViewController* >*)viewControllers NS_SWIFT_NAME(viewController(viewControllers:));

- (void)setup NS_REQUIRES_SUPER;

- (void)setNavigationBarHidden:(BOOL)navigationBarHidden animated:(BOOL)animated;
- (void)setToolbarHidden:(BOOL)toolbarHidden animated:(BOOL)animated;

- (void)setNeedUpdate;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
