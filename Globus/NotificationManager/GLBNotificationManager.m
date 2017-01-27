/*--------------------------------------------------*/

#import "GLBNotificationManager.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBNotificationWindow : UIWindow
@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface GLBNotificationController : UIViewController {
@protected
    __weak UIWindow* _parentWindow;
    UIStatusBarStyle _statusBarStyle;
    NSMutableArray< GLBNotificationView* >* _displayQueue;
    NSMutableArray< GLBNotificationView* >* _queue;
}

@property(nonatomic, weak) UIWindow* parentWindow;
@property(nonatomic) UIStatusBarStyle statusBarStyle;
@property(nonatomic) GLBNotificationManagerDisplayType displayType;

@property(nonatomic, readonly, strong) UIView* rootView;
@property(nonatomic, strong) NSLayoutConstraint* constraintRootTop;
@property(nonatomic, strong) NSLayoutConstraint* constraintRootLeft;
@property(nonatomic, strong) NSLayoutConstraint* constraintRootRight;

@property(nonatomic, readonly, strong) UIView* contentView;
@property(nonatomic, strong) NSLayoutConstraint* constraintContentTop;
@property(nonatomic, strong) NSLayoutConstraint* constraintContentLeft;
@property(nonatomic, strong) NSLayoutConstraint* constraintContentRight;
@property(nonatomic, strong) NSLayoutConstraint* constraintContentBottom;
@property(nonatomic, strong) NSLayoutConstraint* constraintContentHeight;

@property(nonatomic, strong) UIView< GLBNotificationDecorViewProtocol >* topDecorView;
@property(nonatomic, strong) NSLayoutConstraint* constraintTopDecorTop;
@property(nonatomic, strong) NSLayoutConstraint* constraintTopDecorLeft;
@property(nonatomic, strong) NSLayoutConstraint* constraintTopDecorRight;
@property(nonatomic, strong) NSLayoutConstraint* constraintTopDecorHeight;

@property(nonatomic, strong) UIView< GLBNotificationDecorViewProtocol >* bottomDecorView;
@property(nonatomic, strong) NSLayoutConstraint* constraintBottomDecorLeft;
@property(nonatomic, strong) NSLayoutConstraint* constraintBottomDecorRight;
@property(nonatomic, strong) NSLayoutConstraint* constraintBottomDecorBottom;
@property(nonatomic, strong) NSLayoutConstraint* constraintBottomDecorHeight;

@property(nonatomic, strong) UIPanGestureRecognizer* panGesture;

@property(nonatomic, readonly, strong) NSArray< GLBNotificationView* >* visibleViews;

- (GLBNotificationView*)showView:(UIView*)view duration:(NSTimeInterval)duration pressed:(GLBNotificationViewBlock)pressed complete:(GLBNotificationViewBlock)complete;
- (void)hideNotificationView:(GLBNotificationView*)notificationView animated:(BOOL)animated complete:(GLBSimpleBlock)complete;
- (void)hdeAllAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface GLBNotificationView ()

@property(nonatomic, weak) GLBNotificationController* controller;
@property(nonatomic, strong) NSLayoutConstraint* constraintControllerTop;
@property(nonatomic, strong) NSLayoutConstraint* constraintControllerLeft;
@property(nonatomic, strong) NSLayoutConstraint* constraintControllerRight;
@property(nonatomic, strong) NSLayoutConstraint* constraintControllerBottom;
@property(nonatomic, strong) UITapGestureRecognizer* tapGesture;
@property(nonatomic, strong) NSTimer* timer;

@property(nonatomic, strong) UIView< GLBNotificationViewProtocol >* view;
@property(nonatomic, strong) NSLayoutConstraint* constraintViewCenterX;
@property(nonatomic, strong) NSLayoutConstraint* constraintViewCenterY;
@property(nonatomic, strong) NSLayoutConstraint* constraintViewWidth;
@property(nonatomic, strong) NSLayoutConstraint* constraintViewHeight;
@property(nonatomic) NSTimeInterval duration;
@property(nonatomic, copy) GLBNotificationViewBlock pressed;

- (instancetype)initWithController:(GLBNotificationController*)controller view:(UIView*)view duration:(NSTimeInterval)duration pressed:(GLBNotificationViewBlock)pressed;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface GLBNotificationManager () {
@protected
    GLBNotificationWindow* _window;
    GLBNotificationController* _controller;
}

@property(nonatomic, readonly, strong) GLBNotificationWindow* window;
@property(nonatomic, readonly, strong) GLBNotificationController* controller;

+ (instancetype)shared;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBNotificationWindow

#pragma mark - Init / Free

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil) {
        self.backgroundColor = UIColor.clearColor;
        self.glb_userWindow = YES;
    }
    return self;
}

