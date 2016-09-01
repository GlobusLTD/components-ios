/*--------------------------------------------------*/

#import "GLBSplitViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#if __has_include("GLBSlideViewController.h")
#import "GLBSlideViewController.h"
#endif

/*--------------------------------------------------*/

@interface GLBSplitViewController () <
    UIViewControllerTransitioningDelegate, UISplitViewControllerDelegate
#if __has_include("GLBSlideViewController.h")
    , GLBSlideViewControllerDelegate
#endif
>

- (void)_updateViewControllers;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBSplitViewController

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

- (instancetype)initWithMasterViewController:(UIViewController*)masterViewController
                        detailViewController:(UIViewController*)detailViewController {
    self = [super initWithNibName:nil bundle:nil];
    if(self != nil) {
        _masterViewController = masterViewController;
        _detailViewController = detailViewController;
        [self setup];
    }
    return self;
}

- (void)setup {
    self.delegate = self;
    self.transitioningDelegate = self;
    
    [self _updateViewControllers];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

#pragma mark - Property

- (void)setMasterViewController:(UIViewController*)masterViewController {
    if(_masterViewController != masterViewController) {
        _masterViewController = masterViewController;
        [self _updateViewControllers];
    }
}

- (void)setDetailViewController:(UIViewController *)detailViewController {
    if(_detailViewController != detailViewController) {
        _detailViewController = detailViewController;
        [self _updateViewControllers];
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
    UIViewController* controller = (self.collapsed == YES) ? _detailViewController : _masterViewController;
    return controller.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    UIViewController* controller = (self.collapsed == YES) ? _detailViewController : _masterViewController;
    return controller.supportedInterfaceOrientations;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation {
    UIViewController* controller = (self.collapsed == YES) ? _detailViewController : _masterViewController;
    return [controller shouldAutorotateToInterfaceOrientation:orientation];
}

#pragma clang diagnostic pop

- (BOOL)prefersStatusBarHidden {
    UIViewController* controller = (self.collapsed == YES) ? _detailViewController : _masterViewController;
    return controller.prefersStatusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    UIViewController* controller = (self.collapsed == YES) ? _detailViewController : _masterViewController;
    return controller.preferredStatusBarStyle;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    UIViewController* controller = (self.collapsed == YES) ? _detailViewController : _masterViewController;
    return controller.preferredStatusBarUpdateAnimation;
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

#if __has_include("GLBSlideViewController.h")

#pragma mark - UISplitViewControllerDelegate

#endif

#pragma mark - Private

- (void)_updateViewControllers {
    if((_masterViewController != nil) && (_detailViewController != nil)) {
        super.viewControllers = @[
            _masterViewController, _detailViewController
        ];
    }
}

#pragma mark - GLBViewController

- (UIViewController*)currentViewController {
    UIViewController* controller = (self.collapsed == YES) ? _detailViewController : _masterViewController;
    if(controller != nil) {
        return controller.glb_currentViewController;
    }
    return self;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
