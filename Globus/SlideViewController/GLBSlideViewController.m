/*--------------------------------------------------*/

#import "GLBSlideViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import "UIApplication+GLBUI.h"
#import "UIDevice+GLBUI.h"
#import "NSArray+GLBNS.h"
#import "GLBCG.h"

/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBSlideViewControllerSwipeCellDirection) {
    GLBSlideViewControllerSwipeCellDirectionUnknown,
    GLBSlideViewControllerSwipeCellDirectionLeft,
    GLBSlideViewControllerSwipeCellDirectionRight
};

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface GLBSlideViewController () < UIGestureRecognizerDelegate >

@property(nonatomic, getter=isSwipeDragging) BOOL swipeDragging;
@property(nonatomic, getter=isSwipeDecelerating) BOOL swipeDecelerating;

@property(nonatomic, strong) UIView* backgroundView;
@property(nonatomic, strong) UIView* leftView;
@property(nonatomic, strong) UIView* rightView;
@property(nonatomic, strong) UIView* centerView;
@property(nonatomic, strong) UIView* screenshotView;
@property(nonatomic, strong) UITapGestureRecognizer* tapGesture;
@property(nonatomic, strong) UIScreenEdgePanGestureRecognizer* leftEdgeGesture;
@property(nonatomic, strong) UIScreenEdgePanGestureRecognizer* rightEdgeGesture;
@property(nonatomic, strong) UIPanGestureRecognizer* panGesture;

@property(nonatomic) CGFloat swipeLastOffset;
@property(nonatomic) CGFloat swipeLastVelocity;
@property(nonatomic) CGFloat swipeProgress;
@property(nonatomic) CGFloat swipeLeftWidth;
@property(nonatomic) CGFloat swipeRightWidth;
@property(nonatomic) GLBSlideViewControllerSwipeCellDirection swipeDirection;

- (CGRect)_leftViewFrameByPercent:(CGFloat)percent;
- (CGRect)_leftViewFrameFromBounds:(CGRect)bounds byPercent:(CGFloat)percent;
- (CGRect)_rightViewFrameByPercent:(CGFloat)percent;
- (CGRect)_rightViewFrameFromBounds:(CGRect)bounds byPercent:(CGFloat)percent;
- (CGRect)_centerViewFrameByPercent:(CGFloat)percent;
- (CGRect)_centerViewFrameFromBounds:(CGRect)bounds byPercent:(CGFloat)percent;

- (void)_appearBackgroundViewController;
- (void)_disappearBackgroundViewController;
- (void)_appearLeftViewController;
- (void)_disappearLeftViewController;
- (void)_appearRightViewController;
- (void)_disappearRightViewController;
- (void)_appearCenterViewController;
- (void)_disappearCenterViewController;

- (void)_updateSwipeProgress:(CGFloat)swipeProgress speed:(CGFloat)speed endedSwipe:(BOOL)endedSwipe;

- (void)_willBeganSwipe;
- (void)_didBeganSwipe;
- (void)_movingSwipe:(CGFloat)progress;
- (void)_willEndedSwipe;
- (void)_didEndedSwipe;

- (void)_tapGestureHandle;
- (void)_leftEdgeGestureHandle;
- (void)_rightEdgeGestureHandle;
- (void)_panGestureHandle;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBSlideViewController

#pragma mark - Init / Free

- (void)setup {
    [super setup];
    
    if(UIDevice.glb_isIPhone == YES) {
        _swipeVelocity = 1050.0f;
        _leftViewControllerWidth = 280.0f;
        _rightViewControllerWidth = 280.0f;
    } else if(UIDevice.glb_isIPad == YES) {
        _swipeVelocity = 3000.0f;
        _leftViewControllerWidth = 320.0f;
        _rightViewControllerWidth = 320.0f;
    }
    _leftViewControllerIteractionShowEnabled = YES;
    _leftViewControllerIteractionHideEnabled = YES;
    _leftViewControllerShowAlpha = 1.0f;
    _leftViewControllerHideAlpha = 1.0f;
    _leftViewControllerStyle = GLBSlideViewControllerStyleLeaves;
    _rightViewControllerIteractionShowEnabled = YES;
    _rightViewControllerIteractionHideEnabled = YES;
    _rightViewControllerShowAlpha = 1.0f;
    _rightViewControllerHideAlpha = 1.0f;
    _rightViewControllerStyle = GLBSlideViewControllerStyleLeaves;
    _centerViewControllerShowAlpha = 1.0f;
    _centerViewControllerHideAlpha = 1.0f;
    _swipeDamping = 0.8f;
    _draggingStatusBar = NO;
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(_notificationDidBecomeActive:)
                                               name:UIApplicationDidBecomeActiveNotification
                                             object:nil];
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(_notificationWillResignActive:)
                                               name:UIApplicationWillResignActiveNotification
                                             object:nil];
}

- (void)dealloc {
}

#pragma mark - UIViewController

- (BOOL)shouldAutorotate {
    return _centerViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return _centerViewController.supportedInterfaceOrientations;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation {
    return [_centerViewController shouldAutorotateToInterfaceOrientation:orientation];
}

- (BOOL)prefersStatusBarHidden {
    if((_canUseScreenshot == YES) && (_screenshotView != nil)) {
        return YES;
    }
    return _centerViewController.prefersStatusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return _centerViewController.preferredStatusBarStyle;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    if((_canUseScreenshot == YES) && (_screenshotView != nil)) {
        return UIStatusBarAnimationNone;
    }
    return _centerViewController.preferredStatusBarUpdateAnimation;
}

- (void)loadView {
    [super loadView];
    
    self.view.clipsToBounds = YES;
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapGestureHandle)];
    self.leftEdgeGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(_leftEdgeGestureHandle)];
    self.rightEdgeGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(_rightEdgeGestureHandle)];
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_panGestureHandle)];
    
    _backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    _leftView = [[UIView alloc] initWithFrame:[self _leftViewFrameByPercent:0.0f]];
    if(_leftView != nil) {
        _leftView.alpha = [self _leftViewAlphaByPercent:0.0f];
        _leftView.hidden = NO;
    }
    _rightView = [[UIView alloc] initWithFrame:[self _rightViewFrameByPercent:0.0f]];
    if(_rightView != nil) {
        _rightView.alpha = [self _rightViewAlphaByPercent:0.0f];
        _rightView.hidden = YES;
    }
    _centerView = [[UIView alloc] initWithFrame:[self _centerViewFrameByPercent:0.0f]];
    if(_centerView != nil) {
        _centerView.alpha = [self _centerViewAlphaByPercent:0.0f];
    }
    [self.view glb_setSubviews:[self _orderedSubviews]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(_backgroundViewController != nil) {
        [self _appearBackgroundViewController];
    }
    if(_leftViewController != nil) {
        [self _appearLeftViewController];
    }
    if(_rightViewController != nil) {
        [self _appearRightViewController];
    }
    if(_centerViewController != nil) {
        [self _appearCenterViewController];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self _updateCenterView];
}

#pragma mark - Property

- (void)setTapGesture:(UITapGestureRecognizer*)tapGesture {
    if(_tapGesture != tapGesture) {
        if(_tapGesture != nil) {
            [self.view removeGestureRecognizer:_tapGesture];
        }
        _tapGesture = tapGesture;
        if(_tapGesture != nil) {
            _tapGesture.delegate = self;
            if(self.isViewLoaded == YES) {
                [self.view addGestureRecognizer:_tapGesture];
            }
        }
    }
}

- (void)setLeftEdgeGesture:(UIScreenEdgePanGestureRecognizer*)leftEdgeGesture {
    if(_leftEdgeGesture != leftEdgeGesture) {
        if(_leftEdgeGesture != nil) {
            [self.view removeGestureRecognizer:_leftEdgeGesture];
        }
        _leftEdgeGesture = leftEdgeGesture;
        if(_leftEdgeGesture != nil) {
            _leftEdgeGesture.edges = UIRectEdgeLeft;
            _leftEdgeGesture.delegate = self;
            if(self.isViewLoaded == YES) {
                [self.view addGestureRecognizer:_leftEdgeGesture];
            }
        }
    }
}

- (void)setRightEdgeGesture:(UIScreenEdgePanGestureRecognizer*)rightEdgeGesture {
    if(_rightEdgeGesture != rightEdgeGesture) {
        if(_rightEdgeGesture != nil) {
            [self.view removeGestureRecognizer:_rightEdgeGesture];
        }
        _rightEdgeGesture = rightEdgeGesture;
        if(_rightEdgeGesture != nil) {
            _rightEdgeGesture.edges = UIRectEdgeRight;
            _rightEdgeGesture.delegate = self;
            if(self.isViewLoaded == YES) {
                [self.view addGestureRecognizer:_rightEdgeGesture];
            }
        }
    }
}

- (void)setPanGesture:(UIPanGestureRecognizer*)panGesture {
    if(_panGesture != panGesture) {
        if(_panGesture != nil) {
            [self.view removeGestureRecognizer:_panGesture];
        }
        _panGesture = panGesture;
        if(_panGesture != nil) {
            _panGesture.delegate = self;
            if(self.isViewLoaded == YES) {
                [self.view addGestureRecognizer:_panGesture];
            }
        }
    }
}