#pragma mark - Public override

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event {
    UIView* view = [super hitTest:point withEvent:event];
    if(view == self.rootViewController.view) {
        view = nil;
    }
    return view;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

static NSTimeInterval GLBNotificationController_ShowDutation = 0.1f;
static NSTimeInterval GLBNotificationController_HideDutation = 0.2f;

/*--------------------------------------------------*/

@implementation GLBNotificationController

#pragma mark - Synthesize

@synthesize parentWindow = _parentWindow;
@synthesize statusBarStyle = _statusBarStyle;
@synthesize rootView = _rootView;
@synthesize constraintRootTop = _constraintRootTop;
@synthesize constraintRootLeft = _constraintRootLeft;
@synthesize constraintRootRight = _constraintRootRight;
@synthesize contentView = _contentView;
@synthesize constraintContentTop = _constraintContentTop;
@synthesize constraintContentLeft = _constraintContentLeft;
@synthesize constraintContentRight = _constraintContentRight;
@synthesize constraintContentBottom = _constraintContentBottom;
@synthesize constraintContentHeight = _constraintContentHeight;
@synthesize topDecorView = _topDecorView;
@synthesize constraintTopDecorTop = _constraintTopDecorTop;
@synthesize constraintTopDecorLeft = _constraintTopDecorLeft;
@synthesize constraintTopDecorRight = _constraintTopDecorRight;
@synthesize constraintTopDecorHeight = _constraintTopDecorHeight;
@synthesize bottomDecorView = _bottomDecorView;
@synthesize constraintBottomDecorLeft = _constraintBottomDecorLeft;
@synthesize constraintBottomDecorRight = _constraintBottomDecorRight;
@synthesize constraintBottomDecorBottom = _constraintBottomDecorBottom;
@synthesize constraintBottomDecorHeight = _constraintBottomDecorHeight;

#pragma mark - Init / Free

- (instancetype)initWithNibName:(NSString*)nibName bundle:(NSBundle*)bundle {
    self = [super initWithNibName:nibName bundle:bundle];
    if(self != nil) {
        _statusBarStyle = UIStatusBarStyleDefault;
        _displayQueue = [NSMutableArray array];
        _queue = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Property

- (void)setParentWindow:(UIWindow*)parentWindow {
    if(_parentWindow != parentWindow) {
        _parentWindow = parentWindow;
        if(self.isViewLoaded == YES) {
            [self setNeedsStatusBarAppearanceUpdate];
        }
    }
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    if(_statusBarStyle != statusBarStyle) {
        _statusBarStyle = statusBarStyle;
        if(self.isViewLoaded == YES) {
            [self setNeedsStatusBarAppearanceUpdate];
        }
    }
}

- (void)setRootView:(UIView*)rootView {
    if(_rootView != rootView) {
        if(_rootView != nil) {
            [_rootView removeFromSuperview];
        }
        _rootView = rootView;
        if(_rootView != nil) {
            _rootView.translatesAutoresizingMaskIntoConstraints = NO;
            _rootView.glb_verticalContentCompressionResistancePriority = UILayoutPriorityRequired;
            _rootView.backgroundColor = UIColor.clearColor;
            _rootView.clipsToBounds = YES;
            [self.view addSubview:_rootView];
        }
    }
}

- (void)setConstraintRootTop:(NSLayoutConstraint*)constraintRootTop {
    if(_constraintRootTop != constraintRootTop) {
        if(_constraintRootTop != nil) {
            [self.view removeConstraint:_constraintRootTop];
        }
        _constraintRootTop = constraintRootTop;
        if(_constraintRootTop != nil) {
            [self.view addConstraint:_constraintRootTop];
        }
    }
}

- (void)setConstraintRootLeft:(NSLayoutConstraint*)constraintRootLeft {
    if(_constraintRootLeft != constraintRootLeft) {
        if(_constraintRootLeft != nil) {
            [self.view removeConstraint:_constraintRootLeft];
        }
        _constraintRootLeft = constraintRootLeft;
        if(_constraintRootLeft != nil) {
            [self.view addConstraint:_constraintRootLeft];
        }
    }
}

- (void)setConstraintRootRight:(NSLayoutConstraint*)constraintRootRight {
    if(_constraintRootRight != constraintRootRight) {
        if(_constraintRootRight != nil) {
            [self.view removeConstraint:_constraintRootRight];
        }
        _constraintRootRight = constraintRootRight;
        if(_constraintRootRight != nil) {
            [self.view addConstraint:_constraintRootRight];
        }
    }
}

- (void)setContentView:(UIView*)contentView {
    if(_contentView != contentView) {
        if(_contentView != nil) {
            [_contentView removeFromSuperview];
        }
        _contentView = contentView;
        if(_contentView != nil) {
            _contentView.translatesAutoresizingMaskIntoConstraints = NO;
            _contentView.glb_verticalContentCompressionResistancePriority = UILayoutPriorityDefaultHigh;
            _contentView.backgroundColor = UIColor.clearColor;
            _contentView.clipsToBounds = YES;
            [_rootView addSubview:_contentView];
        }
    }
}

- (void)setConstraintContentTop:(NSLayoutConstraint*)constraintContentTop {
    if(_constraintContentTop != constraintContentTop) {
        if(_constraintContentTop != nil) {
            [_rootView removeConstraint:_constraintContentTop];
        }
        _constraintContentTop = constraintContentTop;
        if(_constraintContentTop != nil) {
            [_rootView addConstraint:_constraintContentTop];
        }
    }
}

- (void)setConstraintContentLeft:(NSLayoutConstraint*)constraintContentLeft {
    if(_constraintContentLeft != constraintContentLeft) {
        if(_constraintContentLeft != nil) {
            [_rootView removeConstraint:_constraintContentLeft];
        }
        _constraintContentLeft = constraintContentLeft;
        if(_constraintContentLeft != nil) {
            [_rootView addConstraint:_constraintContentLeft];
        }
    }
}

- (void)setConstraintContentRight:(NSLayoutConstraint*)constraintContentRight {
    if(_constraintContentRight != constraintContentRight) {
        if(_constraintContentRight != nil) {
            [_rootView removeConstraint:_constraintContentRight];
        }
        _constraintContentRight = constraintContentRight;
        if(_constraintContentRight != nil) {
            [_rootView addConstraint:_constraintContentRight];
        }
    }
}

- (void)setConstraintContentBottom:(NSLayoutConstraint*)constraintContentBottom {
    if(_constraintContentBottom != constraintContentBottom) {
        if(_constraintContentBottom != nil) {
            [_rootView removeConstraint:_constraintContentBottom];
        }
        _constraintContentBottom = constraintContentBottom;
        if(_constraintContentBottom != nil) {
            [_rootView addConstraint:_constraintContentBottom];
        }
    }
}

- (void)setConstraintContentHeight:(NSLayoutConstraint*)constraintContentHeight {
    if(_constraintContentHeight != constraintContentHeight) {
        if(_constraintContentHeight != nil) {
            [_contentView removeConstraint:_constraintContentHeight];
        }
        _constraintContentHeight = constraintContentHeight;
        if(_constraintContentHeight != nil) {
            [_contentView addConstraint:_constraintContentHeight];
        }
    }
}

- (void)setTopDecorView:(UIView< GLBNotificationDecorViewProtocol >*)topDecorView {
    if(_topDecorView != topDecorView) {
        if(_topDecorView != nil) {
            self.constraintTopDecorTop = nil;
            self.constraintTopDecorLeft = nil;
            self.constraintTopDecorRight = nil;
            self.constraintTopDecorHeight = nil;
            [_topDecorView removeFromSuperview];
        }
        _topDecorView = topDecorView;
        if(_topDecorView != nil) {
            _topDecorView.translatesAutoresizingMaskIntoConstraints = NO;
            if(self.isViewLoaded == YES) {
                [_rootView addSubview:_topDecorView];
            }
        }
        if(self.isViewLoaded == YES) {
            [self _updateConstraint];
        }
    }
}

- (void)setConstraintTopDecorTop:(NSLayoutConstraint*)constraintTopDecorTop {
    if(_constraintTopDecorTop != constraintTopDecorTop) {
        if(_constraintTopDecorTop != nil) {
            [_rootView removeConstraint:_constraintTopDecorTop];
        }
        _constraintTopDecorTop = constraintTopDecorTop;
        if(_constraintTopDecorTop != nil) {
            [_rootView addConstraint:_constraintTopDecorTop];
        }
    }
}

- (void)setConstraintTopDecorLeft:(NSLayoutConstraint*)constraintTopDecorLeft {
    if(_constraintTopDecorLeft != constraintTopDecorLeft) {
        if(_constraintTopDecorLeft != nil) {
            [_rootView removeConstraint:_constraintTopDecorLeft];
        }
        _constraintTopDecorLeft = constraintTopDecorLeft;
        if(_constraintTopDecorLeft != nil) {
            [_rootView addConstraint:_constraintTopDecorLeft];
        }
    }
}

- (void)setConstraintTopDecorRight:(NSLayoutConstraint*)constraintTopDecorRight {
    if(_constraintTopDecorRight != constraintTopDecorRight) {
        if(_constraintTopDecorRight != nil) {
            [_rootView removeConstraint:_constraintTopDecorRight];
        }
        _constraintTopDecorRight = constraintTopDecorRight;
        if(_constraintTopDecorRight != nil) {
            [_rootView addConstraint:_constraintTopDecorRight];
        }
    }
}

- (void)setConstraintTopDecorHeight:(NSLayoutConstraint*)constraintTopDecorHeight {
    if(_constraintTopDecorHeight != constraintTopDecorHeight) {
        if(_constraintTopDecorHeight != nil) {
            [_topDecorView removeConstraint:_constraintTopDecorHeight];
        }
        _constraintTopDecorHeight = constraintTopDecorHeight;
        if(_constraintTopDecorHeight != nil) {
            [_topDecorView addConstraint:_constraintTopDecorHeight];
        }
    }
}

- (void)setBottomDecorView:(UIView< GLBNotificationDecorViewProtocol >*)bottomDecorView {
    if(_bottomDecorView != bottomDecorView) {
        if(_bottomDecorView != nil) {
            self.constraintBottomDecorLeft = nil;
            self.constraintBottomDecorRight = nil;
            self.constraintBottomDecorBottom = nil;
            self.constraintBottomDecorHeight = nil;
            [_bottomDecorView removeFromSuperview];
        }
        _bottomDecorView = bottomDecorView;
        if(_bottomDecorView != nil) {
            _bottomDecorView.translatesAutoresizingMaskIntoConstraints = NO;
            if(self.isViewLoaded == YES) {
                [_rootView addSubview:_bottomDecorView];
            }
        }
        if(self.isViewLoaded == YES) {
            [self _updateConstraint];
        }
    }
}

- (void)setConstraintBottomDecorLeft:(NSLayoutConstraint*)constraintBottomDecorLeft {
    if(_constraintBottomDecorLeft != constraintBottomDecorLeft) {
        if(_constraintBottomDecorLeft != nil) {
            [_rootView removeConstraint:_constraintBottomDecorLeft];
        }
        _constraintBottomDecorLeft = constraintBottomDecorLeft;
        if(_constraintBottomDecorLeft != nil) {
            [_rootView addConstraint:_constraintBottomDecorLeft];
        }
    }
}

- (void)setConstraintBottomDecorRight:(NSLayoutConstraint*)constraintBottomDecorRight {
    if(_constraintBottomDecorRight != constraintBottomDecorRight) {
        if(_constraintBottomDecorRight != nil) {
            [_rootView removeConstraint:_constraintBottomDecorRight];
        }
        _constraintBottomDecorRight = constraintBottomDecorRight;
        if(_constraintBottomDecorRight != nil) {
            [_rootView addConstraint:_constraintBottomDecorRight];
        }
    }
}

- (void)setConstraintBottomDecorBottom:(NSLayoutConstraint*)constraintBottomDecorBottom {
    if(_constraintBottomDecorBottom != constraintBottomDecorBottom) {
        if(_constraintBottomDecorBottom != nil) {
            [_rootView removeConstraint:_constraintBottomDecorBottom];
        }
        _constraintBottomDecorBottom = constraintBottomDecorBottom;
        if(_constraintBottomDecorBottom != nil) {
            [_rootView addConstraint:_constraintBottomDecorBottom];
        }
    }
}

- (void)setConstraintBottomDecorHeight:(NSLayoutConstraint*)constraintBottomDecorHeight {
    if(_constraintBottomDecorHeight != constraintBottomDecorHeight) {
        if(_constraintBottomDecorHeight != nil) {
            [_bottomDecorView removeConstraint:_constraintBottomDecorHeight];
        }
        _constraintBottomDecorHeight = constraintBottomDecorHeight;
        if(_constraintBottomDecorHeight != nil) {
            [_bottomDecorView addConstraint:_constraintBottomDecorHeight];
        }
    }
}

- (NSArray< GLBNotificationView* >*)visibleViews {
    return _displayQueue.copy;
}

#pragma mark - Public override

- (void)loadView {
    [super loadView];
    
    CGRect bounds = self.view.bounds;
    self.view.backgroundColor = UIColor.clearColor;
    
    if(_rootView == nil) {
        self.rootView = [[UIView alloc] initWithFrame:CGRectMake(
            bounds.origin.x,
            bounds.origin.y,
            bounds.size.width,
            0.0f
        )];
    }
    if(_contentView == nil) {
        self.contentView = [[UIView alloc] initWithFrame:_rootView.bounds];
    }
    if(_topDecorView != nil) {
        [_rootView addSubview:_topDecorView];
    }
    if(_bottomDecorView != nil) {
        [_rootView addSubview:_bottomDecorView];
    }
    [self _updateConstraint];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if(_queue.count > 0) {
        return _statusBarStyle;
    }
    return [_parentWindow.rootViewController preferredStatusBarStyle];
}

- (BOOL)prefersStatusBarHidden {
    return [_parentWindow.rootViewController prefersStatusBarHidden];
}

- (BOOL)shouldAutorotate {
    return [_parentWindow.rootViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [_parentWindow.rootViewController supportedInterfaceOrientations];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation {
    return [_parentWindow.rootViewController shouldAutorotateToInterfaceOrientation:orientation];
}

#pragma clang diagnostic pop

#pragma mark - Public

- (GLBNotificationView*)showView:(UIView< GLBNotificationViewProtocol >*)view duration:(NSTimeInterval)duration pressed:(GLBNotificationViewBlock)pressed complete:(GLBNotificationViewBlock)complete {
    [self glb_loadViewIfNeed];
    GLBNotificationView* notificationView = [[GLBNotificationView alloc] initWithController:self view:view duration:duration pressed:pressed];
    if(notificationView != nil) {
        switch(_displayType) {
            case GLBNotificationManagerDisplayTypeList:
                [_queue insertObject:notificationView atIndex:0];
                [_displayQueue insertObject:notificationView atIndex:0];
                [self _showNotificationView:notificationView first:(_queue.count == 1) animated:YES complete:nil];
                break;
            case GLBNotificationManagerDisplayTypeStack:
                [_queue insertObject:notificationView atIndex:0];
                if(_queue.count == 1) {
                    [_displayQueue insertObject:notificationView atIndex:0];
                    [self _showNotificationView:notificationView first:(_queue.count == 1) animated:YES complete:nil];
                }
                break;
        }
    }
    if(complete != nil) {
        complete(notificationView);
    }
    return notificationView;
}

- (void)hideNotificationView:(GLBNotificationView*)notificationView animated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    [self glb_loadViewIfNeed];
    if([_queue containsObject:notificationView] == YES) {
        if([_displayQueue containsObject:notificationView] == YES) {
            [self _hideNotificationView:notificationView last:(_queue.count == 1) animated:animated complete:^{
                switch(_displayType) {
                    case GLBNotificationManagerDisplayTypeList:
                        break;
                    case GLBNotificationManagerDisplayTypeStack: {
                        GLBNotificationView* nextNotificationView = _queue.lastObject;
                        if(nextNotificationView != nil) {
                            [_displayQueue insertObject:nextNotificationView atIndex:0];
                            [self _showNotificationView:nextNotificationView first:NO animated:animated complete:nil];
                        }
                        break;
                    }
                }
                if(complete != nil) {
                    complete();
                }

            }];
            [_displayQueue removeObject:notificationView];
        }
        [_queue removeObject:notificationView];
    }
}

- (void)hdeAllAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    [self glb_loadViewIfNeed];
    if(_queue.count > 0) {
        [_displayQueue glb_each:^(GLBNotificationView* notificationView) {
            [self _hideNotificationView:notificationView last:(_displayQueue.count == 1) animated:animated complete:nil];
            [_displayQueue removeObject:notificationView];
            [_queue removeObject:notificationView];
        } options:NSEnumerationReverse];
        [_displayQueue removeAllObjects];
        [_queue removeAllObjects];
        [self setNeedsStatusBarAppearanceUpdate];
    }
    if(complete != nil) {
        complete();
    }
}

#pragma mark - Private

- (void)_updateConstraint {
    if(_queue.count > 0) {
        self.constraintRootTop = [NSLayoutConstraint constraintWithItem:_rootView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view attribute:NSLayoutAttributeTop
                                                             multiplier:1.0f constant:0.0f];
    } else {
        self.constraintRootTop = [NSLayoutConstraint constraintWithItem:_rootView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view attribute:NSLayoutAttributeTop
                                                             multiplier:1.0f constant:0.0f];
    }
    self.constraintRootLeft = [NSLayoutConstraint constraintWithItem:_rootView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view attribute:NSLayoutAttributeLeft
                                                          multiplier:1.0f constant:0.0f];
    self.constraintRootRight = [NSLayoutConstraint constraintWithItem:_rootView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual
                                                               toItem:self.view attribute:NSLayoutAttributeRight
                                                           multiplier:1.0f constant:0.0f];
    if(_topDecorView != nil) {
        self.constraintTopDecorTop = [NSLayoutConstraint constraintWithItem:_topDecorView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual
                                                                     toItem:_rootView attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0f constant:0.0f];
        self.constraintTopDecorLeft = [NSLayoutConstraint constraintWithItem:_topDecorView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual
                                                                      toItem:_rootView attribute:NSLayoutAttributeLeft
                                                                  multiplier:1.0f constant:0.0f];
        self.constraintTopDecorRight = [NSLayoutConstraint constraintWithItem:_topDecorView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual
                                                                       toItem:_rootView attribute:NSLayoutAttributeRight
                                                                   multiplier:1.0f constant:0.0f];
        self.constraintTopDecorHeight = [NSLayoutConstraint constraintWithItem:_topDecorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual
                                                                        toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                                    multiplier:1.0f constant:[_topDecorView height]];
        
        self.constraintContentTop = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual
                                                                    toItem:_topDecorView attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0f constant:0.0f];
    } else {
        self.constraintTopDecorTop = nil;
        self.constraintTopDecorLeft = nil;
        self.constraintTopDecorRight = nil;
        self.constraintTopDecorHeight = nil;
        
        self.constraintContentTop = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual
                                                                    toItem:_rootView attribute:NSLayoutAttributeTop
                                                                multiplier:1.0f constant:0.0f];
    }
    self.constraintContentLeft = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual
                                                                 toItem:_rootView attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0f constant:0.0f];
    self.constraintContentRight = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual
                                                                  toItem:_rootView attribute:NSLayoutAttributeRight
                                                              multiplier:1.0f constant:0.0f];
    if(_bottomDecorView != nil) {
        self.constraintBottomDecorLeft = [NSLayoutConstraint constraintWithItem:_bottomDecorView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual
                                                                         toItem:_rootView attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0f constant:0.0f];
        self.constraintBottomDecorRight = [NSLayoutConstraint constraintWithItem:_bottomDecorView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual
                                                                          toItem:_rootView attribute:NSLayoutAttributeRight
                                                                      multiplier:1.0f constant:0.0f];
        self.constraintBottomDecorBottom = [NSLayoutConstraint constraintWithItem:_bottomDecorView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual
                                                                           toItem:_rootView attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0f constant:0.0f];
        self.constraintBottomDecorHeight = [NSLayoutConstraint constraintWithItem:_bottomDecorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1.0f constant:[_bottomDecorView height]];
        
        self.constraintContentBottom = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual
                                                                       toItem:_bottomDecorView attribute:NSLayoutAttributeTop
                                                                   multiplier:1.0f constant:0.0f];
    } else {
        self.constraintBottomDecorLeft = nil;
        self.constraintBottomDecorRight = nil;
        self.constraintBottomDecorBottom = nil;
        self.constraintBottomDecorHeight = nil;
        
        self.constraintContentBottom = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual
                                                                       toItem:_rootView attribute:NSLayoutAttributeBottom
                                                                   multiplier:1.0f constant:0.0f];
    }
    if(_displayQueue.count == 0) {
        self.constraintContentHeight = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1.0f constant:0.0f];
    } else {
        self.constraintContentHeight = nil;
    }
}

