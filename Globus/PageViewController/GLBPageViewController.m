/*--------------------------------------------------*/

#import "GLBPageViewController.h"
#import "GLBSlideViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import "UIScrollView+GLBUI.h"

/*--------------------------------------------------*/

#define ANIMATION_DURATION                          0.2f

/*--------------------------------------------------*/

@interface GLBPageViewController () < UIGestureRecognizerDelegate, GLBSlideViewControllerDelegate > {
    BOOL _animating;
    BOOL _allowBeforeViewController;
    BOOL _allowAfterViewController;
    UIView* _rootView;
    UIEdgeInsets _beforeDecorInsets;
    CGSize _beforeDecorSize;
    struct {
        unsigned int applyFromProgress:1;
    } _canBeforeDecor;
    UIEdgeInsets _afterDecorInsets;
    CGSize _afterDecorSize;
    struct {
        unsigned int applyFromProgress:1;
    } _canAfterDecor;
    UIPanGestureRecognizer* _panGesture;
    NSMutableArray* _friendlyGestures;
    CGPoint _panBeganPosition;
}

@property(nonatomic, weak) UIView< GLBPageDecorDelegate >* beforeDecorView;
@property(nonatomic, weak) UIViewController< GLBPageViewControllerDelegate >* beforeViewController;
@property(nonatomic, weak) UIView< GLBPageDecorDelegate >* afterDecorView;
@property(nonatomic, weak) UIViewController< GLBPageViewControllerDelegate >* afterViewController;

- (void)_loadBeforeAfterData;

- (CGRect)_beforeFrame;
- (CGRect)_beforeFrameFromFrame:(CGRect)currentFrame;
- (CGRect)_currentFrame;
- (CGRect)_afterFrame;
- (CGRect)_afterFrameFromFrame:(CGRect)currentFrame;

- (CGRect)_beforeDecorFrame;
- (CGRect)_beforeDecorFrameFromFrame:(CGRect)currentFrame;
- (CGFloat)_beforeDecorProgressFromFrame:(CGRect)currentFrame;

- (CGRect)_afterDecorFrame;
- (CGRect)_afterDecorFrameFromFrame:(CGRect)currentFrame;
- (CGFloat)_afterDecorProgressFromFrame:(CGRect)currentFrame;

- (void)_animateToDirection:(GLBPageViewControllerDirection)direction duration:(NSTimeInterval)duration animated:(BOOL)animated notification:(BOOL)notification;

- (void)_panGestureHandle:(UIPanGestureRecognizer*)panGesture;

@end

/*--------------------------------------------------*/

@implementation GLBPageViewController

- (void)setup {
    [super setup];
    
    _userInteractionEnabled = YES;
    _draggingRate = 0.5f;
    _bounceRate = 0.5f;
    _thresholdHorizontal = 50.0f;
    _thresholdVertical = 100.0f;
    
    _friendlyGestures = [NSMutableArray array];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.view.clipsToBounds = YES;
    
    _rootView = [[UIView alloc] initWithFrame:self.view.bounds];
    _rootView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _rootView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_rootView];

    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_panGestureHandle:)];
    [_panGesture setDelegate:self];
    [_rootView addGestureRecognizer:_panGesture];
    
    if(_viewController != nil) {
        _viewController.glb_pageController = self;
        _viewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _viewController.view.frame = [self _currentFrame];
        [_rootView addSubview:_viewController.view];
        [self addChildViewController:_viewController];
        [_viewController didMoveToParentViewController:self];
        [self _loadBeforeAfterData];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _rootView.frame = self.view.bounds;
    if(_animating == NO) {
        _rootView.frame = self.view.bounds;
        if(_viewController != nil) {
            _viewController.view.frame = [self _currentFrame];
        }
        CGRect currentFrame = [self _currentFrame];
        if(_beforeDecorView != nil) {
            _beforeDecorView.frame = [self _beforeDecorFrameFromFrame:currentFrame];
            if(_canBeforeDecor.applyFromProgress == YES) {
                [_beforeDecorView pageController:self applyFromProgress:[self _beforeDecorProgressFromFrame:currentFrame]];
            }
        }
        if(_beforeViewController != nil) {
            _beforeViewController.view.frame = [self _beforeFrameFromFrame:currentFrame];
        }
        if(_afterDecorView != nil) {
            _afterDecorView.frame = [self _afterDecorFrameFromFrame:currentFrame];
            if(_canAfterDecor.applyFromProgress == YES) {
                [_afterDecorView pageController:self applyFromProgress:[self _afterDecorProgressFromFrame:currentFrame]];
            }
        }
        if(_afterViewController != nil) {
            _afterViewController.view.frame = [self _afterFrameFromFrame:currentFrame];
        }
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self.view setNeedsLayout];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    [self.view setNeedsLayout];
}

#pragma mark - Property

- (void)setViewController:(UIViewController< GLBPageViewControllerDelegate >*)viewController {
    if(_viewController != viewController) {
        if(self.isViewLoaded == YES) {
            if((_viewController != nil) && (_viewController.parentViewController != self)) {
                [_viewController willMoveToParentViewController:nil];
                [_viewController.view removeFromSuperview];
                [_viewController removeFromParentViewController];
            }
            _viewController = viewController;
            if(_viewController != nil) {
                _viewController.glb_pageController = self;
                if(_viewController.parentViewController != self) {
                    _viewController.view.autoresizingMask = (UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin);
                    _viewController.view.frame = [self _currentFrame];
                    [_rootView addSubview:_viewController.view];
                    [self addChildViewController:_viewController];
                    [_viewController didMoveToParentViewController:self];
                } else {
                    _viewController.view.frame = [self _currentFrame];
                }
            }
            [self _loadBeforeAfterData];
        } else {
            _viewController = viewController;
        }
    }
}

