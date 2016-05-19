/*--------------------------------------------------*/

#import "GLBNotificationManager.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import "UIWindow+GLBUI.h"
#import "NSArray+GLBNS.h"

/*--------------------------------------------------*/

@interface GLBNotificationWindow : UIWindow {
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface GLBNotificationController : UIViewController {
@protected
    __weak UIWindow* _parentWindow;
    UIStatusBarStyle _statusBarStyle;
    NSMutableArray* _queue;
}

@property(nonatomic, weak) UIWindow* parentWindow;
@property(nonatomic) UIStatusBarStyle statusBarStyle;

- (GLBNotificationView*)pushView:(UIView*)view duration:(NSTimeInterval)duration pressed:(GLBNotificationPressed)pressed;
- (void)popNotificationView:(GLBNotificationView*)notificationView animated:(BOOL)animated;
- (void)popAllAnimated:(BOOL)animated;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface GLBNotificationView () {
@protected
    __weak GLBNotificationController* _controller;
    UITapGestureRecognizer* _tapGesture;
    NSTimer* _timer;
@protected
    UIView* _view;
    NSLayoutConstraint* _constraintViewCenterX;
    NSLayoutConstraint* _constraintViewCenterY;
    NSLayoutConstraint* _constraintViewWidth;
    NSLayoutConstraint* _constraintViewHeight;
    NSTimeInterval _duration;
    UIStatusBarStyle _statusBarStyle;
    BOOL _statusBarHidden;
    GLBNotificationPressed _pressed;
}

@property(nonatomic, weak) GLBNotificationController* controller;
@property(nonatomic, strong) NSLayoutConstraint* constraintControllerTop;
@property(nonatomic, strong) NSLayoutConstraint* constraintControllerLeft;
@property(nonatomic, strong) NSLayoutConstraint* constraintControllerRight;
@property(nonatomic, strong) UITapGestureRecognizer* tapGesture;
@property(nonatomic, strong) NSTimer* timer;

@property(nonatomic, strong) UIView* view;
@property(nonatomic, strong) NSLayoutConstraint* constraintViewCenterX;
@property(nonatomic, strong) NSLayoutConstraint* constraintViewCenterY;
@property(nonatomic, strong) NSLayoutConstraint* constraintViewWidth;
@property(nonatomic, strong) NSLayoutConstraint* constraintViewHeight;
@property(nonatomic) NSTimeInterval duration;
@property(nonatomic, copy) GLBNotificationPressed pressed;

- (instancetype)initWithController:(GLBNotificationController*)controller view:(UIView*)view duration:(NSTimeInterval)duration pressed:(GLBNotificationPressed)pressed;

- (IBAction)pressed:(id)sender;

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

- (GLBNotificationView*)_showView:(UIView*)view duration:(NSTimeInterval)duration pressed:(GLBNotificationPressed)pressed;
- (void)_hideNotificationView:(GLBNotificationView*)notificationView animated:(BOOL)animated;
- (void)_hideAllAnimated:(BOOL)animated;

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

#pragma mark - Init / Free

- (instancetype)initWithNibName:(NSString*)nibName bundle:(NSBundle*)bundle {
    self = [super initWithNibName:nibName bundle:bundle];
    if(self != nil) {
        _statusBarStyle = UIStatusBarStyleDefault;
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

#pragma mark - Public override

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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation {
    return [_parentWindow.rootViewController shouldAutorotateToInterfaceOrientation:orientation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
}

#pragma mark - Public

- (GLBNotificationView*)pushView:(UIView*)view duration:(NSTimeInterval)duration pressed:(GLBNotificationPressed)pressed {
    GLBNotificationView* notificationView = [[GLBNotificationView alloc] initWithController:self view:view duration:duration pressed:pressed];
    if(notificationView != nil) {
        [_queue insertObject:notificationView atIndex:0];
        if(self.isViewLoaded == YES) {
            [self setNeedsStatusBarAppearanceUpdate];
        }
        [self _showNotificationView:notificationView animated:YES];
    }
    return notificationView;
}

- (void)popNotificationView:(GLBNotificationView*)notificationView animated:(BOOL)animated {
    if([_queue containsObject:notificationView] == YES) {
        [self _hideNotificationView:notificationView animated:animated];
        [_queue removeObject:notificationView];
        if(self.isViewLoaded == YES) {
            [self setNeedsStatusBarAppearanceUpdate];
        }
    }
}

- (void)popAllAnimated:(BOOL)animated {
    if(_queue.count > 0) {
        [_queue glb_each:^(GLBNotificationView* notificationView) {
            [self _hideNotificationView:notificationView animated:animated];
            [_queue removeObject:notificationView];
            if(self.isViewLoaded == YES) {
                [self setNeedsStatusBarAppearanceUpdate];
            }
        } options:NSEnumerationReverse];
        if(self.isViewLoaded == YES) {
            [self setNeedsStatusBarAppearanceUpdate];
        }
    }
}

#pragma mark - Private

- (void)_showNotificationView:(GLBNotificationView*)notificationView animated:(BOOL)animated {
    GLBNotificationView* prevNotificationView = [_queue glb_prevObjectOfObject:notificationView];
    GLBNotificationView* nextNotificationView = [_queue glb_nextObjectOfObject:notificationView];
    notificationView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:notificationView];
    if(animated == YES) {
        if(prevNotificationView != nil) {
            notificationView.constraintControllerTop = [NSLayoutConstraint constraintWithItem:notificationView
                                                                                    attribute:NSLayoutAttributeBottom
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:prevNotificationView
                                                                                    attribute:NSLayoutAttributeBottom
                                                                                   multiplier:1.0f
                                                                                     constant:0.0f];
        } else {
            notificationView.constraintControllerTop = [NSLayoutConstraint constraintWithItem:notificationView
                                                                                    attribute:NSLayoutAttributeBottom
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self.view
                                                                                    attribute:NSLayoutAttributeTop
                                                                                   multiplier:1.0f
                                                                                     constant:0.0f];
        }
    }
    notificationView.constraintControllerLeft = [NSLayoutConstraint constraintWithItem:notificationView
                                                                             attribute:NSLayoutAttributeLeft
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.view
                                                                             attribute:NSLayoutAttributeLeft
                                                                            multiplier:1.0f
                                                                              constant:0.0f];
    notificationView.constraintControllerRight = [NSLayoutConstraint constraintWithItem:notificationView
                                                                              attribute:NSLayoutAttributeRight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.view
                                                                              attribute:NSLayoutAttributeRight
                                                                             multiplier:1.0f
                                                                               constant:0.0f];
    if(nextNotificationView != nil) {
        nextNotificationView.constraintControllerTop = [NSLayoutConstraint constraintWithItem:nextNotificationView
                                                                                    attribute:NSLayoutAttributeTop
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:notificationView
                                                                                    attribute:NSLayoutAttributeBottom
                                                                                   multiplier:1.0f
                                                                                     constant:0.0f];
    }
    if(animated == YES) {
        [self.view layoutIfNeeded];
    }
    if(prevNotificationView != nil) {
        notificationView.constraintControllerTop = [NSLayoutConstraint constraintWithItem:notificationView
                                                                                attribute:NSLayoutAttributeTop
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:prevNotificationView
                                                                                attribute:NSLayoutAttributeBottom
                                                                               multiplier:1.0f
                                                                                 constant:0.0f];
    } else {
        notificationView.constraintControllerTop = [NSLayoutConstraint constraintWithItem:notificationView
                                                                                attribute:NSLayoutAttributeTop
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self.view
                                                                                attribute:NSLayoutAttributeTop
                                                                               multiplier:1.0f
                                                                                 constant:0.0f];
    }
    [notificationView willShow];
    if(animated == YES) {
        [UIView animateWithDuration:GLBNotificationController_ShowDutation delay:0.0f options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut) animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [notificationView didShow];
        }];
    } else {
        [notificationView didShow];
    }
}

- (void)_hideNotificationView:(GLBNotificationView*)notificationView animated:(BOOL)animated {
    GLBNotificationView* prevNotificationView = [_queue glb_prevObjectOfObject:notificationView];
    GLBNotificationView* nextNotificationView = [_queue glb_nextObjectOfObject:notificationView];
    if(prevNotificationView != nil) {
        notificationView.constraintControllerTop = [NSLayoutConstraint constraintWithItem:notificationView
                                                                                attribute:NSLayoutAttributeBottom
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:prevNotificationView
                                                                                attribute:NSLayoutAttributeBottom
                                                                               multiplier:1.0f
                                                                                 constant:0.0f];
    } else {
        notificationView.constraintControllerTop = [NSLayoutConstraint constraintWithItem:notificationView
                                                                                attribute:NSLayoutAttributeBottom
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self.view
                                                                                attribute:NSLayoutAttributeTop
                                                                               multiplier:1.0f
                                                                                 constant:0.0f];
    }
    if(nextNotificationView != nil) {
        if(prevNotificationView != nil) {
            nextNotificationView.constraintControllerTop = [NSLayoutConstraint constraintWithItem:nextNotificationView
                                                                                        attribute:NSLayoutAttributeTop
                                                                                        relatedBy:NSLayoutRelationEqual
                                                                                           toItem:prevNotificationView
                                                                                        attribute:NSLayoutAttributeBottom
                                                                                       multiplier:1.0f
                                                                                         constant:0.0f];
        } else {
            nextNotificationView.constraintControllerTop = [NSLayoutConstraint constraintWithItem:nextNotificationView
                                                                                        attribute:NSLayoutAttributeTop
                                                                                        relatedBy:NSLayoutRelationEqual
                                                                                           toItem:self.view
                                                                                        attribute:NSLayoutAttributeTop
                                                                                       multiplier:1.0f
                                                                                         constant:0.0f];
        }
    }
    [notificationView willHide];
    if(animated == YES) {
        [UIView animateWithDuration:GLBNotificationController_HideDutation delay:0.0f options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut) animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            notificationView.constraintControllerTop = nil;
            notificationView.constraintControllerLeft = nil;
            notificationView.constraintControllerRight = nil;
            [notificationView removeFromSuperview];
            [notificationView didHide];
        }];
    } else {
        notificationView.constraintControllerTop = nil;
        notificationView.constraintControllerLeft = nil;
        notificationView.constraintControllerRight = nil;
        [notificationView removeFromSuperview];
        [notificationView didHide];
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

- (instancetype)initWithController:(GLBNotificationController*)controller view:(UIView*)view duration:(NSTimeInterval)duration pressed:(GLBNotificationPressed)pressed {
    self = [super initWithFrame:view.bounds];
    if(self != nil) {
        self.controller = controller;
        self.view = view;
        self.duration = duration;
        self.pressed = [pressed copy];
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
                                                              constant:0.0f];
        }
        if(_constraintViewCenterY == nil) {
            _constraintViewCenterY = [_view glb_addConstraintAttribute:NSLayoutAttributeCenterY
                                                              relation:NSLayoutRelationEqual
                                                             attribute:NSLayoutAttributeCenterY
                                                              constant:0.0f];
        }
        if(_constraintViewWidth == nil) {
            _constraintViewWidth = [_view glb_addConstraintAttribute:NSLayoutAttributeWidth
                                                            relation:NSLayoutRelationEqual
                                                           attribute:NSLayoutAttributeWidth
                                                            constant:0.0f];
        }
        if(_constraintViewHeight == nil) {
            _constraintViewHeight = [_view glb_addConstraintAttribute:NSLayoutAttributeHeight
                                                             relation:NSLayoutRelationEqual
                                                            attribute:NSLayoutAttributeHeight
                                                             constant:0.0f];
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

- (void)setView:(UIView*)view {
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
    [_controller popNotificationView:self animated:animated];
}

- (void)willShow {
}

- (void)didShow {
    if(_duration > FLT_EPSILON) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:_duration target:self selector:@selector(hideTimer:) userInfo:nil repeats:NO];
    }
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressed:)];
}

