/*--------------------------------------------------*/

#import "GLBDataViewController.h"

/*--------------------------------------------------*/

#if __has_include("GLBSpinnerView.h")
#import "GLBSpinnerView.h"
#endif

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewController () {
    UIView* _contentView;
    NSMutableArray< NSLayoutConstraint* >* _constraints;
}

@end

/*--------------------------------------------------*/

@implementation GLBDataViewController

#pragma mark - Init / Free

+ (instancetype)instantiate {
    return [self new];
}

+ (instancetype)instantiateWithOptions:(NSDictionary*)options {
    return [self new];
}

- (void)setup {
    [super setup];
    
    _constraints = [NSMutableArray array];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    CGRect screenRect = UIScreen.mainScreen.bounds;
    
    _contentView = [[UIView alloc] initWithFrame:screenRect];
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_contentView];
    
    _dataView = [[GLBDataView alloc] initWithFrame:screenRect];
    _dataView.translatesAutoresizingMaskIntoConstraints = NO;
    _dataView.delegate = self;
    [_contentView addSubview:_dataView];
    [_dataView glb_addConstraintEdgeInsets];

#if __has_include("GLBSpinnerView.h")
    if(_spinnerView.superview == nil) {
        [self.view addSubview:_spinnerView];
    }
#endif
    
    [self configureDataView];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

- (void)viewDidUnload {
    if(_dataView != nil) {
        [self cleanupDataView];
        
        [_dataView removeFromSuperview];
        _dataView = nil;
    }
#if __has_include("GLBSpinnerView.h")
    if(_spinnerView != nil) {
        [_spinnerView removeFromSuperview];
    }
#endif
    if(_contentView != nil) {
        [_contentView removeFromSuperview];
        _contentView = nil;
    }
    self.bottomView = nil;
    self.rightView = nil;
    self.leftView = nil;
    self.topView = nil;
    
    [super viewDidUnload];
}

#pragma clang diagnostic pop

- (void)updateViewConstraints {
    if(_constraints.count > 0) {
        [self.view removeConstraints:_constraints];
        [_constraints removeAllObjects];
    }
    [super updateViewConstraints];
    BOOL assignTopLayout = (((self.edgesForExtendedLayout & UIRectEdgeTop) != 0) && (self.automaticallyAdjustsScrollViewInsets == NO) && (self.topLayoutGuide != nil));
    BOOL assignBottomLayout = (((self.edgesForExtendedLayout & UIRectEdgeBottom) != 0) && (self.automaticallyAdjustsScrollViewInsets == NO) && (self.bottomLayoutGuide != nil));
    if(assignTopLayout == YES) {
        if(_topView != nil) {
            [_constraints addObject:[_topView glb_addConstraintTop:0.0f bottomItem:self.topLayoutGuide]];
            [_constraints addObject:[_contentView glb_addConstraintTop:0.0f bottomItem:_topView]];
        } else {
            [_constraints addObject:[_contentView glb_addConstraintTop:0.0f bottomItem:self.topLayoutGuide]];
        }
    } else {
        if(_topView != nil) {
            [_constraints addObject:[_topView glb_addConstraintTop:0.0f]];
            [_constraints addObject:[_contentView glb_addConstraintTop:0.0f bottomItem:_topView]];
        } else {
            [_constraints addObject:[_contentView glb_addConstraintTop:0.0f]];
        }
    }
    if(_leftView != nil) {
        [_constraints addObject:[_leftView glb_addConstraintLeft:0.0f]];
        [_constraints addObject:[_contentView glb_addConstraintLeft:0.0f rightItem:_leftView]];
    } else {
        [_constraints addObject:[_contentView glb_addConstraintLeft:0.0f]];
    }
    if(_rightView != nil) {
        [_constraints addObject:[_rightView glb_addConstraintRight:0.0f]];
        [_constraints addObject:[_contentView glb_addConstraintRight:0.0f leftItem:_rightView]];
    } else {
        [_constraints addObject:[_contentView glb_addConstraintRight:0.0f]];
    }
    if(assignBottomLayout == YES) {
        if(_bottomView != nil) {
            [_constraints addObject:[_bottomView glb_addConstraintBottom:0.0f topItem:self.bottomLayoutGuide]];
            [_constraints addObject:[_contentView glb_addConstraintBottom:0.0f topItem:_bottomView]];
        } else {
            [_constraints addObject:[_contentView glb_addConstraintBottom:0.0f topItem:self.bottomLayoutGuide]];
        }
    } else {
        if(_bottomView != nil) {
            [_constraints addObject:[_bottomView glb_addConstraintBottom:0.0f]];
            [_constraints addObject:[_contentView glb_addConstraintBottom:0.0f topItem:_bottomView]];
        } else {
            [_constraints addObject:[_contentView glb_addConstraintBottom:0.0f]];
        }
    }
#if __has_include("GLBSpinnerView.h")
    if(_spinnerView != nil) {
        [_constraints addObjectsFromArray:[_spinnerView glb_addConstraintCenter:UIOffsetZero item:_contentView] ];
    }
#endif
}

#pragma mark - Property override

