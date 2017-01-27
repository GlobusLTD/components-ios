/*--------------------------------------------------*/

#import "GLBNavigationViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#if __has_include("GLBSlideViewController.h")
#import "GLBSlideViewController.h"
#endif

/*--------------------------------------------------*/

@interface GLBNavigationViewController () <
    UIViewControllerTransitioningDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate
#if __has_include("GLBSlideViewController.h")
    ,GLBSlideViewControllerDelegate
#endif
>

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBNavigationViewController

#pragma mark - Init / Free

+ (instancetype)viewControllerWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass {
    return [[self alloc] initWithNavigationBarClass:navigationBarClass toolbarClass:toolbarClass];
}

+ (instancetype)viewControllerWithRootViewController:(UIViewController*)rootViewController {
    return [[self alloc] initWithRootViewController:rootViewController];
}

- (instancetype)initWithCoder:(NSCoder*)coder {
    self = [super initWithCoder:coder];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString*)nib bundle:(NSBundle*)bundle {
    self = [super initWithNibName:nib bundle:bundle];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass {
    self = [super initWithNavigationBarClass:navigationBarClass toolbarClass:toolbarClass];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithRootViewController:(UIViewController*)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.delegate = self;
    self.transitioningDelegate = self;
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

#pragma mark - Property

- (void)setView:(UIView*)view {
    super.view = view;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    if(view == nil) {
        [self viewDidUnload];
    }
#pragma clang diagnostic pop
}

- (UIGestureRecognizer*)interactivePopGestureRecognizer {
    UIGestureRecognizer* gesture = super.interactivePopGestureRecognizer;
    gesture.delegate = self;
    return gesture;
}

#pragma mark - Public

- (void)setNeedUpdate {
    for(id object in self.viewControllers) {
        if([object respondsToSelector:@selector(setNeedUpdate)] == YES) {
            [object setNeedUpdate];
        }
    }
}

- (void)updateBarsAnimated:(BOOL)animated {
    UIViewController* viewController = self.topViewController;
    if(viewController != nil) {
        [self updateBarsWithViewController:viewController animated:animated];
    }
}

- (void)updateBarsWithViewController:(UIViewController*)viewController animated:(BOOL)animated {
    id vc = viewController;
    if([vc respondsToSelector:@selector(isNavigationBarHidden)] == YES) {
        [self setNavigationBarHidden:[vc isNavigationBarHidden] animated:animated];
    }
    if([vc respondsToSelector:@selector(isToolbarHidden)] == YES) {
        [self setToolbarHidden:[vc isToolbarHidden] animated:animated];
    }
    if([UIDevice glb_compareSystemVersion:@"8.0"] != NSOrderedAscending) {
        if([vc respondsToSelector:@selector(hidesBarsWhenKeyboardAppears)] == YES) {
            self.hidesBarsWhenKeyboardAppears = [vc hidesBarsWhenKeyboardAppears];
        }
        if([vc respondsToSelector:@selector(hidesBarsOnSwipe)] == YES) {
            self.hidesBarsOnSwipe = [vc hidesBarsOnSwipe];
        }
        if([vc respondsToSelector:@selector(hidesBarsWhenVerticallyCompact)] == YES) {
            self.hidesBarsWhenVerticallyCompact = [vc hidesBarsWhenVerticallyCompact];
        }
        if([vc respondsToSelector:@selector(hidesBarsOnTap)] == YES) {
            self.hidesBarsOnTap = [vc hidesBarsOnTap];
        }
    }
#ifndef GLOBUS_APP_EXTENSION
    if([vc respondsToSelector:@selector(supportedInterfaceOrientations)] == YES) {
        UIInterfaceOrientation currectOrientation = UIApplication.sharedApplication.statusBarOrientation;
        UIInterfaceOrientationMask supportedOrientations = [vc supportedInterfaceOrientations];
        if((supportedOrientations & (1 << currectOrientation)) == 0) {
            if((supportedOrientations & UIInterfaceOrientationMaskPortrait) != 0) {
                [UIDevice glb_setOrientation:UIInterfaceOrientationPortrait];
            } else if((supportedOrientations & UIInterfaceOrientationMaskPortraitUpsideDown) != 0) {
                [UIDevice glb_setOrientation:UIInterfaceOrientationPortraitUpsideDown];
            } else if((supportedOrientations & UIInterfaceOrientationMaskLandscapeLeft) != 0) {
                [UIDevice glb_setOrientation:UIInterfaceOrientationLandscapeLeft];
            } else if((supportedOrientations & UIInterfaceOrientationMaskLandscapeRight) != 0) {
                [UIDevice glb_setOrientation:UIInterfaceOrientationLandscapeRight];
            }
        }
    }
#endif
}

#pragma mark - UIViewController

- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation {
    return [self.topViewController shouldAutorotateToInterfaceOrientation:orientation];
}

#pragma clang diagnostic pop

- (BOOL)prefersStatusBarHidden {
    if(self.presentedViewController != nil) {
        return self.presentedViewController.prefersStatusBarHidden;
    }
    return self.topViewController.prefersStatusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if(self.presentedViewController != nil) {
        return self.presentedViewController.preferredStatusBarStyle;
    }
    return self.topViewController.preferredStatusBarStyle;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    if(self.presentedViewController != nil) {
        return self.presentedViewController.preferredStatusBarUpdateAnimation;
    }
    return self.topViewController.preferredStatusBarUpdateAnimation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.clipsToBounds = YES;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

- (void)viewDidUnload {
    [self setNeedUpdate];
    
    [super viewDidUnload];
}

#pragma clang diagnostic pop

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view layoutIfNeeded];
    
    if(_appeared == NO) {
        _appeared = YES;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    if(_appeared == YES) {
        _appeared = NO;
    }
    [super viewDidDisappear:animated];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id< UIViewControllerAnimatedTransitioning >)animationControllerForPresentedController:(UIViewController*)presented presentingController:(UIViewController*)presenting sourceController:(UIViewController*)source {
    if(_transitionModal != nil) {
        _transitionModal.operation = GLBTransitionOperationPresent;
    }
    return _transitionModal;
}

- (id< UIViewControllerAnimatedTransitioning >)animationControllerForDismissedController:(UIViewController*)dismissed {
    if(_transitionModal != nil) {
        _transitionModal.operation = GLBTransitionOperationDismiss;
    }
    return _transitionModal;
}

- (id< UIViewControllerInteractiveTransitioning >)interactionControllerForPresentation:(id< UIViewControllerAnimatedTransitioning >)animator {
    if(_transitionModal != nil) {
        _transitionModal.operation = GLBTransitionOperationPresent;
    }
    return _transitionModal;
}

- (id< UIViewControllerInteractiveTransitioning >)interactionControllerForDismissal:(id< UIViewControllerAnimatedTransitioning >)animator {
    if(_transitionModal != nil) {
        _transitionModal.operation = GLBTransitionOperationDismiss;
    }
    return _transitionModal;
}

#pragma mark - UINavigationControllerDelegate

- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController*)navigationController {
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController*)navigationController {
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

- (id< UIViewControllerInteractiveTransitioning >)navigationController:(UINavigationController*)navigationController
                           interactionControllerForAnimationController:(id< UIViewControllerAnimatedTransitioning >)animationController {
    return nil;
}

- (id< UIViewControllerAnimatedTransitioning >)navigationController:(UINavigationController*)navigationController
                                    animationControllerForOperation:(UINavigationControllerOperation)operation
                                                 fromViewController:(UIViewController*)fromViewController
                                                   toViewController:(UIViewController*)toViewController {
    switch(operation) {
        case UINavigationControllerOperationPush:
            _transitionNavigation.operation = GLBTransitionOperationPush;
            break;
        case UINavigationControllerOperationPop:
            _transitionNavigation.operation = GLBTransitionOperationPop;
            break;
        default:
            break;
    }
    if(self.interactivePopGestureRecognizer.state != UIGestureRecognizerStateBegan) {
        return _transitionNavigation;
    }
    return nil;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    if(gestureRecognizer == self.interactivePopGestureRecognizer) {
        return (self.viewControllers.count > 1);
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*)otherGesture {
    if([otherGesture isKindOfClass:UIPanGestureRecognizer.class] == YES) {
        if([UIDevice glb_compareSystemVersion:@"8.0"] != NSOrderedAscending) {
            if(otherGesture == self.barHideOnSwipeGestureRecognizer) {
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    UIView* view = touch.view;
    if([view isKindOfClass:UIControl.class] == YES) {
        return NO;
    }
    return YES;
}

#pragma mark - GLBViewControllerExtension

- (UIViewController*)currentViewController {
    UIViewController* controller = self.topViewController;
    if(controller != nil) {
        return controller.glb_currentViewController;
    }
    return self;
}

#if __has_include("GLBSlideViewController.h")

#pragma mark - GLBSlideViewControllerDelegate

- (BOOL)canShowLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(canShowLeftViewControllerInSlideViewController:)] == YES) {
        return [controller canShowLeftViewControllerInSlideViewController:slideViewController];
    }
    return (self.viewControllers.count == 1);
}

- (BOOL)canShowLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController touch:(CGPoint)touch bounds:(CGRect)bounds {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)self.topViewController;
    if([viewController respondsToSelector:@selector(canShowLeftViewControllerInSlideViewController:touch:bounds:)] == YES) {
        return [viewController canShowLeftViewControllerInSlideViewController:slideViewController touch:touch bounds:bounds];
    }
    return CGRectContainsPoint(bounds, touch);
}

- (void)willShowLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(NSTimeInterval)duration {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(willShowLeftViewControllerInSlideViewController:duration:)] == YES) {
        [controller willShowLeftViewControllerInSlideViewController:slideViewController duration:duration];
    }
}

