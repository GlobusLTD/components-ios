/*--------------------------------------------------*/

#import "GLBTabBarViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#if __has_include("GLBSlideViewController.h")
#import "GLBSlideViewController.h"
#endif

/*--------------------------------------------------*/

@interface GLBTabBarViewController () <
    UIViewControllerTransitioningDelegate, UITabBarControllerDelegate
#if __has_include("GLBSlideViewController.h")
    , GLBSlideViewControllerDelegate
#endif
>

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBTabBarViewController

#pragma mark - Init / Free

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

- (void)setup {
    self.delegate = self;
    self.transitioningDelegate = self;
    
    _toolbarHidden = YES;
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

- (void)setNavigationBarHidden:(BOOL)navigationBarHidden {
    [self setNavigationBarHidden:navigationBarHidden animated:NO];
}

- (void)setToolbarHidden:(BOOL)toolbarHidden {
    [self setToolbarHidden:toolbarHidden animated:NO];
}

- (void)setHidesBarsWhenKeyboardAppears:(BOOL)hidesBarsWhenKeyboardAppears {
    if(_hidesBarsWhenKeyboardAppears != hidesBarsWhenKeyboardAppears) {
        _hidesBarsWhenKeyboardAppears = hidesBarsWhenKeyboardAppears;
        
        if((self.isViewLoaded == YES) && (self.navigationController.topViewController == self)) {
            if([UIDevice glb_compareSystemVersion:@"8.0"] != NSOrderedAscending) {
                self.navigationController.hidesBarsWhenKeyboardAppears = _hidesBarsWhenKeyboardAppears;
            }
        }
    }
}

- (void)setHidesBarsOnSwipe:(BOOL)hidesBarsOnSwipe {
    if(_hidesBarsOnSwipe != hidesBarsOnSwipe) {
        _hidesBarsOnSwipe = hidesBarsOnSwipe;
        
        if((self.isViewLoaded == YES) && (self.navigationController.topViewController == self)) {
            if([UIDevice glb_compareSystemVersion:@"8.0"] != NSOrderedAscending) {
                self.navigationController.hidesBarsOnSwipe = _hidesBarsOnSwipe;
            }
        }
    }
}

- (void)setHidesBarsWhenVerticallyCompact:(BOOL)hidesBarsWhenVerticallyCompact {
    if(_hidesBarsWhenVerticallyCompact != hidesBarsWhenVerticallyCompact) {
        _hidesBarsWhenVerticallyCompact = hidesBarsWhenVerticallyCompact;
        
        if((self.isViewLoaded == YES) && (self.navigationController.topViewController == self)) {
            if([UIDevice glb_compareSystemVersion:@"8.0"] != NSOrderedAscending) {
                self.navigationController.hidesBarsWhenVerticallyCompact = _hidesBarsWhenVerticallyCompact;
            }
        }
    }
}

- (void)setHidesBarsOnTap:(BOOL)hidesBarsOnTap {
    if(_hidesBarsOnTap != hidesBarsOnTap) {
        _hidesBarsOnTap = hidesBarsOnTap;
        
        if((self.isViewLoaded == YES) && (self.navigationController.topViewController == self)) {
            if([UIDevice glb_compareSystemVersion:@"8.0"] != NSOrderedAscending) {
                self.navigationController.hidesBarsOnTap = _hidesBarsOnTap;
            }
        }
    }
}

#pragma mark - Public

- (void)setNavigationBarHidden:(BOOL)navigationBarHidden animated:(BOOL)animated {
    if(_navigationBarHidden != navigationBarHidden) {
        _navigationBarHidden = navigationBarHidden;
        
        if((self.isViewLoaded == YES) && (self.navigationController.topViewController == self)) {
            [self.navigationController setNavigationBarHidden:_navigationBarHidden animated:animated];
        }
    }
}

- (void)setToolbarHidden:(BOOL)toolbarHidden animated:(BOOL)animated {
    if(_toolbarHidden != toolbarHidden) {
        _toolbarHidden = toolbarHidden;
        
        if((self.isViewLoaded == YES) && (self.navigationController.topViewController == self)) {
            [self.navigationController setToolbarHidden:_toolbarHidden animated:animated];
        }
    }
}

- (void)setNeedUpdate {
    for(id object in self.viewControllers) {
        if([object respondsToSelector:@selector(setNeedUpdate)] == YES) {
            [object setNeedUpdate];
        }
    }
}

#pragma mark - UIViewController

- (BOOL)shouldAutorotate {
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.selectedViewController.supportedInterfaceOrientations;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation {
    return [self.selectedViewController shouldAutorotateToInterfaceOrientation:orientation];
}

#pragma clang diagnostic pop

- (BOOL)prefersStatusBarHidden {
    return self.selectedViewController.prefersStatusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.selectedViewController.preferredStatusBarStyle;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return self.selectedViewController.preferredStatusBarUpdateAnimation;
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

#pragma mark - UITabBarControllerDelegate

- (UIInterfaceOrientationMask)tabBarControllerSupportedInterfaceOrientations:(UITabBarController*)tabBarController {
    return self.selectedViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)tabBarControllerPreferredInterfaceOrientationForPresentation:(UITabBarController*)tabBarController {
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

- (id< UIViewControllerInteractiveTransitioning >)tabBarController:(UITabBarController*)tabBarController interactionControllerForAnimationController:(id< UIViewControllerAnimatedTransitioning >)animationController {
    return _transitionNavigation;
}

- (id< UIViewControllerAnimatedTransitioning >)tabBarController:(UITabBarController*)tabBarController animationControllerForTransitionFromViewController:(UIViewController*)fromViewController toViewController:(UIViewController*)toViewController {
    if(_transitionNavigation != nil) {
        NSArray* viewControllers = tabBarController.viewControllers;
        if([viewControllers indexOfObject:fromViewController] > [viewControllers indexOfObject:toViewController]) {
            _transitionModal.operation = GLBTransitionOperationPush;
        } else {
            _transitionModal.operation = GLBTransitionOperationPop;
        }
        return _transitionNavigation;
    }
    return nil;
}

#if __has_include("GLBSlideViewController.h")

#pragma mark - GLBSlideViewControllerDelegate

- (BOOL)canShowLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(canShowLeftViewControllerInSlideViewController:)] == YES) {
        return [controller canShowLeftViewControllerInSlideViewController:slideViewController];
    }
    return (self.viewControllers.count == 1);
}

- (BOOL)canShowLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController touch:(CGPoint)touch bounds:(CGRect)bounds {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)self.selectedViewController;
    if([viewController respondsToSelector:@selector(canShowLeftViewControllerInSlideViewController:touch:bounds:)] == YES) {
        return [viewController canShowLeftViewControllerInSlideViewController:slideViewController touch:touch bounds:bounds];
    }
    return CGRectContainsPoint(bounds, touch);
}

