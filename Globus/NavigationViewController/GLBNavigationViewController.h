/*--------------------------------------------------*/

#import "UINavigationController+GLBUI.h"
#import "UIDevice+GLBUI.h"

/*--------------------------------------------------*/

#import "GLBTransitionController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBNavigationViewController : UINavigationController< GLBViewControllerExtension >

@property(nonatomic, readonly, assign, getter=isAppeared) BOOL appeared;
@property(nonatomic, nullable, strong) __kindof GLBTransitionController* transitionModal;
@property(nonatomic, nullable, strong) __kindof GLBTransitionController* transitionNavigation;

+ (nonnull instancetype)viewControllerWithNavigationBarClass:(nullable Class)navigationBarClass toolbarClass:(nullable Class)toolbarClass NS_SWIFT_NAME(viewController(navigationBarClass:toolbarClass:));
+ (nonnull instancetype)viewControllerWithRootViewController:(nonnull UIViewController*)rootViewController NS_SWIFT_NAME(viewController(rootViewController:));

- (void)setup NS_REQUIRES_SUPER;

- (void)setNeedUpdate;

- (void)updateBarsAnimated:(BOOL)animated;
- (void)updateBarsWithViewController:(nonnull UIViewController*)viewController animated:(BOOL)animated;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