- (void)didShowLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(didShowLeftViewControllerInSlideViewController:)] == YES) {
        [controller didShowLeftViewControllerInSlideViewController:slideViewController];
    }
}

- (void)willHideLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(NSTimeInterval)duration {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(willHideLeftViewControllerInSlideViewController:duration:)] == YES) {
        [controller willHideLeftViewControllerInSlideViewController:slideViewController duration:duration];
    }
}

- (void)didHideLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(didHideLeftViewControllerInSlideViewController:)] == YES) {
        [controller didHideLeftViewControllerInSlideViewController:slideViewController];
    }
}

- (BOOL)canShowRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(canShowRightViewControllerInSlideViewController:)] == YES) {
        return [controller canShowRightViewControllerInSlideViewController:slideViewController];
    }
    return YES;
}

- (BOOL)canShowRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController touch:(CGPoint)touch bounds:(CGRect)bounds {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)self.topViewController;
    if([viewController respondsToSelector:@selector(canShowRightViewControllerInSlideViewController:touch:bounds:)] == YES) {
        return [viewController canShowRightViewControllerInSlideViewController:slideViewController touch:touch bounds:bounds];
    }
    return CGRectContainsPoint(bounds, touch);
}

- (void)willShowRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(NSTimeInterval)duration {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(willShowRightViewControllerInSlideViewController:duration:)] == YES) {
        [controller willShowRightViewControllerInSlideViewController:slideViewController duration:duration];
    }
}

