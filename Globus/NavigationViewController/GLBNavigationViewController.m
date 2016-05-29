/*--------------------------------------------------*/

#import "GLBNavigationViewController.h"
#import "GLBTransitionController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import "GLBSlideViewController.h"

/*--------------------------------------------------*/

#import "UIDevice+GLBUI.h"

/*--------------------------------------------------*/

@interface GLBNavigationViewController () < UIViewControllerTransitioningDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate, GLBSlideViewControllerDelegate >

@property(nonatomic, strong) UIScreenEdgePanGestureRecognizer* interactiveGesture;

- (void)interactiveGestureHandle:(UIPanGestureRecognizer*)interactiveGesture;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBNavigationViewController

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
    self.interactivePopGestureRecognizer.delegate = self;
    
    _interactiveGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(interactiveGestureHandle:)];
    _transitionInteractive = [[GLBTransitionControllerSlide alloc] initWithRatio:0.2f];
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

- (void)setInteractiveGesture:(UIScreenEdgePanGestureRecognizer*)interactiveGesture {
    if(_interactiveGesture != interactiveGesture) {
        if(_interactiveGesture != nil) {
            [self.view removeGestureRecognizer:_interactiveGesture];
        }
        _interactiveGesture = interactiveGesture;
        if(_interactiveGesture != nil) {
            _interactiveGesture.delegate = self;
            _interactiveGesture.edges = UIRectEdgeLeft;
            [self.view addGestureRecognizer:_interactiveGesture];

        }
    }
}

#pragma mark - Public

- (void)setNeedUpdate {
    for(id object in self.viewControllers) {
        if([object respondsToSelector:@selector(setNeedUpdate)] == YES) {
            [object setNeedUpdate];
        }
    }
}

#pragma mark - UIViewController

- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation {
    return [self.topViewController shouldAutorotateToInterfaceOrientation:orientation];
}

- (BOOL)prefersStatusBarHidden {
    return self.topViewController.prefersStatusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.topViewController.preferredStatusBarStyle;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return self.topViewController.preferredStatusBarUpdateAnimation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.clipsToBounds = YES;
}

- (void)viewDidUnload {
    [self setNeedUpdate];
    
    [super viewDidUnload];
}

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