- (void)setBeforeDecorView:(UIView< GLBPageDecorDelegate >*)beforeDecorView {
    if(_beforeDecorView != beforeDecorView) {
        if(_beforeDecorView != nil) {
            [_beforeDecorView removeFromSuperview];
        }
        _beforeDecorView = beforeDecorView;
        _canBeforeDecor.applyFromProgress = [_beforeDecorView respondsToSelector:@selector(pageController:applyFromProgress:)];
        if(_beforeDecorView != nil) {
            CGRect currentFrame = [self _currentFrame];
            _beforeDecorView.frame = [self _beforeDecorFrameFromFrame:currentFrame];
            if(_canBeforeDecor.applyFromProgress == YES) {
                [_beforeDecorView pageController:self applyFromProgress:[self _beforeDecorProgressFromFrame:currentFrame]];
            }
            [_rootView addSubview:_beforeDecorView];
            [_rootView sendSubviewToBack:_beforeDecorView];
        }
    }
}

- (void)setBeforeViewController:(UIViewController< GLBPageViewControllerDelegate >*)beforeViewController {
    if(_beforeViewController != beforeViewController) {
        if((_beforeViewController != nil) && (_beforeViewController.parentViewController != self)) {
            [_beforeViewController willMoveToParentViewController:nil];
            [_beforeViewController.view removeFromSuperview];
            [_beforeViewController removeFromParentViewController];
        }
        _beforeViewController = beforeViewController;
        if(_beforeViewController != nil) {
            _beforeViewController.glb_pageController = self;
            if(_beforeViewController.parentViewController != self) {
                _beforeViewController.view.autoresizingMask = (UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin);
                _beforeViewController.view.frame = [self _beforeFrame];
                [_rootView addSubview:_beforeViewController.view];
                [self addChildViewController:_beforeViewController];
                [_beforeViewController didMoveToParentViewController:self];
            } else {
                _beforeViewController.view.frame = [self _beforeFrame];
            }
        }
    }
}

- (void)setAfterDecorView:(UIView< GLBPageDecorDelegate >*)afterDecorView {
    if(_afterDecorView != afterDecorView) {
        if(_afterDecorView != nil) {
            [_afterDecorView removeFromSuperview];
        }
        _afterDecorView = afterDecorView;
        _canAfterDecor.applyFromProgress = [_afterDecorView respondsToSelector:@selector(pageController:applyFromProgress:)];
        if(_afterDecorView != nil) {
            CGRect currentFrame = [self _currentFrame];
            _afterDecorView.frame = [self _afterDecorFrameFromFrame:currentFrame];
            if(_canAfterDecor.applyFromProgress == YES) {
                [_afterDecorView pageController:self applyFromProgress:[self _afterDecorProgressFromFrame:currentFrame]];
            }
            [_rootView addSubview:_afterDecorView];
            [_rootView sendSubviewToBack:_afterDecorView];
        }
    }
}

- (void)setAfterViewController:(UIViewController< GLBPageViewControllerDelegate >*)afterViewController {
    if(_afterViewController != afterViewController) {
        if((_afterViewController != nil) && (_afterViewController.parentViewController != self)) {
            [_afterViewController willMoveToParentViewController:nil];
            [_afterViewController.view removeFromSuperview];
            [_afterViewController removeFromParentViewController];
        }
        _afterViewController = afterViewController;
        if(_afterViewController != nil) {
            _afterViewController.glb_pageController = self;
            if(_afterViewController.parentViewController != self) {
                _afterViewController.view.autoresizingMask = (UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin);
                _afterViewController.view.frame = [self _afterFrame];
                [_rootView addSubview:_afterViewController.view];
                [self addChildViewController:_afterViewController];
                [_afterViewController didMoveToParentViewController:self];
            } else {
                _afterViewController.view.frame = [self _afterFrame];
            }
        }
    }
}

#pragma mark - Public

- (void)setViewController:(UIViewController< GLBPageViewControllerDelegate >*)viewController direction:(GLBPageViewControllerDirection)direction animated:(BOOL)animated {
    switch(direction) {
        case GLBPageViewControllerDirectionReverse:
            self.beforeViewController = viewController;
            break;
        case GLBPageViewControllerDirectionForward:
            self.afterViewController = viewController;
            break;
    }
    [self _animateToDirection:direction duration:ANIMATION_DURATION animated:animated notification:NO];
}

- (void)setViewController:(UIViewController< GLBPageViewControllerDelegate >*)viewController direction:(GLBPageViewControllerDirection)direction duration:(NSTimeInterval)duration animated:(BOOL)animated {
    switch(direction) {
        case GLBPageViewControllerDirectionReverse:
            self.beforeViewController = viewController;
            break;
        case GLBPageViewControllerDirectionForward:
            self.afterViewController = viewController;
            break;
    }
    [self _animateToDirection:direction duration:duration animated:animated notification:NO];
}

#pragma mark - Private