- (void)didShowRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(didShowRightViewControllerInSlideViewController:)] == YES) {
        [controller didShowRightViewControllerInSlideViewController:slideViewController];
    }
}

- (void)willHideRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(NSTimeInterval)duration {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(willHideRightViewControllerInSlideViewController:duration:)] == YES) {
        [controller willHideRightViewControllerInSlideViewController:slideViewController duration:duration];
    }
}

- (void)didHideRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(didHideRightViewControllerInSlideViewController:)] == YES) {
        [controller didHideRightViewControllerInSlideViewController:slideViewController];
    }
}

- (BOOL)canShowViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(canShowViewControllerInSlideViewController:)] == YES) {
        return [controller canShowViewControllerInSlideViewController:slideViewController];
    }
    return (self.viewControllers.count == 1);
}

- (void)willShowViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(NSTimeInterval)duration {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(willShowViewControllerInSlideViewController:duration:)] == YES) {
        [controller willShowViewControllerInSlideViewController:slideViewController duration:duration];
    }
}

- (void)didShowViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(didShowViewControllerInSlideViewController:)] == YES) {
        [controller didShowViewControllerInSlideViewController:slideViewController];
    }
}

- (void)willHideViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(NSTimeInterval)duration {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(willHideViewControllerInSlideViewController:duration:)] == YES) {
        [controller willHideViewControllerInSlideViewController:slideViewController duration:duration];
    }
}