- (void)setBackgroundView:(UIView*)backgroundView {
    if(_backgroundView != backgroundView) {
        if(_backgroundView != nil) {
            [_backgroundView removeFromSuperview];
        }
        _backgroundView = backgroundView;
        if(self.isViewLoaded == YES) {
            [self.view glb_setSubviews:[self _orderedSubviews]];
        }
    }
}

- (void)setLeftView:(UIView*)leftView {
    if(_leftView != leftView) {
        if(_leftView != nil) {
            [_leftView removeFromSuperview];
        }
        _leftView = leftView;
        if(_leftView != nil) {
            _leftView.alpha = [self _leftViewAlphaByPercent:0.0f];
        }
        if(self.isViewLoaded == YES) {
            [self.view glb_setSubviews:[self _orderedSubviews]];
        }
    }
}

- (void)setRightView:(UIView*)rightView {
    if(_rightView != rightView) {
        if(_rightView != nil) {
            [_rightView removeFromSuperview];
        }
        _rightView = rightView;
        if(_rightView != nil) {
            _rightView.alpha = [self _rightViewAlphaByPercent:0.0f];
        }
        if(self.isViewLoaded == YES) {
            [self.view glb_setSubviews:[self _orderedSubviews]];
        }
    }
}

- (void)setCenterView:(UIView*)centerView {
    if(_centerView != centerView) {
        if(_centerView != nil) {
            [_centerView removeFromSuperview];
        }
        _centerView = centerView;
        if(_centerView != nil) {
            _centerView.alpha = [self _centerViewAlphaByPercent:0.0f];
        }
        if(self.isViewLoaded == YES) {
            [self.view glb_setSubviews:[self _orderedSubviews]];
        }
    }
}

- (void)setScreenshotView:(UIView*)screenshotView {
    if(_screenshotView != screenshotView) {
        if(_screenshotView != nil) {
            [_screenshotView removeFromSuperview];
        }
        _screenshotView = screenshotView;
        if(_screenshotView != nil) {
            _screenshotView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            if(_centerView != nil) {
                [_centerView addSubview:_screenshotView];
            }
        }
        if(self.isViewLoaded == YES) {
            [self setNeedsStatusBarAppearanceUpdate];
        }
    }
}

- (void)setBackgroundViewController:(UIViewController*)backgroundViewController {
    [self setBackgroundViewController:backgroundViewController animated:NO complete:nil];
}

- (void)setLeftViewController:(UIViewController*)leftViewController {
    [self setLeftViewController:leftViewController animated:NO complete:nil];
}

- (void)setLeftViewControllerStyle:(GLBSlideViewControllerStyle)leftViewControllerStyle {
    if(_leftViewControllerStyle != leftViewControllerStyle) {
        _leftViewControllerStyle = leftViewControllerStyle;
        if(_leftView != nil) {
            [self.view glb_setSubviews:[self _orderedSubviews]];
            [self _updateLeftView];

        }
    }
}

- (void)setLeftViewControllerWidth:(CGFloat)leftViewControllerWidth {
    if(_leftViewControllerWidth != leftViewControllerWidth) {
        _leftViewControllerWidth = leftViewControllerWidth;
        if(_leftView != nil) {
            [self _updateLeftView];
        }
    }
}

- (void)setLeftViewControllerIteractionShowEnabled:(BOOL)leftViewControllerIteractionShowEnabled {
    if(_leftViewControllerIteractionShowEnabled != leftViewControllerIteractionShowEnabled) {
        _leftViewControllerIteractionShowEnabled = leftViewControllerIteractionShowEnabled;
        [self _updateIteraction];
    }
}

- (void)setLeftViewControllerIteractionHideEnabled:(BOOL)leftViewControllerIteractionHideEnabled {
    if(_leftViewControllerIteractionHideEnabled != leftViewControllerIteractionHideEnabled) {
        _leftViewControllerIteractionHideEnabled = leftViewControllerIteractionHideEnabled;
        [self _updateIteraction];
    }
}

- (void)setLeftViewControllerHideOffset:(CGFloat)leftViewControllerHideOffset {
    if(_leftViewControllerHideOffset != leftViewControllerHideOffset) {
        _leftViewControllerHideOffset = leftViewControllerHideOffset;
        if(_leftView != nil) {
            [self _updateLeftView];
        }
    }
}

- (void)setLeftViewControllerShowOffset:(CGFloat)leftViewControllerShowOffset {
    if(_leftViewControllerShowOffset != leftViewControllerShowOffset) {
        _leftViewControllerShowOffset = leftViewControllerShowOffset;
        if(_leftView != nil) {
            [self _updateLeftView];
        }
    }
}

- (void)setLeftViewControllerHideAlpha:(CGFloat)leftViewControllerHideAlpha {
    if(_leftViewControllerHideAlpha != leftViewControllerHideAlpha) {
        _leftViewControllerHideAlpha = leftViewControllerHideAlpha;
        if(_leftView != nil) {
            _leftView.alpha = [self _leftViewAlphaByPercent:_swipeProgress];
        }
    }
}

- (void)setLeftViewControllerShowAlpha:(CGFloat)leftViewControllerShowAlpha {
    if(_leftViewControllerShowAlpha != leftViewControllerShowAlpha) {
        _leftViewControllerShowAlpha = leftViewControllerShowAlpha;
        if(_leftView != nil) {
            _leftView.alpha = [self _leftViewAlphaByPercent:_swipeProgress];
        }
    }
}

- (void)setRightViewController:(UIViewController*)rightViewController {
    [self setRightViewController:rightViewController animated:NO complete:nil];
}

- (void)setRightViewControllerStyle:(GLBSlideViewControllerStyle)rightViewControllerStyle {
    if(_rightViewControllerStyle != rightViewControllerStyle) {
        _rightViewControllerStyle = rightViewControllerStyle;
        if(_rightView != nil) {
            [self.view glb_setSubviews:[self _orderedSubviews]];
            [self _updateRightView];

        }
    }
}

- (void)setRightViewControllerWidth:(CGFloat)rightViewControllerWidth {
    if(_rightViewControllerWidth != rightViewControllerWidth) {
        _rightViewControllerWidth = rightViewControllerWidth;
        if(_rightView != nil) {
            [self _updateRightView];
        }
    }
}

- (void)setRightViewControllerIteractionShowEnabled:(BOOL)rightViewControllerIteractionShowEnabled {
    if(_rightViewControllerIteractionShowEnabled != rightViewControllerIteractionShowEnabled) {
        _rightViewControllerIteractionShowEnabled = rightViewControllerIteractionShowEnabled;
        [self _updateIteraction];
    }
}

- (void)setRightViewControllerIteractionHideEnabled:(BOOL)rightViewControllerIteractionHideEnabled {
    if(_rightViewControllerIteractionHideEnabled != rightViewControllerIteractionHideEnabled) {
        _rightViewControllerIteractionHideEnabled = rightViewControllerIteractionHideEnabled;
        [self _updateIteraction];
    }
}

- (void)setRightViewControllerHideOffset:(CGFloat)rightViewControllerHideOffset {
    if(_rightViewControllerHideOffset != rightViewControllerHideOffset) {
        _rightViewControllerHideOffset = rightViewControllerHideOffset;
        if(_rightView != nil) {
            [self _updateRightView];
        }
    }
}

- (void)setRightViewControllerShowOffset:(CGFloat)rightViewControllerShowOffset {
    if(_rightViewControllerShowOffset != rightViewControllerShowOffset) {
        _rightViewControllerShowOffset = rightViewControllerShowOffset;
        if(_rightView != nil) {
            [self _updateRightView];
        }
    }
}

- (void)setRightViewControllerHideAlpha:(CGFloat)rightViewControllerHideAlpha {
    if(_rightViewControllerHideAlpha != rightViewControllerHideAlpha) {
        _rightViewControllerHideAlpha = rightViewControllerHideAlpha;
        if(_rightView != nil) {
            _rightView.alpha = [self _rightViewAlphaByPercent:_swipeProgress];
        }
    }
}

- (void)setRightViewControllerShowAlpha:(CGFloat)rightViewControllerShowAlpha {
    if(_rightViewControllerShowAlpha != rightViewControllerShowAlpha) {
        _rightViewControllerShowAlpha = rightViewControllerShowAlpha;
        if(_rightView != nil) {
            _rightView.alpha = [self _rightViewAlphaByPercent:_swipeProgress];
        }
    }
}

- (void)setCenterViewController:(UIViewController*)centerViewController {
    [self setCenterViewController:centerViewController animated:NO complete:nil];
}

- (void)setCenterViewControllerHideOffset:(CGFloat)centerViewControllerHideOffset {
    if(_centerViewControllerHideOffset != centerViewControllerHideOffset) {
        _centerViewControllerHideOffset = centerViewControllerHideOffset;
        if(_centerView != nil) {
            [self _updateCenterView];
        }
    }
}

- (void)setCenterViewControllerShowOffset:(CGFloat)centerViewControllerShowOffset {
    if(_centerViewControllerShowOffset != centerViewControllerShowOffset) {
        _centerViewControllerShowOffset = centerViewControllerShowOffset;
        if(_centerView != nil) {
            [self _updateCenterView];
        }
    }
}