- (void)_loadBeforeAfterData {
    _allowBeforeViewController = [_viewController allowBeforeViewControllerInPageViewController:self];
    if(_allowBeforeViewController == YES) {
        if(([_viewController respondsToSelector:@selector(beforeDecorSizeInPageViewController:)] == YES) && ([_viewController respondsToSelector:@selector(beforeDecorViewInPageViewController:)] == YES)) {
            if([_viewController respondsToSelector:@selector(beforeDecorInsetsInPageViewController:)] == YES) {
                _beforeDecorInsets = [_viewController beforeDecorInsetsInPageViewController:self];
            }
            _beforeDecorSize = [_viewController beforeDecorSizeInPageViewController:self];
            self.beforeDecorView = [_viewController beforeDecorViewInPageViewController:self];
        }
        if(_beforeDecorView == nil) {
            self.beforeViewController = [_viewController beforeViewControllerInPageViewController:self];
        } else {
            self.beforeViewController = nil;
        }
    } else {
        self.beforeViewController = nil;
    }
    _allowAfterViewController = [_viewController allowAfterViewControllerInPageViewController:self];
    if(_allowAfterViewController == YES) {
        if(([_viewController respondsToSelector:@selector(afterDecorSizeInPageViewController:)] == YES) && ([_viewController respondsToSelector:@selector(afterDecorViewInPageViewController:)] == YES)) {
            if([_viewController respondsToSelector:@selector(afterDecorInsetsInPageViewController:)] == YES) {
                _afterDecorInsets = [_viewController afterDecorInsetsInPageViewController:self];
            }
            _afterDecorSize = [_viewController afterDecorSizeInPageViewController:self];
            self.afterDecorView = [_viewController afterDecorViewInPageViewController:self];
        }
        if(_afterDecorView == nil) {
            self.afterViewController = [_viewController afterViewControllerInPageViewController:self];
        } else {
            self.afterViewController = nil;
        }
    } else {
        self.afterViewController = nil;
    }
    [self _cleanupChildsViewController];
}

- (void)_cleanupChildsViewController {
    NSMutableArray< UIViewController* >* unusedViewControllers = [NSMutableArray array];
    NSArray< UIViewController* >* viewControllers = self.childViewControllers;
    for(UIViewController* viewController in viewControllers) {
        if((viewController != _viewController) && (viewController != _beforeViewController) && (viewController != _afterViewController)) {
            [unusedViewControllers addObject:viewController];
        }
    }
    for(UIViewController* viewController in unusedViewControllers) {
        [viewController willMoveToParentViewController:nil];
        [viewController.view removeFromSuperview];
        [viewController removeFromParentViewController];
    }
}

- (CGRect)_beforeFrame {
    CGRect currentFrame = [self _currentFrame];
    switch(_orientation) {
        case GLBPageViewControllerOrientationVertical:
            return CGRectMake(currentFrame.origin.x, currentFrame.origin.y - currentFrame.size.height, currentFrame.size.width, currentFrame.size.height);
        case GLBPageViewControllerOrientationHorizontal:
            return CGRectMake(currentFrame.origin.x - currentFrame.size.width, currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height);
    }
}

- (CGRect)_beforeFrameFromFrame:(CGRect)currentFrame {
    CGRect result = [self _beforeFrame];
    switch(_orientation) {
        case GLBPageViewControllerOrientationVertical: {
            result.origin.y = currentFrame.origin.y - result.size.height;
            break;
        }
        case GLBPageViewControllerOrientationHorizontal: {
            result.origin.x = currentFrame.origin.x - result.size.width;
            break;
        }
    }
    return result;
}

- (CGRect)_currentFrame {
    return _rootView.bounds;
}

- (CGRect)_afterFrame {
    CGRect currentFrame = [self _currentFrame];
    switch(_orientation) {
        case GLBPageViewControllerOrientationVertical:
            return CGRectMake(currentFrame.origin.x, currentFrame.origin.y + currentFrame.size.height, currentFrame.size.width, currentFrame.size.height);
        case GLBPageViewControllerOrientationHorizontal:
            return CGRectMake(currentFrame.origin.x + currentFrame.size.width, currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height);
    }
}

- (CGRect)_afterFrameFromFrame:(CGRect)currentFrame {
    CGRect result = [self _afterFrame];
    switch(_orientation) {
        case GLBPageViewControllerOrientationVertical: {
            result.origin.y = currentFrame.origin.y + currentFrame.size.height;
            break;
        }
        case GLBPageViewControllerOrientationHorizontal: {
            result.origin.x = currentFrame.origin.x + currentFrame.size.width;
            break;
        }
    }
    return result;
}

- (CGRect)_beforeDecorFrame {
    CGRect result = CGRectZero;
    CGRect beforeFrame = [self _beforeFrame];
    switch(_orientation) {
        case GLBPageViewControllerOrientationVertical:
            result.origin.x = CGRectGetMidX(beforeFrame) - (_beforeDecorSize.width * 0.5f);
            result.origin.y = CGRectGetMaxY(beforeFrame) - _beforeDecorSize.height;
            result.size.width = _beforeDecorSize.width;
            result.size.height = _beforeDecorSize.height;
            break;
        case GLBPageViewControllerOrientationHorizontal:
            result.origin.x = CGRectGetMaxX(beforeFrame) - _beforeDecorSize.width;
            result.origin.y = CGRectGetMidY(beforeFrame) - (_beforeDecorSize.height * 0.5f);
            result.size.width = _beforeDecorSize.width;
            result.size.height = _beforeDecorSize.height;
            break;
    }
    result = UIEdgeInsetsInsetRect(result, _beforeDecorInsets);
    result.size.width = MAX(0.0f, result.size.width);
    result.size.height = MAX(0.0f, result.size.height);
    return result;
}

