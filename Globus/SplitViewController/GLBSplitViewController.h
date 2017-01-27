/*--------------------------------------------------*/

#import "UIViewController+GLBUI.h"
#import "UIDevice+GLBUI.h"

/*--------------------------------------------------*/

#import "GLBTransitionController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBSplitViewController : UISplitViewController< GLBViewControllerExtension >

@property(nonatomic, readonly, assign, getter=isAppeared) BOOL appeared;
@property(nonatomic, nullable, strong) __kindof GLBTransitionController* transitionModal;
@property(nonatomic, nullable, strong) __kindof UIViewController* masterViewController;
@property(nonatomic, nullable, strong) __kindof UIViewController* detailViewController;

+ (nonnull instancetype)viewControllerWithMasterViewController:(nullable __kindof UIViewController*)masterViewController detailViewController:(nullable __kindof UIViewController*)detailViewController NS_SWIFT_NAME(viewController(masterViewController:detailViewController:));
- (nonnull instancetype)initWithMasterViewController:(nullable __kindof UIViewController*)masterViewController detailViewController:(nullable __kindof UIViewController*)detailViewController;

- (void)setup NS_REQUIRES_SUPER;

- (void)setNeedUpdate;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
