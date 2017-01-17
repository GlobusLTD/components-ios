/*--------------------------------------------------*/

#import "GLBTransitionController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBTransitionController ()

@property(nonatomic, readonly, weak) UIViewController* fromViewController;
@property(nonatomic) CGRect initialFrameFromViewController;
@property(nonatomic) CGRect finalFrameFromViewController;
@property(nonatomic, readonly, weak) UIViewController* toViewController;
@property(nonatomic) CGRect initialFrameToViewController;
@property(nonatomic) CGRect finalFrameToViewController;
@property(nonatomic, readonly, strong) UIView* containerView;
@property(nonatomic, readonly, strong) UIView* fromView;
@property(nonatomic, readonly, strong) UIView* toView;

- (void)_prepareTransitionContext;
- (void)_cleanupTransitionContext;

- (void)_startTransition;
- (void)_completeTransition;

- (void)_startInteractive;
- (void)_updateInteractive:(CGFloat)percentComplete;
- (void)_finishInteractive;
- (void)_cancelInteractive;
- (void)_completeInteractive;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