- (CGRect)_beforeDecorFrameFromFrame:(CGRect)currentFrame {
    CGRect result = CGRectZero;
    CGRect beforeFrame = [self _beforeFrame];
    switch(_orientation) {
        case GLBPageViewControllerOrientationVertical: {
            CGFloat delta = CGRectGetMinY(currentFrame) - CGRectGetMaxY(beforeFrame);
            result.origin.x = CGRectGetMidX(beforeFrame) - (_beforeDecorSize.width * 0.5f);
            result.origin.y = (CGRectGetMaxY(beforeFrame) + (delta * 0.5f)) - (_beforeDecorSize.height * 0.5f);
            result.size.width = _beforeDecorSize.width;
            result.size.height = _beforeDecorSize.height;
            break;
        }
        case GLBPageViewControllerOrientationHorizontal: {
            CGFloat delta = CGRectGetMinX(currentFrame) - CGRectGetMaxX(beforeFrame);
            result.origin.x = (CGRectGetMaxX(beforeFrame) + (delta * 0.5f)) - (_beforeDecorSize.width * 0.5f);
            result.origin.y = CGRectGetMidY(beforeFrame) - (_beforeDecorSize.height * 0.5f);
            result.size.width = _beforeDecorSize.width;
            result.size.height = _beforeDecorSize.height;
            break;
        }
    }
    result = UIEdgeInsetsInsetRect(result, _beforeDecorInsets);
    result.size.width = MAX(0.0f, result.size.width);
    result.size.height = MAX(0.0f, result.size.height);
    return result;
}

- (CGFloat)_beforeDecorProgressFromFrame:(CGRect)currentFrame {
    CGFloat result = 0.0f;
    CGRect beforeFrame = [self _beforeFrame];
    switch(_orientation) {
        case GLBPageViewControllerOrientationVertical: {
            CGFloat delta = CGRectGetMinY(currentFrame) - CGRectGetMaxY(beforeFrame);
            result = MAX(0.0f, ABS(delta) / _beforeDecorSize.height);
            break;
        }
        case GLBPageViewControllerOrientationHorizontal: {
            CGFloat delta = CGRectGetMinX(currentFrame) - CGRectGetMaxX(beforeFrame);
            result = MAX(0.0f, ABS(delta) / _beforeDecorSize.width);
            break;
        }
    }
    return result;
}

- (CGRect)_afterDecorFrame {
    CGRect result = CGRectZero;
    CGRect _afterFrame = [self _afterFrame];
    switch(_orientation) {
        case GLBPageViewControllerOrientationVertical:
            result.origin.x = CGRectGetMidX(_afterFrame) - (_afterDecorSize.width * 0.5f);
            result.origin.y = CGRectGetMinY(_afterFrame);
            result.size.width = _beforeDecorSize.width;
            result.size.height = _beforeDecorSize.height;
            break;
        case GLBPageViewControllerOrientationHorizontal:
            result.origin.x = CGRectGetMinX(_afterFrame);
            result.origin.y = CGRectGetMidY(_afterFrame) - (_afterDecorSize.height * 0.5f);
            result.size.width = _afterDecorSize.width;
            result.size.height = _afterDecorSize.height;
            break;
    }
    result = UIEdgeInsetsInsetRect(result, _afterDecorInsets);
    result.size.width = MAX(0.0f, result.size.width);
    result.size.height = MAX(0.0f, result.size.height);
    return result;
}

- (CGRect)_afterDecorFrameFromFrame:(CGRect)currentFrame {
    CGRect result = CGRectZero;
    CGRect _afterFrame = [self _afterFrame];
    switch(_orientation) {
        case GLBPageViewControllerOrientationVertical: {
            CGFloat delta = CGRectGetMinY(_afterFrame) - CGRectGetMaxY(currentFrame);
            result.origin.x = CGRectGetMidX(_afterFrame) - (_afterDecorSize.width * 0.5f);
            result.origin.y = (CGRectGetMinY(_afterFrame) - (delta * 0.5f)) - (_afterDecorSize.height * 0.5f);
            result.size.width = _afterDecorSize.width;
            result.size.height = _afterDecorSize.height;
            break;
        }
        case GLBPageViewControllerOrientationHorizontal: {
            CGFloat delta = CGRectGetMinX(_afterFrame) - CGRectGetMaxX(currentFrame);
            result.origin.x = CGRectGetMinX(_afterFrame) - (delta * 0.5f) - (_afterDecorSize.width * 0.5f);
            result.origin.y = CGRectGetMidY(_afterFrame) - (_afterDecorSize.height * 0.5f);
            result.size.width = _afterDecorSize.width;
            result.size.height = _afterDecorSize.height;
            break;
        }
    }
    result = UIEdgeInsetsInsetRect(result, _afterDecorInsets);
    result.size.width = MAX(0.0f, result.size.width);
    result.size.height = MAX(0.0f, result.size.height);
    return result;
}

- (CGFloat)_afterDecorProgressFromFrame:(CGRect)currentFrame {
    CGFloat result = 0.0f;
    CGRect _afterFrame = [self _afterFrame];
    switch(_orientation) {
        case GLBPageViewControllerOrientationVertical: {
            CGFloat delta = CGRectGetMinY(_afterFrame) - CGRectGetMaxY(currentFrame);
            result = MAX(0.0f, ABS(delta) / _afterDecorSize.height);
            break;
        }
        case GLBPageViewControllerOrientationHorizontal: {
            CGFloat delta = CGRectGetMinX(_afterFrame) - CGRectGetMaxX(currentFrame);
            result = MAX(0.0f, ABS(delta) / _afterDecorSize.width);
            break;
        }
    }
    return result;
}

