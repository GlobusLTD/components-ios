/*--------------------------------------------------*/

#import "GLBTransitionController+Private.h"
#import "UIDevice+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBTransitionController

@synthesize transitionContext = _transitionContext;
@synthesize operation = _operation;
@synthesize duration = _duration;
@synthesize percentComplete = _percentComplete;
@synthesize completionSpeed = _completionSpeed;
@synthesize completionCurve = _completionCurve;
@synthesize interactive = _interactive;

@synthesize fromViewController = _fromViewController;
@synthesize initialFrameFromViewController = _initialFrameFromViewController;
@synthesize finalFrameFromViewController = _finalFrameFromViewController;
@synthesize toViewController = _toViewController;
@synthesize initialFrameToViewController = _initialFrameToViewController;
@synthesize finalFrameToViewController = _finalFrameToViewController;
@synthesize containerView = _containerView;
@synthesize fromView = _fromView;
@synthesize toView = _toView;

#pragma mark - Init / Free

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _operation = GLBTransitionOperationPresent;
    _duration = 0.3f;
    _completionSpeed = 720.0f;
    _completionSpeed = UIViewAnimationCurveEaseOut;
    _initialFrameFromViewController = CGRectNull;
    _finalFrameFromViewController = CGRectNull;
    _initialFrameToViewController = CGRectNull;
    _finalFrameToViewController = CGRectNull;
}

- (void)dealloc {
}

#pragma mark - Property

- (void)setTransitionContext:(id< UIViewControllerContextTransitioning >)transitionContext {
    if(_transitionContext != transitionContext) {
        _transitionContext = transitionContext;
        [self _prepareTransitionContext];
    }
}

#pragma mark - Public

- (BOOL)isAnimated {
    return [_transitionContext isAnimated];
}

- (BOOL)isCancelled {
    return [_transitionContext transitionWasCancelled];
}

- (void)beginInteractive {
    _interactive = YES;
}

- (void)updateInteractive:(CGFloat)percentComplete {
    if((_interactive == YES) && (_percentComplete != percentComplete)) {
        _percentComplete = percentComplete;
        [self _updateInteractive:percentComplete];
    }
}

- (void)finishInteractive {
    if(_interactive == YES) {
        [self _finishInteractive];
    }
}

- (void)cancelInteractive {
    if(_interactive == YES) {
        [self _cancelInteractive];
    }
}

- (void)endInteractive {
    _interactive = NO;
}

#pragma mark - Private

- (void)_prepareTransitionContext {
    _fromViewController = [_transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    _initialFrameFromViewController = [_transitionContext initialFrameForViewController:_fromViewController];
    _finalFrameFromViewController = [_transitionContext finalFrameForViewController:_fromViewController];
    _toViewController = [_transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    _initialFrameToViewController = [_transitionContext initialFrameForViewController:_toViewController];
    _finalFrameToViewController = [_transitionContext finalFrameForViewController:_toViewController];
    _containerView = _transitionContext.containerView;
    if(UIDevice.glb_systemVersion >= 8.0f) {
        _fromView = [_transitionContext viewForKey:UITransitionContextFromViewKey];
        _toView = [_transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        _fromView = _fromViewController.view;
        _toView = _toViewController.view;
    }
}

- (void)_startTransition {
}

- (void)_completeTransition {
    [_transitionContext completeTransition:([_transitionContext transitionWasCancelled] == NO)];
}

- (void)_startInteractive {
}

- (void)_updateInteractive:(CGFloat)percentComplete {
    [_transitionContext updateInteractiveTransition:percentComplete];
}

- (void)_finishInteractive {
    [_transitionContext finishInteractiveTransition];
}

- (void)_cancelInteractive {
    [_transitionContext cancelInteractiveTransition];
}

- (void)_completeInteractive {
    [_transitionContext completeTransition:([_transitionContext transitionWasCancelled] == NO)];
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id< UIViewControllerContextTransitioning >)transitionContext {
    return _duration;
}

- (void)animateTransition:(id< UIViewControllerContextTransitioning >)transitionContext {
    self.transitionContext = transitionContext;
    [self _startTransition];
}

- (void)animationEnded:(BOOL)transitionComplete {
}

#pragma mark - UIViewControllerInteractiveTransitioning

- (void)startInteractiveTransition:(id< UIViewControllerContextTransitioning >)transitionContext {
    if((_interactive == YES) && ([transitionContext isInteractive] == YES)) {
        self.transitionContext = transitionContext;
        [self _startInteractive];
    } else {
        [self animateTransition:transitionContext];
    }
}

- (CGFloat)completionSpeed {
    return _completionSpeed;
}

- (UIViewAnimationCurve)completionCurve {
    return _completionSpeed;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