- (void)_willShowNotificationView:(GLBNotificationView*)notificationView prevNotificationView:(GLBNotificationView*)prevNotificationView nextNotificationView:(GLBNotificationView*)nextNotificationView first:(BOOL)first animated:(BOOL)animated {
    if(first == YES) {
        if(animated == YES) {
            self.constraintRootTop = [NSLayoutConstraint constraintWithItem:_rootView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0f constant:0.0f];
        } else {
            self.constraintRootTop = [NSLayoutConstraint constraintWithItem:_rootView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0f constant:0.0f];
        }
        notificationView.constraintControllerTop = [NSLayoutConstraint constraintWithItem:notificationView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual
                                                                                   toItem:_contentView attribute:NSLayoutAttributeTop
                                                                               multiplier:1.0 constant:0.0];
    } else {
        if(animated == YES) {
            if(prevNotificationView != nil) {
                notificationView.constraintControllerTop = [NSLayoutConstraint constraintWithItem:notificationView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual
                                                                                           toItem:prevNotificationView attribute:NSLayoutAttributeBottom
                                                                                       multiplier:1.0 constant:0.0];
            } else {
                notificationView.constraintControllerTop = [NSLayoutConstraint constraintWithItem:notificationView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual
                                                                                           toItem:_contentView attribute:NSLayoutAttributeTop
                                                                                       multiplier:1.0 constant:0.0];
            }
        }
    }
    notificationView.constraintControllerLeft = [NSLayoutConstraint constraintWithItem:notificationView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual
                                                                                toItem:_contentView attribute:NSLayoutAttributeLeft
                                                                            multiplier:1.0 constant:0.0];
    notificationView.constraintControllerRight = [NSLayoutConstraint constraintWithItem:notificationView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual
                                                                                 toItem:_contentView attribute:NSLayoutAttributeRight
                                                                             multiplier:1.0 constant:0.0];
}