- (void)setCenterViewControllerHideAlpha:(CGFloat)centerViewControllerHideAlpha {
    if(_centerViewControllerHideAlpha != centerViewControllerHideAlpha) {
        _centerViewControllerHideAlpha = centerViewControllerHideAlpha;
        if(_centerView != nil) {
            _centerView.alpha = [self _centerViewAlphaByPercent:_swipeProgress];
        }
    }
}

- (void)setCenterViewControllerShowAlpha:(CGFloat)centerViewControllerShowAlpha {
    if(_centerViewControllerShowAlpha != centerViewControllerShowAlpha) {
        _centerViewControllerShowAlpha = centerViewControllerShowAlpha;
        if(_centerView != nil) {
            _centerView.alpha = [self _centerViewAlphaByPercent:_swipeProgress];
        }
    }
}

- (BOOL)isNavigationBarHidden {
    id vc = _centerViewController;
    if([vc respondsToSelector:@selector(isNavigationBarHidden)] == YES) {
        return [vc isNavigationBarHidden];
    }
    return NO;
}

- (BOOL)isToolbarHidden {
    id vc = _centerViewController;
    if([vc respondsToSelector:@selector(isToolbarHidden)] == YES) {
        return [vc isToolbarHidden];
    }
    return NO;
}

- (BOOL)hidesBarsWhenKeyboardAppears {
    id vc = _centerViewController;
    if([vc respondsToSelector:@selector(hidesBarsWhenKeyboardAppears)] == YES) {
        return [vc hidesBarsWhenKeyboardAppears];
    }
    return NO;
}

- (BOOL)hidesBarsWhenVerticallyCompact {
    id vc = _centerViewController;
    if([vc respondsToSelector:@selector(hidesBarsWhenVerticallyCompact)] == YES) {
        return [vc hidesBarsWhenVerticallyCompact];
    }
    return NO;
}

- (BOOL)hidesBarsOnTap {
    id vc = _centerViewController;
    if([vc respondsToSelector:@selector(hidesBarsOnTap)] == YES) {
        return [vc hidesBarsOnTap];
    }
    return NO;
}

- (BOOL)hideKeyboardIfTouched {
    id vc = _centerViewController;
    if([vc respondsToSelector:@selector(hideKeyboardIfTouched)] == YES) {
        return [vc hideKeyboardIfTouched];
    }
    return NO;
}

#pragma mark - Public

- (void)setBackgroundViewController:(UIViewController*)backgroundViewController animated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    if(_backgroundViewController != backgroundViewController) {
        if(self.isViewLoaded == NO) {
            animated = NO;
        }
        if((_backgroundViewController != nil) && (self.isViewLoaded == YES)) {
            [self _disappearBackgroundViewController];
        }
        _backgroundViewController = backgroundViewController;
        if((_backgroundViewController != nil) && (self.isViewLoaded == YES)) {
            [self _appearBackgroundViewController];
        }
        if(complete != nil) {
            complete();
        }
    }
}

- (void)setLeftViewController:(UIViewController*)leftViewController animated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    if(_leftViewController != leftViewController) {
        if(self.isViewLoaded == NO) {
            animated = NO;
        }
        if((_leftViewController != nil) && (self.isViewLoaded == YES)) {
            [self _disappearLeftViewController];
        }
        _leftViewController = leftViewController;
        if((_leftViewController != nil) && (self.isViewLoaded == YES)) {
            [self _appearLeftViewController];
        }
        if(complete != nil) {
            complete();
        }
    }
}

- (void)setRightViewController:(UIViewController*)rightViewController animated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    if(_rightViewController != rightViewController) {
        if(self.isViewLoaded == NO) {
            animated = NO;
        }
        if((_rightViewController != nil) && (self.isViewLoaded == YES)) {
            [self _disappearRightViewController];
        }
        _rightViewController = rightViewController;
        if((_rightViewController != nil) && (self.isViewLoaded == YES)) {
            [self _appearRightViewController];
        }
        if(complete != nil) {
            complete();
        }
    }
}

- (void)setCenterViewController:(UIViewController*)centerViewController animated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    if(_centerViewController != centerViewController) {
        if(self.isViewLoaded == NO) {
            animated = NO;
        }
        if((_centerViewController != nil) && (self.isViewLoaded == YES)) {
            [self _disappearCenterViewController];
        }
        _centerViewController = centerViewController;
        if((_centerViewController != nil) && (self.isViewLoaded == YES)) {
            [self _appearCenterViewController];
        }
        if(complete != nil) {
            complete();
        }
    }
}