- (void)_animateToDirection:(GLBPageViewControllerDirection)direction duration:(NSTimeInterval)duration animated:(BOOL)animated notification:(BOOL)notification {
    UIViewController< GLBPageViewControllerDelegate >* currentViewController = _viewController;
    UIViewController< GLBPageViewControllerDelegate >* animateViewController = nil;
    switch(direction) {
        case GLBPageViewControllerDirectionReverse:
            animateViewController = _beforeViewController;
            break;
        case GLBPageViewControllerDirectionForward:
            animateViewController = _afterViewController;
            break;
    }
    if(notification == YES) {
        if([currentViewController respondsToSelector:@selector(willDisappearInPageViewController:direction:)] == YES) {
            [currentViewController willDisappearInPageViewController:self direction:direction];
        }
        if([animateViewController respondsToSelector:@selector(willAppearInPageViewController:direction:)] == YES) {
            [animateViewController willAppearInPageViewController:self direction:direction];
        }
    }
    if((self.isViewLoaded == YES) && (animateViewController != nil) && (animated == YES)) {
        _animating = YES;
        _rootView.userInteractionEnabled = NO;
        [UIView animateWithDuration:duration
                         animations:^{
                             CGRect currentFrame = [self _currentFrame];
                             switch(direction) {
                                 case GLBPageViewControllerDirectionReverse:
                                     currentViewController.view.frame = [self _afterFrame];
                                     animateViewController.view.frame = currentFrame;
                                     if(_beforeDecorView != nil) {
                                         _beforeDecorView.frame = [self _beforeDecorFrameFromFrame:currentFrame];
                                         if(_canBeforeDecor.applyFromProgress == YES) {
                                             [_beforeDecorView pageController:self applyFromProgress:[self _beforeDecorProgressFromFrame:currentFrame]];
                                         }
                                     }
                                     break;
                                 case GLBPageViewControllerDirectionForward:
                                     currentViewController.view.frame = [self _beforeFrame];
                                     animateViewController.view.frame = [self _currentFrame];
                                     if(_afterDecorView != nil) {
                                         _afterDecorView.frame = [self _afterDecorFrameFromFrame:currentFrame];
                                         if(_canAfterDecor.applyFromProgress == YES) {
                                             [_afterDecorView pageController:self applyFromProgress:[self _afterDecorProgressFromFrame:currentFrame]];
                                         }
                                     }
                                     break;
                             }
                         } completion:^(BOOL finished) {
                             switch(direction) {
                                 case GLBPageViewControllerDirectionReverse:
                                     currentViewController.view.frame = [self _afterFrame];
                                     animateViewController.view.frame = [self _currentFrame];
                                     break;
                                 case GLBPageViewControllerDirectionForward:
                                     currentViewController.view.frame = [self _beforeFrame];
                                     animateViewController.view.frame = [self _currentFrame];
                                     break;
                             }
                             self.viewController = animateViewController;
                             _rootView.userInteractionEnabled = YES;
                             _animating = NO;
                             if(notification == YES) {
                                 if([animateViewController respondsToSelector:@selector(didAppearInPageViewController:direction:)] == YES) {
                                     [animateViewController didAppearInPageViewController:self direction:direction];
                                 }
                                 if([currentViewController respondsToSelector:@selector(didDisappearInPageViewController:direction:)] == YES) {
                                     [currentViewController didDisappearInPageViewController:self direction:direction];
                                 }
                             }
                         }];
    } else {
        self.viewController = animateViewController;
        if(notification == YES) {
            if([animateViewController respondsToSelector:@selector(didAppearInPageViewController:direction:)] == YES) {
                [animateViewController didAppearInPageViewController:self direction:direction];
            }
            if([currentViewController respondsToSelector:@selector(didDisappearInPageViewController:direction:)] == YES) {
                [currentViewController didDisappearInPageViewController:self direction:direction];
            }
        }
    }
}