- (void)_didShowNotificationView:(GLBNotificationView*)notificationView prevNotificationView:(GLBNotificationView*)prevNotificationView nextNotificationView:(GLBNotificationView*)nextNotificationView first:(BOOL)first animated:(BOOL)animated {
    self.constraintContentHeight = nil;
    if(first == YES) {
        if(animated == YES) {
            self.constraintRootTop = [NSLayoutConstraint constraintWithItem:_rootView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0f constant:0.0f];
        }
        notificationView.constraintControllerBottom = [NSLayoutConstraint constraintWithItem:notificationView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual
                                                                                      toItem:_contentView attribute:NSLayoutAttributeBottom
                                                                                  multiplier:1.0 constant:0.0];
    } else {
        if(prevNotificationView != nil) {
            notificationView.constraintControllerTop = [NSLayoutConstraint constraintWithItem:notificationView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual
                                                                                       toItem:prevNotificationView attribute:NSLayoutAttributeBottom
                                                                                   multiplier:1.0 constant:0.0];
        } else {
            notificationView.constraintControllerTop = [NSLayoutConstraint constraintWithItem:notificationView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual
                                                                                       toItem:_contentView attribute:NSLayoutAttributeTop
                                                                                   multiplier:1.0 constant:0.0];
        }
        if(nextNotificationView != nil) {
            nextNotificationView.constraintControllerTop = [NSLayoutConstraint constraintWithItem:nextNotificationView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual
                                                                                           toItem:notificationView attribute:NSLayoutAttributeBottom
                                                                                       multiplier:1.0 constant:0.0];
        } else {
            notificationView.constraintControllerBottom = [NSLayoutConstraint constraintWithItem:notificationView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual
                                                                                          toItem:_contentView attribute:NSLayoutAttributeBottom
                                                                                      multiplier:1.0 constant:0.0];
        }
    }
}