- (void)didHideViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(didHideViewControllerInSlideViewController:)] == YES) {
        [controller didHideViewControllerInSlideViewController:slideViewController];
    }
}

- (void)willBeganLeftSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(willBeganLeftSwipeInSlideViewController:)] == YES) {
        [controller willBeganLeftSwipeInSlideViewController:slideViewController];
    }
}

- (void)didBeganLeftSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(didBeganLeftSwipeInSlideViewController:)] == YES) {
        [controller didBeganLeftSwipeInSlideViewController:slideViewController];
    }
}

- (void)movingLeftSwipeInSlideViewController:(GLBSlideViewController*)slideViewController progress:(CGFloat)progress {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(movingLeftSwipeInSlideViewController:progress:)] == YES) {
        [controller movingLeftSwipeInSlideViewController:slideViewController progress:progress];
    }
}

- (void)willEndedLeftSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(willEndedLeftSwipeInSlideViewController:)] == YES) {
        [controller willEndedLeftSwipeInSlideViewController:slideViewController];
    }
}

- (void)didEndedLeftSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(didEndedLeftSwipeInSlideViewController:)] == YES) {
        [controller didEndedLeftSwipeInSlideViewController:slideViewController];
    }
}

- (void)willBeganRightSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(willBeganRightSwipeInSlideViewController:)] == YES) {
        [controller willBeganRightSwipeInSlideViewController:slideViewController];
    }
}

- (void)didBeganRightSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(didBeganRightSwipeInSlideViewController:)] == YES) {
        [controller didBeganRightSwipeInSlideViewController:slideViewController];
    }
}

- (void)movingRightSwipeInSlideViewController:(GLBSlideViewController*)slideViewController progress:(CGFloat)progress {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(movingRightSwipeInSlideViewController:progress:)] == YES) {
        [controller movingRightSwipeInSlideViewController:slideViewController progress:progress];
    }
}

- (void)willEndedRightSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(willEndedRightSwipeInSlideViewController:)] == YES) {
        [controller willEndedRightSwipeInSlideViewController:slideViewController];
    }
}

- (void)didEndedRightSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(didEndedRightSwipeInSlideViewController:)] == YES) {
        [controller didEndedRightSwipeInSlideViewController:slideViewController];
    }
}

- (void)willBeganSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(willBeganSwipeInSlideViewController:)] == YES) {
        [controller willBeganSwipeInSlideViewController:slideViewController];
    }
}

- (void)didBeganSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(didBeganSwipeInSlideViewController:)] == YES) {
        [controller didBeganSwipeInSlideViewController:slideViewController];
    }
}

- (void)movingSwipeInSlideViewController:(GLBSlideViewController*)slideViewController progress:(CGFloat)progress {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(movingSwipeInSlideViewController:progress:)] == YES) {
        [controller movingSwipeInSlideViewController:slideViewController progress:progress];
    }
}

- (void)willEndedSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(willEndedSwipeInSlideViewController:)] == YES) {
        [controller willEndedSwipeInSlideViewController:slideViewController];
    }
}

- (void)didEndedSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(didEndedSwipeInSlideViewController:)] == YES) {
        [controller didEndedSwipeInSlideViewController:slideViewController];
    }
}

#endif

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