- (void)navigationController:(UINavigationController*)navigationController willShowViewController:(UIViewController*)viewController animated:(BOOL)animated {
    id vc = viewController;
    if([vc respondsToSelector:@selector(isNavigationBarHidden)] == YES) {
        [navigationController setNavigationBarHidden:[vc isNavigationBarHidden] animated:animated];
    }
    if([vc respondsToSelector:@selector(isToolbarHidden)] == YES) {
        [navigationController setToolbarHidden:[vc isToolbarHidden] animated:animated];
    }
    if(UIDevice.glb_systemVersion >= 8.0f) {
        if([vc respondsToSelector:@selector(hidesBarsWhenKeyboardAppears)] == YES) {
            navigationController.hidesBarsWhenKeyboardAppears = [vc hidesBarsWhenKeyboardAppears];
        }
        if([vc respondsToSelector:@selector(hidesBarsOnSwipe)] == YES) {
            navigationController.hidesBarsOnSwipe = [vc hidesBarsOnSwipe];
        }
        if([vc respondsToSelector:@selector(hidesBarsWhenVerticallyCompact)] == YES) {
            navigationController.hidesBarsWhenVerticallyCompact = [vc hidesBarsWhenVerticallyCompact];
        }
        if([vc respondsToSelector:@selector(hidesBarsOnTap)] == YES) {
            navigationController.hidesBarsOnTap = [vc hidesBarsOnTap];
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

- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController*)navigationController {
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController*)navigationController {
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

- (id< UIViewControllerInteractiveTransitioning >)navigationController:(UINavigationController*)navigationController interactionControllerForAnimationController:(id< UIViewControllerAnimatedTransitioning >)animationController {
    if(animationController == _transitionInteractive) {
        return _transitionInteractive;
    }
    return nil;
}

- (id< UIViewControllerAnimatedTransitioning >)navigationController:(UINavigationController*)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController*)fromViewController toViewController:(UIViewController*)toViewController {
    if((_transitionInteractive != nil) && (_transitionInteractive.isInteractive == YES)) {
        switch(operation) {
            case UINavigationControllerOperationPush: _transitionInteractive.operation = GLBTransitionOperationPush; break;
            case UINavigationControllerOperationPop: _transitionInteractive.operation = GLBTransitionOperationPop; break;
            default: break;
        }
        return _transitionInteractive;
    } else if(_transitionNavigation != nil) {
        switch(operation) {
            case UINavigationControllerOperationPush: _transitionNavigation.operation = GLBTransitionOperationPush; break;
            case UINavigationControllerOperationPop: _transitionNavigation.operation = GLBTransitionOperationPop; break;
            default: break;
        }
        return _transitionNavigation;
    }
    return nil;
}

#pragma mark - Private

- (void)interactiveGestureHandle:(UIPanGestureRecognizer*)interactiveGesture {
    CGPoint translation = [_interactiveGesture translationInView:self.view];
    CGFloat progress = translation.x / self.view.frame.size.width;
    switch(_interactiveGesture.state) {
        case UIGestureRecognizerStateBegan: {
            [_transitionInteractive beginInteractive];
            [self popViewControllerAnimated:YES];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            [_transitionInteractive updateInteractive:MAX(0.0f, MIN(progress, 1.0f))];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            if((_transitionInteractive.isCancelled == NO) && (progress >= 0.3f)) {
                [_transitionInteractive finishInteractive];
            } else {
                [_transitionInteractive cancelInteractive];
            }
            [_transitionInteractive endInteractive];
            break;
        }
        default: {
            break;
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    if(_transitionInteractive != nil) {
        if(_transitionInteractive.isAnimated == NO) {
            if(self.viewControllers.count > 1) {
                if(gestureRecognizer == _interactiveGesture) {
                    return YES;
                } else if(gestureRecognizer == self.interactivePopGestureRecognizer) {
                    return YES;
                }
            }
        }
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gesture shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*)otherGesture {
    if([otherGesture isKindOfClass:UIPanGestureRecognizer.class] == YES) {
        if(UIDevice.glb_systemVersion >= 8.0f) {
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

#pragma mark - GLBSlideViewControllerDelegate

- (BOOL)canShowLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(canShowLeftViewControllerInSlideViewController:)] == YES) {
        return [controller canShowLeftViewControllerInSlideViewController:slideViewController];
    }
    return (self.viewControllers.count == 1);
}

- (void)willShowLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(CGFloat)duration {
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

- (void)willHideLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(CGFloat)duration {
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
    return (self.viewControllers.count == 1);
}

- (void)willShowRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(CGFloat)duration {
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

- (void)willHideRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(CGFloat)duration {
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

- (BOOL)canShowControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(canShowControllerInSlideViewController:)] == YES) {
        return [controller canShowControllerInSlideViewController:slideViewController];
    }
    return (self.viewControllers.count == 1);
}

- (void)willShowControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(CGFloat)duration {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(willShowControllerInSlideViewController:duration:)] == YES) {
        [controller willShowControllerInSlideViewController:slideViewController duration:duration];
    }
}

- (void)didShowControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(didShowControllerInSlideViewController:)] == YES) {
        [controller didShowControllerInSlideViewController:slideViewController];
    }
}

- (void)willHideControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(CGFloat)duration {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(willHideControllerInSlideViewController:duration:)] == YES) {
        [controller willHideControllerInSlideViewController:slideViewController duration:duration];
    }
}

- (void)didHideControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* controller = (id)self.topViewController;
    if([controller respondsToSelector:@selector(didHideControllerInSlideViewController:)] == YES) {
        [controller didHideControllerInSlideViewController:slideViewController];
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

#pragma mark - GLBViewController

- (UIViewController*)currentViewController {
    UIViewController* controller = self.topViewController;
    if(controller != nil) {
        return controller.glb_currentViewController;
    }
    return self;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
