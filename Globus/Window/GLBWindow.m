/*--------------------------------------------------*/

#import "GLBWindow.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#if __has_include("GLBActivityView.h")
#import "GLBActivityView.h"
#endif

/*--------------------------------------------------*/

@interface GLBWindow ()

@property(nonatomic, strong) UIView* emptyView;
@property(nonatomic, strong) UITapGestureRecognizer* emptyTabGesture;
@property(nonatomic, strong) UIPanGestureRecognizer* emptyPanGesture;

- (void)_willShowKeyboard:(NSNotification*)notification;
- (void)_didHideKeyboard:(NSNotification*)notification;

- (void)_resignCurrentFirstResponder;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface GLBWindowTransitionContext: NSObject < UIViewControllerContextTransitioning >

@property(nonatomic, readonly, weak) GLBWindow* window;
@property(nonatomic, readonly, strong) UIViewController* fromViewController;
@property(nonatomic, readonly, strong) UIViewController* toViewController;

- (instancetype)initWithWindow:(GLBWindow*)window fromViewController:(UIViewController*)fromViewController toViewController:(UIViewController*)toViewController;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBWindow

#pragma mark - Init / Free

- (instancetype)init {
    self = [super initWithFrame:UIScreen.mainScreen.bounds];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.glb_userWindow = YES;
    _hideKeyboardIfTouched = YES;
}

- (void)dealloc {
}

#pragma mark - UIWindow

- (void)becomeKeyWindow {
    [super becomeKeyWindow];
    
    if(_emptyView == nil) {
        _emptyView = [[UIView alloc] initWithFrame:self.bounds];
        if(_emptyView != nil) {
            _emptyView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
            _emptyView.backgroundColor = [UIColor clearColor];
            _emptyView.hidden = YES;
            [self addSubview:_emptyView];
            
            self.emptyTabGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_resignCurrentFirstResponder)];
            [_emptyView addGestureRecognizer:self.emptyTabGesture];
            
            self.emptyPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_resignCurrentFirstResponder)];
            [_emptyView addGestureRecognizer:self.emptyPanGesture];
        }
    }
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(_willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(_didHideKeyboard:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)resignKeyWindow {
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
    if(_emptyView != nil) {
        _emptyView.hidden = YES;
    }
    [super resignKeyWindow];
}

- (void)didAddSubview:(UIView*)subview {
    [super didAddSubview:subview];
#if __has_include("GLBActivityView.h")
    if(_activityView != nil) {
        [self bringSubviewToFront:_activityView];
    }
#endif
    [self bringSubviewToFront:_emptyView];
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event {
    if(_emptyView.isHidden == NO) {
        if(self.hideKeyboardIfTouched == YES) {
            UIViewController* currentController = self.glb_currentViewController;
            UIViewController* parentController = [currentController parentViewController];
            if(parentController == nil) {
                parentController = currentController;
            }
            UIView* view = nil;
            if([currentController conformsToProtocol:@protocol(GLBWindowExtension)] == YES) {
                UIViewController< GLBWindowExtension >* extension = (UIViewController< GLBWindowExtension >*)currentController;
                if(extension.hideKeyboardIfTouched == NO) {
                    _emptyView.hidden = YES;
                    view = [super hitTest:point withEvent:event];
                    _emptyView.hidden = NO;
                }
            }
            if(view == nil) {
                view = [parentController.view hitTest:point withEvent:event];
                if(view.canBecomeFirstResponder == NO) {
                    if([view isKindOfClass:UIControl.class] == YES) {
                        UIControl* control = (UIControl*)view;
                        if([control isEnabled] == NO) {
                            view = _emptyView;
                        }
                    } else {
                        view = _emptyView;
                    }
                }
            }
            return view;
        } else {
            _emptyView.hidden = YES;
            UIView* view = [super hitTest:point withEvent:event];
            _emptyView.hidden = NO;
            return view;
        }
    }
    return [super hitTest:point withEvent:event];
}

#pragma mark - Property

#if __has_include("GLBActivityView.h")

- (void)setActivityView:(GLBActivityView*)activityView {
    if(_activityView != activityView) {
        if(_activityView != nil) {
            [_activityView removeFromSuperview];
        }
        _activityView = activityView;
        if(_activityView != nil) {
            _activityView.frame = self.bounds;
            [self addSubview:_activityView];
        }
    }
}

#endif

#pragma mark - Public

- (void)changeRootViewController:(UIViewController*)rootViewController animated:(BOOL)animated {
    if((animated == YES) && (_transition != nil)) {
        GLBWindowTransitionContext* context = [[GLBWindowTransitionContext alloc] initWithWindow:self fromViewController:self.rootViewController toViewController:rootViewController];
        [_transition animateTransition:context];
    } else {
        [self setRootViewController:rootViewController];
    }
}

#pragma mark - Private

- (void)_willShowKeyboard:(NSNotification*)notification {
    _emptyView.hidden = NO;
}

- (void)_didHideKeyboard:(NSNotification*)notification {
    _emptyView.hidden = YES;
}

- (void)_resignCurrentFirstResponder {
    UIResponder* responder = UIResponder.glb_currentFirstResponder;
    if(responder != nil) {
        [responder resignFirstResponder];
    }
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBWindowTransitionContext

#pragma mark - Init / Free

- (instancetype)initWithWindow:(GLBWindow*)window fromViewController:(UIViewController*)fromViewController toViewController:(UIViewController*)toViewController {
    self = [super init];
    if(self != nil) {
        _window = window;
        _fromViewController = fromViewController;
        _toViewController = toViewController;
    }
    return self;
}

#pragma mark - UIViewControllerContextTransitioning

- (UIView*)containerView {
    return _window;
}

- (BOOL)isAnimated {
    return YES;
}

- (BOOL)isInteractive {
    return NO;
}

- (BOOL)transitionWasCancelled {
    return NO;
}

- (UIModalPresentationStyle)presentationStyle {
    return UIModalPresentationNone;
}

- (void)updateInteractiveTransition:(CGFloat)percentComplete {
}

- (void)finishInteractiveTransition {
}

- (void)cancelInteractiveTransition {
}

- (void)pauseInteractiveTransition {
}

- (void)completeTransition:(BOOL)didComplete {
    if(didComplete == YES) {
        [_window setRootViewController:_toViewController];
    }
    [_window.transition animationEnded:didComplete];
}

- (UIViewController*)viewControllerForKey:(UITransitionContextViewControllerKey)key {
    if([key isEqualToString:UITransitionContextFromViewControllerKey] == YES) {
        return _fromViewController;
    } else if([key isEqualToString:UITransitionContextToViewControllerKey] == YES) {
        return _toViewController;
    }
    return nil;
}

- (UIView*)viewForKey:(UITransitionContextViewKey)key {
    return nil;
}

- (CGAffineTransform)targetTransform {
    return CGAffineTransformIdentity;
}

- (CGRect)initialFrameForViewController:(UIViewController*)viewController {
    return _window.frame;
}

- (CGRect)finalFrameForViewController:(UIViewController*)viewController {
    return _window.frame;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
