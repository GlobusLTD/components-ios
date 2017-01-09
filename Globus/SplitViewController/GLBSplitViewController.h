/*--------------------------------------------------*/

#import "UIViewController+GLBUI.h"
#import "UIDevice+GLBUI.h"

/*--------------------------------------------------*/

#import "GLBTransitionController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBSplitViewController : UISplitViewController< GLBViewController >

@property(nonatomic, readonly, assign, getter=isAppeared) BOOL appeared;
@property(nonatomic, nullable, strong) __kindof GLBTransitionController* transitionModal;
@property(nonatomic, nullable, strong) __kindof UIViewController* masterViewController;
@property(nonatomic, nullable, strong) __kindof UIViewController* detailViewController;

+ (instancetype _Nonnull)viewControllerWithMasterViewController:(__kindof UIViewController* _Nullable)masterViewController detailViewController:(__kindof UIViewController* _Nullable)detailViewController NS_SWIFT_NAME(viewController(masterViewController:detailViewController:));
- (instancetype _Nonnull)initWithMasterViewController:(__kindof UIViewController* _Nullable)masterViewController detailViewController:(__kindof UIViewController* _Nullable)detailViewController;

- (void)setup NS_REQUIRES_SUPER;

- (void)setNeedUpdate;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
