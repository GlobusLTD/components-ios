/*--------------------------------------------------*/

#import "GLBBaseTableViewController.h"

/*--------------------------------------------------*/

#if __has_include("GLBSpinnerView.h")
#import "GLBSpinnerView.h"
#endif

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBBaseTableViewController () {
    NSMutableArray< NSLayoutConstraint* >* _constraints;
}

@property(nonatomic, nullable, strong) UITableViewController* tableViewController;

@end

/*--------------------------------------------------*/

@implementation GLBBaseTableViewController

#pragma mark - Init

@synthesize contentView = _contentView;

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

    if(_tableViewController == nil) {
        [self __loadTableViewController];
        [self.view setNeedsUpdateConstraints];
    }
#if __has_include("GLBSpinnerView.h")
    if(_spinnerView.superview == nil) {
        [self.view addSubview:_spinnerView];
        [self.view setNeedsUpdateConstraints];
    }
#endif
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

- (void)viewDidUnload {
#if __has_include("GLBSpinnerView.h")
    if(_spinnerView != nil) {
        [_spinnerView removeFromSuperview];
    }
#endif
    self.tableViewController = nil;
    self.contentView = nil;
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
    id< UILayoutSupport > topLayoutGuide = self.topLayoutGuide;
    id< UILayoutSupport > bottomLayoutGuide = self.bottomLayoutGuide;
    UIRectEdge edgesForExtendedLayout = self.edgesForExtendedLayout;
    BOOL automaticallyAdjustsScrollViewInsets = self.automaticallyAdjustsScrollViewInsets;
    BOOL assignTopLayout = (((edgesForExtendedLayout & UIRectEdgeTop) != 0) && (automaticallyAdjustsScrollViewInsets == NO) && (topLayoutGuide != nil));
    BOOL assignBottomLayout = (((edgesForExtendedLayout & UIRectEdgeBottom) != 0) && (automaticallyAdjustsScrollViewInsets == NO) && (bottomLayoutGuide != nil));
    if(assignTopLayout == YES) {
        if(_topView != nil) {
            [_constraints addObject:[_topView glb_addConstraintTop:0.0f bottomItem:topLayoutGuide]];
            [_constraints addObject:[_contentView glb_addConstraintTop:0.0f bottomItem:_topView]];
        } else {
            [_constraints addObject:[_contentView glb_addConstraintTop:0.0f bottomItem:topLayoutGuide]];
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
            [_constraints addObject:[_bottomView glb_addConstraintBottom:0.0f topItem:bottomLayoutGuide]];
            [_constraints addObject:[_contentView glb_addConstraintBottom:0.0f topItem:_bottomView]];
        } else {
            [_constraints addObject:[_contentView glb_addConstraintBottom:0.0f topItem:bottomLayoutGuide]];
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
        [_constraints addObjectsFromArray:[_spinnerView glb_addConstraintCenter:UIOffsetZero item:_contentView]];
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

- (void)setContentView:(UIView*)contentView {
    if(_contentView != contentView) {
        if(_contentView != nil) {
            [_contentView removeFromSuperview];
        }
        _contentView = contentView;
        if(_contentView != nil) {
            _contentView.translatesAutoresizingMaskIntoConstraints = NO;
            
            if(self.isViewLoaded == YES) {
                [self.view addSubview:_contentView];
                [self.view setNeedsUpdateConstraints];
            }
        }
    }
}

- (UIView*)contentView {
    if(_contentView == nil) {
        [self __loadContentView];
    }
    return _contentView;
}

- (void)setTableViewController:(UITableViewController*)tableViewController {
    if(_tableViewController != tableViewController) {
        if(_tableViewController != nil) {
            [self cleanupTableView];
            [_tableViewController willMoveToParentViewController:nil];
            [_tableViewController.view removeFromSuperview];
            [_tableViewController removeFromParentViewController];
        }
        _tableViewController = tableViewController;
        if(_tableViewController != nil) {
            if(self.isViewLoaded == YES) {
                _tableViewController.view.autoresizingMask = (UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin);
                _tableViewController.view.frame = self.contentView.bounds;

                [self.contentView addSubview:_tableViewController.view];
                [self addChildViewController:_tableViewController];
                [_tableViewController didMoveToParentViewController:self];

                _tableViewController.tableView.dataSource = _dataSource;
                _tableViewController.tableView.delegate = _dataSource;

                [self configureTableView];
            }
        }
    }
}

- (UITableView*)tableView {
    if(_tableViewController == nil) {
        [self __loadTableViewController];
    }
    return _tableViewController.tableView;
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
                if(_tableViewController != nil) {
                    [self.view insertSubview:_spinnerView aboveSubview:_tableViewController.view];
                } else {
                    [self.view addSubview:_spinnerView];
                }
                [self.view setNeedsUpdateConstraints];
            }
        }
    }
}

#endif

- (void)setDataSource:(id< GLBBaseTableViewControllerDataSource >)dataSource {
    if(_dataSource != dataSource) {
        _dataSource = dataSource;
        if(self.isViewLoaded == YES) {
            _tableViewController.tableView.dataSource = _dataSource;
            _tableViewController.tableView.delegate = _dataSource;
            [_tableViewController.tableView reloadData];
        }
    }
}

#pragma mark - Public

- (void)configureTableView {
}

- (void)cleanupTableView {
}

- (void)registerIdentifier:(NSString*)identifier withCellClass:(Class)cellClass {
    [_tableViewController.tableView registerClass:cellClass forCellReuseIdentifier:identifier];
}

- (void)registerIdentifier:(nonnull NSString*)identifier withCellNib:(nonnull UINib*)cellNib {
    [_tableViewController.tableView registerNib:cellNib forCellReuseIdentifier:identifier];
}

- (void)registerIdentifier:(NSString*)identifier withHeaderClass:(Class)cellClass {
    [_tableViewController.tableView registerClass:cellClass forHeaderFooterViewReuseIdentifier:identifier];
}

- (void)registerIdentifier:(nonnull NSString*)identifier withHeaderNib:(nonnull UINib*)cellNib {
    [_tableViewController.tableView registerNib:cellNib forHeaderFooterViewReuseIdentifier:identifier];
}

- (void)registerIdentifier:(NSString*)identifier withFooterClass:(Class)cellClass {
    [_tableViewController.tableView registerClass:cellClass forHeaderFooterViewReuseIdentifier:identifier];
}

- (void)registerIdentifier:(nonnull NSString*)identifier withFooterNib:(nonnull UINib*)cellNib {
    [_tableViewController.tableView registerNib:cellNib forHeaderFooterViewReuseIdentifier:identifier];
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

#pragma mark - Private

- (void)__loadContentView {
    self.contentView = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
}

- (void)__loadTableViewController {
    self.tableViewController = [UITableViewController new];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