- (void)_panGestureHandle:(UIPanGestureRecognizer*)panGesture {
    CGPoint currentPosition = [panGesture locationInView:_rootView];
	switch(panGesture.state) {
        case UIGestureRecognizerStateBegan: {
            _panBeganPosition = currentPosition;
			break;
        }
        case UIGestureRecognizerStateChanged: {
            CGPoint offset = CGPointZero;
            if(_userInteractionEnabled == YES) {
                switch(_orientation) {
                    case GLBPageViewControllerOrientationVertical:
                        offset.y = currentPosition.y - _panBeganPosition.y;
                        break;
                    case GLBPageViewControllerOrientationHorizontal:
                        offset.x = currentPosition.x - _panBeganPosition.x;
                        break;
                }
                if(_friendlyGestures.count > 0) {
                    for(UIGestureRecognizer* gesture in _friendlyGestures) {
                        if([gesture.view isKindOfClass:UIScrollView.class] == YES) {
                            UIScrollView* scrollView = (UIScrollView*)gesture.view;
                            if(scrollView.scrollEnabled == YES) {
                                UIEdgeInsets contentInsets = scrollView.contentInset;
                                CGPoint contentOffset = scrollView.contentOffset;
                                CGSize contentSize = scrollView.contentSize;
                                CGRect frame = scrollView.frame;
                                switch(_orientation) {
                                    case GLBPageViewControllerOrientationVertical: {
                                        if(((contentOffset.y + contentInsets.top) <= offset.y) && (offset.y > 0.0f)) {
                                            scrollView.glb_contentOffsetY = -contentInsets.top;
                                            scrollView.scrollEnabled = NO;
                                        } else if(((contentOffset.y + frame.size.height) >= contentSize.height + offset.y) && (offset.y < 0.0f)) {
                                            scrollView.glb_contentOffsetY = (contentSize.height - frame.size.height) + contentInsets.bottom;
                                            scrollView.scrollEnabled = NO;
                                        } else {
                                            _panBeganPosition.y = currentPosition.y;
                                        }
                                        break;
                                    }
                                    case GLBPageViewControllerOrientationHorizontal: {
                                        if(((contentOffset.x + contentInsets.left) <= offset.x) && (offset.x > 0.0f)) {
                                            scrollView.glb_contentOffsetX = -contentInsets.left;
                                            scrollView.scrollEnabled = NO;
                                        } else if(((contentOffset.x + frame.size.width) >= contentSize.width + offset.x) && (offset.x < 0.0f)) {
                                            scrollView.glb_contentOffsetX = (contentSize.width - frame.size.width) + contentInsets.right;
                                            scrollView.scrollEnabled = NO;
                                        } else {
                                            _panBeganPosition.x = currentPosition.x;
                                        }
                                        break;
                                    }
                                }
                            }
                        }
                    }
                }
                CGRect currentFrame = [self _currentFrame];
                switch(_orientation) {
                    case GLBPageViewControllerOrientationVertical:
                        offset.y = (currentPosition.y - _panBeganPosition.y) * _draggingRate;
                        if(_allowBeforeViewController == YES) {
                            if((currentFrame.origin.y + offset.y) > 0.0f) {
                                offset.y = (_bounceRate > 0.0f) ? offset.y * _bounceRate : 0.0f;
                            }
                        }
                        if(_allowAfterViewController == YES) {
                            if((currentFrame.origin.y + offset.y) < 0.0f) {
                                offset.y = (_bounceRate > 0.0f) ? offset.y * _bounceRate : 0.0f;
                            }
                        }
                        break;
                    case GLBPageViewControllerOrientationHorizontal:
                        offset.x = (currentPosition.x - _panBeganPosition.x) * _draggingRate;
                        if(_allowBeforeViewController == YES) {
                            if((currentFrame.origin.x + offset.x) > 0.0f) {
                                offset.x = (_bounceRate > 0.0f) ? offset.x * _bounceRate : 0.0f;
                            }
                        }
                        if(_allowAfterViewController == YES) {
                            if((currentFrame.origin.x + offset.x) < 0.0f) {
                                offset.x = (_bounceRate > 0.0f) ? offset.x * _bounceRate : 0.0f;
                            }
                        }
                        break;
                }
                currentFrame = CGRectOffset(currentFrame, floorf(offset.x), floorf(offset.y));
                _viewController.view.frame = currentFrame;
                if(_beforeDecorView != nil) {
                    _beforeDecorView.frame = [self _beforeDecorFrameFromFrame:currentFrame];
                    if(_canBeforeDecor.applyFromProgress == YES) {
                        [_beforeDecorView pageController:self applyFromProgress:[self _beforeDecorProgressFromFrame:currentFrame]];
                    }
                } else if(_beforeViewController != nil) {
                    _beforeViewController.view.frame = [self _beforeFrameFromFrame:currentFrame];
                }
                if(_afterDecorView != nil) {
                    _afterDecorView.frame = [self _afterDecorFrameFromFrame:currentFrame];
                    if(_canAfterDecor.applyFromProgress == YES) {
                        [_afterDecorView pageController:self applyFromProgress:[self _afterDecorProgressFromFrame:currentFrame]];
                    }
                } else if(_afterViewController != nil) {
                    _afterViewController.view.frame = [self _afterFrameFromFrame:currentFrame];
                }
            } else {
                _panBeganPosition = currentPosition;
            }
			break;
		}
		case UIGestureRecognizerStateEnded:
		case UIGestureRecognizerStateCancelled: {
            BOOL needRestore = NO;
            switch(_orientation) {
                case GLBPageViewControllerOrientationVertical: {
                    CGFloat delta = ((currentPosition.y - _panBeganPosition.y) * _draggingRate) * _bounceRate;
                    if(delta > _thresholdVertical) {
                        if(_allowBeforeViewController == YES) {
                            if(_beforeViewController == nil) {
                                if([_viewController respondsToSelector:@selector(beforeViewControllerInPageViewController:)] == YES) {
                                    self.beforeViewController = [_viewController beforeViewControllerInPageViewController:self];
                                }
                            }
                            if(_beforeViewController != nil) {
                                [self _animateToDirection:GLBPageViewControllerDirectionReverse duration:ANIMATION_DURATION animated:YES notification:YES];
                            } else {
                                needRestore = YES;
                            }
                        } else {
                            needRestore = YES;
                        }
                    } else if(delta < -_thresholdVertical) {
                        if(_allowBeforeViewController == YES) {
                            if(_afterViewController == nil) {
                                if([_viewController respondsToSelector:@selector(afterViewControllerInPageViewController:)] == YES) {
                                    self.afterViewController = [_viewController afterViewControllerInPageViewController:self];
                                }
                            }
                            if(_afterViewController != nil) {
                                [self _animateToDirection:GLBPageViewControllerDirectionForward duration:ANIMATION_DURATION animated:YES notification:YES];
                            } else {
                                needRestore = YES;
                            }
                        } else {
                            needRestore = YES;
                        }
                    } else {
                        needRestore = YES;
                    }
                    break;
                }
                case GLBPageViewControllerOrientationHorizontal: {
                    CGFloat delta = ((currentPosition.x - _panBeganPosition.x) * _draggingRate) * _bounceRate;
                    if(delta > _thresholdHorizontal) {
                        if(_allowBeforeViewController == YES) {
                            if(_beforeViewController == nil) {
                                if([_viewController respondsToSelector:@selector(beforeViewControllerInPageViewController:)] == YES) {
                                    self.beforeViewController = [_viewController beforeViewControllerInPageViewController:self];
                                }
                            }
                            if(_beforeViewController != nil) {
                                [self _animateToDirection:GLBPageViewControllerDirectionReverse duration:ANIMATION_DURATION animated:YES notification:YES];
                            } else {
                                needRestore = YES;
                            }
                        } else {
                            needRestore = YES;
                        }
                    } else if(delta < -_thresholdHorizontal) {
                        if(_allowAfterViewController == YES) {
                            if(_afterViewController == nil) {
                                if([_viewController respondsToSelector:@selector(afterViewControllerInPageViewController:)] == YES) {
                                    self.afterViewController = [_viewController afterViewControllerInPageViewController:self];
                                }
                            }
                            if(_afterViewController != nil) {
                                [self _animateToDirection:GLBPageViewControllerDirectionForward duration:ANIMATION_DURATION animated:YES notification:YES];
                            } else {
                                needRestore = YES;
                            }
                        } else {
                            needRestore = YES;
                        }
                    } else {
                        needRestore = YES;
                    }
                    break;
                }
            }
            if(needRestore == YES) {
                _rootView.userInteractionEnabled = NO;
                [UIView animateWithDuration:ANIMATION_DURATION
                                 animations:^{
                                     CGRect currentFrame = [self _currentFrame];
                                     _viewController.view.frame = currentFrame;
                                     if(_beforeDecorView != nil) {
                                         _beforeDecorView.frame = [self _beforeDecorFrameFromFrame:currentFrame];
                                         if(_canBeforeDecor.applyFromProgress == YES) {
                                             [_beforeDecorView pageController:self applyFromProgress:[self _beforeDecorProgressFromFrame:currentFrame]];
                                         }
                                     }
                                     if(_beforeViewController != nil) {
                                         _beforeViewController.view.frame = [self _beforeFrameFromFrame:currentFrame];
                                     }
                                     if(_afterDecorView != nil) {
                                         _afterDecorView.frame = [self _afterDecorFrameFromFrame:currentFrame];
                                         if(_canAfterDecor.applyFromProgress == YES) {
                                             [_afterDecorView pageController:self applyFromProgress:[self _afterDecorProgressFromFrame:currentFrame]];
                                         }
                                     }
                                     if(_afterViewController != nil) {
                                         _afterViewController.view.frame = [self _afterFrameFromFrame:currentFrame];
                                     }
                                 } completion:^(BOOL finished) {
                                     _rootView.userInteractionEnabled = YES;
                                 }];
            }
            for(UIGestureRecognizer* gesture in _friendlyGestures) {
                if([gesture.view isKindOfClass:UIScrollView.class] == YES) {
                    UIScrollView* scrollView = (UIScrollView*)gesture.view;
                    scrollView.scrollEnabled = YES;
                }
            }
            [_friendlyGestures removeAllObjects];
			break;
		}
		default:
			break;
	}
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gesture {
    BOOL result = NO;
    if(gesture == _panGesture) {
        if(_userInteractionEnabled == YES) {
            CGPoint translation = [_panGesture translationInView:_rootView];
            switch(_orientation) {
                case GLBPageViewControllerOrientationVertical:
                    if(ABS(translation.y) >= ABS(translation.x)) {
                        if(translation.y > 0.0f) {
                            result = (_allowBeforeViewController == YES) || (_bounceRate > 0.0f);
                        } else if(translation.y < 0.0f) {
                            result = (_allowAfterViewController == YES) || (_bounceRate > 0.0f);
                        } else {
                            result = (_allowAfterViewController == YES) || (_allowBeforeViewController == YES);
                        }
                    }
                    break;
                case GLBPageViewControllerOrientationHorizontal:
                    if(ABS(translation.x) >= ABS(translation.y)) {
                        if(translation.x > 0.0f) {
                            result = (_allowBeforeViewController == YES) || (_bounceRate > 0.0f);
                        } else if(translation.x < 0.0f) {
                            result = (_allowAfterViewController == YES) || (_bounceRate > 0.0f);
                        } else {
                            result = (_allowAfterViewController == YES) || (_allowBeforeViewController == YES);
                        }
                    }
                    break;
            }
        }
    }
    return result;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gesture shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*)otherGesture {
    if([otherGesture isKindOfClass:UIPanGestureRecognizer.class] == YES) {
        if([otherGesture.view isKindOfClass:UIScrollView.class] == YES) {
            if([_friendlyGestures containsObject:otherGesture] == NO) {
                [_friendlyGestures addObject:otherGesture];
            }
            return YES;
        }
    }
    return NO;
}

#pragma mark - GLBSlideViewControllerDelegate

- (BOOL)canShowLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(canShowLeftViewControllerInSlideViewController:)] == YES) {
        return [viewController canShowLeftViewControllerInSlideViewController:slideViewController];
    }
    return YES;
}