- (void)willShowLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(NSTimeInterval)duration {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(willShowLeftViewControllerInSlideViewController:duration:)] == YES) {
        [controller willShowLeftViewControllerInSlideViewController:slideViewController duration:duration];
    }
}

- (void)didShowLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(didShowLeftViewControllerInSlideViewController:)] == YES) {
        [controller didShowLeftViewControllerInSlideViewController:slideViewController];
    }
}

- (void)willHideLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(NSTimeInterval)duration {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(willHideLeftViewControllerInSlideViewController:duration:)] == YES) {
        [controller willHideLeftViewControllerInSlideViewController:slideViewController duration:duration];
    }
}

- (void)didHideLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(didHideLeftViewControllerInSlideViewController:)] == YES) {
        [controller didHideLeftViewControllerInSlideViewController:slideViewController];
    }
}

- (BOOL)canShowRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(canShowRightViewControllerInSlideViewController:)] == YES) {
        return [controller canShowRightViewControllerInSlideViewController:slideViewController];
    }
    return (self.viewControllers.count == 1);
}

- (BOOL)canShowRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController touch:(CGPoint)touch bounds:(CGRect)bounds {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)self.selectedViewController;
    if([viewController respondsToSelector:@selector(canShowRightViewControllerInSlideViewController:touch:bounds:)] == YES) {
        return [viewController canShowRightViewControllerInSlideViewController:slideViewController touch:touch bounds:bounds];
    }
    return CGRectContainsPoint(bounds, touch);
}

- (void)willShowRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(NSTimeInterval)duration {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(willShowRightViewControllerInSlideViewController:duration:)] == YES) {
        [controller willShowRightViewControllerInSlideViewController:slideViewController duration:duration];
    }
}

- (void)didShowRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(didShowRightViewControllerInSlideViewController:)] == YES) {
        [controller didShowRightViewControllerInSlideViewController:slideViewController];
    }
}

- (void)willHideRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(NSTimeInterval)duration {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(willHideRightViewControllerInSlideViewController:duration:)] == YES) {
        [controller willHideRightViewControllerInSlideViewController:slideViewController duration:duration];
    }
}