- (void)_showNotificationView:(GLBNotificationView*)notificationView first:(BOOL)first animated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    GLBNotificationView* prevNotificationView = [_displayQueue glb_prevObjectOfObject:notificationView];
    GLBNotificationView* nextNotificationView = [_displayQueue glb_nextObjectOfObject:notificationView];
    [_contentView addSubview:notificationView];
    [self _willShowNotificationView:notificationView prevNotificationView:prevNotificationView nextNotificationView:nextNotificationView first:first animated:animated];
    if(animated == YES) {
        [self.view layoutIfNeeded];
    }
    [self _didShowNotificationView:notificationView prevNotificationView:prevNotificationView nextNotificationView:nextNotificationView first:first animated:animated];
    [notificationView willShow];
    if(animated == YES) {
        [UIView animateWithDuration:GLBNotificationController_ShowDutation delay:0.0 options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut) animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [notificationView didShow];
            if(complete != nil) {
                complete();
            }
        }];
    } else {
        [self setNeedsStatusBarAppearanceUpdate];
        [notificationView didShow];
        if(complete != nil) {
            complete();
        }
    }
}

- (void)_willHideNotificationView:(GLBNotificationView*)notificationView prevNotificationView:(GLBNotificationView*)prevNotificationView nextNotificationView:(GLBNotificationView*)nextNotificationView last:(BOOL)last animated:(BOOL)animated {
    if(last == YES) {
        self.constraintRootTop = [NSLayoutConstraint constraintWithItem:_rootView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view attribute:NSLayoutAttributeTop
                                                             multiplier:1.0f constant:0.0f];
    } else {
        if(prevNotificationView != nil) {
            notificationView.constraintControllerTop = [NSLayoutConstraint constraintWithItem:notificationView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual
                                                                                       toItem:prevNotificationView attribute:NSLayoutAttributeBottom
                                                                                   multiplier:1.0 constant:0.0];
        } else {
            notificationView.constraintControllerTop = [NSLayoutConstraint constraintWithItem:notificationView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual
                                                                                       toItem:_contentView attribute:NSLayoutAttributeTop
                                                                                   multiplier:1.0 constant:0.0];
        }
        if(nextNotificationView != nil) {
            if(prevNotificationView != nil) {
                nextNotificationView.constraintControllerTop = [NSLayoutConstraint constraintWithItem:nextNotificationView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual
                                                                                               toItem:prevNotificationView attribute:NSLayoutAttributeBottom
                                                                                           multiplier:1.0 constant:0.0];
            } else {
                nextNotificationView.constraintControllerTop = [NSLayoutConstraint constraintWithItem:nextNotificationView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual
                                                                                               toItem:_contentView attribute:NSLayoutAttributeTop
                                                                                           multiplier:1.0 constant:0.0];
            }
        } else if(prevNotificationView != nil) {
            notificationView.constraintControllerBottom = nil;
            
            prevNotificationView.constraintControllerBottom = [NSLayoutConstraint constraintWithItem:prevNotificationView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual
                                                                                              toItem:_contentView attribute:NSLayoutAttributeBottom
                                                                                          multiplier:1.0 constant:0.0];
        }
    }
}