- (void)willShowLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(CGFloat)duration {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(willShowLeftViewControllerInSlideViewController:duration:)] == YES) {
        [viewController willShowLeftViewControllerInSlideViewController:slideViewController duration:duration];
    }
}

- (void)didShowLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(didShowLeftViewControllerInSlideViewController:)] == YES) {
        [viewController didShowLeftViewControllerInSlideViewController:slideViewController];
    }
}

- (void)willHideLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(CGFloat)duration {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(willHideLeftViewControllerInSlideViewController:duration:)] == YES) {
        [viewController willHideLeftViewControllerInSlideViewController:slideViewController duration:duration];
    }
}

- (void)didHideLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(didHideLeftViewControllerInSlideViewController:)] == YES) {
        [viewController didHideLeftViewControllerInSlideViewController:slideViewController];
    }
}

- (BOOL)canShowRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(canShowRightViewControllerInSlideViewController:)] == YES) {
        return [viewController canShowRightViewControllerInSlideViewController:slideViewController];
    }
    return YES;
}

- (void)willShowRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(CGFloat)duration {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(willShowRightViewControllerInSlideViewController:duration:)] == YES) {
        [viewController willShowRightViewControllerInSlideViewController:slideViewController duration:duration];
    }
}

- (void)didShowRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(didShowRightViewControllerInSlideViewController:)] == YES) {
        [viewController didShowRightViewControllerInSlideViewController:slideViewController];
    }
}