- (void)showLeftViewControllerAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    if((_leftViewController != nil) && (_showedLeftViewController == NO)) {
        BOOL allow = YES;
        id< GLBSlideViewControllerDelegate > centerViewController = ([_centerViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_centerViewController : nil;
        id< GLBSlideViewControllerDelegate > leftViewController = ([_leftViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_leftViewController : nil;
        if([centerViewController respondsToSelector:@selector(canShowLeftViewControllerInSlideViewController:)] == YES) {
            if([centerViewController canShowLeftViewControllerInSlideViewController:self] == YES) {
                if([leftViewController respondsToSelector:@selector(canShowControllerInSlideViewController:)] == YES) {
                    allow = [leftViewController canShowControllerInSlideViewController:self];
                }
            } else {
                allow = NO;
            }
        }
        if(allow == YES) {
            if(self.isViewLoaded == NO) {
                animated = NO;
            }
            _showedLeftViewController = YES;
            if(_canUseScreenshot == YES) {
                [self _takeScreenshotView];
            }
            _swipeProgress = -1.0f;
            _leftView.hidden = NO;
            _rightView.hidden = YES;
            CGRect leftFrame = [self _leftViewFrameByPercent:_swipeProgress];
            CGFloat leftAlpha = [self _leftViewAlphaByPercent:_swipeProgress];
            CGRect centerFrame = [self _centerViewFrameByPercent:_swipeProgress];
            CGFloat centerAlpha = [self _centerViewAlphaByPercent:_swipeProgress];
            if(animated == YES) {
                NSTimeInterval duration = _leftViewControllerWidth / _swipeVelocity;
                if([centerViewController respondsToSelector:@selector(willShowLeftViewControllerInSlideViewController:duration:)] == YES) {
                    [centerViewController willShowLeftViewControllerInSlideViewController:self duration:duration];
                }
                if([leftViewController respondsToSelector:@selector(willShowControllerInSlideViewController:duration:)] == YES) {
                    [leftViewController willShowControllerInSlideViewController:self duration:duration];
                }
                UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState;
                if(_swipeUseSpring == YES) {
                    [UIView animateWithDuration:duration delay:0.0f usingSpringWithDamping:_swipeDamping initialSpringVelocity:0.0f options:options | UIViewAnimationOptionCurveLinear animations:^{
                        _leftView.frame = leftFrame;
                        _leftView.alpha = leftAlpha;
                        _centerView.frame = centerFrame;
                        _centerView.alpha = centerAlpha;
                        if(_draggingStatusBar == YES) {
                            [self _updateStatusBarFrame];
                        }
                    } completion:^(BOOL finished) {
                        _leftView.userInteractionEnabled = YES;
                        _centerView.userInteractionEnabled = !_leftViewControllerIteractionShowEnabled;
                        if([centerViewController respondsToSelector:@selector(didShowLeftViewControllerInSlideViewController:)] == YES) {
                            [centerViewController didShowLeftViewControllerInSlideViewController:self];
                        }
                        if([leftViewController respondsToSelector:@selector(didShowControllerInSlideViewController:)] == YES) {
                            [leftViewController didShowControllerInSlideViewController:self];
                        }
                        if(complete != nil) {
                            complete();
                        }
                    }];
                } else {
                    [UIView animateWithDuration:duration delay:0.0f options:options | UIViewAnimationOptionCurveEaseOut animations:^{
                        _leftView.frame = leftFrame;
                        _leftView.alpha = leftAlpha;
                        _centerView.frame = centerFrame;
                        _centerView.alpha = centerAlpha;
                        if(_draggingStatusBar == YES) {
                            [self _updateStatusBarFrame];
                        }
                    } completion:^(BOOL finished) {
                        _leftView.userInteractionEnabled = YES;
                        _centerView.userInteractionEnabled = !_leftViewControllerIteractionShowEnabled;
                        if([centerViewController respondsToSelector:@selector(didShowLeftViewControllerInSlideViewController:)] == YES) {
                            [centerViewController didShowLeftViewControllerInSlideViewController:self];
                        }
                        if([leftViewController respondsToSelector:@selector(didShowControllerInSlideViewController:)] == YES) {
                            [leftViewController didShowControllerInSlideViewController:self];
                        }
                        if(complete != nil) {
                            complete();
                        }
                    }];
                }
            } else {
                if([centerViewController respondsToSelector:@selector(willShowLeftViewControllerInSlideViewController:duration:)] == YES) {
                    [centerViewController willShowLeftViewControllerInSlideViewController:self duration:0.0f];
                }
                if([leftViewController respondsToSelector:@selector(willShowControllerInSlideViewController:duration:)] == YES) {
                    [leftViewController willShowControllerInSlideViewController:self duration:0.0f];
                }
                _leftView.frame = leftFrame;
                _leftView.alpha = leftAlpha;
                _leftView.userInteractionEnabled = YES;
                _centerView.frame = centerFrame;
                _centerView.alpha = centerAlpha;
                _centerView.userInteractionEnabled = !_leftViewControllerIteractionShowEnabled;
                if(_draggingStatusBar == YES) {
                    [self _updateStatusBarFrame];
                }
                if([centerViewController respondsToSelector:@selector(didShowLeftViewControllerInSlideViewController:)] == YES) {
                    [centerViewController didShowLeftViewControllerInSlideViewController:self];
                }
                if([leftViewController respondsToSelector:@selector(didShowControllerInSlideViewController:)] == YES) {
                    [leftViewController didShowControllerInSlideViewController:self];
                }
                if(complete != nil) {
                    complete();
                }
            }
        }
    }
}

- (void)hideLeftViewControllerAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    if(_showedLeftViewController == YES) {
        id< GLBSlideViewControllerDelegate > centerViewController = ([_centerViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_centerViewController : nil;
        id< GLBSlideViewControllerDelegate > leftViewController = ([_leftViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_leftViewController : nil;
        if(self.isViewLoaded == NO) {
            animated = NO;
        }
        _swipeProgress = 0.0f;
        CGRect leftFrame = [self _leftViewFrameByPercent:_swipeProgress];
        CGFloat leftAlpha = [self _leftViewAlphaByPercent:_swipeProgress];
        CGRect centerFrame = [self _centerViewFrameByPercent:_swipeProgress];
        CGFloat centerAlpha = [self _centerViewAlphaByPercent:_swipeProgress];
        if(animated == YES) {
            NSTimeInterval duration = _leftViewControllerWidth / _swipeVelocity;
            if([centerViewController respondsToSelector:@selector(willHideLeftViewControllerInSlideViewController:duration:)] == YES) {
                [centerViewController willHideLeftViewControllerInSlideViewController:self duration:duration];
            }
            if([leftViewController respondsToSelector:@selector(willHideControllerInSlideViewController:duration:)] == YES) {
                [leftViewController willHideControllerInSlideViewController:self duration:duration];
            }
            UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState;
            if(_swipeUseSpring == YES) {
                [UIView animateWithDuration:duration delay:0.0f usingSpringWithDamping:_swipeDamping initialSpringVelocity:0.0f options:options | UIViewAnimationOptionCurveLinear animations:^{
                    _leftView.frame = leftFrame;
                    _leftView.alpha = leftAlpha;
                    _centerView.frame = centerFrame;
                    _centerView.alpha = centerAlpha;
                    if(_draggingStatusBar == YES) {
                        [self _updateStatusBarFrame];
                    }
                } completion:^(BOOL finished) {
                    _leftView.hidden = YES;
                    _leftView.userInteractionEnabled = NO;
                    _centerView.userInteractionEnabled = YES;
                    _showedLeftViewController = NO;
                    self.screenshotView = nil;
                    if([centerViewController respondsToSelector:@selector(didHideLeftViewControllerInSlideViewController:)] == YES) {
                        [centerViewController didHideLeftViewControllerInSlideViewController:self];
                    }
                    if([leftViewController respondsToSelector:@selector(didHideControllerInSlideViewController:)] == YES) {
                        [leftViewController didHideControllerInSlideViewController:self];
                    }
                    if(complete != nil) {
                        complete();
                    }
                }];
            } else {
                [UIView animateWithDuration:duration delay:0.0f options:options | UIViewAnimationOptionCurveEaseOut animations:^{
                    _leftView.frame = leftFrame;
                    _leftView.alpha = leftAlpha;
                    _centerView.frame = centerFrame;
                    _centerView.alpha = centerAlpha;
                    if(_draggingStatusBar == YES) {
                        [self _updateStatusBarFrame];
                    }
                } completion:^(BOOL finished) {
                    _leftView.hidden = YES;
                    _leftView.userInteractionEnabled = NO;
                    _centerView.userInteractionEnabled = YES;
                    _showedLeftViewController = NO;
                    self.screenshotView = nil;
                    if([centerViewController respondsToSelector:@selector(didHideLeftViewControllerInSlideViewController:)] == YES) {
                        [centerViewController didHideLeftViewControllerInSlideViewController:self];
                    }
                    if([leftViewController respondsToSelector:@selector(didHideControllerInSlideViewController:)] == YES) {
                        [leftViewController didHideControllerInSlideViewController:self];
                    }
                    if(complete != nil) {
                        complete();
                    }
                }];
            }
        } else {
            if([centerViewController respondsToSelector:@selector(willHideLeftViewControllerInSlideViewController:duration:)] == YES) {
                [centerViewController willHideLeftViewControllerInSlideViewController:self duration:0.0f];
            }
            if([leftViewController respondsToSelector:@selector(willHideControllerInSlideViewController:duration:)] == YES) {
                [leftViewController willHideControllerInSlideViewController:self duration:0.0f];
            }
            _leftView.frame = leftFrame;
            _leftView.alpha = leftAlpha;
            _leftView.userInteractionEnabled = NO;
            _leftView.hidden = YES;
            _centerView.frame = centerFrame;
            _centerView.alpha = centerAlpha;
            _centerView.userInteractionEnabled = YES;
            if(_draggingStatusBar == YES) {
                [self _updateStatusBarFrame];
            }
            _showedLeftViewController = NO;
            self.screenshotView = nil;
            if([centerViewController respondsToSelector:@selector(didHideLeftViewControllerInSlideViewController:)] == YES) {
                [centerViewController didHideLeftViewControllerInSlideViewController:self];
            }
            if([leftViewController respondsToSelector:@selector(didHideControllerInSlideViewController:)] == YES) {
                [leftViewController didHideControllerInSlideViewController:self];
            }
            if(complete != nil) {
                complete();
            }
        }
    }
}

- (void)showRightViewControllerAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    if((_rightViewController != nil) && (_showedRightViewController == NO)) {
        BOOL allow = YES;
        id< GLBSlideViewControllerDelegate > centerViewController = ([_centerViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_centerViewController : nil;
        id< GLBSlideViewControllerDelegate > rightViewController = ([_rightViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_rightViewController : nil;
        if([centerViewController respondsToSelector:@selector(canShowRightViewControllerInSlideViewController:)] == YES) {
            if([centerViewController canShowRightViewControllerInSlideViewController:self] == YES) {
                if([rightViewController respondsToSelector:@selector(canShowControllerInSlideViewController:)] == YES) {
                    allow = [rightViewController canShowControllerInSlideViewController:self];
                }
            } else {
                allow = NO;
            }
        }
        if(allow == YES) {
            if(self.isViewLoaded == NO) {
                animated = NO;
            }
            _showedRightViewController = YES;
            if(_canUseScreenshot == YES) {
                [self _takeScreenshotView];
            }
            _swipeProgress = 1.0f;
            _leftView.hidden = YES;
            _rightView.hidden = NO;
            CGRect rightFrame = [self _rightViewFrameByPercent:_swipeProgress];
            CGFloat rightAlpha = [self _rightViewAlphaByPercent:_swipeProgress];
            CGRect centerFrame = [self _centerViewFrameByPercent:_swipeProgress];
            CGFloat centerAlpha = [self _centerViewAlphaByPercent:_swipeProgress];
            if(animated == YES) {
                NSTimeInterval duration = _rightViewControllerWidth / _swipeVelocity;
                if([centerViewController respondsToSelector:@selector(willShowRightViewControllerInSlideViewController:duration:)] == YES) {
                    [centerViewController willShowRightViewControllerInSlideViewController:self duration:duration];
                }
                if([rightViewController respondsToSelector:@selector(willShowControllerInSlideViewController:duration:)] == YES) {
                    [rightViewController willShowControllerInSlideViewController:self duration:duration];
                }
                UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState;
                if(_swipeUseSpring == YES) {
                    [UIView animateWithDuration:duration delay:0.0f usingSpringWithDamping:_swipeDamping initialSpringVelocity:0.0f options:options | UIViewAnimationOptionCurveLinear animations:^{
                        _rightView.frame = rightFrame;
                        _rightView.alpha = rightAlpha;
                        _centerView.frame = centerFrame;
                        _centerView.alpha = centerAlpha;
                        if(_draggingStatusBar == YES) {
                            [self _updateStatusBarFrame];
                        }
                    } completion:^(BOOL finished) {
                        _rightView.userInteractionEnabled = YES;
                        _centerView.userInteractionEnabled = !_rightViewControllerIteractionShowEnabled;
                        if([centerViewController respondsToSelector:@selector(didShowRightViewControllerInSlideViewController:)] == YES) {
                            [centerViewController didShowRightViewControllerInSlideViewController:self];
                        }
                        if([rightViewController respondsToSelector:@selector(didShowControllerInSlideViewController:)] == YES) {
                            [rightViewController didShowControllerInSlideViewController:self];
                        }
                        if(complete != nil) {
                            complete();
                        }
                    }];
                } else {
                    [UIView animateWithDuration:duration delay:0.0f options:options | UIViewAnimationOptionCurveEaseOut animations:^{
                        _rightView.frame = rightFrame;
                        _rightView.alpha = rightAlpha;
                        _centerView.frame = centerFrame;
                        _centerView.alpha = centerAlpha;
                        if(_draggingStatusBar == YES) {
                            [self _updateStatusBarFrame];
                        }
                    } completion:^(BOOL finished) {
                        _rightView.userInteractionEnabled = YES;
                        _centerView.userInteractionEnabled = !_rightViewControllerIteractionShowEnabled;
                        if([centerViewController respondsToSelector:@selector(didShowRightViewControllerInSlideViewController:)] == YES) {
                            [centerViewController didShowRightViewControllerInSlideViewController:self];
                        }
                        if([rightViewController respondsToSelector:@selector(didShowControllerInSlideViewController:)] == YES) {
                            [rightViewController didShowControllerInSlideViewController:self];
                        }
                        if(complete != nil) {
                            complete();
                        }
                    }];
                }
            } else {
                if([centerViewController respondsToSelector:@selector(willShowRightViewControllerInSlideViewController:duration:)] == YES) {
                    [centerViewController willShowRightViewControllerInSlideViewController:self duration:0.0f];
                }
                if([rightViewController respondsToSelector:@selector(willShowControllerInSlideViewController:duration:)] == YES) {
                    [rightViewController willShowControllerInSlideViewController:self duration:0.0f];
                }
                _rightView.frame = rightFrame;
                _rightView.alpha = rightAlpha;
                _rightView.userInteractionEnabled = YES;
                _centerView.frame = centerFrame;
                _centerView.alpha = centerAlpha;
                _centerView.userInteractionEnabled = !_rightViewControllerIteractionShowEnabled;
                if(_draggingStatusBar == YES) {
                    [self _updateStatusBarFrame];
                }
                _showedRightViewController = YES;
                if([centerViewController respondsToSelector:@selector(didShowRightViewControllerInSlideViewController:)] == YES) {
                    [centerViewController didShowRightViewControllerInSlideViewController:self];
                }
                if([rightViewController respondsToSelector:@selector(didShowControllerInSlideViewController:)] == YES) {
                    [rightViewController didShowControllerInSlideViewController:self];
                }
                if(complete != nil) {
                    complete();
                }
            }
        }
    }
}

- (void)hideRightViewControllerAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    if(_showedRightViewController == YES) {
        id< GLBSlideViewControllerDelegate > centerViewController = ([_centerViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_centerViewController : nil;
        id< GLBSlideViewControllerDelegate > rightViewController = ([_rightViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_rightViewController : nil;
        if(self.isViewLoaded == NO) {
            animated = NO;
        }
        _swipeProgress = 0.0f;
        CGRect rightFrame = [self _rightViewFrameByPercent:_swipeProgress];
        CGFloat rightAlpha = [self _rightViewAlphaByPercent:_swipeProgress];
        CGRect centerFrame = [self _centerViewFrameByPercent:_swipeProgress];
        CGFloat centerAlpha = [self _centerViewAlphaByPercent:_swipeProgress];
        if(animated == YES) {
            NSTimeInterval duration = _rightViewControllerWidth / _swipeVelocity;
            if([centerViewController respondsToSelector:@selector(willHideRightViewControllerInSlideViewController:duration:)] == YES) {
                [centerViewController willHideRightViewControllerInSlideViewController:self duration:duration];
            }
            if([rightViewController respondsToSelector:@selector(willHideRightViewControllerInSlideViewController:duration:)] == YES) {
                [rightViewController willHideControllerInSlideViewController:self duration:duration];
            }
            UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState;
            if(_swipeUseSpring == YES) {
                [UIView animateWithDuration:duration delay:0.0f usingSpringWithDamping:_swipeDamping initialSpringVelocity:0.0f options:options | UIViewAnimationOptionCurveLinear animations:^{
                    _rightView.frame = rightFrame;
                    _rightView.alpha = rightAlpha;
                    _centerView.frame = centerFrame;
                    _centerView.alpha = centerAlpha;
                    if(_draggingStatusBar == YES) {
                        [self _updateStatusBarFrame];
                    }
                } completion:^(BOOL finished) {
                    _rightView.hidden = YES;
                    _rightView.userInteractionEnabled = NO;
                    _centerView.userInteractionEnabled = YES;
                    _showedRightViewController = NO;
                    self.screenshotView = nil;
                    if([centerViewController respondsToSelector:@selector(didHideRightViewControllerInSlideViewController:)] == YES) {
                        [centerViewController didHideRightViewControllerInSlideViewController:self];
                    }
                    if([rightViewController respondsToSelector:@selector(didHideRightViewControllerInSlideViewController:)] == YES) {
                        [rightViewController didHideControllerInSlideViewController:self];
                    }
                    if(complete != nil) {
                        complete();
                    }
                }];
            } else {
                [UIView animateWithDuration:duration delay:0.0f options:options | UIViewAnimationOptionCurveEaseOut animations:^{
                    _rightView.frame = rightFrame;
                    _rightView.alpha = rightAlpha;
                    _centerView.frame = centerFrame;
                    _centerView.alpha = centerAlpha;
                    if(_draggingStatusBar == YES) {
                        [self _updateStatusBarFrame];
                    }
                } completion:^(BOOL finished) {
                    _rightView.hidden = YES;
                    _rightView.userInteractionEnabled = NO;
                    _centerView.userInteractionEnabled = YES;
                    _showedRightViewController = NO;
                    self.screenshotView = nil;
                    if([centerViewController respondsToSelector:@selector(didHideRightViewControllerInSlideViewController:)] == YES) {
                        [centerViewController didHideRightViewControllerInSlideViewController:self];
                    }
                    if([rightViewController respondsToSelector:@selector(didHideRightViewControllerInSlideViewController:)] == YES) {
                        [rightViewController didHideControllerInSlideViewController:self];
                    }
                    if(complete != nil) {
                        complete();
                    }
                }];
            }
        } else {
            if([centerViewController respondsToSelector:@selector(willHideRightViewControllerInSlideViewController:duration:)] == YES) {
                [centerViewController willHideRightViewControllerInSlideViewController:self duration:0.0f];
            }
            if([rightViewController respondsToSelector:@selector(willHideRightViewControllerInSlideViewController:duration:)] == YES) {
                [rightViewController willHideControllerInSlideViewController:self duration:0.0f];
            }
            _rightView.frame = rightFrame;
            _rightView.alpha = rightAlpha;
            _rightView.userInteractionEnabled = NO;
            _rightView.hidden = YES;
            _centerView.frame = centerFrame;
            _centerView.alpha = centerAlpha;
            _centerView.userInteractionEnabled = YES;
            if(_draggingStatusBar == YES) {
                [self _updateStatusBarFrame];
            }
            _showedRightViewController = NO;
            self.screenshotView = nil;
            if([centerViewController respondsToSelector:@selector(didHideRightViewControllerInSlideViewController:)] == YES) {
                [centerViewController didHideRightViewControllerInSlideViewController:self];
            }
            if([rightViewController respondsToSelector:@selector(didHideRightViewControllerInSlideViewController:)] == YES) {
                [rightViewController didHideControllerInSlideViewController:self];
            }
            if(complete != nil) {
                complete();
            }
        }
    }
}

#pragma mark - Private

- (NSArray*)_orderedSubviews {
    NSMutableArray* result = [NSMutableArray array];
    if(_backgroundView != nil) {
        [result addObject:_backgroundView];
    }
    if(_leftView != nil) {
        switch(_leftViewControllerStyle) {
            case GLBSlideViewControllerStyleStands:
            case GLBSlideViewControllerStyleLeaves:
                [result addObject:_leftView];
                break;
            default:
                break;
        }
    }
    if(_rightView != nil) {
        switch(_rightViewControllerStyle) {
            case GLBSlideViewControllerStyleStands:
            case GLBSlideViewControllerStyleLeaves:
                [result addObject:_rightView];
                break;
            default:
                break;
        }
    }
    if(_centerView != nil) {
        [result addObject:_centerView];
    }
    if(_leftView != nil) {
        switch(_leftViewControllerStyle) {
            case GLBSlideViewControllerStylePushes:
            case GLBSlideViewControllerStyleStretch:
                [result addObject:_leftView];
                break;
            default:
                break;
        }
    }
    if(_rightView != nil) {
        switch(_rightViewControllerStyle) {
            case GLBSlideViewControllerStylePushes:
            case GLBSlideViewControllerStyleStretch:
                [result addObject:_rightView];
                break;
            default:
                break;
        }
    }
    return result;
}

- (void)_updateLeftView {
    CGRect bounds = self.view.bounds;
    _backgroundView.frame = bounds;
    _leftView.frame = [self _leftViewFrameFromBounds:bounds byPercent:_swipeProgress];
    _centerView.frame = [self _centerViewFrameFromBounds:bounds byPercent:_swipeProgress];
}

- (void)_updateRightView {
    CGRect bounds = self.view.bounds;
    _backgroundView.frame = bounds;
    _centerView.frame = [self _centerViewFrameFromBounds:bounds byPercent:_swipeProgress];
    _rightView.frame = [self _rightViewFrameFromBounds:bounds byPercent:_swipeProgress];
}

- (void)_updateCenterView {
    CGRect bounds = self.view.bounds;
    _backgroundView.frame = bounds;
    _leftView.frame = [self _leftViewFrameFromBounds:bounds byPercent:_swipeProgress];
    _centerView.frame = [self _centerViewFrameFromBounds:bounds byPercent:_swipeProgress];
    _rightView.frame = [self _rightViewFrameFromBounds:bounds byPercent:_swipeProgress];
}

- (void)_updateIteraction {
    if(_showedLeftViewController == YES) {
        _leftView.userInteractionEnabled = YES;
        _rightView.userInteractionEnabled = NO;
        _centerView.userInteractionEnabled = !_leftViewControllerIteractionShowEnabled;
    } else if(_showedRightViewController == YES) {
        _leftView.userInteractionEnabled = NO;
        _rightView.userInteractionEnabled = YES;
        _centerView.userInteractionEnabled = !_rightViewControllerIteractionShowEnabled;
    } else {
        _leftView.userInteractionEnabled = NO;
        _rightView.userInteractionEnabled = NO;
        _centerView.userInteractionEnabled = YES;
    }
}

- (void)_takeScreenshotView {
#ifndef GLOBUS_APP_EXTENSION
    CGRect bounds = [self.view convertRect:self.view.bounds toView:nil];
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, UIScreen.mainScreen.scale);
    [UIApplication.sharedApplication.glb_windows glb_each:^(UIWindow* window) {
        [window drawViewHierarchyInRect:bounds afterScreenUpdates:NO];
    } options:NSEnumerationReverse];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if(image != nil) {
        self.screenshotView = [[UIImageView alloc] initWithImage:image];
    } else {
        self.screenshotView = nil;
    }
#endif
}

- (CGRect)_leftViewFrameByPercent:(CGFloat)percent {
    return [self _leftViewFrameFromBounds:self.view.bounds byPercent:percent];
}

- (CGRect)_leftViewFrameFromBounds:(CGRect)bounds byPercent:(CGFloat)percent {
    CGFloat p = -percent;
    switch(_leftViewControllerStyle) {
        case GLBSlideViewControllerStyleStands:
            bounds.size.width = _leftViewControllerWidth;
            break;
        case GLBSlideViewControllerStyleLeaves:
        case GLBSlideViewControllerStylePushes:
        case GLBSlideViewControllerStyleStretch:
            bounds.origin.x = GLBFloatLerp(bounds.origin.x - _leftViewControllerWidth, bounds.origin.x, p);
            bounds.size.width = _leftViewControllerWidth;
            break;
    }
    bounds.origin.y = GLBFloatLerp(bounds.origin.y + _leftViewControllerHideOffset, bounds.origin.y + _leftViewControllerShowOffset, p);
    return bounds;
}

- (CGFloat)_leftViewAlphaByPercent:(CGFloat)percent {
    return GLBFloatLerp(_leftViewControllerHideAlpha, _leftViewControllerShowAlpha, -percent);
}

- (CGRect)_rightViewFrameByPercent:(CGFloat)percent {
    return [self _rightViewFrameFromBounds:self.view.bounds byPercent:percent];
}

- (CGRect)_rightViewFrameFromBounds:(CGRect)bounds byPercent:(CGFloat)percent {
    CGFloat p = percent;
    CGFloat bx = bounds.origin.x + bounds.size.width;
    switch(_rightViewControllerStyle) {
        case GLBSlideViewControllerStyleStands:
            bounds.origin.x = bx - _rightViewControllerWidth;
            bounds.size.width = _rightViewControllerWidth;
            break;
        case GLBSlideViewControllerStyleLeaves:
        case GLBSlideViewControllerStylePushes:
        case GLBSlideViewControllerStyleStretch:
            bounds.origin.x = GLBFloatLerp(bx, bx - _rightViewControllerWidth, p);
            bounds.size.width = _rightViewControllerWidth;
            break;
    }
    bounds.origin.y = GLBFloatLerp(bounds.origin.y + _rightViewControllerHideOffset, bounds.origin.y + _rightViewControllerShowOffset, p);
    return bounds;
}

- (CGFloat)_rightViewAlphaByPercent:(CGFloat)percent {
    return GLBFloatLerp(_rightViewControllerHideAlpha, _rightViewControllerShowAlpha, percent);
}

- (CGRect)_centerViewFrameByPercent:(CGFloat)percent {
    return [self _centerViewFrameFromBounds:self.view.bounds byPercent:percent];
}

- (CGRect)_centerViewFrameFromBounds:(CGRect)bounds byPercent:(CGFloat)percent {
    CGFloat p = 0.0f;
    if(percent < -FLT_EPSILON) {
        p = -percent;
        switch(_leftViewControllerStyle) {
            case GLBSlideViewControllerStyleStands:
            case GLBSlideViewControllerStyleLeaves:
                bounds.origin.x = GLBFloatLerp(bounds.origin.x, bounds.origin.x + _leftViewControllerWidth, p);
                break;
            case GLBSlideViewControllerStylePushes:
                break;
            case GLBSlideViewControllerStyleStretch:
                bounds.origin.x = GLBFloatLerp(bounds.origin.x, bounds.origin.x + _leftViewControllerWidth, p);
                bounds.size.width = GLBFloatLerp(bounds.size.width, bounds.size.width - _leftViewControllerWidth, p);
                break;
        }
    } else if(percent > FLT_EPSILON) {
        p = percent;
        switch(_rightViewControllerStyle) {
            case GLBSlideViewControllerStyleStands:
            case GLBSlideViewControllerStyleLeaves:
                bounds.origin.x = GLBFloatLerp(bounds.origin.x, bounds.origin.x - _rightViewControllerWidth, p);
                break;
            case GLBSlideViewControllerStylePushes:
                break;
            case GLBSlideViewControllerStyleStretch:
                bounds.size.width = GLBFloatLerp(bounds.size.width, bounds.size.width - _rightViewControllerWidth, p);
                break;
        }
    }
    bounds.origin.y = GLBFloatLerp(bounds.origin.y + _centerViewControllerHideOffset, bounds.origin.y + _centerViewControllerShowOffset, p);
    return bounds;
}

- (CGFloat)_centerViewAlphaByPercent:(CGFloat)percent {
    return GLBFloatLerp(_centerViewControllerShowAlpha, _centerViewControllerHideAlpha, ABS(percent));
}

- (void)_updateStatusBarFrame {
#ifndef GLOBUS_APP_EXTENSION
    UIWindow* statusBarWindow = UIApplication.sharedApplication.glb_statusBarWindow;
    if(statusBarWindow != nil) {
        statusBarWindow.frame = [self.view convertRect:_centerView.frame toView:nil];
    }
#endif
}

- (void)_appearBackgroundViewController {
    _backgroundViewController.glb_slideViewController = self;
    
    _backgroundViewController.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    _backgroundViewController.view.frame = _backgroundView.bounds;
    [_backgroundView addSubview:_backgroundViewController.view];
    [self addChildViewController:_backgroundViewController];
    [_backgroundViewController didMoveToParentViewController:self];
}

- (void)_disappearBackgroundViewController {
    _backgroundViewController.glb_slideViewController = nil;
    
    [_backgroundViewController viewWillDisappear:NO];
    [_backgroundViewController.view removeFromSuperview];
    [_backgroundViewController viewDidDisappear:NO];
}

- (void)_appearLeftViewController {
    _leftViewController.glb_slideViewController = self;
    
    _leftViewController.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    _leftViewController.view.frame = _leftView.bounds;
    [_leftView addSubview:_leftViewController.view];
    [self addChildViewController:_leftViewController];
    [_leftViewController didMoveToParentViewController:self];
}

- (void)_disappearLeftViewController {
    _leftViewController.glb_slideViewController = nil;
    
    [_leftViewController willMoveToParentViewController:nil];
    [_leftViewController.view removeFromSuperview];
    [_leftViewController removeFromParentViewController];
}

- (void)_appearRightViewController {
    _rightViewController.glb_slideViewController = self;
    
    _rightViewController.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    _rightViewController.view.frame = _rightView.bounds;
    [_rightView addSubview:_rightViewController.view];
    [self addChildViewController:_rightViewController];
    [_rightViewController didMoveToParentViewController:self];
}

- (void)_disappearRightViewController {
    _rightViewController.glb_slideViewController = nil;
    
    [_rightViewController willMoveToParentViewController:nil];
    [_rightViewController.view removeFromSuperview];
    [_rightViewController removeFromParentViewController];
}

- (void)_appearCenterViewController {
    _centerViewController.glb_slideViewController = self;
    
    _centerViewController.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    _centerViewController.view.frame = _centerView.bounds;
    [_centerView addSubview:_centerViewController.view];
    [self addChildViewController:_centerViewController];
    [_centerViewController didMoveToParentViewController:self];
}

- (void)_disappearCenterViewController {
    _centerViewController.glb_slideViewController = nil;
    
    [_centerViewController willMoveToParentViewController:nil];
    [_centerViewController.view removeFromSuperview];
    [_centerViewController removeFromParentViewController];
}

- (void)_updateSwipeProgress:(CGFloat)swipeProgress speed:(CGFloat)speed endedSwipe:(BOOL)endedSwipe {
    CGFloat minSwipeProgress = (_swipeDirection == GLBSlideViewControllerSwipeCellDirectionLeft) ? -1.0f : 0.0f;
    CGFloat maxSwipeProgress = (_swipeDirection == GLBSlideViewControllerSwipeCellDirectionRight) ? 1.0f :0.0f;
    CGFloat normalizedSwipeProgress = MIN(MAX(minSwipeProgress, swipeProgress), maxSwipeProgress);
    if(_swipeProgress != normalizedSwipeProgress) {
        _swipeProgress = normalizedSwipeProgress;
        
        CGRect bounds = self.view.bounds;
        CGFloat duration = ABS(speed) / _swipeVelocity;
        UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState;
        if((_swipeUseSpring == YES) && (endedSwipe == YES)) {
            [UIView animateWithDuration:duration delay:0.0f usingSpringWithDamping:_swipeDamping initialSpringVelocity:0.0f options:options | UIViewAnimationOptionCurveLinear animations:^{
                _leftView.frame = [self _leftViewFrameFromBounds:bounds byPercent:_swipeProgress];
                _leftView.alpha = [self _leftViewAlphaByPercent:_swipeProgress];
                _centerView.frame = [self _centerViewFrameFromBounds:bounds byPercent:_swipeProgress];
                _centerView.alpha = [self _centerViewAlphaByPercent:_swipeProgress];
                _rightView.frame = [self _rightViewFrameFromBounds:bounds byPercent:_swipeProgress];
                _rightView.alpha = [self _rightViewAlphaByPercent:_swipeProgress];
                if(_draggingStatusBar == YES) {
                    [self _updateStatusBarFrame];
                }
            } completion:^(BOOL finished) {
                [self _didEndedSwipe];
            }];
        } else {
            if(endedSwipe == YES) {
                options |= UIViewAnimationOptionCurveEaseOut;
            }
            [UIView animateWithDuration:duration delay:0.0f options:options animations:^{
                _leftView.frame = [self _leftViewFrameFromBounds:bounds byPercent:_swipeProgress];
                _leftView.alpha = [self _leftViewAlphaByPercent:_swipeProgress];
                _centerView.frame = [self _centerViewFrameFromBounds:bounds byPercent:_swipeProgress];
                _centerView.alpha = [self _centerViewAlphaByPercent:_swipeProgress];
                _rightView.frame = [self _rightViewFrameFromBounds:bounds byPercent:_swipeProgress];
                _rightView.alpha = [self _rightViewAlphaByPercent:_swipeProgress];
                if(_draggingStatusBar == YES) {
                    [self _updateStatusBarFrame];
                }
            } completion:^(BOOL finished) {
                if(endedSwipe == YES) {
                    [self _didEndedSwipe];
                }
            }];
        }
    } else {
        if(endedSwipe == YES) {
            [self _didEndedSwipe];
        }
    }
}

- (void)_willBeganSwipe {
}

- (void)_didBeganSwipe {
    _swipeDragging = YES;
    if((_canUseScreenshot == YES) && (_showedLeftViewController == NO) && (_showedRightViewController == NO)) {
        [self _takeScreenshotView];
    }
    id< GLBSlideViewControllerDelegate > centerViewController = ([_centerViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_centerViewController : nil;
    if(_swipeDirection == GLBSlideViewControllerSwipeCellDirectionLeft) {
        if([centerViewController respondsToSelector:@selector(willBeganLeftSwipeInSlideViewController:)] == YES) {
            [centerViewController willBeganLeftSwipeInSlideViewController:self];
        }
        if([centerViewController respondsToSelector:@selector(didBeganLeftSwipeInSlideViewController:)] == YES) {
            [centerViewController didBeganLeftSwipeInSlideViewController:self];
        }
        _leftView.hidden = NO;
        _rightView.hidden = YES;
        id< GLBSlideViewControllerDelegate > leftViewController = ([_leftViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_leftViewController : nil;
        if([leftViewController respondsToSelector:@selector(willBeganSwipeInSlideViewController:)] == YES) {
            [leftViewController willBeganSwipeInSlideViewController:self];
        }
        if([leftViewController respondsToSelector:@selector(didBeganSwipeInSlideViewController:)] == YES) {
            [leftViewController didBeganSwipeInSlideViewController:self];
        }
    } else if(_swipeDirection == GLBSlideViewControllerSwipeCellDirectionRight) {
        if([centerViewController respondsToSelector:@selector(willBeganRightSwipeInSlideViewController:)] == YES) {
            [centerViewController willBeganRightSwipeInSlideViewController:self];
        }
        if([centerViewController respondsToSelector:@selector(didBeganRightSwipeInSlideViewController:)] == YES) {
            [centerViewController didBeganRightSwipeInSlideViewController:self];
        }
        _leftView.hidden = YES;
        _rightView.hidden = NO;
        id< GLBSlideViewControllerDelegate > rightViewController = ([_rightViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_rightViewController : nil;
        if([rightViewController respondsToSelector:@selector(willBeganSwipeInSlideViewController:)] == YES) {
            [rightViewController willBeganSwipeInSlideViewController:self];
        }
        if([rightViewController respondsToSelector:@selector(didBeganSwipeInSlideViewController:)] == YES) {
            [rightViewController didBeganSwipeInSlideViewController:self];
        }
    }
}

- (void)_movingSwipe:(CGFloat)progress {
    id< GLBSlideViewControllerDelegate > centerViewController = ([_centerViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_centerViewController : nil;
    if(_swipeDirection == GLBSlideViewControllerSwipeCellDirectionLeft) {
        if([centerViewController respondsToSelector:@selector(movingLeftSwipeInSlideViewController:progress:)] == YES) {
            [centerViewController movingLeftSwipeInSlideViewController:self progress:progress];
        }
        id< GLBSlideViewControllerDelegate > leftViewController = ([_leftViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_leftViewController : nil;
        if([leftViewController respondsToSelector:@selector(movingSwipeInSlideViewController:progress:)] == YES) {
            [leftViewController movingSwipeInSlideViewController:self progress:progress];
        }
    } else if(_swipeDirection == GLBSlideViewControllerSwipeCellDirectionRight) {
        if([centerViewController respondsToSelector:@selector(movingRightSwipeInSlideViewController:progress:)] == YES) {
            [centerViewController movingRightSwipeInSlideViewController:self progress:progress];
        }
        id< GLBSlideViewControllerDelegate > rightViewController = ([_rightViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_rightViewController : nil;
        if([rightViewController respondsToSelector:@selector(movingSwipeInSlideViewController:progress:)] == YES) {
            [rightViewController movingSwipeInSlideViewController:self progress:progress];
        }
    }
}

- (void)_willEndedSwipe {
    _swipeDragging = NO;
    _swipeDecelerating = YES;
    id< GLBSlideViewControllerDelegate > centerViewController = ([_centerViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_centerViewController : nil;
    if(_swipeDirection == GLBSlideViewControllerSwipeCellDirectionLeft) {
        if([centerViewController respondsToSelector:@selector(willEndedLeftSwipeInSlideViewController:)] == YES) {
            [centerViewController willEndedLeftSwipeInSlideViewController:self];
        }
        id< GLBSlideViewControllerDelegate > leftViewController = ([_leftViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_leftViewController : nil;
        if([leftViewController respondsToSelector:@selector(willEndedSwipeInSlideViewController:)] == YES) {
            [leftViewController willEndedSwipeInSlideViewController:self];
        }
    } else if(_swipeDirection == GLBSlideViewControllerSwipeCellDirectionRight) {
        if([centerViewController respondsToSelector:@selector(willEndedRightSwipeInSlideViewController:)] == YES) {
            [centerViewController willEndedRightSwipeInSlideViewController:self];
        }
        id< GLBSlideViewControllerDelegate > rightViewController = ([_rightViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_rightViewController : nil;
        if([rightViewController respondsToSelector:@selector(willEndedSwipeInSlideViewController:)] == YES) {
            [rightViewController willEndedSwipeInSlideViewController:self];
        }
    }
}

- (void)_didEndedSwipe {
    _showedLeftViewController = (_swipeProgress < 0.0f) ? YES : NO;
    _showedRightViewController = (_swipeProgress > 0.0f) ? YES : NO;
    _leftView.hidden = (_showedLeftViewController == NO);
    _rightView.hidden = (_showedRightViewController == NO);
    [self _updateIteraction];
    _swipeDecelerating = NO;
    if((_showedLeftViewController == NO) && (_showedRightViewController == NO)) {
        self.screenshotView = nil;
    }
    id< GLBSlideViewControllerDelegate > centerViewController = ([_centerViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_centerViewController : nil;
    if(_swipeDirection == GLBSlideViewControllerSwipeCellDirectionLeft) {
        if([centerViewController respondsToSelector:@selector(didEndedLeftSwipeInSlideViewController:)] == YES) {
            [centerViewController didEndedLeftSwipeInSlideViewController:self];
        }
        id< GLBSlideViewControllerDelegate > leftViewController = ([_leftViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_leftViewController : nil;
        if([leftViewController respondsToSelector:@selector(didEndedSwipeInSlideViewController:)] == YES) {
            [leftViewController didEndedSwipeInSlideViewController:self];
        }
    } else if(_swipeDirection == GLBSlideViewControllerSwipeCellDirectionRight) {
        if([centerViewController respondsToSelector:@selector(didEndedRightSwipeInSlideViewController:)] == YES) {
            [centerViewController didEndedRightSwipeInSlideViewController:self];
        }
        id< GLBSlideViewControllerDelegate > rightViewController = ([_rightViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_rightViewController : nil;
        if([rightViewController respondsToSelector:@selector(didEndedSwipeInSlideViewController:)] == YES) {
            [rightViewController didEndedSwipeInSlideViewController:self];
        }
    }
}

- (void)_tapGestureHandle {
    if(_showedLeftViewController == YES) {
        [self hideLeftViewControllerAnimated:YES complete:nil];
    } else if(_showedRightViewController == YES) {
        [self hideRightViewControllerAnimated:YES complete:nil];
    }
}

- (void)_leftEdgeGestureHandle {
    _swipeDirection = GLBSlideViewControllerSwipeCellDirectionLeft;
    [self _edgeGestureHandle:_leftEdgeGesture];
}

- (void)_rightEdgeGestureHandle {
    _swipeDirection = GLBSlideViewControllerSwipeCellDirectionRight;
    [self _edgeGestureHandle:_rightEdgeGesture];
}

- (void)_panGestureHandle {
    if(_showedLeftViewController == YES) {
        _swipeDirection = GLBSlideViewControllerSwipeCellDirectionLeft;
    } else if(_showedRightViewController == YES) {
        _swipeDirection = GLBSlideViewControllerSwipeCellDirectionRight;
    }
    [self _edgeGestureHandle:_panGesture];
}

- (void)_edgeGestureHandle:(UIPanGestureRecognizer*)gesture {
    if(_swipeDecelerating == NO) {
        CGPoint translation = [gesture translationInView:self.view];
        CGPoint velocity = [gesture velocityInView:self.view];
        switch(gesture.state) {
            case UIGestureRecognizerStateBegan: {
                [self _willBeganSwipe];
                _swipeLastOffset = translation.x;
                _swipeLastVelocity = velocity.x;
                _swipeLeftWidth = -_leftViewControllerWidth;
                _swipeRightWidth = _rightViewControllerWidth;
                [self _didBeganSwipe];
                break;
            }
            case UIGestureRecognizerStateChanged: {
                CGFloat delta = _swipeLastOffset - translation.x;
                switch(_swipeDirection) {
                    case GLBSlideViewControllerSwipeCellDirectionUnknown: {
                        break;
                    }
                    case GLBSlideViewControllerSwipeCellDirectionLeft: {
                        CGFloat localDelta = MIN(MAX(_swipeLeftWidth, delta), -_swipeLeftWidth);
                        [self _updateSwipeProgress:_swipeProgress - (localDelta / _swipeLeftWidth) speed:localDelta endedSwipe:NO];
                        [self _movingSwipe:_swipeProgress];
                        break;
                    }
                    case GLBSlideViewControllerSwipeCellDirectionRight: {
                        CGFloat localDelta = MIN(MAX(-_swipeRightWidth, delta), _swipeRightWidth);
                        [self _updateSwipeProgress:_swipeProgress + (localDelta / _swipeRightWidth) speed:localDelta endedSwipe:NO];
                        [self _movingSwipe:_swipeProgress];
                        break;
                    }
                }
                _swipeLastOffset = translation.x;
                _swipeLastVelocity = velocity.x;
                break;
            }
            default: {
                [self _willEndedSwipe];
                CGFloat swipeProgress = roundf(_swipeProgress - (_swipeLastVelocity / _swipeVelocity));
                CGFloat minSwipeProgress = (_swipeDirection == GLBSlideViewControllerSwipeCellDirectionLeft) ? -1.0f : 0.0f;
                CGFloat maxSwipeProgress = (_swipeDirection == GLBSlideViewControllerSwipeCellDirectionRight) ? 1.0f :0.0f;
                CGFloat needSwipeProgress = MIN(MAX(minSwipeProgress, swipeProgress), maxSwipeProgress);
                switch(_swipeDirection) {
                    case GLBSlideViewControllerSwipeCellDirectionLeft: {
                        [self _updateSwipeProgress:needSwipeProgress speed:_swipeLeftWidth * ABS(needSwipeProgress - _swipeProgress) endedSwipe:YES];
                        break;
                    }
                    case GLBSlideViewControllerSwipeCellDirectionRight: {
                        [self _updateSwipeProgress:needSwipeProgress speed:_swipeRightWidth * ABS(needSwipeProgress - _swipeProgress) endedSwipe:YES];
                        break;
                    }
                    default: {
                        [self _didEndedSwipe];
                        break;
                    }
                }
                break;
            }
        }
    }
}

- (void)_notificationDidBecomeActive:(NSNotification*)notification {
}

- (void)_notificationWillResignActive:(NSNotification*)notification {
    if(_draggingStatusBar == YES) {
        [self hideLeftViewControllerAnimated:YES complete:nil];
        [self hideRightViewControllerAnimated:YES complete:nil];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    if(gestureRecognizer == _tapGesture) {
        CGPoint location = [_tapGesture locationInView:self.view];
        if(_showedLeftViewController == YES) {
            if(_leftViewControllerIteractionHideEnabled == YES) {
                if((CGRectContainsPoint(_centerView.frame, location) == YES) && (CGRectContainsPoint(_leftView.frame, location) == NO)) {
                    return YES;
                }
            }
        } else if(_showedRightViewController == YES) {
            if(_rightViewControllerIteractionHideEnabled == YES) {
                if((CGRectContainsPoint(_centerView.frame, location) == YES) && (CGRectContainsPoint(_rightView.frame, location) == NO)) {
                    return YES;
                }
            }
        }
    } else if(gestureRecognizer == _leftEdgeGesture) {
        if((_swipeDragging == NO) && (_swipeDecelerating == NO)) {
            BOOL allowPan = NO;
            if((_leftViewController != nil) && (_showedLeftViewController == NO) && (_leftViewControllerIteractionShowEnabled == YES)) {
                id< GLBSlideViewControllerDelegate > centerViewController = ([_centerViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_centerViewController : nil;
                if([centerViewController respondsToSelector:@selector(canShowLeftViewControllerInSlideViewController:)] == YES) {
                    if([centerViewController canShowLeftViewControllerInSlideViewController:self] == YES) {
                        id< GLBSlideViewControllerDelegate > leftViewController = ([_leftViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_leftViewController : nil;
                        if([leftViewController respondsToSelector:@selector(canShowControllerInSlideViewController:)] == YES) {
                            allowPan = [leftViewController canShowControllerInSlideViewController:self];
                        } else {
                            allowPan = YES;
                        }
                    } else {
                        allowPan = NO;
                    }
                } else {
                    allowPan = YES;
                }
            }
            return allowPan;
        }
    } else if(gestureRecognizer == _rightEdgeGesture) {
        if((_swipeDragging == NO) && (_swipeDecelerating == NO)) {
            BOOL allowPan = NO;
            if((_rightViewController != nil) && (_showedRightViewController == NO) && (_rightViewControllerIteractionShowEnabled == YES)) {
                id< GLBSlideViewControllerDelegate > centerViewController = ([_centerViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_centerViewController : nil;
                if([centerViewController respondsToSelector:@selector(canShowRightViewControllerInSlideViewController:)] == YES) {
                    if([centerViewController canShowRightViewControllerInSlideViewController:self] == YES) {
                        id< GLBSlideViewControllerDelegate > rightViewController = ([_rightViewController conformsToProtocol:@protocol(GLBSlideViewControllerDelegate)] == YES) ? (id< GLBSlideViewControllerDelegate >)_rightViewController : nil;
                        if([rightViewController respondsToSelector:@selector(canShowControllerInSlideViewController:)] == YES) {
                            allowPan = [rightViewController canShowControllerInSlideViewController:self];
                        } else {
                            allowPan = YES;
                        }
                    } else {
                        allowPan = NO;
                    }
                } else {
                    allowPan = YES;
                }
            }
            return allowPan;
        }
    } else if(gestureRecognizer == _panGesture) {
        CGPoint location = [_panGesture locationInView:self.view];
        if(_showedLeftViewController == YES) {
            if(_leftViewControllerIteractionHideEnabled == YES) {
                return YES;
            }
        } else if(_showedRightViewController == YES) {
            if(_rightViewControllerIteractionHideEnabled == YES) {
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer*)otherGestureRecognizer {
    if((gestureRecognizer == _leftEdgeGesture) || (gestureRecognizer == _rightEdgeGesture)) {
        if([otherGestureRecognizer.view isDescendantOfView:_centerView] == YES) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - GLBViewController

- (UIViewController*)currentViewController {
    if((_showedLeftViewController == YES) && (_leftViewController != nil)) {
        return _leftViewController.glb_currentViewController;
    } else if((_showedRightViewController == YES) && (_leftViewController != nil)) {
        return _rightViewController.glb_currentViewController;
    } else if(_centerViewController != nil) {
        return _centerViewController.glb_currentViewController;
    }
    return self;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

#import <objc/runtime.h>

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation UIViewController (GLBSlideViewController)

- (void)setGlb_slideViewController:(GLBSlideViewController*)slideViewController {
    objc_setAssociatedObject(self, @selector(glb_slideViewController), slideViewController, OBJC_ASSOCIATION_ASSIGN);
}

- (GLBSlideViewController*)glb_slideViewController {
    GLBSlideViewController* controller = objc_getAssociatedObject(self, @selector(glb_slideViewController));
    if(controller == nil) {
        controller = self.parentViewController.glb_slideViewController;
    }
    return controller;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
