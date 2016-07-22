/*--------------------------------------------------*/

#import "GLBDialogViewController+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBDialogViewController

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

- (instancetype)initWithContentViewController:(UIViewController*)contentViewController {
    self = [super initWithNibName:nil bundle:nil];
    if(self != nil) {
        _contentViewController = contentViewController;
        _contentViewController.glb_dialogViewController = self;
        [self setup];
    }
    return self;
}

- (void)setup {
    _animationDuration = 0.4f;
    _backgroundBlurred = YES;
    _backgroundBlurRadius = 20.0f;
    _backgroundBlurIterations = 4;
    _backgroundBlurDynamic = NO;
    _backgroundBlurUpdateInterval = 0.1f;
    _backgroundColor = nil;
    _backgroundTintColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
    _backgroundAlpha = 1.0f;
    
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressedBackground:)];
    _tapGesture.delegate = self;
    
    _autoUpdateConstraintContentView = YES;
}

- (void)dealloc {
    _contentViewController.glb_dialogViewController = nil;
}

#pragma mark - Property

- (void)setBackgroundBlurred:(BOOL)backgroundBlurred {
    if(_backgroundBlurred != backgroundBlurred) {
        _backgroundBlurred = backgroundBlurred;
        if(self.isViewLoaded == YES) {
            _backgroundView.blurEnabled = _backgroundBlurred;
        }
    }
}

- (void)setBackgroundBlurRadius:(CGFloat)backgroundBlurRadius {
    if(_backgroundBlurRadius != backgroundBlurRadius) {
        _backgroundBlurRadius = backgroundBlurRadius;
        if(self.isViewLoaded == YES) {
            _backgroundView.blurRadius = _backgroundBlurRadius;
        }
    }
}

- (void)setBackgroundBlurIterations:(NSUInteger)backgroundBlurIterations {
    if(_backgroundBlurIterations != backgroundBlurIterations) {
        _backgroundBlurIterations = backgroundBlurIterations;
        if(self.isViewLoaded == YES) {
            _backgroundView.blurIterations = _backgroundBlurIterations;
        }
    }
}

- (void)setBackgroundBlurDynamic:(BOOL)backgroundBlurDynamic {
    if(_backgroundBlurDynamic != backgroundBlurDynamic) {
        _backgroundBlurDynamic = backgroundBlurDynamic;
        if(self.isViewLoaded == YES) {
            _backgroundView.dynamic = _backgroundBlurDynamic;
        }
    }
}

- (void)setBackgroundBlurUpdateInterval:(NSTimeInterval)backgroundBlurUpdateInterval {
    if(_backgroundBlurUpdateInterval != backgroundBlurUpdateInterval) {
        _backgroundBlurUpdateInterval = backgroundBlurUpdateInterval;
        if(self.isViewLoaded == YES) {
            _backgroundView.updateInterval = _backgroundBlurUpdateInterval;
        }
    }
}

- (void)setBackgroundColor:(UIColor*)backgroundColor {
    if([_backgroundColor isEqual:backgroundColor] == NO) {
        _backgroundColor = backgroundColor;
        if(self.isViewLoaded == YES) {
            _backgroundView.backgroundColor = _backgroundColor;
        }
    }
}

- (void)setBackgroundTintColor:(UIColor*)backgroundTintColor {
    if([_backgroundTintColor isEqual:backgroundTintColor] == NO) {
        _backgroundTintColor = backgroundTintColor;
        if(self.isViewLoaded == YES) {
            _backgroundView.tintColor = _backgroundTintColor;
        }
    }
}

- (void)setContentVerticalAlignment:(GLBDialogViewControllerAlignmentVertical)contentVerticalAlignment {
    if(_contentVerticalAlignment != contentVerticalAlignment) {
        _contentVerticalAlignment = contentVerticalAlignment;
        if(self.isViewLoaded == YES) {
            _needClearConstraintContentView = YES;
            if(_autoUpdateConstraintContentView == YES) {
                [self _updateConstraintContentView];
            }
        }
    }
}

- (void)setContentVerticalOffset:(CGFloat)contentVerticalOffset {
    if(_contentVerticalOffset != contentVerticalOffset) {
        _contentVerticalOffset = contentVerticalOffset;
        if((self.isViewLoaded == YES) && (_autoUpdateConstraintContentView == YES)) {
            [self _updateConstraintContentView];
        }
    }
}