- (void)_didHideNotificationView:(GLBNotificationView*)notificationView prevNotificationView:(GLBNotificationView*)prevNotificationView nextNotificationView:(GLBNotificationView*)nextNotificationView last:(BOOL)last animated:(BOOL)animated {
    notificationView.constraintControllerTop = nil;
    notificationView.constraintControllerLeft = nil;
    notificationView.constraintControllerRight = nil;
    notificationView.constraintControllerBottom = nil;
    
    if((prevNotificationView == nil) && (nextNotificationView == nil)) {
        self.constraintContentHeight = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1.0f constant:0.0f];
    }
}

- (void)_hideNotificationView:(GLBNotificationView*)notificationView last:(BOOL)last animated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    GLBNotificationView* prevNotificationView = [_displayQueue glb_prevObjectOfObject:notificationView];
    GLBNotificationView* nextNotificationView = [_displayQueue glb_nextObjectOfObject:notificationView];
    [self _willHideNotificationView:notificationView prevNotificationView:prevNotificationView nextNotificationView:nextNotificationView last:last animated:animated];
    [notificationView willHide];
    if(animated == YES) {
        [UIView animateWithDuration:GLBNotificationController_HideDutation delay:0.0 options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut) animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self _didHideNotificationView:notificationView prevNotificationView:prevNotificationView nextNotificationView:nextNotificationView last:last animated:animated];
            [self setNeedsStatusBarAppearanceUpdate];
            [notificationView removeFromSuperview];
            [notificationView didHide];
            if(complete != nil) {
                complete();
            }
        }];
    } else {
        [self _didHideNotificationView:notificationView prevNotificationView:prevNotificationView nextNotificationView:nextNotificationView last:last animated:animated];
        [self setNeedsStatusBarAppearanceUpdate];
        [notificationView removeFromSuperview];
        [notificationView didHide];
        if(complete != nil) {
            complete();
        }
    }
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBNotificationView

#pragma mark - Synthesize

@synthesize controller = _controller;
@synthesize constraintControllerTop = _constraintControllerTop;
@synthesize constraintControllerLeft = _constraintControllerLeft;
@synthesize constraintControllerRight = _constraintControllerRight;
@synthesize tapGesture = _tapGesture;
@synthesize timer = _timer;
@synthesize view = _view;
@synthesize constraintViewCenterX = _constraintViewCenterX;
@synthesize constraintViewCenterY = _constraintViewCenterY;
@synthesize constraintViewWidth = _constraintViewWidth;
@synthesize constraintViewHeight = _constraintViewHeight;
@synthesize duration = _duration;
@synthesize pressed = _pressed;

#pragma mark - Init / Free

- (instancetype)initWithController:(GLBNotificationController*)controller view:(UIView< GLBNotificationViewProtocol >*)view duration:(NSTimeInterval)duration pressed:(GLBNotificationViewBlock)pressed {
    self = [super initWithFrame:view.bounds];
    if(self != nil) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.glb_verticalContentCompressionResistancePriority = UILayoutPriorityDefaultHigh;
        
        _controller = controller;
        self.view = view;
        _duration = duration;
        _pressed = [pressed copy];
    }
    return self;
}

#pragma mark - Public override

