/*--------------------------------------------------*/

#import "GLBViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#if __has_include("GLBNavigationViewController.h")
#import "GLBNavigationViewController.h"
#endif

#if __has_include("GLBActivityView.h")
#import "GLBActivityView.h"
#endif

/*--------------------------------------------------*/

@interface GLBViewController () {
    BOOL _needUpdateNavigationItem;
    BOOL _needUpdateToolbarItems;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBViewController

#pragma mark - Init / Free

+ (instancetype)instantiate {
    return [self instantiateWithOptions:nil];
}

+ (instancetype)instantiateWithOptions:(NSDictionary*)options {
    UINib* nib = self.glb_nib;
    if(nib != nil) {
        return [nib glb_instantiateWithClass:self.class owner:nil options:options];
    }
    return nil;
}

- (void)setup {
    [super setup];
    
    if(UIDevice.glb_isIPhone == YES) {
        _supportedOrientationMask = UIInterfaceOrientationMaskPortrait;
    } else {
        _supportedOrientationMask = UIInterfaceOrientationMaskLandscape;
    }
    _needUpdateNavigationItem = YES;
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
    Class class = self.class;
    NSBundle* bundle = self.nibBundle;
    if(bundle == nil) {
        bundle = [NSBundle bundleForClass:class];
    }
    NSString* nibName = self.nibName;
    UINib* nib = nil;
    if(nibName.length > 0) {
        nib = [UINib glb_nibWithName:nibName bundle:bundle];
    } else {
        nib = [UINib glb_nibWithClass:class bundle:bundle];
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#if __has_include("GLBNavigationViewController.h")
    UINavigationController* nvc = self.navigationController;
    if([nvc isKindOfClass:GLBNavigationViewController.class] == YES) {
        GLBNavigationViewController* glbvc = (GLBNavigationViewController*)nvc;
        [glbvc updateBarsWithViewController:self animated:animated];
    }
#endif
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

#pragma mark - UIViewController

- (void)update {
    [super update];
    
    if(_needUpdateNavigationItem == YES) {
        _needUpdateNavigationItem = NO;
        [self updateNavigationItem];
    }
    if(_needUpdateToolbarItems == YES) {
        _needUpdateToolbarItems = NO;
        [self updateToolbarItems];
    }
}

#pragma mark - Property

#if __has_include("GLBActivityView.h")
- (void)setActivityView:(GLBActivityView *)activityView {
    if(_activityView != activityView) {
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

#pragma mark - Public

- (void)setNeedUpdateNavigationItem {
    if(self.isAppeared == YES) {
        _needUpdateNavigationItem = NO;
        [self updateNavigationItem];
    } else {
        _needUpdateNavigationItem = YES;
    }
}

- (void)updateNavigationItem {
    self.navigationItem.leftBarButtonItems = [self prepareNavigationLeftBarButtons];
    self.navigationItem.rightBarButtonItems = [self prepareNavigationRightBarButtons];
}

- (void)updateNavigationItem:(UINavigationItem*)navigationItem {
}

- (NSArray< UIBarButtonItem* >*)prepareNavigationLeftBarButtons {
    return self.navigationItem.leftBarButtonItems;
}

- (NSArray< UIBarButtonItem* >*)prepareNavigationRightBarButtons {
    return self.navigationItem.rightBarButtonItems;
}

- (void)setNeedUpdateToolbarItems {
    if(self.isAppeared == YES) {
        _needUpdateToolbarItems = NO;
        [self updateToolbarItems];
    } else {
        _needUpdateToolbarItems = YES;
    }
}

- (void)updateToolbarItems {
    self.toolbarItems = [self prepareToolbarItems];
}

- (NSArray< UIBarButtonItem* >*)prepareToolbarItems {
    return self.toolbarItems;
}

#pragma mark - GLBNibExtension

+ (NSString*)nibName {
    return self.glb_className;
}

+ (NSBundle*)nibBundle {
    return nil;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
