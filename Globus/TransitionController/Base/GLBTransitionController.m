/*--------------------------------------------------*/

#import "GLBTransitionController+Private.h"

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
    _completionSpeed = 720.0;
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
        if(_transitionContext != nil) {
            [self _cleanupTransitionContext];
        }
        _transitionContext = transitionContext;
        if(_transitionContext != nil) {
            [self _prepareTransitionContext];
        }
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
    if([UIDevice glb_compareSystemVersion:@"8.0"] != NSOrderedAscending) {
        _fromView = [_transitionContext viewForKey:UITransitionContextFromViewKey];
        _toView = [_transitionContext viewForKey:UITransitionContextToViewKey];
    }
    if(_fromView == nil) {
        _fromView = _fromViewController.view;
    }
    if(_toView == nil) {
        _toView = _toViewController.view;
    }
}

- (void)_cleanupTransitionContext {
    _fromViewController = nil;
    _initialFrameFromViewController = CGRectNull;
    _finalFrameFromViewController = CGRectNull;
    _toViewController = nil;
    _initialFrameToViewController = CGRectNull;
    _finalFrameToViewController = CGRectNull;
    _containerView = nil;
    _fromView = nil;
    _toView = nil;
}

- (void)_startTransition {
}

- (void)_completeTransition {
    [_transitionContext completeTransition:([_transitionContext transitionWasCancelled] == NO)];
    self.transitionContext = nil;
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
    self.transitionContext = nil;
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
    self.transitionContext = nil;
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
    return _completionCurve;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