- (void)setContentHorizontalAlignment:(GLBDialogViewControllerAlignmentHorizontal)contentHorizontalAlignment {
    if(_contentHorizontalAlignment != contentHorizontalAlignment) {
        _contentHorizontalAlignment = contentHorizontalAlignment;
        if(self.isViewLoaded == YES) {
            _needClearConstraintContentView = YES;
            if(_autoUpdateConstraintContentView == YES) {
                [self _updateConstraintContentView];
            }
        }
    }
}

- (void)setContentHorizontalOffset:(CGFloat)contentHorizontalOffset {
    if(_contentHorizontalOffset != contentHorizontalOffset) {
        _contentHorizontalOffset = contentHorizontalOffset;
        if((self.isViewLoaded == YES) && (_autoUpdateConstraintContentView == YES)) {
            [self _updateConstraintContentView];
        }
    }
}

- (void)setContentWidthBehaviour:(GLBDialogViewControllerSizeBehaviour)contentWidthBehaviour {
    if(_contentWidthBehaviour != contentWidthBehaviour) {
        _contentWidthBehaviour = contentWidthBehaviour;
        if(self.isViewLoaded == YES) {
            _needClearConstraintContentView = YES;
            if(_autoUpdateConstraintContentView == YES) {
                [self _updateConstraintContentView];
            }
        }
    }
}

- (void)setContentHeightBehaviour:(GLBDialogViewControllerSizeBehaviour)contentHeightBehaviour {
    if(_contentHeightBehaviour != contentHeightBehaviour) {
        _contentHeightBehaviour = contentHeightBehaviour;
        if(self.isViewLoaded == YES) {
            _needClearConstraintContentView = YES;
            if(_autoUpdateConstraintContentView == YES) {
                [self _updateConstraintContentView];
            }
        }
    }
}

- (void)setContentSize:(CGSize)contentSize {
    if(CGSizeEqualToSize(_contentSize, contentSize) == NO) {
        _contentSize = contentSize;
        if((self.isViewLoaded == YES) && (_autoUpdateConstraintContentView == YES)) {
            [self _updateConstraintContentView];
        }
    }
}

- (void)setContentWidth:(CGFloat)contentWidth {
    self.contentSize = CGSizeMake(contentWidth, _contentSize.height);
}

- (CGFloat)contentWidth {
    return _contentSize.width;
}

- (void)setContentHeight:(CGFloat)contentHeight {
    self.contentSize = CGSizeMake(_contentSize.width, contentHeight);
}

- (CGFloat)contentHeight {
    return _contentSize.height;
}

- (void)setContentMinSize:(CGSize)contentMinSize {
    if(CGSizeEqualToSize(_contentMinSize, contentMinSize) == NO) {
        _contentMinSize = contentMinSize;
        if((self.isViewLoaded == YES) && (_autoUpdateConstraintContentView == YES)) {
            [self _updateConstraintContentView];
        }
    }
}

- (void)setContentMinWidth:(CGFloat)contentMinWidth {
    self.contentMinSize = CGSizeMake(contentMinWidth, _contentMinSize.height);
}

- (CGFloat)contentMinWidth {
    return _contentMinSize.width;
}

- (void)setContentMinHeight:(CGFloat)contentMinHeight {
    self.contentMinSize = CGSizeMake(_contentMinSize.width, contentMinHeight);
}

- (CGFloat)contentMinHeight {
    return _contentMinSize.height;
}

- (void)setContentMaxSize:(CGSize)contentMaxSize {
    if(CGSizeEqualToSize(_contentMaxSize, contentMaxSize) == NO) {
        _contentMaxSize = contentMaxSize;
        if((self.isViewLoaded == YES) && (_autoUpdateConstraintContentView == YES)) {
            [self _updateConstraintContentView];
        }
    }
}

- (void)setContentMaxWidth:(CGFloat)contentMaxWidth {
    self.contentMaxSize = CGSizeMake(contentMaxWidth, _contentMaxSize.height);
}

- (CGFloat)contentMaxWidth {
    return _contentMaxSize.width;
}

- (void)setContentMaxHeight:(CGFloat)contentMaxHeight {
    self.contentMaxSize = CGSizeMake(_contentMaxSize.width, contentMaxHeight);
}

- (CGFloat)contentMaxHeight {
    return _contentMaxSize.height;
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    if(UIEdgeInsetsEqualToEdgeInsets(_contentInset, contentInset) == NO) {
        _contentInset = contentInset;
        if((self.isViewLoaded == YES) && (_autoUpdateConstraintContentView == YES)) {
            [self _updateConstraintContentView];
        }
    }
}

- (void)setContentInsetTop:(CGFloat)contentInsetTop {
    self.contentInset = UIEdgeInsetsMake(contentInsetTop, _contentInset.left, _contentInset.bottom, _contentInset.right);
}