- (void)updateConstraints {
    if(_view != nil) {
        if(_constraintViewCenterX == nil) {
            _constraintViewCenterX = [_view glb_addConstraintAttribute:NSLayoutAttributeCenterX
                                                              relation:NSLayoutRelationEqual
                                                             attribute:NSLayoutAttributeCenterX
                                                              constant:0.0];
        }
        if(_constraintViewCenterY == nil) {
            _constraintViewCenterY = [_view glb_addConstraintAttribute:NSLayoutAttributeCenterY
                                                              relation:NSLayoutRelationEqual
                                                             attribute:NSLayoutAttributeCenterY
                                                              constant:0.0];
        }
        if(_constraintViewWidth == nil) {
            _constraintViewWidth = [_view glb_addConstraintAttribute:NSLayoutAttributeWidth
                                                            relation:NSLayoutRelationEqual
                                                           attribute:NSLayoutAttributeWidth
                                                            constant:0.0];
        }
        if(_constraintViewHeight == nil) {
            _constraintViewHeight = [_view glb_addConstraintAttribute:NSLayoutAttributeHeight
                                                             relation:NSLayoutRelationEqual
                                                            attribute:NSLayoutAttributeHeight
                                                             constant:0.0];
        }
    } else {
        if(_constraintViewCenterX != nil) {
            [self removeConstraint:_constraintViewCenterX];
            _constraintViewCenterX = nil;
        }
        if(_constraintViewCenterY != nil) {
            [self removeConstraint:_constraintViewCenterY];
            _constraintViewCenterY = nil;
        }
        if(_constraintViewWidth != nil) {
            [self removeConstraint:_constraintViewWidth];
            _constraintViewWidth = nil;
        }
        if(_constraintViewHeight != nil) {
            [self removeConstraint:_constraintViewHeight];
            _constraintViewHeight = nil;
        }
    }
    [super updateConstraints];
}

#pragma mark - Property

- (void)setView:(UIView< GLBNotificationViewProtocol >*)view {
    if(_view != view) {
        if(_view != nil) {
            _view.glb_notificationView = nil;
            [_view removeFromSuperview];
        }
        _view = view;
        if(_view != nil) {
            _view.glb_notificationView = self;
            _view.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:_view];
        }
        [self setNeedsUpdateConstraints];
    }
}

- (void)setTimer:(NSTimer*)timer {
    if(_timer != timer) {
        if(_timer != nil) {
            [_timer invalidate];
        }
        _timer = timer;
        if(_timer != nil) {
            [NSRunLoop.mainRunLoop addTimer:_timer forMode:NSRunLoopCommonModes];
        }
    }
}

- (void)setConstraintControllerTop:(NSLayoutConstraint*)constraintControllerTop {
    if(_constraintControllerTop != constraintControllerTop) {
        if(_constraintControllerTop != nil) {
            [self.superview removeConstraint:_constraintControllerTop];
        }
        _constraintControllerTop = constraintControllerTop;
        if(_constraintControllerTop != nil) {
            [self.superview addConstraint:_constraintControllerTop];
        }
    }
}

- (void)setConstraintControllerLeft:(NSLayoutConstraint*)constraintControllerLeft {
    if(_constraintControllerLeft != constraintControllerLeft) {
        if(_constraintControllerLeft != nil) {
            [self.superview removeConstraint:_constraintControllerLeft];
        }
        _constraintControllerLeft = constraintControllerLeft;
        if(_constraintControllerLeft != nil) {
            [self.superview addConstraint:_constraintControllerLeft];
        }
    }
}

- (void)setConstraintControllerRight:(NSLayoutConstraint*)constraintControllerRight {
    if(_constraintControllerRight != constraintControllerRight) {
        if(_constraintControllerRight != nil) {
            [self.superview removeConstraint:_constraintControllerRight];
        }
        _constraintControllerRight = constraintControllerRight;
        if(_constraintControllerRight != nil) {
            [self.superview addConstraint:_constraintControllerRight];
        }
    }
}

- (void)setConstraintControllerBottom:(NSLayoutConstraint*)constraintControllerBottom {
    if(_constraintControllerBottom != constraintControllerBottom) {
        if(_constraintControllerBottom != nil) {
            [self.superview removeConstraint:_constraintControllerBottom];
        }
        _constraintControllerBottom = constraintControllerBottom;
        if(_constraintControllerBottom != nil) {
            [self.superview addConstraint:_constraintControllerBottom];
        }
    }
}

- (void)setTapGesture:(UITapGestureRecognizer*)tapGesture {
    if(_tapGesture != tapGesture) {
        if(_tapGesture != nil) {
            [self removeGestureRecognizer:_tapGesture];
        }
        _tapGesture = tapGesture;
        if(_tapGesture != nil) {
            [self addGestureRecognizer:_tapGesture];
        }
    }
}

#pragma mark - Public

- (void)hideAnimated:(BOOL)animated {
    [_controller hideNotificationView:self animated:animated complete:nil];
}

- (void)hideAnimated:(BOOL)animated complete:(GLBNotificationViewBlock)complete {
    [_controller hideNotificationView:self animated:animated complete:complete];
}

- (void)willShow {
    [_view willShowNotificationView:self];
}

- (void)didShow {
    if(_duration > FLT_EPSILON) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:_duration target:self selector:@selector(hideTimer:) userInfo:nil repeats:NO];
    }
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressed:)];
    [_view didShowNotificationView:self];
}

- (void)willHide {
    self.tapGesture = nil;
    self.timer = nil;
    [_view willHideNotificationView:self];
}

- (void)didHide {
    [_view didHideNotificationView:self];
    self.view = nil;
}

#pragma mark - Actions

- (IBAction)hideTimer:(id)sender {
    [self hideAnimated:YES];
}

- (IBAction)pressed:(id)sender {
    self.timer = nil;
    if(_pressed != nil) {
        _pressed(self);
    } else {
        [self hideAnimated:YES];
    }
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

static NSTimeInterval GLBNotificationManager_Dutation = 3.0;

/*--------------------------------------------------*/

@implementation GLBNotificationManager

#pragma mark - Synthesize

@synthesize window = _window;
@synthesize controller = _controller;

#pragma mark - Singleton

+ (instancetype)shared {
    static id instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [self new];
    });
    return instance;
}

