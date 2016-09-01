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
@property(nonatomic, strong) GLBTransitionController* transitionModal;
@property(nonatomic, strong) UIViewController* masterViewController;
@property(nonatomic, strong) UIViewController* detailViewController;

- (instancetype)initWithMasterViewController:(UIViewController*)masterViewController
                        detailViewController:(UIViewController*)detailViewController;

- (void)setup NS_REQUIRES_SUPER;

- (void)setNeedUpdate;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