- (void)willHideRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(CGFloat)duration {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(willHideRightViewControllerInSlideViewController:duration:)] == YES) {
        [viewController willHideRightViewControllerInSlideViewController:slideViewController duration:duration];
    }
}

- (void)didHideRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(didHideRightViewControllerInSlideViewController:)] == YES) {
        [viewController didHideRightViewControllerInSlideViewController:slideViewController];
    }
}

- (BOOL)canShowControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(canShowControllerInSlideViewController:)] == YES) {
        return [viewController canShowControllerInSlideViewController:slideViewController];
    }
    return YES;
}

- (void)willShowControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(CGFloat)duration {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(willShowControllerInSlideViewController:duration:)] == YES) {
        [viewController willShowControllerInSlideViewController:slideViewController duration:duration];
    }
}

- (void)didShowControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(didShowControllerInSlideViewController:)] == YES) {
        [viewController didShowControllerInSlideViewController:slideViewController];
    }
}

- (void)willHideControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(CGFloat)duration {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(willHideControllerInSlideViewController:duration:)] == YES) {
        [viewController willHideControllerInSlideViewController:slideViewController duration:duration];
    }
}

- (void)didHideControllerInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(didHideControllerInSlideViewController:)] == YES) {
        [viewController didHideControllerInSlideViewController:slideViewController];
    }
}

- (void)willBeganLeftSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(willBeganLeftSwipeInSlideViewController:)] == YES) {
        [viewController willBeganLeftSwipeInSlideViewController:slideViewController];
    }
}

- (void)didBeganLeftSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(didBeganLeftSwipeInSlideViewController:)] == YES) {
        [viewController didBeganLeftSwipeInSlideViewController:slideViewController];
    }
}

- (void)movingLeftSwipeInSlideViewController:(GLBSlideViewController*)slideViewController progress:(CGFloat)progress {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(movingLeftSwipeInSlideViewController:progress:)] == YES) {
        [viewController movingLeftSwipeInSlideViewController:slideViewController progress:progress];
    }
}

- (void)willEndedLeftSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(willEndedLeftSwipeInSlideViewController:)] == YES) {
        [viewController willEndedLeftSwipeInSlideViewController:slideViewController];
    }
}

- (void)didEndedLeftSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(didEndedLeftSwipeInSlideViewController:)] == YES) {
        [viewController didEndedLeftSwipeInSlideViewController:slideViewController];
    }
}

- (void)willBeganRightSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(willBeganRightSwipeInSlideViewController:)] == YES) {
        [viewController willBeganRightSwipeInSlideViewController:slideViewController];
    }
}

- (void)didBeganRightSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(didBeganRightSwipeInSlideViewController:)] == YES) {
        [viewController didBeganRightSwipeInSlideViewController:slideViewController];
    }
}

- (void)movingRightSwipeInSlideViewController:(GLBSlideViewController*)slideViewController progress:(CGFloat)progress {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(movingRightSwipeInSlideViewController:progress:)] == YES) {
        [viewController movingRightSwipeInSlideViewController:slideViewController progress:progress];
    }
}

- (void)willEndedRightSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(willEndedRightSwipeInSlideViewController:)] == YES) {
        [viewController willEndedRightSwipeInSlideViewController:slideViewController];
    }
}

- (void)didEndedRightSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(didEndedRightSwipeInSlideViewController:)] == YES) {
        [viewController didEndedRightSwipeInSlideViewController:slideViewController];
    }
}

- (void)willBeganSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(willBeganSwipeInSlideViewController:)] == YES) {
        [viewController willBeganSwipeInSlideViewController:slideViewController];
    }
}

- (void)didBeganSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(didBeganSwipeInSlideViewController:)] == YES) {
        [viewController didBeganSwipeInSlideViewController:slideViewController];
    }
}

- (void)movingSwipeInSlideViewController:(GLBSlideViewController*)slideViewController progress:(CGFloat)progress {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(movingSwipeInSlideViewController:progress:)] == YES) {
        [viewController movingSwipeInSlideViewController:slideViewController progress:progress];
    }
}

- (void)willEndedSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(willEndedSwipeInSlideViewController:)] == YES) {
        [viewController willEndedSwipeInSlideViewController:slideViewController];
    }
}

- (void)didEndedSwipeInSlideViewController:(GLBSlideViewController*)slideViewController {
    UIViewController< GLBSlideViewControllerDelegate >* viewController = (id)_viewController;
    if([viewController respondsToSelector:@selector(didEndedSwipeInSlideViewController:)] == YES) {
        [viewController didEndedSwipeInSlideViewController:slideViewController];
    }
}

#pragma mark - GLBViewController

- (UIViewController*)currentViewController {
    if(_viewController != nil) {
        return _viewController.glb_currentViewController;
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

@implementation UIViewController (GLBPageViewController)

- (void)setGlb_pageController:(GLBPageViewController*)pageController {
    objc_setAssociatedObject(self, @selector(glb_pageController), pageController, OBJC_ASSOCIATION_ASSIGN);
}

- (GLBPageViewController*)glb_pageController {
    GLBPageViewController* viewController = objc_getAssociatedObject(self, @selector(glb_pageController));
    if(viewController == nil) {
        viewController = self.parentViewController.glb_pageController;
    }
    return viewController;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
