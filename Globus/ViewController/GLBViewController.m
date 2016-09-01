/*--------------------------------------------------*/

#import "GLBViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#if __has_include("GLBActivityView.h")
#import "GLBActivityView.h"
#endif
#import "UIDevice+GLBUI.h"
#import "UINib+GLBUI.h"

/*--------------------------------------------------*/

@interface GLBViewController ()
@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBViewController

#pragma mark - Init / Free

- (void)setup {
    [super setup];
    
    _automaticallyHideKeyboard = YES;
    if(UIDevice.glb_isIPhone == YES) {
        _supportedOrientationMask = UIInterfaceOrientationMaskPortrait;
    } else {
        _supportedOrientationMask = UIInterfaceOrientationMaskLandscape;
    }
}

- (void)dealloc {
}

#pragma mark - UIViewController

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return _supportedOrientationMask;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation {
    return ((_supportedOrientationMask & orientation) != 0);
}

#pragma clang diagnostic pop

- (void)loadView {
    UINib* nib = nil;
    NSString* nibName = self.nibName;
    if(nibName.length > 0) {
        nib = [UINib glb_nibWithName:nibName bundle:self.nibBundle];
    } else {
        nib = [UINib glb_nibWithClass:self.class bundle:self.nibBundle];
    }
    if(nib != nil) {
        NSArray* objects = [nib instantiateWithOwner:self options:nil];
        for(id object in objects) {
            if([object isKindOfClass:UIViewController.class] == YES) {
                UIViewController* controller = object;
                if(controller.isViewLoaded == YES) {
                    [self addChildViewController:controller];
                    [controller didMoveToParentViewController:self];
                }
            }
        }
    } else {
        [super loadView];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
#if __has_include("GLBActivityView.h")
    if(_activityView != nil) {
        _activityView.frame = self.view.bounds;
        if(_activityView.superview == nil) {
            [self.view addSubview:_activityView];
        }
        [self.view bringSubviewToFront:_activityView];
    }
#endif
}

#pragma mark - Property

#if __has_include("GLBActivityView.h")
- (void)setActivityView:(GLBActivityView *)activityView {
    if(_activityView == activityView) {
        if(_activityView != nil) {
            [_activityView removeFromSuperview];
        }
        _activityView = activityView;
        if((_activityView != nil) && (self.isViewLoaded == YES)) {
            _activityView.frame = self.view.bounds;
            [self.view addSubview:_activityView];
            [self.view bringSubviewToFront:_activityView];
        }
    }
}
#endif

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
