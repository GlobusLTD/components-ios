/*--------------------------------------------------*/

#import "GLBDialogViewController.h"
#import "GLBSlideViewController.h"
#import "GLBBlurView.h"

/*--------------------------------------------------*/

#import "UIWindow+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDialogViewController () < UIGestureRecognizerDelegate >

@property(nonatomic, strong) UIWindow* dialogWindow;
@property(nonatomic, weak) UIWindow* ownerWindow;
@property(nonatomic, strong) UIViewController* ownerViewController;

@property(nonatomic, strong) GLBBlurView* backgroundView;
@property(nonatomic, strong) UIViewController* contentViewController;
@property(nonatomic, strong) NSLayoutConstraint* constraintContentViewHorizontalAlignment;
@property(nonatomic, strong) NSLayoutConstraint* constraintContentViewVerticalAlignment;
@property(nonatomic, strong) NSLayoutConstraint* constraintContentViewWidth;
@property(nonatomic, strong) NSLayoutConstraint* constraintContentViewHeight;
@property(nonatomic, strong) NSLayoutConstraint* constraintContentViewMinWidth;
@property(nonatomic, strong) NSLayoutConstraint* constraintContentViewMinHeight;
@property(nonatomic, strong) NSLayoutConstraint* constraintContentViewMaxWidth;
@property(nonatomic, strong) NSLayoutConstraint* constraintContentViewMaxHeight;
@property(nonatomic, strong) NSLayoutConstraint* constraintContentViewTop;
@property(nonatomic, strong) NSLayoutConstraint* constraintContentViewBottom;
@property(nonatomic, strong) NSLayoutConstraint* constraintContentViewLeft;
@property(nonatomic, strong) NSLayoutConstraint* constraintContentViewRight;
@property(nonatomic, strong) UITapGestureRecognizer* tapGesture;

@end

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
    _backgroundColor = nil;
    _backgroundTintColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
    _backgroundAlpha = 1.0f;
}

#pragma mark - Property

- (void)setOwnerViewController:(UIViewController*)ownerViewController {
    if(_ownerViewController != ownerViewController) {
        _ownerViewController = ownerViewController;
        if(self.isViewLoaded == YES) {
            [self setNeedsStatusBarAppearanceUpdate];
        }
    }
}

- (void)setDialogWindow:(UIWindow*)dialogWindow {
    if(_dialogWindow != dialogWindow) {
        if((_ownerWindow != nil) && (_dialogWindow != nil)) {
            [_ownerWindow makeKeyAndVisible];
        }
        _dialogWindow = dialogWindow;
        if(_dialogWindow != nil) {
            _dialogWindow.windowLevel = _ownerWindow.windowLevel + 0.01f;
            _dialogWindow.backgroundColor = UIColor.clearColor;
            _dialogWindow.glb_userWindow = YES;
            _dialogWindow.rootViewController = self;
            [_dialogWindow makeKeyAndVisible];
            [_dialogWindow layoutIfNeeded];
        }
    }
}

- (void)setBackgroundView:(GLBBlurView*)backgroundView {
    if(_backgroundView != backgroundView) {
        if(_backgroundView != nil) {
            [_backgroundView removeFromSuperview];
        }
        _backgroundView = backgroundView;
        if(_backgroundView != nil) {
            UIViewController* currentViewController = _ownerWindow.glb_currentViewController;
            _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
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
            _backgroundView.blurEnabled = _backgroundBlurred;
            _backgroundView.blurRadius = _backgroundBlurRadius;
            _backgroundView.blurIterations = _backgroundBlurIterations;
            _backgroundView.backgroundColor = _backgroundColor;
            _backgroundView.tintColor = _backgroundTintColor;
            _backgroundView.alpha = _backgroundAlpha;
            [self.view addSubview:_backgroundView];
        }
    }
}

- (void)setTapGesture:(UITapGestureRecognizer*)tapGesture {
    if(_tapGesture != tapGesture) {
        if(_tapGesture != nil) {
            [self.view removeGestureRecognizer:_tapGesture];
        }
        _tapGesture = tapGesture;
        if(_tapGesture != nil) {
            [self.view addGestureRecognizer:_tapGesture];
            _tapGesture.delegate = self;
        }
        
    }
}

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
            [self _clearConstraintContentView];
            [self _updateConstraintContentView];
        }
    }
}

