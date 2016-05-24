/*--------------------------------------------------*/

#import "GLBViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import "UIDevice+GLBUI.h"
#import "UINib+GLBUI.h"

/*--------------------------------------------------*/

@interface GLBViewController ()
@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBViewController

#pragma mark - Synthesize

@synthesize activity = _activity;

#pragma mark - Init / Free

- (void)setup {
    [super setup];
    
    _automaticallyHideKeyboard = YES;
    if(UIDevice.glb_isIPhone == YES) {
        _orientation = UIInterfaceOrientationMaskPortrait;
    } else {
        _orientation = UIInterfaceOrientationMaskLandscape;
    }
}

- (void)dealloc {
}

#pragma mark - UIViewController

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return _orientation;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation {
    return ((_orientation & orientation) != 0);
}

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
    
    if(_activity != nil) {
        _activity.frame = self.view.bounds;
        if(_activity.superview == nil) {
            [self.view addSubview:_activity];
        }
        [self.view bringSubviewToFront:_activity];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIView setAnimationsEnabled:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView setAnimationsEnabled:YES];
    
    UIInterfaceOrientation currectOrientation = UIApplication.sharedApplication.statusBarOrientation;
    if((_orientation & currectOrientation) == 0) {
        if((_orientation & UIInterfaceOrientationPortrait) == 0) {
            [UIDevice glb_setOrientation:UIInterfaceOrientationPortrait];
        } else if((_orientation & UIInterfaceOrientationPortraitUpsideDown) == 0) {
            [UIDevice glb_setOrientation:UIInterfaceOrientationPortraitUpsideDown];
        } else if((_orientation & UIInterfaceOrientationLandscapeLeft) == 0) {
            [UIDevice glb_setOrientation:UIInterfaceOrientationLandscapeLeft];
        } else if((_orientation & UIInterfaceOrientationLandscapeRight) == 0) {
            [UIDevice glb_setOrientation:UIInterfaceOrientationLandscapeRight];
        }
    }
}

#pragma mark - Property

- (GLBActivityView*)activity {
    if(_activity == nil) {
        _activity = [GLBActivityView activityViewWithStyle:_activityStyle];
        if(self.isViewLoaded == YES) {
            _activity.frame = self.view.bounds;
            [self.view addSubview:_activity];
            [self.view bringSubviewToFront:_activity];
        }
    }
    return _activity;
}

- (void)setActivityStyle:(GLBActivityViewStyle)activityStyle {
    if(_activityStyle != activityStyle) {
        if(_activity != nil) {
            [_activity removeFromSuperview];
            _activity = nil;
        }
        _activityStyle = activityStyle;
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