#pragma mark - Init / Free

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        self.window.hidden = NO;
    }
    return self;
}

#pragma mark - Public

+ (void)setParentWindow:(UIWindow*)parentWindow {
    [[[self shared] controller] setParentWindow:parentWindow];
}

+ (UIWindow*)parentWindow {
    return [[[self shared] controller] parentWindow];
}

+ (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    [[[self shared] controller] setStatusBarStyle:statusBarStyle];
}

+ (UIStatusBarStyle)statusBarStyle {
    return [[[self shared] controller] statusBarStyle];
}

+ (void)setStatusBarHidden:(BOOL)statusBarHidden {
    UIWindowLevel windowLevel = UIWindowLevelStatusBar;
    if(statusBarHidden == YES) {
        windowLevel += 1;
    } else {
        windowLevel -= 1;
    }
    [[[self shared] window] setWindowLevel:windowLevel];
}

+ (BOOL)statusBarHidden {
    return ([[[self shared] window] windowLevel] >= UIWindowLevelStatusBar);
}

+ (void)setDisplayType:(GLBNotificationManagerDisplayType)displayType {
    [[[self shared] controller] setDisplayType:displayType];
}

+ (GLBNotificationManagerDisplayType)displayType {
    return [[[self shared] controller] displayType];
}

+ (void)setTopDecorView:(UIView< GLBNotificationDecorViewProtocol >*)topDecorView {
    [[[self shared] controller] setTopDecorView:topDecorView];
}

+ (UIView< GLBNotificationDecorViewProtocol >*)topDecorView {
    return [[[self shared] controller] topDecorView];
}

+ (void)setBottomDecorView:(UIView< GLBNotificationDecorViewProtocol >*)bottomDecorView {
    [[[self shared] controller] setBottomDecorView:bottomDecorView];
}

+ (UIView< GLBNotificationDecorViewProtocol >*)bottomDecorView {
    return [[[self shared] controller] bottomDecorView];
}

+ (NSArray< GLBNotificationView* >*)visibleViews {
    return [[[self shared] controller] visibleViews];
}

+ (GLBNotificationView*)showView:(UIView< GLBNotificationViewProtocol >*)view {
    return [[[self shared] controller] showView:view duration:GLBNotificationManager_Dutation pressed:nil complete:nil];
}

+ (GLBNotificationView*)showView:(UIView< GLBNotificationViewProtocol >*)view complete:(GLBNotificationViewBlock)complete {
    return [[[self shared] controller] showView:view duration:GLBNotificationManager_Dutation pressed:nil complete:complete];
}

+ (GLBNotificationView*)showView:(UIView< GLBNotificationViewProtocol >*)view pressed:(GLBNotificationViewBlock)pressed {
    return [[[self shared] controller] showView:view duration:GLBNotificationManager_Dutation pressed:pressed complete:nil];
}

+ (GLBNotificationView*)showView:(UIView< GLBNotificationViewProtocol >*)view pressed:(GLBNotificationViewBlock)pressed complete:(GLBNotificationViewBlock)complete {
    return [[[self shared] controller] showView:view duration:GLBNotificationManager_Dutation pressed:pressed complete:complete];
}

+ (GLBNotificationView*)showView:(UIView< GLBNotificationViewProtocol >*)view duration:(NSTimeInterval)duration {
    return [[[self shared] controller] showView:view duration:duration pressed:nil complete:nil];
}

+ (GLBNotificationView*)showView:(UIView< GLBNotificationViewProtocol >*)view duration:(NSTimeInterval)duration complete:(GLBNotificationViewBlock)complete {
    return [[[self shared] controller] showView:view duration:duration pressed:nil complete:complete];
}

+ (GLBNotificationView*)showView:(UIView< GLBNotificationViewProtocol >*)view duration:(NSTimeInterval)duration pressed:(GLBNotificationViewBlock)pressed {
    return [[[self shared] controller] showView:view duration:duration pressed:pressed complete:nil];
}

+ (GLBNotificationView*)showView:(UIView< GLBNotificationViewProtocol >*)view duration:(NSTimeInterval)duration pressed:(GLBNotificationViewBlock)pressed complete:(GLBNotificationViewBlock)complete {
    return [[[self shared] controller] showView:view duration:duration pressed:pressed complete:complete];
}

+ (void)hideNotificationView:(GLBNotificationView*)notificationView animated:(BOOL)animated {
    [[[self shared] controller] hideNotificationView:notificationView animated:animated complete:nil];
}

+ (void)hideNotificationView:(GLBNotificationView*)notificationView animated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    [[[self shared] controller] hideNotificationView:notificationView animated:animated complete:complete];
}

+ (void)hideAllAnimated:(BOOL)animated {
    [[[self shared] controller] hdeAllAnimated:animated complete:nil];
}

+ (void)hideAllAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    [[[self shared] controller] hdeAllAnimated:animated complete:complete];
}

#pragma mark - Property

- (GLBNotificationWindow*)window {
    if(_window == nil) {
        _window = [[GLBNotificationWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _window.windowLevel = UIWindowLevelStatusBar - 1;
        _window.rootViewController = self.controller;
    }
    return _window;
}

- (GLBNotificationController*)controller {
    if(_controller == nil) {
        _controller = [GLBNotificationController new];
        _controller.parentWindow = UIApplication.sharedApplication.keyWindow;
    }
    return _controller;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation UIView (GLBNotification)

- (void)setGlb_notificationView:(GLBNotificationView*)notificationView {
    objc_setAssociatedObject(self, @selector(glb_notificationView), notificationView, OBJC_ASSOCIATION_ASSIGN);
}

- (GLBNotificationView*)glb_notificationView {
    GLBNotificationView* view = objc_getAssociatedObject(self, @selector(glb_notificationView));
    if(view == nil) {
        view = self.superview.glb_notificationView;
    }
    return view;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