- (void)setContentVerticalOffset:(CGFloat)contentVerticalOffset {
    if(_contentVerticalOffset != contentVerticalOffset) {
        _contentVerticalOffset = contentVerticalOffset;
        if(self.isViewLoaded == YES) {
            [self _updateConstraintContentView];
        }
    }
}

- (void)setContentHorizontalAlignment:(GLBDialogViewControllerAlignmentHorizontal)contentHorizontalAlignment {
    if(_contentHorizontalAlignment != contentHorizontalAlignment) {
        _contentHorizontalAlignment = contentHorizontalAlignment;
        if(self.isViewLoaded == YES) {
            [self _clearConstraintContentView];
            [self _updateConstraintContentView];
        }
    }
}

- (void)setContentHorizontalOffset:(CGFloat)contentHorizontalOffset {
    if(_contentHorizontalOffset != contentHorizontalOffset) {
        _contentHorizontalOffset = contentHorizontalOffset;
        if(self.isViewLoaded == YES) {
            [self _updateConstraintContentView];
        }
    }
}

- (void)setContentWidthBehaviour:(GLBDialogViewControllerSizeBehaviour)contentWidthBehaviour {
    if(_contentWidthBehaviour != contentWidthBehaviour) {
        _contentWidthBehaviour = contentWidthBehaviour;
        if(self.isViewLoaded == YES) {
            [self _clearConstraintContentView];
            [self _updateConstraintContentView];
        }
    }
}

- (void)setContentHeightBehaviour:(GLBDialogViewControllerSizeBehaviour)contentHeightBehaviour {
    if(_contentHeightBehaviour != contentHeightBehaviour) {
        _contentHeightBehaviour = contentHeightBehaviour;
        if(self.isViewLoaded == YES) {
            [self _clearConstraintContentView];
            [self _updateConstraintContentView];
        }
    }
}

- (void)setContentSize:(CGSize)contentSize {
    if(CGSizeEqualToSize(_contentSize, contentSize) == NO) {
        _contentSize = contentSize;
        if(self.isViewLoaded == YES) {
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
        if(self.isViewLoaded == YES) {
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
        if(self.isViewLoaded == YES) {
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
        if(self.isViewLoaded == YES) {
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
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressedBackground:)];
    self.backgroundView = [[GLBBlurView alloc] initWithFrame:self.view.bounds];
    
    if(_contentViewController != nil) {
        [self addChildViewController:_contentViewController];
        _contentViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
        _contentViewController.view.frame = self.view.bounds;
        [self.view addSubview:_contentViewController.view];
        [_contentViewController didMoveToParentViewController:self];
        
        [self _updateConstraintContentView];
    }
}

#pragma mark - Public

- (void)presentViewController:(UIViewController*)viewController withCompletion:(GLBDialogViewControllerBlock)completion {
#ifndef GLOBUS_APP_EXTENSION
    _ownerWindow = UIApplication.sharedApplication.keyWindow;
#endif
    _ownerViewController = viewController;
    self.dialogWindow = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.view.userInteractionEnabled = YES;
    self.view.alpha = 0.0;
    
    _backgroundView.blurRadius = (_backgroundBlurred == YES) ? 0.0f : _backgroundBlurRadius;
    [UIView animateWithDuration:_animationDuration animations:^{
        if(_backgroundBlurred == YES) {
            _backgroundView.blurRadius = _backgroundBlurRadius;
        }
        self.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        _tapGesture.enabled = YES;
        if(completion != nil) {
            completion(self);
        }
    }];
}

- (void)presentWithCompletion:(GLBDialogViewControllerBlock)completion {
#ifndef GLOBUS_APP_EXTENSION
    [self presentViewController:UIApplication.sharedApplication.keyWindow.rootViewController withCompletion:completion];
#else
    [self presentViewController:nil withCompletion:completion];
#endif
}

- (void)dismissWithCompletion:(GLBDialogViewControllerBlock)completion {
    _tapGesture.enabled = NO;
    [UIView animateWithDuration:_animationDuration animations:^{
        if(_backgroundBlurred == YES) {
            _backgroundView.blurRadius = 0.0f;
        }
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.dialogWindow = nil;
        if(_dismiss != nil) {
            _dismiss(self);
        }
        if(completion != nil) {
            completion(self);
        }
    }];
}

#pragma mark - Private

- (void)_updateConstraintContentView {
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

- (void)_clearConstraintContentView {
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