- (CGFloat)contentInsetTop {
    return _contentInset.top;
}

- (void)setContentInsetBottom:(CGFloat)contentInsetBottom {
    self.contentInset = UIEdgeInsetsMake(_contentInset.top, _contentInset.left, contentInsetBottom, _contentInset.right);
}

- (CGFloat)contentInsetBottom {
    return _contentInset.bottom;
}

- (void)setContentInsetLeft:(CGFloat)contentInsetLeft {
    self.contentInset = UIEdgeInsetsMake(_contentInset.top, contentInsetLeft, _contentInset.bottom, _contentInset.right);
}

- (CGFloat)contentInsetLeft {
    return _contentInset.left;
}

- (void)setContentInsetRight:(CGFloat)contentInsetRight {
    self.contentInset = UIEdgeInsetsMake(_contentInset.top, _contentInset.left, _contentInset.bottom, contentInsetRight);
}

- (CGFloat)contentInsetRight {
    return _contentInset.right;
}

#pragma mark - UIViewController

- (BOOL)prefersStatusBarHidden {
    if(_ownerViewController != nil) {
        return [_ownerViewController prefersStatusBarHidden];
    }
    return [_contentViewController prefersStatusBarHidden];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if(_ownerViewController != nil) {
        return [_ownerViewController preferredStatusBarStyle];
    }
    return [_contentViewController preferredStatusBarStyle];
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    if(_ownerViewController != nil) {
        return [_ownerViewController preferredStatusBarUpdateAnimation];
    }
    return [_contentViewController preferredStatusBarUpdateAnimation];
}