- (void)setEdgesForExtendedLayout:(UIRectEdge)edgesForExtendedLayout {
    [super setEdgesForExtendedLayout:edgesForExtendedLayout];
    if(self.isViewLoaded == YES) {
        [self.view setNeedsUpdateConstraints];
    }
}

- (void)setAutomaticallyAdjustsScrollViewInsets:(BOOL)automaticallyAdjustsScrollViewInsets {
    [super setAutomaticallyAdjustsScrollViewInsets:automaticallyAdjustsScrollViewInsets];
    if(self.isViewLoaded == YES) {
        [self.view setNeedsUpdateConstraints];
    }
}

#pragma mark - Property

- (void)setTopView:(UIView*)topView {
    if(_topView != topView) {
        if(_topView != nil) {
            [_topView removeFromSuperview];
        }
        _topView = topView;
        if(_topView != nil) {
            _topView.translatesAutoresizingMaskIntoConstraints = NO;
            
            if(self.isViewLoaded == YES) {
                [self.view addSubview:_topView];
                [self.view setNeedsUpdateConstraints];
            }
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
            _leftView.translatesAutoresizingMaskIntoConstraints = NO;
            
            if(self.isViewLoaded == YES) {
                [self.view addSubview:_leftView];
                [self.view setNeedsUpdateConstraints];
            }
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
            _rightView.translatesAutoresizingMaskIntoConstraints = NO;
            
            if(self.isViewLoaded == YES) {
                [self.view addSubview:_rightView];
                [self.view setNeedsUpdateConstraints];
            }
        }
    }
}

- (void)setBottomView:(UIView*)bottomView {
    if(_bottomView != bottomView) {
        if(_bottomView != nil) {
            [_bottomView removeFromSuperview];
        }
        _bottomView = bottomView;
        if(_bottomView != nil) {
            _bottomView.translatesAutoresizingMaskIntoConstraints = NO;
            
            if(self.isViewLoaded == YES) {
                [self.view addSubview:_bottomView];
                [self.view setNeedsUpdateConstraints];
            }
        }
    }
}

#if __has_include("GLBSpinnerView.h")

- (void)setSpinnerView:(GLBSpinnerView*)spinnerView {
    if(_spinnerView != spinnerView) {
        if(_spinnerView != nil) {
            [_spinnerView removeFromSuperview];
        }
        _spinnerView = spinnerView;
        if(_spinnerView != nil) {
            _spinnerView.translatesAutoresizingMaskIntoConstraints = NO;
            _spinnerView.hidesWhenStopped = YES;
            
            if(self.isViewLoaded == YES) {
                if(_dataView != nil) {
                    [self.view insertSubview:_spinnerView aboveSubview:_dataView];
                } else {
                    [self.view addSubview:_spinnerView];
                }
                [self.view setNeedsUpdateConstraints];
            }
        }
    }
}

#endif

#pragma mark - Public

- (void)configureDataView {
}

- (void)cleanupDataView {
    self.dataView.container = nil;
    [self.dataView unregisterAllIdentifiers];
    [self.dataView unregisterAllActions];
}

- (void)registerIdentifier:(NSString*)identifier withViewClass:(Class)viewClass {
    [self.dataView registerIdentifier:identifier withViewClass:viewClass];
}

- (void)unregisterIdentifier:(NSString*)identifier {
    [self.dataView unregisterIdentifier:identifier];
}

- (void)unregisterAllIdentifiers {
    [self.dataView unregisterAllIdentifiers];
}

- (void)registerAction:(SEL)action forKey:(id)key {
    [self.dataView registerActionWithTarget:self action:action forKey:key];
}

- (void)registerAction:(SEL)action forIdentifier:(id)identifier forKey:(id)key {
    [self.dataView registerActionWithTarget:self action:action forIdentifier:identifier forKey:key];
}

- (void)unregisterActionForKey:(id)key {
    [self.dataView unregisterActionWithTarget:self forKey:key];
}

- (void)unregisterActionForIdentifier:(id)identifier forKey:(id)key {
    [self.dataView unregisterActionWithTarget:self forIdentifier:identifier forKey:key];
}

- (void)unregisterAllActions {
    [self.dataView unregisterAllActions];
}

- (BOOL)containsActionForKey:(id)key {
    return [self.dataView containsActionForKey:key];
}

- (BOOL)containsActionForIdentifier:(id)identifier forKey:(id)key {
    return [self.dataView containsActionForIdentifier:identifier forKey:key];
}

- (void)performActionForKey:(id)key withArguments:(NSArray*)arguments {
    [self.dataView performActionForKey:key withArguments:arguments];
}

- (void)performActionForIdentifier:(id)identifier forKey:(id)key withArguments:(NSArray*)arguments {
    [self.dataView performActionForIdentifier:identifier forKey:key withArguments:arguments];
}

- (BOOL)isLoading {
#if __has_include("GLBSpinnerView.h")
    if(_spinnerView != nil) {
        return _spinnerView.isAnimating;
    }
#endif
    return NO;
}

- (void)showLoading {
#if __has_include("GLBSpinnerView.h")
    if(_spinnerView != nil) {
        [_spinnerView startAnimating];
    }
#endif
}

- (void)hideLoading {
#if __has_include("GLBSpinnerView.h")
    if(_spinnerView != nil) {
        [_spinnerView stopAnimating];
    }
#endif
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