- (void)willHide {
    self.tapGesture = nil;
    self.timer = nil;
}

- (void)didHide {
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

static NSTimeInterval GLBNotificationManager_Dutation = 3.0f;

/*--------------------------------------------------*/

@implementation GLBNotificationManager

#pragma mark - Synthesize

@synthesize window = _window;
@synthesize controller = _controller;

#pragma mark - Singleton

+ (instancetype)shared {
    static id shared = nil;
    if(shared == nil) {
        @synchronized(self) {
            if(shared == nil) {
                shared = [self new];
            }
        }
    }
    return shared;
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
    [[self.shared controller] setParentWindow:parentWindow];
}

+ (UIWindow*)parentWindow {
    return [[self.shared controller] parentWindow];
}

+ (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    [[self.shared controller] setStatusBarStyle:statusBarStyle];
}

+ (UIStatusBarStyle)statusBarStyle {
    return [[self.shared controller] statusBarStyle];
}

+ (void)setStatusBarHidden:(BOOL)statusBarHidden {
    if(statusBarHidden == YES) {
        [[self.shared window] setWindowLevel:UIWindowLevelStatusBar + 1];
    } else {
        [[self.shared window] setWindowLevel:UIWindowLevelStatusBar - 1];
    }
}

+ (BOOL)statusBarHidden {
    return [[self.shared window] windowLevel] >= UIWindowLevelStatusBar;
}

+ (GLBNotificationView*)showView:(UIView*)view {
    return [self.shared _showView:view duration:GLBNotificationManager_Dutation pressed:nil];
}

+ (GLBNotificationView*)showView:(UIView*)view pressed:(GLBNotificationPressed)pressed {
    return [self.shared _showView:view duration:GLBNotificationManager_Dutation pressed:pressed];
}

+ (GLBNotificationView*)showView:(UIView*)view duration:(NSTimeInterval)duration {
    return [self.shared _showView:view duration:duration pressed:nil];
}

+ (GLBNotificationView*)showView:(UIView*)view duration:(NSTimeInterval)duration pressed:(GLBNotificationPressed)pressed {
    return [self.shared _showView:view duration:duration pressed:pressed];
}

+ (void)hideNotificationView:(GLBNotificationView*)notificationView animated:(BOOL)animated {
    [self.shared _hideNotificationView:notificationView animated:animated];
}

+ (void)hideAllAnimated:(BOOL)animated {
    [self.shared _hideAllAnimated:animated];
}

#pragma mark - Property

- (GLBNotificationWindow*)window {
    if(_window == nil) {
        _window = [[GLBNotificationWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _window.windowLevel = UIWindowLevelStatusBar - 1.0f;
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

#pragma mark - Private

- (GLBNotificationView*)_showView:(UIView*)view duration:(NSTimeInterval)duration pressed:(GLBNotificationPressed)pressed {
    return [self.controller pushView:view duration:duration pressed:pressed];
}

- (void)_hideNotificationView:(GLBNotificationView*)notificationView animated:(BOOL)animated {
    [self.controller popNotificationView:notificationView animated:animated];
}

- (void)_hideAllAnimated:(BOOL)animated {
    [self.controller popAllAnimated:animated];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

#import <objc/runtime.h>

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