- (void)didHideRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(didHideRightViewControllerInSlideViewController:)] == YES) {
        [controller didHideRightViewControllerInSlideViewController:slideViewController];
    }
}

- (BOOL)canShowViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(canShowViewControllerInSlideViewController:)] == YES) {
        return [controller canShowViewControllerInSlideViewController:slideViewController];
    }
    return (self.viewControllers.count == 1);
}

- (void)willShowViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(NSTimeInterval)duration {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(willShowViewControllerInSlideViewController:duration:)] == YES) {
        [controller willShowViewControllerInSlideViewController:slideViewController duration:duration];
    }
}

- (void)didShowViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(didShowViewControllerInSlideViewController:)] == YES) {
        [controller didShowViewControllerInSlideViewController:slideViewController];
    }
}

- (void)willHideViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(NSTimeInterval)duration {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(willHideViewControllerInSlideViewController:duration:)] == YES) {
        [controller willHideViewControllerInSlideViewController:slideViewController duration:duration];
    }
}

- (void)didHideViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(didHideViewControllerInSlideViewController:)] == YES) {
        [controller didHideViewControllerInSlideViewController:slideViewController];
    }
}

- (void)willBeganLeftSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(willBeganLeftSwipeInSlideViewController:)] == YES) {
        [controller willBeganLeftSwipeInSlideViewController:slideViewController];
    }
}

- (void)didBeganLeftSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(didBeganLeftSwipeInSlideViewController:)] == YES) {
        [controller didBeganLeftSwipeInSlideViewController:slideViewController];
    }
}

- (void)movingLeftSwipeInSlideViewController:(GLBSlideViewController*)slideViewController progress:(CGFloat)progress {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(movingLeftSwipeInSlideViewController:progress:)] == YES) {
        [controller movingLeftSwipeInSlideViewController:slideViewController progress:progress];
    }
}

- (void)willEndedLeftSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(willEndedLeftSwipeInSlideViewController:)] == YES) {
        [controller willEndedLeftSwipeInSlideViewController:slideViewController];
    }
}

- (void)didEndedLeftSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(didEndedLeftSwipeInSlideViewController:)] == YES) {
        [controller didEndedLeftSwipeInSlideViewController:slideViewController];
    }
}

- (void)willBeganRightSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(willBeganRightSwipeInSlideViewController:)] == YES) {
        [controller willBeganRightSwipeInSlideViewController:slideViewController];
    }
}

- (void)didBeganRightSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(didBeganRightSwipeInSlideViewController:)] == YES) {
        [controller didBeganRightSwipeInSlideViewController:slideViewController];
    }
}

- (void)movingRightSwipeInSlideViewController:(GLBSlideViewController*)slideViewController progress:(CGFloat)progress {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(movingRightSwipeInSlideViewController:progress:)] == YES) {
        [controller movingRightSwipeInSlideViewController:slideViewController progress:progress];
    }
}

- (void)willEndedRightSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(willEndedRightSwipeInSlideViewController:)] == YES) {
        [controller willEndedRightSwipeInSlideViewController:slideViewController];
    }
}

- (void)didEndedRightSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(didEndedRightSwipeInSlideViewController:)] == YES) {
        [controller didEndedRightSwipeInSlideViewController:slideViewController];
    }
}

- (void)willBeganSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(willBeganSwipeInSlideViewController:)] == YES) {
        [controller willBeganSwipeInSlideViewController:slideViewController];
    }
}

- (void)didBeganSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(didBeganSwipeInSlideViewController:)] == YES) {
        [controller didBeganSwipeInSlideViewController:slideViewController];
    }
}

- (void)movingSwipeInSlideViewController:(GLBSlideViewController*)slideViewController progress:(CGFloat)progress {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(movingSwipeInSlideViewController:progress:)] == YES) {
        [controller movingSwipeInSlideViewController:slideViewController progress:progress];
    }
}

- (void)willEndedSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(willEndedSwipeInSlideViewController:)] == YES) {
        [controller willEndedSwipeInSlideViewController:slideViewController];
    }
}

- (void)didEndedSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.selectedViewController;
    if([controller respondsToSelector:@selector(didEndedSwipeInSlideViewController:)] == YES) {
        [controller didEndedSwipeInSlideViewController:slideViewController];
    }
}

#endif

#pragma mark - GLBViewController

- (UIViewController*)currentViewController {
    UIViewController* viewController = self.selectedViewController;
    if(viewController != nil) {
        return viewController.glb_currentViewController;
    }
    return self;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