- (BOOL)shouldAutorotate {
    if(_ownerViewController != nil) {
        return [_ownerViewController shouldAutorotate];
    }
    return [_contentViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if(_ownerViewController != nil) {
        return [_ownerViewController supportedInterfaceOrientations];
    }
    return [_contentViewController supportedInterfaceOrientations];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if(_ownerViewController != nil) {
        return [_ownerViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
    }
    return [_contentViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.clearColor;
    
    if(_tapGesture != nil) {
        [self.view addGestureRecognizer:_tapGesture];
    }
    
    _backgroundView = [[GLBBlurView alloc] initWithFrame:self.view.bounds];
    if(_backgroundView  != nil) {
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _backgroundView.blurEnabled = _backgroundBlurred;
        _backgroundView.blurRadius = _backgroundBlurRadius;
        _backgroundView.blurIterations = _backgroundBlurIterations;
        _backgroundView.dynamic = _backgroundBlurDynamic;
        _backgroundView.updateInterval = _backgroundBlurUpdateInterval;
        _backgroundView.backgroundColor = _backgroundColor;
        _backgroundView.tintColor = _backgroundTintColor;
        _backgroundView.alpha = _backgroundAlpha;
        [self.view addSubview:_backgroundView];
    }
    
    if(_contentViewController != nil) {
        _contentViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
        _contentViewController.view.frame = self.view.bounds;
        [self.view addSubview:_contentViewController.view];
        [self addChildViewController:_contentViewController];
        [_contentViewController didMoveToParentViewController:self];
    }
    
    [self _updateConstraintContentView];
}

#pragma mark - Public

- (void)presentViewController:(UIViewController*)viewController withCompletion:(GLBDialogViewControllerBlock)completion {
#ifndef GLOBUS_APP_EXTENSION
    _ownerWindow = UIApplication.sharedApplication.keyWindow;
#endif
    _ownerViewController = viewController;
    if(_dialogWindow == nil) {
        _dialogWindow = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        if(_ownerWindow != nil) {
            _dialogWindow.windowLevel = _ownerWindow.windowLevel + 0.01f;
        } else {
            _dialogWindow.windowLevel = UIWindowLevelNormal + 0.01f;
        }
        _dialogWindow.backgroundColor = UIColor.clearColor;
        _dialogWindow.rootViewController = self;
        _dialogWindow.glb_userWindow = YES;
        [_dialogWindow makeKeyAndVisible];
        [_dialogWindow layoutIfNeeded];
    } else {
        if(_ownerWindow != nil) {
            _dialogWindow.windowLevel = _ownerWindow.windowLevel + 0.01f;
        } else {
            _dialogWindow.windowLevel = UIWindowLevelNormal + 0.01f;
        }
    }
    if(_ownerWindow != nil) {
        UIViewController* currentViewController = _ownerWindow.glb_currentViewController;
        if(currentViewController != nil) {
            if(currentViewController.navigationController != nil) {
                _backgroundView.underlyingView = currentViewController.navigationController.view;
            } else if(currentViewController.tabBarController != nil) {
                _backgroundView.underlyingView = currentViewController.tabBarController.view;
            } else if(currentViewController.glb_slideViewController != nil) {
                _backgroundView.underlyingView = currentViewController.glb_slideViewController.view;
            } else {
                _backgroundView.underlyingView = currentViewController.view;
            }
        } else {
            _backgroundView.underlyingView = _ownerWindow.rootViewController.view;
        }
    }
    [self glb_loadViewIfNeed];
    [self setNeedsStatusBarAppearanceUpdate];
    [self _willPresentWithCompletion:completion];
}

- (void)presentWithCompletion:(GLBDialogViewControllerBlock)completion {
#ifndef GLOBUS_APP_EXTENSION
    [self presentViewController:UIApplication.sharedApplication.keyWindow.rootViewController withCompletion:completion];
#else
    [self presentViewController:nil withCompletion:completion];
#endif
}

- (void)dismissWithCompletion:(GLBDialogViewControllerBlock)completion {
    [self _willDismissWithCompletion:completion];
}

#pragma mark - Private

- (void)_willPresentWithCompletion:(GLBDialogViewControllerBlock)completion {
    _autoUpdateConstraintContentView = NO;
    _dialogWindow.userInteractionEnabled = NO;
    _tapGesture.enabled = NO;
    
    id< GLBDialogContentViewController > contentViewController = ([_contentViewController conformsToProtocol:@protocol(GLBDialogContentViewController)] == YES) ? (id< GLBDialogContentViewController >)_contentViewController : nil;
    if([contentViewController respondsToSelector:@selector(willPresentDialogViewController:)] == YES) {
        [contentViewController willPresentDialogViewController:self];
    }
    
    [self _presentWithCompletion:completion];
}

- (void)_presentWithCompletion:(GLBDialogViewControllerBlock)completion {
    __weak typeof(self) weakSelf = self;
    
    GLBDialogAnimationController* animationController = _animationController;
    if(animationController == nil) {
        animationController = [GLBDialogDefaultAnimationController new];
    }
    [animationController presentDialogViewController:self completion:^{
        [weakSelf _didPresentWithCompletion:completion];
    }];
}

- (void)_didPresentWithCompletion:(GLBDialogViewControllerBlock)completion {
    _autoUpdateConstraintContentView = YES;
    _dialogWindow.userInteractionEnabled = YES;
    _tapGesture.enabled = YES;
    
    id< GLBDialogContentViewController > contentViewController = ([_contentViewController conformsToProtocol:@protocol(GLBDialogContentViewController)] == YES) ? (id< GLBDialogContentViewController >)_contentViewController : nil;
    if([contentViewController respondsToSelector:@selector(didPresentDialogViewController:)] == YES) {
        [contentViewController didPresentDialogViewController:self];
    }
    
    if(completion != nil) {
        completion(self);
    }
}

- (void)_willDismissWithCompletion:(GLBDialogViewControllerBlock)completion {
    _autoUpdateConstraintContentView = NO;
    _dialogWindow.userInteractionEnabled = NO;
    _tapGesture.enabled = NO;
    
    id< GLBDialogContentViewController > contentViewController = ([_contentViewController conformsToProtocol:@protocol(GLBDialogContentViewController)] == YES) ? (id< GLBDialogContentViewController >)_contentViewController : nil;
    if([contentViewController respondsToSelector:@selector(willDismissDialogViewController:)] == YES) {
        [contentViewController willDismissDialogViewController:self];
    }
    
    [self _dismissWithCompletion:completion];
}

- (void)_dismissWithCompletion:(GLBDialogViewControllerBlock)completion {
    __weak typeof(self) weakSelf = self;
    
    GLBDialogAnimationController* animationController = _animationController;
    if(animationController == nil) {
        animationController = [GLBDialogDefaultAnimationController new];
    }
    [animationController dismissDialogViewController:self completion:^{
        [weakSelf _didDismissWithCompletion:completion];
    }];
}

- (void)_didDismissWithCompletion:(GLBDialogViewControllerBlock)completion {
    _autoUpdateConstraintContentView = YES;
    _dialogWindow.userInteractionEnabled = YES;
    _tapGesture.enabled = YES;
    
    id< GLBDialogContentViewController > contentViewController = ([_contentViewController conformsToProtocol:@protocol(GLBDialogContentViewController)] == YES) ? (id< GLBDialogContentViewController >)_contentViewController : nil;
    if([contentViewController respondsToSelector:@selector(didDismissDialogViewController:)] == YES) {
        [contentViewController didDismissDialogViewController:self];
    }
    
    if(_dialogWindow != nil) {
        _dialogWindow.hidden = YES;
    }
    if(_ownerWindow != nil) {
        [_ownerWindow makeKeyWindow];
    }
    if(_dismiss != nil) {
        _dismiss(self);
    }
    
    if(completion != nil) {
        completion(self);
    }
}

- (void)_updateConstraintContentView {
    if(_needClearConstraintContentView == YES) {
        
        if(_constraintContentViewVerticalAlignment != nil) {
            [self.view removeConstraint:_constraintContentViewVerticalAlignment];
            _constraintContentViewVerticalAlignment = nil;
        }
        if(_constraintContentViewHorizontalAlignment != nil) {
            [self.view removeConstraint:_constraintContentViewHorizontalAlignment];
            _constraintContentViewHorizontalAlignment = nil;
        }
        
        if(_constraintContentViewWidth != nil) {
            [self.view removeConstraint:_constraintContentViewWidth];
            _constraintContentViewWidth = nil;
        }
        if(_constraintContentViewMinWidth != nil) {
            [self.view removeConstraint:_constraintContentViewMinWidth];
            _constraintContentViewMinWidth = nil;
        }
        if(_constraintContentViewMaxWidth != nil) {
            [self.view removeConstraint:_constraintContentViewMaxWidth];
            _constraintContentViewMaxWidth = nil;
        }
        if(_constraintContentViewLeft != nil) {
            [self.view removeConstraint:_constraintContentViewLeft];
            _constraintContentViewLeft = nil;
        }
        if(_constraintContentViewRight != nil) {
            [self.view removeConstraint:_constraintContentViewRight];
            _constraintContentViewRight = nil;
        }
        
        if(_constraintContentViewHeight != nil) {
            [self.view removeConstraint:_constraintContentViewHeight];
            _constraintContentViewHeight = nil;
        }
        if(_constraintContentViewMinHeight != nil) {
            [self.view removeConstraint:_constraintContentViewMinHeight];
            _constraintContentViewMinHeight = nil;
        }
        if(_constraintContentViewMaxHeight != nil) {
            [self.view removeConstraint:_constraintContentViewMaxHeight];
            _constraintContentViewMaxHeight = nil;
        }
        if(_constraintContentViewTop != nil) {
            [self.view removeConstraint:_constraintContentViewTop];
            _constraintContentViewTop = nil;
        }
        if(_constraintContentViewBottom != nil) {
            [self.view removeConstraint:_constraintContentViewBottom];
            _constraintContentViewBottom = nil;
        }
    }
    if(_constraintContentViewHorizontalAlignment == nil) {
        switch(_contentVerticalAlignment) {
            case GLBDialogViewControllerAlignmentVerticalTop:
                _constraintContentViewHorizontalAlignment = [_contentViewController.view glb_addConstraintAttribute:NSLayoutAttributeTop
                                                                                                           relation:NSLayoutRelationEqual
                                                                                                          attribute:NSLayoutAttributeTop
                                                                                                           constant:_contentVerticalOffset
                                                                                                           priority:UILayoutPriorityRequired
                                                                                                         multiplier:1.0f];
                break;
            case GLBDialogViewControllerAlignmentVerticalCenter:
                _constraintContentViewHorizontalAlignment = [_contentViewController.view glb_addConstraintAttribute:NSLayoutAttributeCenterY
                                                                                                           relation:NSLayoutRelationEqual
                                                                                                          attribute:NSLayoutAttributeCenterY
                                                                                                           constant:_contentVerticalOffset
                                                                                                           priority:UILayoutPriorityRequired
                                                                                                         multiplier:1.0f];
                break;
            case GLBDialogViewControllerAlignmentVerticalBottom:
                _constraintContentViewHorizontalAlignment = [_contentViewController.view glb_addConstraintAttribute:NSLayoutAttributeBottom
                                                                                                           relation:NSLayoutRelationEqual
                                                                                                          attribute:NSLayoutAttributeBottom
                                                                                                           constant:-_contentVerticalOffset
                                                                                                           priority:UILayoutPriorityRequired
                                                                                                         multiplier:1.0f];
                break;
        }
    } else {
        switch(_contentVerticalAlignment) {
            case GLBDialogViewControllerAlignmentVerticalTop:
                _constraintContentViewHorizontalAlignment.constant = _contentVerticalOffset;
                break;
            case GLBDialogViewControllerAlignmentVerticalCenter:
                _constraintContentViewHorizontalAlignment.constant = _contentVerticalOffset;
                break;
            case GLBDialogViewControllerAlignmentVerticalBottom:
                _constraintContentViewHorizontalAlignment.constant = -_contentVerticalOffset;
                break;
        }
    }
    if(_constraintContentViewVerticalAlignment == nil) {
        switch(_contentHorizontalAlignment) {
            case GLBDialogViewControllerAlignmentHorizontalLeft:
                _constraintContentViewVerticalAlignment = [_contentViewController.view glb_addConstraintAttribute:NSLayoutAttributeLeft
                                                                                                         relation:NSLayoutRelationEqual
                                                                                                        attribute:NSLayoutAttributeLeft
                                                                                                         constant:_contentHorizontalOffset
                                                                                                         priority:UILayoutPriorityRequired
                                                                                                       multiplier:1.0f];
                break;
            case GLBDialogViewControllerAlignmentHorizontalCenter:
                _constraintContentViewVerticalAlignment = [_contentViewController.view glb_addConstraintAttribute:NSLayoutAttributeCenterX
                                                                                                         relation:NSLayoutRelationEqual
                                                                                                        attribute:NSLayoutAttributeCenterX
                                                                                                         constant:_contentHorizontalOffset
                                                                                                         priority:UILayoutPriorityRequired
                                                                                                       multiplier:1.0f];
                break;
            case GLBDialogViewControllerAlignmentHorizontalRight:
                _constraintContentViewVerticalAlignment = [_contentViewController.view glb_addConstraintAttribute:NSLayoutAttributeRight
                                                                                                         relation:NSLayoutRelationEqual
                                                                                                        attribute:NSLayoutAttributeRight
                                                                                                         constant:-_contentHorizontalOffset
                                                                                                         priority:UILayoutPriorityRequired
                                                                                                       multiplier:1.0f];
                break;
        }
    } else {
        switch(_contentHorizontalAlignment) {
            case GLBDialogViewControllerAlignmentHorizontalLeft:
                _constraintContentViewVerticalAlignment.constant = _contentHorizontalOffset;
                break;
            case GLBDialogViewControllerAlignmentHorizontalCenter:
                _constraintContentViewVerticalAlignment.constant = _contentHorizontalOffset;
                break;
            case GLBDialogViewControllerAlignmentHorizontalRight:
                _constraintContentViewVerticalAlignment.constant = -_contentHorizontalOffset;
                break;
        }
    }
    switch(_contentWidthBehaviour) {
        case GLBDialogViewControllerSizeBehaviourFit:
            if(_contentSize.width > FLT_EPSILON) {
                if(_constraintContentViewWidth == nil) {
                    _constraintContentViewWidth = [_contentViewController.view glb_addConstraintAttribute:NSLayoutAttributeWidth
                                                                                                 relation:NSLayoutRelationEqual
                                                                                                 constant:_contentSize.width];
                } else {
                    _constraintContentViewWidth.constant = _contentSize.width;
                }
                if(_constraintContentViewMinWidth != nil) {
                    [self.view removeConstraint:_constraintContentViewMinWidth];
                    _constraintContentViewMinWidth = nil;
                }
                if(_constraintContentViewMaxWidth != nil) {
                    [self.view removeConstraint:_constraintContentViewMaxWidth];
                    _constraintContentViewMaxWidth = nil;
                }
            } else {
                if(_contentMinSize.width > FLT_EPSILON) {
                    if(_constraintContentViewMinWidth == nil) {
                        _constraintContentViewMinWidth = [_contentViewController.view glb_addConstraintAttribute:NSLayoutAttributeWidth
                                                                                                        relation:NSLayoutRelationGreaterThanOrEqual
                                                                                                        constant:_contentMinSize.width];
                    } else {
                        _constraintContentViewMinWidth.constant = _contentMinSize.width;
                    }
                } else {
                    if(_constraintContentViewMinWidth != nil) {
                        [self.view removeConstraint:_constraintContentViewMinWidth];
                        _constraintContentViewMinWidth = nil;
                    }
                }
                if(_contentMaxSize.width > FLT_EPSILON) {
                    if(_constraintContentViewMaxWidth == nil) {
                        _constraintContentViewMaxWidth = [_contentViewController.view glb_addConstraintAttribute:NSLayoutAttributeWidth
                                                                                                        relation:NSLayoutRelationLessThanOrEqual
                                                                                                        constant:_contentMaxSize.width];
                    } else {
                        _constraintContentViewMaxWidth.constant = _contentMaxSize.width;
                    }
                } else {
                    if(_constraintContentViewMaxWidth != nil) {
                        [self.view removeConstraint:_constraintContentViewMaxWidth];
                        _constraintContentViewMaxWidth = nil;
                    }
                }
                if(_constraintContentViewWidth != nil) {
                    [self.view removeConstraint:_constraintContentViewWidth];
                    _constraintContentViewWidth = nil;
                }
            }
            if(_constraintContentViewLeft != nil) {
                [self.view removeConstraint:_constraintContentViewLeft];
                _constraintContentViewLeft = nil;
            }
            if(_constraintContentViewRight != nil) {
                [self.view removeConstraint:_constraintContentViewRight];
                _constraintContentViewRight = nil;
            }
            break;
        case GLBDialogViewControllerSizeBehaviourFill:
            if(_constraintContentViewLeft == nil) {
                _constraintContentViewLeft = [_contentViewController.view glb_addConstraintAttribute:NSLayoutAttributeLeft
                                                                                            relation:NSLayoutRelationEqual
                                                                                           attribute:NSLayoutAttributeLeft
                                                                                            constant:_contentInset.left];
            } else {
                _constraintContentViewLeft.constant = _contentInset.left;
            }
            if(_constraintContentViewRight == nil) {
                _constraintContentViewRight = [_contentViewController.view glb_addConstraintAttribute:NSLayoutAttributeRight
                                                                                             relation:NSLayoutRelationEqual
                                                                                            attribute:NSLayoutAttributeRight
                                                                                             constant:-_contentInset.right];
            } else {
                _constraintContentViewRight.constant = -_contentInset.right;
            }
            if(_constraintContentViewWidth != nil) {
                [self.view removeConstraint:_constraintContentViewWidth];
                _constraintContentViewWidth = nil;
            }
            if(_constraintContentViewMinWidth != nil) {
                [self.view removeConstraint:_constraintContentViewMinWidth];
                _constraintContentViewMinWidth = nil;
            }
            if(_constraintContentViewMaxWidth != nil) {
                [self.view removeConstraint:_constraintContentViewMaxWidth];
                _constraintContentViewMaxWidth = nil;
            }
            break;
    }
    switch(_contentHeightBehaviour) {
        case GLBDialogViewControllerSizeBehaviourFit:
            if(_contentSize.height > FLT_EPSILON) {
                if(_constraintContentViewHeight == nil) {
                    _constraintContentViewHeight = [_contentViewController.view glb_addConstraintAttribute:NSLayoutAttributeHeight
                                                                                                  relation:NSLayoutRelationEqual
                                                                                                  constant:_contentSize.height];
                } else {
                    _constraintContentViewHeight.constant = _contentSize.height;
                }
                if(_constraintContentViewMinHeight != nil) {
                    [self.view removeConstraint:_constraintContentViewMinHeight];
                    _constraintContentViewMinHeight = nil;
                }
                if(_constraintContentViewMaxHeight != nil) {
                    [self.view removeConstraint:_constraintContentViewMaxHeight];
                    _constraintContentViewMaxHeight = nil;
                }
            } else {
                if(_contentMinSize.height > FLT_EPSILON) {
                    if(_constraintContentViewMinHeight == nil) {
                        _constraintContentViewMinHeight = [_contentViewController.view glb_addConstraintAttribute:NSLayoutAttributeHeight
                                                                                                         relation:NSLayoutRelationGreaterThanOrEqual
                                                                                                         constant:_contentMinSize.height];
                    } else {
                        _constraintContentViewMinHeight.constant = _contentMinSize.height;
                    }
                } else {
                    if(_constraintContentViewMinHeight != nil) {
                        [self.view removeConstraint:_constraintContentViewMinHeight];
                        _constraintContentViewMinHeight = nil;
                    }
                }
                if(_contentMaxSize.height > FLT_EPSILON) {
                    if(_constraintContentViewMaxHeight == nil) {
                        _constraintContentViewMaxHeight = [_contentViewController.view glb_addConstraintAttribute:NSLayoutAttributeHeight
                                                                                                         relation:NSLayoutRelationLessThanOrEqual
                                                                                                         constant:_contentMaxSize.height];
                    } else {
                        _constraintContentViewMaxHeight.constant = _contentMaxSize.height;
                    }
                } else {
                    if(_constraintContentViewMaxHeight != nil) {
                        [self.view removeConstraint:_constraintContentViewMaxHeight];
                        _constraintContentViewMaxHeight = nil;
                    }
                }
                if(_constraintContentViewHeight != nil) {
                    [self.view removeConstraint:_constraintContentViewHeight];
                    _constraintContentViewHeight = nil;
                }
            }
            if(_constraintContentViewTop != nil) {
                [self.view removeConstraint:_constraintContentViewTop];
                _constraintContentViewTop = nil;
            }
            if(_constraintContentViewBottom != nil) {
                [self.view removeConstraint:_constraintContentViewBottom];
                _constraintContentViewBottom = nil;
            }
            break;
        case GLBDialogViewControllerSizeBehaviourFill:
            if(_constraintContentViewTop == nil) {
                _constraintContentViewTop = [_contentViewController.view glb_addConstraintAttribute:NSLayoutAttributeTop
                                                                                           relation:NSLayoutRelationEqual
                                                                                          attribute:NSLayoutAttributeTop
                                                                                           constant:_contentInset.top];
            } else {
                _constraintContentViewTop.constant = _contentInset.top;
            }
            if(_constraintContentViewBottom == nil) {
                _constraintContentViewBottom = [_contentViewController.view glb_addConstraintAttribute:NSLayoutAttributeBottom
                                                                                              relation:NSLayoutRelationEqual
                                                                                             attribute:NSLayoutAttributeBottom
                                                                                              constant:-_contentInset.bottom];
            } else {
                _constraintContentViewBottom.constant = -_contentInset.bottom;
            }
            if(_constraintContentViewHeight != nil) {
                [self.view removeConstraint:_constraintContentViewHeight];
                _constraintContentViewHeight = nil;
            }
            if(_constraintContentViewMinHeight != nil) {
                [self.view removeConstraint:_constraintContentViewMinHeight];
                _constraintContentViewMinHeight = nil;
            }
            if(_constraintContentViewMaxHeight != nil) {
                [self.view removeConstraint:_constraintContentViewMaxHeight];
                _constraintContentViewMaxHeight = nil;
            }
            break;
    }
}

#pragma mark - Actions

- (IBAction)pressedBackground:(id)sender {
    if(_touchedOutsideContent != nil) {
        _touchedOutsideContent(self);
    } else {
        [self dismissWithCompletion:nil];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    UIView* view = _contentViewController.view;
    CGRect bounds = [view convertRect:view.bounds toView:nil];
    CGPoint point = [touch locationInView:_dialogWindow];
    return (CGRectContainsPoint(bounds, point) == NO);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceivePress:(UIPress*)press {
    return NO;
}

@end


/*--------------------------------------------------*/

@implementation GLBDialogAnimationController

#pragma mark - Public

- (void)presentDialogViewController:(GLBDialogViewController*)dialogViewController completion:(GLBSimpleBlock)completion {
}

- (void)dismissDialogViewController:(GLBDialogViewController*)dialogViewController completion:(GLBSimpleBlock)completion {
}

@end

/*--------------------------------------------------*/

@implementation GLBDialogDefaultAnimationController

#pragma mark - Public

- (void)presentDialogViewController:(GLBDialogViewController*)dialogViewController completion:(GLBSimpleBlock)completion {
    dialogViewController.view.alpha = 0.0;
    
    if(dialogViewController.backgroundBlurred == YES) {
        dialogViewController.backgroundView.blurRadius = 0.0f;
    }
    [UIView animateWithDuration:dialogViewController.animationDuration animations:^{
        if(dialogViewController.backgroundBlurred == YES) {
            dialogViewController.backgroundView.blurRadius = dialogViewController.backgroundBlurRadius;
        }
        dialogViewController.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        if(completion != nil) {
            completion();
        }
    }];
}

- (void)dismissDialogViewController:(GLBDialogViewController*)dialogViewController completion:(GLBSimpleBlock)completion {
    [UIView animateWithDuration:dialogViewController.animationDuration animations:^{
        if(dialogViewController.backgroundBlurred == YES) {
            dialogViewController.backgroundView.blurRadius = 0.0f;
        }
        dialogViewController.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if(completion != nil) {
            completion();
        }
    }];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

#import <objc/runtime.h>

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation UIViewController (GLBDialogViewController)

- (void)setGlb_dialogViewController:(GLBDialogViewController*)dialogViewController {
    objc_setAssociatedObject(self, @selector(glb_dialogViewController), dialogViewController, OBJC_ASSOCIATION_ASSIGN);
}

- (GLBDialogViewController*)glb_dialogViewController {
    GLBDialogViewController* controller = objc_getAssociatedObject(self, @selector(glb_dialogViewController));
    if(controller == nil) {
        controller = self.parentViewController.glb_dialogViewController;
    }
    return controller;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
