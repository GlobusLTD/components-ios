/*--------------------------------------------------*/

#import "GLBDataView+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#if __has_include("GLBPageControl.h")
#import "GLBPageControl.h"
#endif
#import "GLBTimeout.h"

/*--------------------------------------------------*/

const static NSTimeInterval GLBDataViewMovingDuration = 0.2f;

/*--------------------------------------------------*/

const static CFTimeInterval GLBDataViewDefaultSetContentOffsetDuration = 0.25;
const static double GLBDataViewApproximationTolerance = 0.00000001;
const static int GLBDataViewMaximumSteps = 10;

/*--------------------------------------------------*/

double GLBDataViewCubicFunctionValue(double a, double b, double c, double d, double x);
double GLBDataViewCubicDerivativeValue(double a, double b, double c, double __unused d, double x);
double GLBDataViewRootOfCubic(double a, double b, double c, double d, double x);
double GLBDataViewTimingFunctionValue(CAMediaTimingFunction* function, double x);

/*--------------------------------------------------*/

@implementation GLBDataView

#pragma mark - Synthesize

@synthesize delegateProxy = _delegateProxy;
@synthesize contentView = _contentView;
@synthesize velocity = _velocity;
@synthesize velocityMin = _velocityMin;
@synthesize velocityMax = _velocityMax;
@synthesize allowsSelection = _allowsSelection;
@synthesize allowsMultipleSelection = _allowsMultipleSelection;
@synthesize allowsOnceSelection = _allowsOnceSelection;
@synthesize allowsEditing = _allowsEditing;
@synthesize allowsMultipleEditing = _allowsMultipleEditing;
@synthesize allowsMoving = _allowsMoving;
@synthesize bouncesTop = _bouncesTop;
@synthesize bouncesLeft = _bouncesLeft;
@synthesize bouncesRight = _bouncesRight;
@synthesize bouncesBottom = _bouncesBottom;
@synthesize scrollDirection = _scrollDirection;
@synthesize scrollBeginPosition = _scrollBeginPosition;
@synthesize edgeInset = _edgeInset;
@synthesize container = _container;
@synthesize containerInset = _containerInset;
@synthesize saveContainerInset = _saveContainerInset;
@synthesize visibleItems = _visibleItems;
@synthesize selectedItems = _selectedItems;
@synthesize highlightedItems = _highlightedItems;
@synthesize editingItems = _editingItems;
@synthesize movingItem = _movingItem;
@synthesize movingItemLastOffset = _movingItemLastOffset;
@synthesize registersViews = _registersViews;
@synthesize registersActions = _registersActions;
@synthesize queueCells = _queueCells;
@synthesize queueBatch = _queueBatch;
@synthesize reloadedBeforeItems = _reloadedBeforeItems;
@synthesize reloadedAfterItems = _reloadedAfterItems;
@synthesize deletedItems = _deletedItems;
@synthesize insertedItems = _insertedItems;
@synthesize animating = _animating;
@synthesize updating = _updating;
@synthesize transiting = _transiting;
@synthesize invalidLayout = _invalidLayout;
#if __has_include("GLBPageControl.h")
@synthesize pageControl = _pageControl;
#endif
@synthesize searchBarIteractionEnabled = _searchBarIteractionEnabled;
@synthesize showedSearchBar = _showedSearchBar;
@synthesize searchBar = _searchBar;
@synthesize searchBarStyle =  _searchBarStyle;
@synthesize searchBarInset =  _searchBarInset;
@synthesize searchBarOverlayLastPosition =  _searchBarOverlayLastPosition;
@synthesize refreshViewInset =  _refreshViewInset;
@synthesize constraintSearchBarTop = _constraintSearchBarTop;
@synthesize constraintSearchBarLeft = _constraintSearchBarLeft;
@synthesize topRefreshIteractionEnabled = _topRefreshIteractionEnabled;
@synthesize topRefreshBelowDataView = _topRefreshBelowDataView;
@synthesize topRefreshView = _topRefreshView;
@synthesize constraintTopRefreshTop = _constraintTopRefreshTop;
@synthesize constraintTopRefreshLeft = _constraintTopRefreshLeft;
@synthesize constraintTopRefreshRight = _constraintTopRefreshRight;
@synthesize constraintTopRefreshSize = _constraintTopRefreshSize;
@synthesize bottomRefreshIteractionEnabled = _bottomRefreshIteractionEnabled;
@synthesize bottomRefreshBelowDataView = _bottomRefreshBelowDataView;
@synthesize bottomRefreshView = _bottomRefreshView;
@synthesize constraintBottomRefreshBottom = _constraintBottomRefreshBottom;
@synthesize constraintBottomRefreshLeft = _constraintBottomRefreshLeft;
@synthesize constraintBottomRefreshRight = _constraintBottomRefreshRight;
@synthesize constraintBottomRefreshSize = _constraintBottomRefreshSize;
@synthesize leftRefreshIteractionEnabled = _leftRefreshIteractionEnabled;
@synthesize leftRefreshBelowDataView = _leftRefreshBelowDataView;
@synthesize leftRefreshView = _leftRefreshView;
@synthesize constraintLeftRefreshTop = _constraintLeftRefreshTop;
@synthesize constraintLeftRefreshBottom = _constraintLeftRefreshBottom;
@synthesize constraintLeftRefreshLeft = _constraintLeftRefreshLeft;
@synthesize constraintLeftRefreshSize = _constraintLeftRefreshSize;
@synthesize rightRefreshIteractionEnabled = _rightRefreshIteractionEnabled;
@synthesize rightRefreshBelowDataView = _rightRefreshBelowDataView;
@synthesize rightRefreshView = _rightRefreshView;
@synthesize constraintRightRefreshTop = _constraintRightRefreshTop;
@synthesize constraintRightRefreshBottom = _constraintRightRefreshBottom;
@synthesize constraintRightRefreshRight = _constraintRightRefreshRight;
@synthesize constraintRightRefreshSize = _constraintRightRefreshSize;
@synthesize scrollDisplayLink = _scrollDisplayLink;
@synthesize scrollTimingFunction = _scrollTimingFunction;
@synthesize scrollDuration = _scrollDuration;
@synthesize scrollAnimationStarted = _scrollAnimationStarted;
@synthesize scrollBeginTime = _scrollBeginTime;
@synthesize scrollBeginContentOffset = _scrollBeginContentOffset;
@synthesize scrollDeltaContentOffset = _scrollDeltaContentOffset;
@synthesize canDraggingSearchBar = _canDraggingSearchBar;
@synthesize canDraggingTopRefresh = _canDraggingTopRefresh;
@synthesize canDraggingBottomRefresh = _canDraggingBottomRefresh;
@synthesize canDraggingLeftRefresh = _canDraggingLeftRefresh;
@synthesize canDraggingRightRefresh = _canDraggingRightRefresh;

#pragma mark - Init / Free

- (instancetype)initWithCoder:(NSCoder*)coder {
    self = [super initWithCoder:coder];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.delegateProxy = [GLBDataViewDelegateProxy new];
    
    if(UIDevice.glb_isIPhone == YES) {
        _velocity = 400.0;
        _velocityMin = 300.0;
        _velocityMax = 900.0;
    } else if(UIDevice.glb_isIPad == YES) {
        _velocity = 2000.0;
        _velocityMin = 3000.0;
        _velocityMax = 6000.0;
    }
    
    _bouncesTop = YES;
    _bouncesLeft = YES;
    _bouncesRight = YES;
    _bouncesBottom = YES;
    
    _allowsSelection = YES;
    _allowsEditing = YES;
    
    _visibleItems = NSMutableArray.array;
    _selectedItems = NSMutableArray.array;
    _highlightedItems = NSMutableArray.array;
    _editingItems = NSMutableArray.array;
    _registersViews = NSMutableDictionary.dictionary;
    _registersActions = [GLBActions new];
    _queueCells = NSMutableDictionary.dictionary;
    _queueBatch = NSMutableArray.array;
    _reloadedBeforeItems = NSMutableArray.array;
    _reloadedAfterItems = NSMutableArray.array;
    _deletedItems = NSMutableArray.array;
    _insertedItems = NSMutableArray.array;
    
    _searchBarIteractionEnabled = YES;
    _showedSearchBar = NO;
    _searchBarStyle = GLBDataViewSearchBarStyleOverlay;
    _topRefreshIteractionEnabled = YES;
    _topRefreshBelowDataView = YES;
    _bottomRefreshIteractionEnabled = YES;
    _bottomRefreshBelowDataView = YES;
    _leftRefreshIteractionEnabled = YES;
    _leftRefreshBelowDataView = YES;
    _rightRefreshIteractionEnabled = YES;
    _rightRefreshBelowDataView = YES;
    
    self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(_handlerLongPressGestureRecognizer:)];
    
    [self glb_registerAdjustmentResponder];
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(_receiveMemoryWarning)
                                               name:UIApplicationDidReceiveMemoryWarningNotification
                                             object:nil];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self
                                                  name:UIApplicationDidReceiveMemoryWarningNotification
                                                object:nil];
    
    [self glb_unregisterAdjustmentResponder];
}

#pragma mark - UIView

- (void)setNeedsLayout {
    [super setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self validateLayoutIfNeed];
    [self _layoutForVisible];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    if(self.superview != nil) {
        if((_topRefreshView != nil) &&  (_topRefreshView.superview == nil)) {
            if(_topRefreshBelowDataView == YES) {
                [self.superview insertSubview:_topRefreshView belowSubview:self];
            } else {
                [self.superview insertSubview:_topRefreshView aboveSubview:self];
            }
        }
        if((_bottomRefreshView != nil) &&  (_bottomRefreshView.superview == nil)) {
            if(_bottomRefreshBelowDataView == YES) {
                [self.superview insertSubview:_bottomRefreshView belowSubview:self];
            } else {
                [self.superview insertSubview:_bottomRefreshView aboveSubview:self];
            }
        }
        if((_leftRefreshView != nil) &&  (_leftRefreshView.superview == nil)) {
            if(_leftRefreshBelowDataView == YES) {
                [self.superview insertSubview:_leftRefreshView belowSubview:self];
            } else {
                [self.superview insertSubview:_leftRefreshView aboveSubview:self];
            }
        }
        if((_rightRefreshView != nil) &&  (_rightRefreshView.superview == nil)) {
            if(_rightRefreshBelowDataView == YES) {
                [self.superview insertSubview:_rightRefreshView belowSubview:self];
            } else {
                [self.superview insertSubview:_rightRefreshView aboveSubview:self];
            }
        }
    }
    [self _updateSuperviewConstraints];
}

#pragma mark - Property

- (void)setFrame:(CGRect)frame {
    BOOL resize = (CGSizeEqualToSize(self.frame.size, frame.size) == NO);
    super.frame = frame;
    if(resize == YES) {
        if(CGSizeEqualToSize(frame.size, self.contentSize) == NO) {
            [_container setNeedResize];
        }
        if(_transiting == YES) {
            [_container _transitionResize];
        }
    }
}

- (void)setBounds:(CGRect)bounds {
    BOOL resize = (CGSizeEqualToSize(self.bounds.size, bounds.size) == NO);
    super.bounds = bounds;
    if(resize == YES) {
        if(CGSizeEqualToSize(bounds.size, self.contentSize) == NO) {
            [_container setNeedResize];
        }
        if(_transiting == YES) {
            [_container _transitionResize];
        }
    }
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    UIEdgeInsets oldContentInset = self.contentInset;
    if(UIEdgeInsetsEqualToEdgeInsets(oldContentInset, contentInset) == NO) {
        CGFloat x = contentInset.left - oldContentInset.left;
        CGFloat y = contentInset.top - oldContentInset.top;
        _scrollBeginPosition = CGPointMake(_scrollBeginPosition.x + x, _scrollBeginPosition.y + y);
        _searchBarOverlayLastPosition += y;
        [super setContentInset:contentInset];
        [self setNeedsLayout];
    }
}

- (void)setContentSize:(CGSize)contentSize {
    [super setContentSize:contentSize];
    CGFloat width = (contentSize.width > FLT_EPSILON) ? contentSize.width : self.frame.size.width;
    CGFloat height = (contentSize.height > FLT_EPSILON) ? contentSize.height : self.frame.size.height;
    self.contentView.glb_frameSize = CGSizeMake(width, height);
}

- (void)setDelegateProxy:(GLBDataViewDelegateProxy*)delegateProxy {
    if(_delegateProxy != delegateProxy) {
        _delegateProxy.view = nil;
        super.delegate = nil;
        _delegateProxy = delegateProxy;
        super.delegate = _delegateProxy;
        _delegateProxy.view = self;
    }
}

- (void)setDelegate:(id< UIScrollViewDelegate >)delegate {
    if(_delegateProxy.delegate != delegate) {
        super.delegate = nil;
        _delegateProxy.delegate = delegate;
        super.delegate = _delegateProxy;
    }
}

- (id< UIScrollViewDelegate >)delegate {
    return _delegateProxy.delegate;
}

- (GLBDataContentView*)contentView {
    if(_contentView == nil) {
        CGSize contentSize = self.contentSize;
        CGFloat width = (contentSize.width > FLT_EPSILON) ? contentSize.width : self.frame.size.width;
        CGFloat height = (contentSize.height > FLT_EPSILON) ? contentSize.height : self.frame.size.height;
        _contentView = [[GLBDataContentView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (void)setContainer:(GLBDataViewContainer*)container {
    if(_container != container) {
        if(_container != nil) {
            [self setNeedValidateLayout];
            [self deselectAllItemsAnimated:NO];
            [self unhighlightAllItemsAnimated:NO];
            [self endedEditAllItemsAnimated:NO];
            [self endedMoveItemAnimated:NO];
            if(_visibleItems.count > 0) {
                [_visibleItems glb_each:^(GLBDataViewItem* item) {
                    [self enqueueCellWithItem:item];
                    item.parent = nil;
                }];
                [_visibleItems removeAllObjects];
            }
            _container.view = nil;
        }
        _container = container;
        if(_container != nil) {
            _container.view = self;
            [self setNeedValidateLayout];
        }
        [self validateLayoutIfNeed];
    }
}

- (void)setEdgeInset:(UIEdgeInsets)edgeInsets {
    [self _setEdgeInset:edgeInsets force:(self.tracking == NO)];
}

- (void)setEdgeInsetTop:(CGFloat)edgeInsetTop {
    self.edgeInset = UIEdgeInsetsMake(edgeInsetTop, _edgeInset.left, _edgeInset.bottom, _edgeInset.right);
}

- (CGFloat)edgeInsetTop {
    return _edgeInset.top;
}

- (void)setEdgeInsetRight:(CGFloat)edgeInsetRight {
    self.edgeInset = UIEdgeInsetsMake(_edgeInset.top, _edgeInset.left, _edgeInset.bottom, edgeInsetRight);
}

- (CGFloat)edgeInsetRight {
    return _edgeInset.right;
}

- (void)setEdgeInsetBottom:(CGFloat)edgeInsetBottom {
    self.edgeInset = UIEdgeInsetsMake(_edgeInset.top, _edgeInset.left, edgeInsetBottom, _edgeInset.right);
}

- (CGFloat)edgeInsetBottom {
    return _edgeInset.bottom;
}

- (void)setEdgeInsetLeft:(CGFloat)edgeInsetLeft {
    self.edgeInset = UIEdgeInsetsMake(_edgeInset.top, edgeInsetLeft, _edgeInset.bottom, _edgeInset.right);
}

- (CGFloat)edgeInsetLeft {
    return _edgeInset.left;
}

- (void)setContainerInset:(UIEdgeInsets)containerInset {
    [self _setContainerInset:containerInset force:(self.tracking == NO)];
}

- (void)setContainerInsetTop:(CGFloat)containerInsetTop {
    self.containerInset = UIEdgeInsetsMake(containerInsetTop, _containerInset.left, _containerInset.bottom, _containerInset.right);
}

- (CGFloat)containerInsetTop {
    return _containerInset.top;
}

- (void)setContainerInsetRight:(CGFloat)containerInsetRight {
    self.containerInset = UIEdgeInsetsMake(_containerInset.top, _containerInset.left, _containerInset.bottom, containerInsetRight);
}

- (CGFloat)containerInsetRight {
    return _containerInset.right;
}

- (void)setContainerInsetBottom:(CGFloat)containerInsetBottom {
    self.containerInset = UIEdgeInsetsMake(_containerInset.top, _containerInset.left, containerInsetBottom, _containerInset.right);
}

- (CGFloat)containerInsetBottom {
    return _containerInset.bottom;
}

- (void)setContainerInsetLeft:(CGFloat)containerInsetLeft {
    self.containerInset = UIEdgeInsetsMake(_containerInset.top, containerInsetLeft, _containerInset.bottom, _containerInset.right);
}

- (CGFloat)containerInsetLeft {
    return _containerInset.left;
}

- (NSArray*)visibleItems {
    [_visibleItems sortUsingComparator:^NSComparisonResult(GLBDataViewItem* item1, GLBDataViewItem* item2) {
        if(item1.order < item2.order) {
            return NSOrderedAscending;
        } else if(item1.order > item2.order) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    return _visibleItems.copy;
}

- (NSArray*)visibleCells {
    NSMutableArray* result = NSMutableArray.array;
    for(GLBDataViewItem* item in self.visibleItems) {
        [result addObject:item.view];
    }
    return [NSArray arrayWithArray:result];
}

- (NSArray*)selectedItems {
    return _selectedItems.copy;
}

- (NSArray*)selectedCells {
    NSMutableArray* result = NSMutableArray.array;
    for(GLBDataViewItem* item in _selectedItems) {
        GLBDataViewCell* cell = item.cell;
        if(cell != nil) {
            [result addObject:cell];
        }
    }
    return result;
}

- (NSArray*)highlightedItems {
    return _highlightedItems.copy;
}

- (NSArray*)highlightedCells {
    NSMutableArray* result = NSMutableArray.array;
    for(GLBDataViewItem* item in _highlightedItems) {
        GLBDataViewCell* cell = item.cell;
        if(cell != nil) {
            [result addObject:cell];
        }
    }
    return result;
}

- (NSArray*)editingItems {
    return _editingItems.copy;
}

- (NSArray*)editingCells {
    NSMutableArray* result = NSMutableArray.array;
    for(GLBDataViewItem* item in _editingItems) {
        GLBDataViewCell* cell = item.cell;
        if(cell != nil) {
            [result addObject:cell];
        }
    }
    return result;
}

- (GLBDataViewItem*)movingItem {
    return _movingItem;
}

- (GLBDataViewCell*)movingCell {
    if(_movingItem.cell != nil) {
        return _movingItem.cell;
    }
    return nil;
}

- (void)setLongPressGestureRecognizer:(UILongPressGestureRecognizer*)longPressGestureRecognizer {
    if(_longPressGestureRecognizer != longPressGestureRecognizer) {
        if(_longPressGestureRecognizer != nil) {
            [self removeGestureRecognizer:_longPressGestureRecognizer];
        }
        _longPressGestureRecognizer = longPressGestureRecognizer;
        if(_longPressGestureRecognizer != nil) {
            _longPressGestureRecognizer.delegate = self;
            [self addGestureRecognizer:_longPressGestureRecognizer];
        }
    }
}

#if __has_include("GLBPageControl.h")

- (void)setPageControl:(GLBPageControl*)pageControl {
    if(_pageControl != pageControl) {
        if(_pageControl != nil) {
            [_pageControl removeTarget:self action:@selector(_changedPageControl) forControlEvents:UIControlEventValueChanged];
        }
        _pageControl = pageControl;
        if(_pageControl != nil) {
            [_pageControl addTarget:self action:@selector(_changedPageControl) forControlEvents:UIControlEventValueChanged];
        }
    }
}

#endif

- (void)setShowedSearchBar:(BOOL)showedSearchBar {
    if(showedSearchBar == YES) {
        [self showSearchBarAnimated:NO complete:nil];
    } else {
        [self hideSearchBarAnimated:NO complete:nil];
    }
}

- (void)setSearchBarStyle:(GLBDataViewSearchBarStyle)searchBarStyle {
    if(_searchBarStyle != searchBarStyle) {
        _searchBarStyle = searchBarStyle;
    }
}

- (void)setSearchBar:(GLBSearchBar*)searchBar {
    if(_searchBar != searchBar) {
        if(_searchBar != nil) {
            self.constraintSearchBarTop = nil;
            self.constraintSearchBarLeft = nil;
            self.constraintSearchBarRight = nil;
            [_searchBar removeFromSuperview];
        }
        _searchBar = searchBar;
        if(_searchBar != nil) {
            _searchBar.translatesAutoresizingMaskIntoConstraints = NO;
            _searchBar.delegate = self;
            if(self.superview != nil) {
                [self.superview insertSubview:_searchBar aboveSubview:self];
                [self _updateSuperviewConstraints];
            }
        }
        self.searchBarInset = (_showedSearchBar == YES) ? _searchBar.glb_frameHeight : 0;
    }
}

- (void)setConstraintSearchBarTop:(NSLayoutConstraint*)constraintSearchBarTop {
    if(_constraintSearchBarTop != constraintSearchBarTop) {
        if(_constraintSearchBarTop != nil) {
            [self.superview removeConstraint:_constraintSearchBarTop];
        }
        _constraintSearchBarTop = constraintSearchBarTop;
        if(_constraintSearchBarTop != nil) {
            [self.superview addConstraint:_constraintSearchBarTop];
        }
    }
}

- (void)setConstraintSearchBarLeft:(NSLayoutConstraint*)constraintSearchBarLeft {
    if(_constraintSearchBarLeft != constraintSearchBarLeft) {
        if(_constraintSearchBarLeft != nil) {
            [self.superview removeConstraint:_constraintSearchBarLeft];
        }
        _constraintSearchBarLeft = constraintSearchBarLeft;
        if(_constraintSearchBarLeft != nil) {
            [self.superview addConstraint:_constraintSearchBarLeft];
        }
    }
}

- (void)setConstraintSearchBarRight:(NSLayoutConstraint*)constraintSearchBarRight {
    if(_constraintSearchBarRight != constraintSearchBarRight) {
        if(_constraintSearchBarRight != nil) {
            [self.superview removeConstraint:_constraintSearchBarRight];
        }
        _constraintSearchBarRight = constraintSearchBarRight;
        if(_constraintSearchBarRight != nil) {
            [self.superview addConstraint:_constraintSearchBarRight];
        }
    }
}

- (void)setSearchBarInset:(CGFloat)searchBarInset {
    [self _setSearchBarInset:searchBarInset force:(self.tracking == NO)];
}

- (void)setTopRefreshBelowDataView:(BOOL)topRefreshBelowDataView {
    if(_topRefreshBelowDataView != topRefreshBelowDataView) {
        if(_topRefreshView != nil) {
            self.constraintTopRefreshTop = nil;
            self.constraintTopRefreshLeft = nil;
            self.constraintTopRefreshRight = nil;
            self.constraintTopRefreshSize = nil;
            [_topRefreshView removeFromSuperview];
        }
        _topRefreshBelowDataView = topRefreshBelowDataView;
        if(self.superview != nil) {
            if(_topRefreshBelowDataView == YES) {
                [self.superview insertSubview:_topRefreshView belowSubview:self];
            } else {
                [self.superview insertSubview:_topRefreshView aboveSubview:self];
            }
            [self _updateSuperviewConstraints];
        }
    }
}

- (void)setTopRefreshView:(GLBDataRefreshView*)topRefreshView {
    if(_topRefreshView != topRefreshView) {
        if(_topRefreshView != nil) {
            self.constraintTopRefreshTop = nil;
            self.constraintTopRefreshLeft = nil;
            self.constraintTopRefreshRight = nil;
            self.constraintTopRefreshSize = nil;
            [_topRefreshView removeFromSuperview];
            _topRefreshView.view = nil;
        }
        _topRefreshView = topRefreshView;
        if(_topRefreshView != nil) {
            _topRefreshView.translatesAutoresizingMaskIntoConstraints = NO;
            _topRefreshView.type = GLBDataRefreshViewTypeTop;
            _topRefreshView.view = self;
            if(self.superview != nil) {
                if(_topRefreshBelowDataView == YES) {
                    [self.superview insertSubview:_topRefreshView belowSubview:self];
                } else {
                    [self.superview insertSubview:_topRefreshView aboveSubview:self];
                }
                [self _updateSuperviewConstraints];
            }
        }
    }
}

- (void)setConstraintTopRefreshTop:(NSLayoutConstraint*)constraintTopRefreshTop {
    if(_constraintTopRefreshTop != constraintTopRefreshTop) {
        if(_constraintTopRefreshTop != nil) {
            [self.superview removeConstraint:_constraintTopRefreshTop];
        }
        _constraintTopRefreshTop = constraintTopRefreshTop;
        if(_constraintTopRefreshTop != nil) {
            _topRefreshView.constraintOffset = _constraintTopRefreshTop;
            [self.superview addConstraint:_constraintTopRefreshTop];
        }
    }
}

- (void)setConstraintTopRefreshLeft:(NSLayoutConstraint*)constraintTopRefreshLeft {
    if(_constraintTopRefreshLeft != constraintTopRefreshLeft) {
        if(_constraintTopRefreshLeft != nil) {
            [self.superview removeConstraint:_constraintTopRefreshLeft];
        }
        _constraintTopRefreshLeft = constraintTopRefreshLeft;
        if(_constraintTopRefreshLeft != nil) {
            [self.superview addConstraint:_constraintTopRefreshLeft];
        }
    }
}

- (void)setConstraintTopRefreshRight:(NSLayoutConstraint*)constraintTopRefreshRight {
    if(_constraintTopRefreshRight != constraintTopRefreshRight) {
        if(_constraintTopRefreshRight != nil) {
            [self.superview removeConstraint:_constraintTopRefreshRight];
        }
        _constraintTopRefreshRight = constraintTopRefreshRight;
        if(_constraintTopRefreshRight != nil) {
            [self.superview addConstraint:_constraintTopRefreshRight];
        }
    }
}

- (void)setConstraintTopRefreshSize:(NSLayoutConstraint*)constraintTopRefreshSize {
    if(_constraintTopRefreshSize != constraintTopRefreshSize) {
        if(_constraintTopRefreshSize != nil) {
            [self.superview removeConstraint:_constraintTopRefreshSize];
        }
        _constraintTopRefreshSize = constraintTopRefreshSize;
        if(_constraintTopRefreshSize != nil) {
            _topRefreshView.constraintSize = _constraintTopRefreshSize;
            [self.superview addConstraint:_constraintTopRefreshSize];
        }
    }
}

- (void)setBottomRefreshBelowDataView:(BOOL)bottomRefreshBelowDataView {
    if(_bottomRefreshBelowDataView != bottomRefreshBelowDataView) {
        if(_bottomRefreshView != nil) {
            self.constraintBottomRefreshBottom = nil;
            self.constraintBottomRefreshLeft = nil;
            self.constraintBottomRefreshRight = nil;
            self.constraintBottomRefreshSize = nil;
            [_bottomRefreshView removeFromSuperview];
        }
        _bottomRefreshBelowDataView = bottomRefreshBelowDataView;
        if(self.superview != nil) {
            if(_bottomRefreshBelowDataView == YES) {
                [self.superview insertSubview:_bottomRefreshView belowSubview:self];
            } else {
                [self.superview insertSubview:_bottomRefreshView aboveSubview:self];
            }
            [self _updateSuperviewConstraints];
        }
    }
}

- (void)setBottomRefreshView:(GLBDataRefreshView*)bottomRefreshView {
    if(_bottomRefreshView != bottomRefreshView) {
        if(_bottomRefreshView != nil) {
            self.constraintBottomRefreshBottom = nil;
            self.constraintBottomRefreshLeft = nil;
            self.constraintBottomRefreshRight = nil;
            self.constraintBottomRefreshSize = nil;
            [_bottomRefreshView removeFromSuperview];
            _bottomRefreshView.view = nil;
        }
        _bottomRefreshView = bottomRefreshView;
        if(_bottomRefreshView != nil) {
            _bottomRefreshView.translatesAutoresizingMaskIntoConstraints = NO;
            _bottomRefreshView.type = GLBDataRefreshViewTypeBottom;
            _bottomRefreshView.view = self;
            if(self.superview != nil) {
                if(_bottomRefreshBelowDataView == YES) {
                    [self.superview insertSubview:_bottomRefreshView belowSubview:self];
                } else {
                    [self.superview insertSubview:_bottomRefreshView aboveSubview:self];
                }
                [self _updateSuperviewConstraints];
            }
        }
    }
}

- (void)setConstraintBottomRefreshBottom:(NSLayoutConstraint*)constraintBottomRefreshBottom {
    if(_constraintBottomRefreshBottom != constraintBottomRefreshBottom) {
        if(_constraintBottomRefreshBottom != nil) {
            [self.superview removeConstraint:_constraintBottomRefreshBottom];
        }
        _constraintBottomRefreshBottom = constraintBottomRefreshBottom;
        if(_constraintBottomRefreshBottom != nil) {
            _bottomRefreshView.constraintOffset = _constraintBottomRefreshBottom;
            [self.superview addConstraint:_constraintBottomRefreshBottom];
        }
    }
}

- (void)setConstraintBottomRefreshLeft:(NSLayoutConstraint*)constraintBottomRefreshLeft {
    if(_constraintBottomRefreshLeft != constraintBottomRefreshLeft) {
        if(_constraintBottomRefreshLeft != nil) {
            [self.superview removeConstraint:_constraintBottomRefreshLeft];
        }
        _constraintBottomRefreshLeft = constraintBottomRefreshLeft;
        if(_constraintBottomRefreshLeft != nil) {
            [self.superview addConstraint:_constraintBottomRefreshLeft];
        }
    }
}

- (void)setConstraintBottomRefreshRight:(NSLayoutConstraint*)constraintBottomRefreshRight {
    if(_constraintBottomRefreshRight != constraintBottomRefreshRight) {
        if(_constraintBottomRefreshRight != nil) {
            [self.superview removeConstraint:_constraintBottomRefreshRight];
        }
        _constraintBottomRefreshRight = constraintBottomRefreshRight;
        if(_constraintBottomRefreshRight != nil) {
            [self.superview addConstraint:_constraintBottomRefreshRight];
        }
    }
}

- (void)setConstraintBottomRefreshSize:(NSLayoutConstraint*)constraintBottomRefreshSize {
    if(_constraintBottomRefreshSize != constraintBottomRefreshSize) {
        if(_constraintBottomRefreshSize != nil) {
            [self.superview removeConstraint:_constraintBottomRefreshSize];
        }
        _constraintBottomRefreshSize = constraintBottomRefreshSize;
        if(_constraintBottomRefreshSize != nil) {
            _bottomRefreshView.constraintSize = _constraintBottomRefreshSize;
            [self.superview addConstraint:_constraintBottomRefreshSize];
        }
    }
}

- (void)setLeftRefreshBelowDataView:(BOOL)leftRefreshBelowDataView {
    if(_leftRefreshBelowDataView != leftRefreshBelowDataView) {
        if(_leftRefreshView != nil) {
            self.constraintLeftRefreshBottom = nil;
            self.constraintLeftRefreshLeft = nil;
            self.constraintLeftRefreshTop = nil;
            self.constraintLeftRefreshSize = nil;
            [_leftRefreshView removeFromSuperview];
        }
        _leftRefreshBelowDataView = leftRefreshBelowDataView;
        if(self.superview != nil) {
            if(_leftRefreshBelowDataView == YES) {
                [self.superview insertSubview:_leftRefreshView belowSubview:self];
            } else {
                [self.superview insertSubview:_leftRefreshView aboveSubview:self];
            }
            [self _updateSuperviewConstraints];
        }
    }
}

- (void)setLeftRefreshView:(GLBDataRefreshView*)leftRefreshView {
    if(_leftRefreshView != leftRefreshView) {
        if(_leftRefreshView != nil) {
            self.constraintLeftRefreshBottom = nil;
            self.constraintLeftRefreshLeft = nil;
            self.constraintLeftRefreshTop = nil;
            self.constraintLeftRefreshSize = nil;
            [_leftRefreshView removeFromSuperview];
            _leftRefreshView.view = nil;
        }
        _leftRefreshView = leftRefreshView;
        if(_leftRefreshView != nil) {
            _leftRefreshView.translatesAutoresizingMaskIntoConstraints = NO;
            _leftRefreshView.type = GLBDataRefreshViewTypeLeft;
            _leftRefreshView.view = self;
            if(self.superview != nil) {
                if(_leftRefreshBelowDataView == YES) {
                    [self.superview insertSubview:_leftRefreshView belowSubview:self];
                } else {
                    [self.superview insertSubview:_leftRefreshView aboveSubview:self];
                }
                [self _updateSuperviewConstraints];
            }
        }
    }
}

- (void)setConstraintLeftRefreshTop:(NSLayoutConstraint*)constraintLeftRefreshTop {
    if(_constraintLeftRefreshTop != constraintLeftRefreshTop) {
        if(_constraintLeftRefreshTop != nil) {
            [self.superview removeConstraint:_constraintLeftRefreshTop];
        }
        _constraintLeftRefreshTop = constraintLeftRefreshTop;
        if(_constraintLeftRefreshTop != nil) {
            [self.superview addConstraint:_constraintLeftRefreshTop];
        }
    }
}

- (void)setConstraintLeftRefreshBottom:(NSLayoutConstraint*)constraintLeftRefreshBottom {
    if(_constraintLeftRefreshBottom != constraintLeftRefreshBottom) {
        if(_constraintLeftRefreshBottom != nil) {
            [self.superview removeConstraint:_constraintLeftRefreshBottom];
        }
        _constraintLeftRefreshBottom = constraintLeftRefreshBottom;
        if(_constraintLeftRefreshBottom != nil) {
            [self.superview addConstraint:_constraintLeftRefreshBottom];
        }
    }
}

- (void)setConstraintLeftRefreshLeft:(NSLayoutConstraint*)constraintLeftRefreshLeft {
    if(_constraintLeftRefreshLeft != constraintLeftRefreshLeft) {
        if(_constraintLeftRefreshLeft != nil) {
            [self.superview removeConstraint:_constraintLeftRefreshLeft];
        }
        _constraintLeftRefreshLeft = constraintLeftRefreshLeft;
        if(_constraintLeftRefreshLeft != nil) {
            _leftRefreshView.constraintOffset = _constraintLeftRefreshLeft;
            [self.superview addConstraint:_constraintLeftRefreshLeft];
        }
    }
}

- (void)setConstraintLeftRefreshSize:(NSLayoutConstraint*)constraintLeftRefreshSize {
    if(_constraintLeftRefreshSize != constraintLeftRefreshSize) {
        if(_constraintLeftRefreshSize != nil) {
            [self.superview removeConstraint:_constraintLeftRefreshSize];
        }
        _constraintLeftRefreshSize = constraintLeftRefreshSize;
        if(_constraintLeftRefreshSize != nil) {
            _leftRefreshView.constraintSize = _constraintLeftRefreshSize;
            [self.superview addConstraint:_constraintLeftRefreshSize];
        }
    }
}

- (void)setRightRefreshBelowDataView:(BOOL)rightRefreshBelowDataView {
    if(_rightRefreshBelowDataView != rightRefreshBelowDataView) {
        if(_rightRefreshView != nil) {
            self.constraintRightRefreshTop = nil;
            self.constraintRightRefreshBottom = nil;
            self.constraintRightRefreshRight = nil;
            self.constraintRightRefreshSize = nil;
            [_rightRefreshView removeFromSuperview];
        }
        _rightRefreshBelowDataView = rightRefreshBelowDataView;
        if(self.superview != nil) {
            if(_rightRefreshBelowDataView == YES) {
                [self.superview insertSubview:_rightRefreshView belowSubview:self];
            } else {
                [self.superview insertSubview:_rightRefreshView aboveSubview:self];
            }
            [self _updateSuperviewConstraints];
        }
    }
}

- (void)setRightRefreshView:(GLBDataRefreshView*)rightRefreshView {
    if(_rightRefreshView != rightRefreshView) {
        if(_rightRefreshView != nil) {
            self.constraintRightRefreshTop = nil;
            self.constraintRightRefreshBottom = nil;
            self.constraintRightRefreshRight = nil;
            self.constraintRightRefreshSize = nil;
            [_rightRefreshView removeFromSuperview];
            _rightRefreshView.view = nil;
        }
        _rightRefreshView = rightRefreshView;
        if(_rightRefreshView != nil) {
            _rightRefreshView.translatesAutoresizingMaskIntoConstraints = NO;
            _rightRefreshView.type = GLBDataRefreshViewTypeRight;
            _rightRefreshView.view = self;
            if(self.superview != nil) {
                if(_rightRefreshBelowDataView == YES) {
                    [self.superview insertSubview:_rightRefreshView belowSubview:self];
                } else {
                    [self.superview insertSubview:_rightRefreshView aboveSubview:self];
                }
                [self _updateSuperviewConstraints];
            }
        }
    }
}

- (void)setConstraintRightRefreshTop:(NSLayoutConstraint*)constraintRightRefreshTop {
    if(_constraintRightRefreshTop != constraintRightRefreshTop) {
        if(_constraintRightRefreshTop != nil) {
            [self.superview removeConstraint:_constraintRightRefreshTop];
        }
        _constraintRightRefreshTop = constraintRightRefreshTop;
        if(_constraintRightRefreshTop != nil) {
            [self.superview addConstraint:_constraintRightRefreshTop];
        }
    }
}

- (void)setConstraintRightRefreshBottom:(NSLayoutConstraint*)constraintRightRefreshBottom {
    if(_constraintRightRefreshBottom != constraintRightRefreshBottom) {
        if(_constraintRightRefreshBottom != nil) {
            [self.superview removeConstraint:_constraintRightRefreshBottom];
        }
        _constraintRightRefreshBottom = constraintRightRefreshBottom;
        if(_constraintRightRefreshBottom != nil) {
            [self.superview addConstraint:_constraintRightRefreshBottom];
        }
    }
}

- (void)setConstraintRightRefreshRight:(NSLayoutConstraint*)constraintRightRefreshRight {
    if(_constraintRightRefreshRight != constraintRightRefreshRight) {
        if(_constraintRightRefreshRight != nil) {
            [self.superview removeConstraint:_constraintRightRefreshRight];
        }
        _constraintRightRefreshRight = constraintRightRefreshRight;
        if(_constraintRightRefreshRight != nil) {
            _rightRefreshView.constraintOffset = _constraintRightRefreshRight;
            [self.superview addConstraint:_constraintRightRefreshRight];
        }
    }
}

- (void)setConstraintRightRefreshSize:(NSLayoutConstraint*)constraintRightRefreshSize {
    if(_constraintRightRefreshSize != constraintRightRefreshSize) {
        if(_constraintRightRefreshSize != nil) {
            [self.superview removeConstraint:_constraintRightRefreshSize];
        }
        _constraintRightRefreshSize = constraintRightRefreshSize;
        if(_constraintRightRefreshSize != nil) {
            _rightRefreshView.constraintSize = _constraintRightRefreshSize;
            [self.superview addConstraint:_constraintRightRefreshSize];
        }
    }
}

- (void)setRefreshViewInset:(UIEdgeInsets)refreshViewInset {
    [self _setRefreshViewInset:refreshViewInset force:(self.tracking == NO)];
}

#pragma mark - Public

- (void)registerIdentifier:(NSString*)identifier withViewClass:(Class)viewClass {
#if defined(GLB_DEBUG) && ((GLB_DEBUG_LEVEL & GLB_DEBUG_LEVEL_ERROR) != 0)
    if(_registersViews[identifier] != nil) {
        NSLog(@"ERROR: [%@:%@] %@ - %@", self.class, NSStringFromSelector(_cmd), identifier, viewClass);
        return;
    }
#endif
    _registersViews[identifier] = viewClass;
}

- (void)unregisterIdentifier:(NSString*)identifier {
#if defined(GLB_DEBUG) && ((GLB_DEBUG_LEVEL & GLB_DEBUG_LEVEL_ERROR) != 0)
    if(_registersViews[identifier] == nil) {
        NSLog(@"ERROR: [%@:%@] %@", self.class, NSStringFromSelector(_cmd), identifier);
        return;
    }
#endif
    [_registersViews removeObjectForKey:identifier];
}

- (void)unregisterAllIdentifiers {
    [_registersViews removeAllObjects];
}

- (void)registerActionWithTarget:(id)target action:(SEL)action forKey:(id)key {
    [_registersActions addActionWithTarget:target action:action forKey:key];
}

- (void)registerActionWithTarget:(id)target action:(SEL)action forIdentifier:(id)identifier forKey:(id)key {
    [_registersActions addActionWithTarget:target action:action inGroup:identifier forKey:key];
}

- (void)unregisterActionWithTarget:(id)target forKey:(id)key {
    [_registersActions removeAllActionsByTarget:target forKey:key];
}

- (void)unregisterActionWithTarget:(id)target forIdentifier:(id)identifier forKey:(id)key {
    [_registersActions removeAllActionsByTarget:target inGroup:identifier forKey:key];
}

- (void)unregisterActionsWithTarget:(id)target {
    [_registersActions removeAllActionsByTarget:target];
}

- (void)unregisterAllActions {
    [_registersActions removeAllActions];
}

- (BOOL)containsActionForKey:(id)key {
    return [_registersActions containsActionForKey:key];
}

- (BOOL)containsActionForIdentifier:(id)identifier forKey:(id)key {
    return [_registersActions containsActionInGroup:identifier forKey:key];
}

- (void)performActionForKey:(id)key withArguments:(NSArray*)arguments {
    [_registersActions performForKey:key withArguments:arguments];
}

- (void)performActionForIdentifier:(id)identifier forKey:(id)key withArguments:(NSArray*)arguments {
    [_registersActions performInGroup:identifier forKey:key withArguments:arguments];
}

- (Class)cellClassWithItem:(GLBDataViewItem*)item {
    return _registersViews[item.identifier];
}

- (void)dequeueCellWithItem:(GLBDataViewItem*)item {
    if(item.cell == nil) {
        item.cell = [self _dequeueCellWithItem:item];
    }
}

- (void)enqueueCellWithItem:(GLBDataViewItem*)item {
    GLBDataViewCell* cell = item.cell;
    if(cell != nil) {
        [self _enqueueCell:cell forIdentifier:item.identifier];
        item.cell = nil;
    }
}

- (GLBDataViewItem*)itemForPoint:(CGPoint)point {
    [self validateLayoutIfNeed];
    return [_container itemForPoint:point];
}

- (GLBDataViewItem*)itemForData:(id)data {
    return [_container itemForData:data];
}

- (GLBDataViewCell*)cellForData:(id)data {
    return [_container cellForData:data];
}

- (BOOL)isSelectedItem:(GLBDataViewItem*)item {
    return [_selectedItems containsObject:item];
}

- (BOOL)shouldSelectItem:(GLBDataViewItem*)item {
    return [self _shouldSelectItem:item user:NO];
}

- (BOOL)shouldDeselectItem:(GLBDataViewItem* __unused)item {
    return [self _shouldDeselectItem:item user:NO];
}

- (void)selectItem:(GLBDataViewItem*)item animated:(BOOL)animated {
    [self _selectItem:item user:NO animated:animated];
}

- (void)deselectItem:(GLBDataViewItem*)item animated:(BOOL)animated {
    [self _deselectItem:item user:NO animated:animated];
}

- (void)deselectAllItemsAnimated:(BOOL)animated {
    [self _deselectAllItemsUser:NO animated:animated];
}

- (BOOL)isHighlightedItem:(GLBDataViewItem*)item {
    return [_highlightedItems containsObject:item];
}

- (BOOL)shouldHighlightItem:(GLBDataViewItem*)item {
    return item.allowsHighlighting;
}

- (BOOL)shouldUnhighlightItem:(GLBDataViewItem* __unused)item {
    return YES;
}

- (void)highlightItem:(GLBDataViewItem*)item animated:(BOOL)animated {
    if([_highlightedItems containsObject:item] == NO) {
        if([self shouldHighlightItem:item] == YES) {
            [_highlightedItems addObject:item];
            [item highlightedAnimated:animated];
        }
    }
}

- (void)unhighlightItem:(GLBDataViewItem*)item animated:(BOOL)animated {
    if([_highlightedItems containsObject:item] == YES) {
        if([self shouldUnhighlightItem:item] == YES) {
            [_highlightedItems removeObject:item];
            [item unhighlightedAnimated:animated];
        }
    }
}

- (void)unhighlightAllItemsAnimated:(BOOL)animated {
    if(_highlightedItems.count > 0) {
        [_highlightedItems glb_each:^(GLBDataViewItem* item) {
            if([self shouldUnhighlightItem:item] == YES) {
                [_highlightedItems removeObject:item];
                [item unhighlightedAnimated:animated];
            }
        }];
    }
}

- (BOOL)isEditingItem:(GLBDataViewItem*)item {
    return [_editingItems containsObject:item];
}

- (BOOL)shouldBeganEditItem:(GLBDataViewItem*)item {
    if(_allowsEditing == YES) {
        return item.allowsEditing;
    }
    return NO;
}

- (BOOL)shouldEndedEditItem:(GLBDataViewItem* __unused)item {
    return _allowsEditing;
}

- (void)beganEditItem:(GLBDataViewItem*)item animated:(BOOL)animated {
    if([_editingItems containsObject:item] == NO) {
        if([self shouldBeganEditItem:item] == YES) {
            if(_allowsMultipleEditing == YES) {
                [_editingItems addObject:item];
                [item beginEditingAnimated:animated];
            } else {
                if(_editingItems.count > 0) {
                    NSMutableArray* endEditItems = [NSMutableArray array];
                    [_editingItems glb_each:^(GLBDataViewItem* editItem) {
                        if([self shouldEndedEditItem:editItem] == YES) {
                            [endEditItems addObject:editItem];
                        }
                    }];
                    [_editingItems removeObjectsInArray:endEditItems];
                    for(GLBDataViewItem* editItem in endEditItems) {
                        [editItem endEditingAnimated:animated];
                    }
                }
                [_editingItems addObject:item];
                [item beginEditingAnimated:animated];
            }
        }
    }
}

- (void)endedEditItem:(GLBDataViewItem*)item animated:(BOOL)animated {
    if([_editingItems containsObject:item] == YES) {
        if([self shouldEndedEditItem:item] == YES) {
            [_editingItems removeObject:item];
            [item endEditingAnimated:animated];
        }
    }
}

- (void)endedEditAllItemsAnimated:(BOOL)animated {
    if(_editingItems.count > 0) {
        [_editingItems glb_each:^(GLBDataViewItem* item) {
            if([self shouldEndedEditItem:item] == YES) {
                [_editingItems removeObject:item];
                [item endEditingAnimated:animated];
            }
        }];
    }
}

- (BOOL)isMovingItem:(GLBDataViewItem*)item {
    return (_movingItem == item);
}

- (BOOL)shouldBeganMoveItem:(GLBDataViewItem*)item {
    if((_allowsMoving == YES) && (item.allowsMoving == YES) && (_editingItems.count < 1)) {
        return YES;
    }
    return NO;
}

- (BOOL)shouldEndedMoveItem:(GLBDataViewItem* __unused)item {
    return _allowsMoving;
}

- (void)beganMoveItem:(GLBDataViewItem*)item animated:(BOOL)animated {
    if(_movingItem != item) {
        if([self shouldBeganMoveItem:item] == YES) {
            [_movingItem endMovingAnimated:animated];
            _movingItem = item;
            [_movingItem beginMovingAnimated:animated];
        }
    }
}

- (void)endedMoveItemAnimated:(BOOL)animated {
    if(_movingItem != nil) {
        if([self shouldEndedMoveItem:_movingItem] == YES) {
            [_movingItem endMovingAnimated:animated];
            _movingItem = nil;
            [self setNeedValidateLayout];
        }
    }
}

- (void)beginUpdateAnimated:(BOOL)animated {
    _updating = YES;
    _animating = animated;
    [_container _beginUpdateAnimated:animated];
}

- (void)update:(GLBSimpleBlock)update {
    if(update != nil) {
        update();
    }
    [self validateLayoutIfNeed];
    [self _layoutForVisible];
    [_container _updateAnimated:_animating];
    if(_reloadedBeforeItems.count > 0) {
        if([self containsActionForKey:GLBDataViewAnimateReplaceOut] == YES) {
            [self performActionForKey:GLBDataViewAnimateReplaceOut withArguments:@[ self, _reloadedBeforeItems ]];
        } else {
            for(GLBDataViewItem* item in _reloadedBeforeItems) {
                GLBDataViewCell* cell = item.cell;
                if(cell != nil) {
                    [UIView performWithoutAnimation:^{
                        cell.glb_ZPosition = -1;
                        cell.alpha = 1;
                    }];
                    cell.alpha = 0;
                }
            }
        }
    }
    if(_reloadedAfterItems.count > 0) {
        if([self containsActionForKey:GLBDataViewAnimateReplaceIn] == YES) {
            [self performActionForKey:GLBDataViewAnimateReplaceOut withArguments:@[ self, _reloadedAfterItems ]];
        } else {
            for(GLBDataViewItem* item in _reloadedAfterItems) {
                GLBDataViewCell* cell = item.cell;
                if(cell != nil) {
                    [UIView performWithoutAnimation:^{
                        cell.glb_ZPosition = -1;
                        cell.alpha = 0;
                    }];
                    cell.alpha = 1;
                }
            }
        }
    }
    if(_insertedItems.count > 0) {
        if([self containsActionForKey:GLBDataViewAnimateInsert] == YES) {
            [self performActionForKey:GLBDataViewAnimateInsert withArguments:@[ self, _insertedItems ]];
        } else {
            for(GLBDataViewItem* item in _insertedItems) {
                GLBDataViewCell* cell = item.cell;
                if(cell != nil) {
                    [UIView performWithoutAnimation:^{
                        cell.glb_ZPosition = -1.0f;
                        cell.alpha = 0.0f;
                    }];
                    cell.alpha = 1.0f;
                }
            }
        }
    }
    if(_deletedItems.count > 0) {
        if([self containsActionForKey:GLBDataViewAnimateDelete] == YES) {
            [self performActionForKey:GLBDataViewAnimateDelete withArguments:@[ self, _deletedItems ]];
        } else {
            for(GLBDataViewItem* item in _deletedItems) {
                GLBDataViewCell* cell = item.cell;
                if(cell != nil) {
                    [UIView performWithoutAnimation:^{
                        cell.glb_ZPosition = -1.0f;
                        cell.alpha = 1.0f;
                    }];
                    cell.alpha = 0.0f;
                }
            }
        }
    }
}

- (void)endUpdate {
    if(_reloadedBeforeItems.count > 0) {
        if([self containsActionForKey:GLBDataViewAnimateRestore] == YES) {
            [self performActionForKey:GLBDataViewAnimateRestore withArguments:@[ self, _reloadedBeforeItems ]];
            for(GLBDataViewItem* item in _reloadedBeforeItems) {
                [self _disappearItem:item];
                item.parent = nil;
            }
        } else {
            for(GLBDataViewItem* item in _reloadedBeforeItems) {
                GLBDataViewCell* cell = item.cell;
                if(cell != nil) {
                    cell.glb_ZPosition = 0.0f;
                    cell.alpha = 1.0f;
                }
                [self _disappearItem:item];
                item.parent = nil;
            }
        }
        [_reloadedBeforeItems removeAllObjects];
    }
    if(_reloadedAfterItems.count > 0) {
        for(GLBDataViewItem* item in _reloadedAfterItems) {
            GLBDataViewCell* cell = item.cell;
            if(cell != nil) {
                cell.glb_ZPosition = 0.0f;
                cell.alpha = 1.0f;
            }
        }
        [_reloadedAfterItems removeAllObjects];
    }
    if(_insertedItems.count > 0) {
        for(GLBDataViewItem* item in _insertedItems) {
            GLBDataViewCell* cell = item.cell;
            if(cell != nil) {
                cell.glb_ZPosition = 0.0f;
                cell.alpha = 1.0f;
            }
        }
        [_insertedItems removeAllObjects];
    }
    if(_deletedItems.count > 0) {
        if([self containsActionForKey:GLBDataViewAnimateRestore] == YES) {
            [self performActionForKey:GLBDataViewAnimateRestore withArguments:@[ self, _deletedItems ]];
            for(GLBDataViewItem* item in _deletedItems) {
                [self _disappearItem:item];
                item.parent = nil;
            }
        } else {
            for(GLBDataViewItem* item in _deletedItems) {
                GLBDataViewCell* cell = item.cell;
                if(cell != nil) {
                    cell.glb_ZPosition = 0.0f;
                    cell.alpha = 1.0f;
                }
                [self _disappearItem:item];
                item.parent = nil;
            }
        }
        [_deletedItems removeAllObjects];
    }
    [_container _endUpdateAnimated:_animating];
    _animating = NO;
    _updating = NO;

    if(_queueBatch.count > 0) {
        GLBDataBatch* batch = _queueBatch.firstObject;
        [_queueBatch removeObjectAtIndex:0];
        [self batchDuration:batch.duration update:batch.update complete:batch.complete];
    }
}

- (void)batchUpdate:(GLBSimpleBlock)update {
    [self batchDuration:0.0f update:update complete:nil];
}

- (void)batchUpdate:(GLBSimpleBlock)update complete:(GLBSimpleBlock)complete {
    [self batchDuration:0.0f update:update complete:complete];
}

- (void)batchDuration:(NSTimeInterval)duration update:(GLBSimpleBlock)update {
    [self batchDuration:duration update:update complete:nil];
}

- (void)batchDuration:(NSTimeInterval)duration update:(GLBSimpleBlock)update complete:(GLBSimpleBlock)complete {
    if((_updating == NO) && (_transiting == NO)) {
        if(duration > FLT_EPSILON) {
            [self beginUpdateAnimated:YES];
            [UIView animateWithDuration:duration
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [self update:update];
                             }
                             completion:nil];
            [GLBTimeout executeBlock:^{
                [self endUpdate];
                if(complete != nil) {
                    complete();
                }
            } afterDelay:duration];
        } else {
            [self beginUpdateAnimated:NO];
            [self update:update];
            [self endUpdate];
            if(complete != nil) {
                complete();
            }
        }
    } else {
        GLBDataBatch* batch = [[GLBDataBatch alloc] initWithDuration:duration update:update complete:complete];
        if(batch != nil) {
            [_queueBatch addObject:batch];
        }
    }
}

- (void)beginTransition {
    if(_transiting == NO) {
        _transiting = YES;
        [_container _beginTransition];
    }
}

- (void)endTransition {
    if(_transiting == YES) {
        _transiting = NO;
        [_container _endTransition];
        
        [self validateLayoutIfNeed];
        [self _layoutForVisible];

        if(_queueBatch.count > 0) {
            GLBDataBatch* batch = _queueBatch.firstObject;
            [_queueBatch removeObjectAtIndex:0];
            [self batchDuration:batch.duration update:batch.update complete:batch.complete];
        }
    }
}

- (void)setNeedValidateLayout {
    if((_invalidLayout == NO) && (_invalidatingLayout == NO)) {
        _invalidLayout = YES;
        [self setNeedsLayout];
    }
}

- (void)validateLayoutIfNeed {
    if((_invalidLayout == YES) && (_invalidatingLayout == NO)) {
        _invalidatingLayout = YES;
        _invalidLayout = NO;
        [self _validateLayout];
        _invalidatingLayout = NO;
    }
}

- (void)animateContentOffset:(CGPoint)contentOffset withTimingFunction:(CAMediaTimingFunction*)timingFunction {
    [self animateContentOffset:contentOffset
            withTimingFunction:timingFunction
                      duration:GLBDataViewDefaultSetContentOffsetDuration];
}

- (void)animateContentOffset:(CGPoint)contentOffset withTimingFunction:(CAMediaTimingFunction*)timingFunction duration:(CFTimeInterval)duration {
    _scrollDuration = duration;
    _scrollTimingFunction = timingFunction;
    _scrollDeltaContentOffset = GLBPointSubPoint(contentOffset, self.contentOffset);
    if(_scrollDisplayLink == nil) {
        _scrollDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(_animateContentOffset:)];
        _scrollDisplayLink.frameInterval = 1;
        [_scrollDisplayLink addToRunLoop:NSRunLoop.currentRunLoop forMode:NSDefaultRunLoopMode];
    } else {
        _scrollDisplayLink.paused = NO;
    }
}

- (void)stopAnimateContentOffset {
    if((_scrollDisplayLink != nil) && (_scrollDisplayLink.isPaused == NO)) {
        [self _stopAnimateContentOffset];
    }
}

- (void)scrollToItem:(GLBDataViewItem*)item scrollPosition:(GLBDataViewPosition)scrollPosition animated:(BOOL)animated {
    [self scrollToRect:item.updateFrame scrollPosition:scrollPosition animated:animated];
}

- (void)scrollToRect:(CGRect)rect scrollPosition:(GLBDataViewPosition)scrollPosition animated:(BOOL)animated {
    [self validateLayoutIfNeed];
    NSUInteger vPosition = scrollPosition & (GLBDataViewPositionTop | GLBDataViewPositionCenteredVertically | GLBDataViewPositionBottom);
    NSUInteger hPosition = scrollPosition & (GLBDataViewPositionLeft | GLBDataViewPositionCenteredHorizontally | GLBDataViewPositionRight);
    CGRect viewportRect = self.glb_visibleBounds;
    CGPoint contentOffset = self.contentOffset;
    CGSize contentSize = self.contentSize;
    switch(hPosition) {
        case GLBDataViewPositionLeft: {
            contentOffset.x = rect.origin.x;
            break;
        }
        case GLBDataViewPositionCenteredHorizontally: {
            contentOffset.x = (rect.origin.x + (rect.size.width * 0.5f)) - (viewportRect.size.width * 0.5f);
            break;
        }
        case GLBDataViewPositionRight: {
            contentOffset.x = (rect.origin.x + rect.size.width) - viewportRect.size.width;
            break;
        }
        case GLBDataViewPositionInsideHorizontally: {
            if(rect.origin.x < viewportRect.origin.x) {
                contentOffset.x = rect.origin.x;
            } else if(rect.origin.x + rect.size.width > viewportRect.origin.x + viewportRect.size.width) {
                contentOffset.x = (rect.origin.x + rect.size.width) - viewportRect.size.width;
            }
            break;
        }
    }
    switch(vPosition) {
        case GLBDataViewPositionTop: {
            contentOffset.y = rect.origin.y;
            break;
        }
        case GLBDataViewPositionCenteredVertically: {
            contentOffset.y = (rect.origin.y + (rect.size.height * 0.5f)) - (viewportRect.size.height * 0.5f);
            break;
        }
        case GLBDataViewPositionBottom: {
            contentOffset.y = (rect.origin.y + rect.size.height) - viewportRect.size.height;
            break;
        }
        case GLBDataViewPositionInsideVertically: {
            if(rect.origin.y < viewportRect.origin.y) {
                contentOffset.y = rect.origin.y;
            } else if(rect.origin.y + rect.size.height > viewportRect.origin.y + viewportRect.size.height) {
                contentOffset.y = (rect.origin.y + rect.size.height) - viewportRect.size.height;
            }
            break;
        }
    }
    contentOffset.x = MAX(0.0f, MIN(contentOffset.x, contentSize.width - viewportRect.size.width));
    contentOffset.y = MAX(0.0f, MIN(contentOffset.y, contentSize.height - viewportRect.size.height));
    [self setContentOffset:contentOffset animated:animated];
}

- (void)showSearchBarAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    [self _showSearchBarAnimated:animated velocity:_velocity complete:complete];
}

- (void)hideSearchBarAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    [self _hideSearchBarAnimated:animated velocity:_velocity complete:complete];
}

- (void)showTopRefreshAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    [self _showTopRefreshAnimated:animated velocity:_velocity complete:complete];
}

- (void)hideTopRefreshAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    [self _hideTopRefreshAnimated:animated velocity:_velocity complete:complete];
}

- (void)showBottomRefreshAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    [self _showBottomRefreshAnimated:animated velocity:_velocity complete:complete];
}

- (void)hideBottomRefreshAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    [self _hideBottomRefreshAnimated:animated velocity:_velocity complete:complete];
}

- (void)showLeftRefreshAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    [self _showLeftRefreshAnimated:animated velocity:_velocity complete:complete];
}

- (void)hideLeftRefreshAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    [self _hideLeftRefreshAnimated:animated velocity:_velocity complete:complete];
}

- (void)showRightRefreshAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    [self _showRightRefreshAnimated:animated velocity:_velocity complete:complete];
}

- (void)hideRightRefreshAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    [self _hideRightRefreshAnimated:animated velocity:_velocity complete:complete];
}

#pragma mark - Private

- (void)_setEdgeInset:(UIEdgeInsets)edgeInsets force:(BOOL)force {
    if(UIEdgeInsetsEqualToEdgeInsets(_edgeInset, edgeInsets) == NO) {
        _edgeInset = edgeInsets;
        [self _updateInsets:force];
    }
}

- (void)_setSearchBarInset:(CGFloat)searchBarInset force:(BOOL)force {
    if(_searchBarInset != searchBarInset) {
        _searchBarInset = searchBarInset;
        [self _updateInsets:force];
    }
}

- (void)_setRefreshViewInset:(UIEdgeInsets)refreshViewInset force:(BOOL)force {
    if(UIEdgeInsetsEqualToEdgeInsets(_refreshViewInset, refreshViewInset) == NO) {
        _refreshViewInset = refreshViewInset;
        [self _updateInsets:force];
    }
}

- (void)_setContainerInset:(UIEdgeInsets)containerInset force:(BOOL)force {
    if(UIEdgeInsetsEqualToEdgeInsets(_containerInset, containerInset) == NO) {
        _containerInset = containerInset;
        [self _updateInsets:force];
    }
}

- (void)_receiveMemoryWarning {
    [_queueCells glb_each:^(NSString* identifier, NSArray* cells) {
        for(GLBDataViewCell* cell in cells) {
            [cell removeFromSuperview];
            cell.view = nil;
        }
    }];
    [_queueCells removeAllObjects];
}

- (GLBDataViewCell*)_dequeueCellWithItem:(GLBDataViewItem*)item {
    NSString* identifier = item.identifier;
    NSMutableArray* queue = _queueCells[identifier];
    GLBDataViewCell* cell = [queue lastObject];
    if(cell == nil) {
        cell = [[_registersViews[identifier] alloc] initWithIdentifier:identifier];
        if(cell != nil) {
            cell.view = self;
            __block NSUInteger viewIndex = NSNotFound;
            [self.contentView.subviews enumerateObjectsUsingBlock:^(UIView* view, NSUInteger index, BOOL* stop) {
                if([view isKindOfClass:GLBDataViewCell.class] == YES) {
                    GLBDataViewCell* existCell = (GLBDataViewCell*)view;
                    if(item.order > existCell.item.order) {
                        viewIndex = index;
                    } else if(item.order <= existCell.item.order) {
                        *stop = YES;
                    }
                }
            }];
            if(viewIndex != NSNotFound) {
                [self.contentView insertSubview:cell atIndex:(NSInteger)(viewIndex + 1)];
            } else {
                [self.contentView insertSubview:cell atIndex:0];
            }
        }
    } else {
        [queue removeLastObject];
    }
    return cell;
}

- (void)_enqueueCell:(GLBDataViewCell*)cell forIdentifier:(NSString*)identifier {
    NSMutableArray* queue = _queueCells[identifier];
    if(queue == nil) {
        _queueCells[identifier] = [NSMutableArray arrayWithObject:cell];
    } else {
        [queue addObject:cell];
    }
}

- (void)_pressedItem:(GLBDataViewItem*)item animated:(BOOL)animated {
    if(_allowsOnceSelection == YES) {
        [self _selectItem:item user:YES animated:animated];
    } else {
        if([self isSelectedItem:item] == NO) {
            [self _selectItem:item user:YES animated:animated];
        } else {
            [self _deselectItem:item user:YES animated:animated];
        }
    }
    [self endedEditItem:item animated:animated];
}

- (BOOL)_shouldSelectItem:(GLBDataViewItem*)item user:(BOOL)user {
    if((_allowsSelection == YES) || (user == NO)) {
        if(item.allowsSelection == YES) {
            if([self isSelectedItem:item] == NO) {
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)_shouldDeselectItem:(GLBDataViewItem*)item user:(BOOL)user {
    if((_allowsSelection == YES) || (user == NO)) {
        if(item.allowsSelection == YES) {
            if([self isSelectedItem:item] == YES) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)_selectItem:(GLBDataViewItem*)item user:(BOOL)user animated:(BOOL)animated {
    if([self _shouldSelectItem:item user:user] == YES) {
        if(_allowsMultipleSelection == YES) {
            [_selectedItems addObject:item];
            [item selectedAnimated:animated];
            if(user == YES) {
                [self performActionForIdentifier:item.identifier forKey:GLBDataViewSelectItem withArguments:@[ item ]];
            }
        } else {
            while(_selectedItems.count > 0) {
                [self _deselectItem:_selectedItems.firstObject user:user animated:animated];
            }
            [_selectedItems addObject:item];
            [item selectedAnimated:animated];
            if(user == YES) {
                [self performActionForIdentifier:item.identifier forKey:GLBDataViewSelectItem withArguments:@[ item ]];
            }
        }
    }
}

- (void)_deselectItem:(GLBDataViewItem*)item user:(BOOL)user animated:(BOOL)animated {
    if([self _shouldDeselectItem:item user:user] == YES) {
        [_selectedItems removeObject:item];
        [item deselectedAnimated:animated];
        if(user == YES) {
            [self performActionForIdentifier:item.identifier forKey:GLBDataViewDeselectItem withArguments:@[ item ]];
        }
    }
}

- (void)_deselectAllItemsUser:(BOOL)user animated:(BOOL)animated {
    if(_selectedItems.count > 0) {
        [_selectedItems glb_each:^(GLBDataViewItem* item) {
            if([self shouldDeselectItem:item] == YES) {
                [_selectedItems removeObject:item];
                [item deselectedAnimated:animated];
                if(user == YES) {
                    [self performActionForIdentifier:item.identifier forKey:GLBDataViewDeselectItem withArguments:@[ item ]];
                }
            }
        }];
    }
}

- (void)_appearItem:(GLBDataViewItem*)item {
    [_visibleItems addObject:item];
    [self dequeueCellWithItem:item];
}

- (void)_disappearItem:(GLBDataViewItem*)item {
    [_visibleItems removeObject:item];
    [self enqueueCellWithItem:item];
}

- (void)_didInsertItems:(NSArray*)items {
    if((_updating == NO) && (_transiting == NO)) {
        @throw [NSException exceptionWithName:self.glb_className reason:@"Need invoke on batchUpdate" userInfo:nil];
    }
    [_insertedItems addObjectsFromArray:items];
    [self setNeedValidateLayout];
}

- (void)_didDeleteItems:(NSArray*)items {
    if((_updating == NO) && (_transiting == NO)) {
        @throw [NSException exceptionWithName:self.glb_className reason:@"Need invoke on batchUpdate" userInfo:nil];
    }
    [_visibleItems removeObjectsInArray:items];
    [_selectedItems removeObjectsInArray:items];
    [_highlightedItems removeObjectsInArray:items];
    [_editingItems removeObjectsInArray:items];
    [_deletedItems addObjectsFromArray:items];
    [self setNeedValidateLayout];
}

- (void)_didReplaceOriginItems:(NSArray*)originItems withItems:(NSArray*)items {
    if((_updating == NO) && (_transiting == NO)) {
        @throw [NSException exceptionWithName:self.glb_className reason:@"Need invoke on batchUpdate" userInfo:nil];
    }
    [_visibleItems removeObjectsInArray:originItems];
    [_selectedItems removeObjectsInArray:originItems];
    [_highlightedItems removeObjectsInArray:originItems];
    [_editingItems removeObjectsInArray:originItems];
    [_reloadedBeforeItems addObjectsFromArray:originItems];
    [_reloadedAfterItems addObjectsFromArray:items];
    [self setNeedValidateLayout];
}

- (void)_validateLayout {
    CGSize containerSize = CGSizeZero;
    if(_container != nil) {
        [_container _validateLayoutForAvailableFrame:GLBRectMakeOriginAndSize(CGPointZero, self.frame.size)];
        containerSize = _container.frame.size;
    }
    self.contentSize = containerSize;
#if __has_include("GLBPageControl.h")
    [_pageControl updatePageNumberForScrollView:self];
#endif
}

- (void)_layoutForVisible {
    CGRect bounds = self.bounds;
    [_container _willLayoutForBounds:bounds];
    if((_animating == NO) && (_transiting == NO)) {
        [_visibleItems glb_each:^(GLBDataViewItem* item) {
            [item invalidateLayoutForBounds:bounds];
        }];
    }
    [_container _didLayoutForBounds:bounds];
}

- (void)_updateSuperviewConstraints {
    if(_searchBar != nil) {
        if(_constraintSearchBarTop == nil) {
            self.constraintSearchBarTop = [NSLayoutConstraint constraintWithItem:_searchBar
                                                                       attribute:NSLayoutAttributeBottom
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1.0f
                                                                        constant:_edgeInset.top + _searchBarInset];
        }
        if(_constraintSearchBarLeft == nil) {
            if(_leftRefreshView != nil) {
                self.constraintSearchBarLeft = [NSLayoutConstraint constraintWithItem:_searchBar
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:_leftRefreshView
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1.0f
                                                                             constant:0.0f];
            } else {
                self.constraintSearchBarLeft = [NSLayoutConstraint constraintWithItem:_searchBar
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self
                                                                            attribute:NSLayoutAttributeLeft
                                                                           multiplier:1.0f
                                                                             constant:0.0f];
            }
        }
        if(_constraintSearchBarRight == nil) {
            if(_rightRefreshView != nil) {
                self.constraintSearchBarRight = [NSLayoutConstraint constraintWithItem:_searchBar
                                                                             attribute:NSLayoutAttributeRight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:_rightRefreshView
                                                                             attribute:NSLayoutAttributeLeft
                                                                            multiplier:1.0f
                                                                              constant:0.0f];
            } else {
                self.constraintSearchBarRight = [NSLayoutConstraint constraintWithItem:_searchBar
                                                                             attribute:NSLayoutAttributeRight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self
                                                                             attribute:NSLayoutAttributeRight
                                                                            multiplier:1.0f
                                                                              constant:0.0f];
            }
        }
    } else {
        self.constraintSearchBarTop = nil;
        self.constraintSearchBarLeft = nil;
        self.constraintSearchBarRight = nil;
    }
    if(_topRefreshView != nil) {
        if(_constraintTopRefreshTop == nil) {
            if(_searchBar != nil) {
                self.constraintTopRefreshTop = [NSLayoutConstraint constraintWithItem:_topRefreshView
                                                                            attribute:NSLayoutAttributeTop
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:_searchBar
                                                                            attribute:NSLayoutAttributeBottom
                                                                           multiplier:1.0f
                                                                             constant:-_topRefreshView.size];
            } else {
                self.constraintTopRefreshTop = [NSLayoutConstraint constraintWithItem:_topRefreshView
                                                                            attribute:NSLayoutAttributeTop
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self
                                                                            attribute:NSLayoutAttributeTop
                                                                           multiplier:1.0f
                                                                             constant:_edgeInset.top - _topRefreshView.size];
            }
        }
        if(_constraintTopRefreshLeft == nil) {
            self.constraintTopRefreshLeft = [NSLayoutConstraint constraintWithItem:_topRefreshView
                                                                         attribute:NSLayoutAttributeLeft
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self
                                                                         attribute:NSLayoutAttributeLeft
                                                                        multiplier:1.0f
                                                                          constant:_edgeInset.left];
        }
        if(_constraintTopRefreshRight == nil) {
            self.constraintTopRefreshRight = [NSLayoutConstraint constraintWithItem:_topRefreshView
                                                                          attribute:NSLayoutAttributeRight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeRight
                                                                         multiplier:1.0f
                                                                           constant:_edgeInset.right];
        }
        if(_constraintTopRefreshSize == nil) {
            self.constraintTopRefreshSize = [NSLayoutConstraint constraintWithItem:_topRefreshView
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1.0f
                                                                          constant:_topRefreshView.size];
        }
    } else {
        self.constraintTopRefreshTop = nil;
        self.constraintTopRefreshLeft = nil;
        self.constraintTopRefreshRight = nil;
        self.constraintTopRefreshSize = nil;
    }
    if(_bottomRefreshView != nil) {
        if(_constraintBottomRefreshBottom == nil) {
            self.constraintBottomRefreshBottom = [NSLayoutConstraint constraintWithItem:_bottomRefreshView
                                                                              attribute:NSLayoutAttributeBottom
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self
                                                                              attribute:NSLayoutAttributeBottom
                                                                             multiplier:1.0f
                                                                               constant:_edgeInset.bottom - _bottomRefreshView.size];
        }
        if(_constraintBottomRefreshLeft == nil) {
            self.constraintBottomRefreshLeft = [NSLayoutConstraint constraintWithItem:_bottomRefreshView
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self
                                                                            attribute:NSLayoutAttributeLeft
                                                                           multiplier:1.0f
                                                                             constant:_edgeInset.left];
        }
        if(_constraintBottomRefreshRight == nil) {
            self.constraintBottomRefreshRight = [NSLayoutConstraint constraintWithItem:_bottomRefreshView
                                                                             attribute:NSLayoutAttributeRight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self
                                                                             attribute:NSLayoutAttributeRight
                                                                            multiplier:1.0f
                                                                              constant:_edgeInset.right];
        }
        if(_constraintBottomRefreshSize == nil) {
            self.constraintBottomRefreshSize = [NSLayoutConstraint constraintWithItem:_bottomRefreshView
                                                                            attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1.0f
                                                                             constant:_bottomRefreshView.size];
        }
    } else {
        self.constraintBottomRefreshBottom = nil;
        self.constraintBottomRefreshLeft = nil;
        self.constraintBottomRefreshRight = nil;
        self.constraintBottomRefreshSize = nil;
    }
    if(_leftRefreshView != nil) {
        if(_constraintLeftRefreshTop == nil) {
            self.constraintLeftRefreshTop = [NSLayoutConstraint constraintWithItem:_leftRefreshView
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1.0f
                                                                          constant:_edgeInset.top];
        }
        if(_constraintLeftRefreshBottom == nil) {
            self.constraintLeftRefreshBottom = [NSLayoutConstraint constraintWithItem:_leftRefreshView
                                                                            attribute:NSLayoutAttributeBottom
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self
                                                                            attribute:NSLayoutAttributeBottom
                                                                           multiplier:1.0f
                                                                             constant:_edgeInset.bottom];
        }
        if(_constraintLeftRefreshLeft == nil) {
            self.constraintLeftRefreshLeft = [NSLayoutConstraint constraintWithItem:_leftRefreshView
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1.0f
                                                                           constant:_edgeInset.left - _leftRefreshView.size];
        }
        if(_constraintLeftRefreshSize == nil) {
            self.constraintLeftRefreshSize = [NSLayoutConstraint constraintWithItem:_leftRefreshView
                                                                          attribute:NSLayoutAttributeWidth
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1.0f
                                                                           constant:_leftRefreshView.size];
        }
    } else {
        self.constraintLeftRefreshTop = nil;
        self.constraintLeftRefreshBottom = nil;
        self.constraintLeftRefreshLeft = nil;
        self.constraintLeftRefreshSize = nil;
    }
    if(_rightRefreshView != nil) {
        if(_constraintRightRefreshTop == nil) {
            self.constraintRightRefreshTop = [NSLayoutConstraint constraintWithItem:_rightRefreshView
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeTop
                                                                         multiplier:1.0f
                                                                           constant:_edgeInset.top];
        }
        if(_constraintRightRefreshBottom == nil) {
            self.constraintRightRefreshBottom = [NSLayoutConstraint constraintWithItem:_rightRefreshView
                                                                             attribute:NSLayoutAttributeBottom
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self
                                                                             attribute:NSLayoutAttributeBottom
                                                                            multiplier:1.0f
                                                                              constant:_edgeInset.bottom];
        }
        if(_constraintRightRefreshRight == nil) {
            self.constraintRightRefreshRight = [NSLayoutConstraint constraintWithItem:_rightRefreshView
                                                                            attribute:NSLayoutAttributeRight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1.0f
                                                                             constant:_edgeInset.right - _rightRefreshView.size];
        }
        if(_constraintRightRefreshSize == nil) {
            self.constraintRightRefreshSize = [NSLayoutConstraint constraintWithItem:_rightRefreshView
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:nil
                                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                                          multiplier:1.0f
                                                                            constant:_rightRefreshView.size];
        }
    } else {
        self.constraintRightRefreshTop = nil;
        self.constraintRightRefreshBottom = nil;
        self.constraintRightRefreshRight = nil;
        self.constraintRightRefreshSize = nil;
    }
    [self.superview layoutIfNeeded];
}

- (void)_updateInsets:(BOOL)force {
    UIEdgeInsets insets = _edgeInset;
    if(_searchBar != nil) {
        _constraintSearchBarTop.constant = _edgeInset.top + _searchBarInset;
        insets.top += MIN(_searchBarInset, _searchBar.glb_frameHeight);
    }
    if(_topRefreshView != nil) {
        insets.top += MIN(_refreshViewInset.top, _topRefreshView.size);
    }
    if(_bottomRefreshView != nil) {
        insets.bottom += MIN(_refreshViewInset.bottom, _bottomRefreshView.size);
    }
    if(_leftRefreshView != nil) {
        insets.left += MIN(_refreshViewInset.left, _leftRefreshView.size);
    }
    if(_rightRefreshView != nil) {
        insets.right += MIN(_refreshViewInset.right, _rightRefreshView.size);
    }
    insets.top += _containerInset.top;
    insets.bottom += _containerInset.bottom;
    insets.left += _containerInset.left;
    insets.right += _containerInset.right;
    self.scrollIndicatorInsets = insets;
    if(force == YES) {
        self.contentInset = insets;
    }
}

- (void)_willBeginDragging {
    [_visibleItems glb_each:^(GLBDataViewItem* item) {
        if(item.cell != nil) {
            [item.cell _willBeginDragging];
        }
    }];
    _contentView.userInteractionEnabled = NO;
    _contentView.userInteractionEnabled = YES;
    _scrollBeginPosition = self.contentOffset;
    if(self.directionalLockEnabled == YES) {
        _scrollDirection = GLBDataViewDirectionUnknown;
    }
    if(self.pagingEnabled == NO) {
        if(_canDraggingSearchBar == NO) {
            if((_searchBar != nil) && (_searchBarIteractionEnabled == YES)) {
                switch(_searchBarStyle) {
                    case GLBDataViewSearchBarStyleStatic:
                        _canDraggingSearchBar = NO;
                        break;
                    case GLBDataViewSearchBarStyleInside:
                        _canDraggingSearchBar = ((_searchBar.searching == NO) && (_searchBar.editing == NO));
                        break;
                    case GLBDataViewSearchBarStyleOverlay: {
                        CGFloat searchBarHeight = _searchBar.glb_frameHeight;
                        if(self.glb_contentSizeHeight > self.glb_frameHeight + searchBarHeight) {
                            CGFloat inset = _edgeInset.top + _refreshViewInset.top + _containerInset.top;
                            if(_showedSearchBar == YES) {
                                _searchBarOverlayLastPosition = MAX(-inset, _scrollBeginPosition.y + _searchBar.glb_frameHeight);
                            } else {
                                _searchBarOverlayLastPosition = MAX(-inset, _scrollBeginPosition.y - _searchBar.glb_frameHeight);
                            }
                            _canDraggingSearchBar = ((_searchBar.searching == NO) && (_searchBar.editing == NO));
                        }
                        break;
                    }
                }
            }
        }
        if((_canDraggingTopRefresh == NO) && (_canDraggingBottomRefresh == NO) && (_canDraggingLeftRefresh == NO) && (_canDraggingRightRefresh == NO)) {
            if((_topRefreshView != nil) && (_topRefreshIteractionEnabled == YES)) {
                switch(_topRefreshView.state) {
                    case GLBDataRefreshViewStateIdle: _canDraggingTopRefresh = YES; break;
                    default: _canDraggingTopRefresh = NO; break;
                }
            }
            if((_bottomRefreshView != nil) && (_bottomRefreshIteractionEnabled == YES)) {
                switch(_bottomRefreshView.state) {
                    case GLBDataRefreshViewStateIdle: _canDraggingBottomRefresh = YES; break;
                    default: _canDraggingBottomRefresh = NO; break;
                }
            }
            if((_leftRefreshView != nil) && (_leftRefreshIteractionEnabled == YES)) {
                switch(_leftRefreshView.state) {
                    case GLBDataRefreshViewStateIdle: _canDraggingLeftRefresh = YES; break;
                    default: _canDraggingLeftRefresh = NO; break;
                }
            }
            if((_rightRefreshView != nil) && (_rightRefreshIteractionEnabled == YES)) {
                switch(_rightRefreshView.state) {
                    case GLBDataRefreshViewStateIdle: _canDraggingRightRefresh = YES; break;
                    default: _canDraggingRightRefresh = NO; break;
                }
            }
        }
    }
    [_container _willBeginDragging];
}

- (void)_didScrollDragging:(BOOL)dragging decelerating:(BOOL)decelerating {
    if(self.pagingEnabled == NO) {
        CGSize frameSize = self.glb_frameSize;
        CGPoint contentOffset = self.contentOffset;
        CGSize contentSize = self.contentSize;
        UIEdgeInsets contentInset = self.contentInset;
        CGFloat searchBarInset = _searchBarInset;
        UIEdgeInsets refreshViewInset = _refreshViewInset;
        if(self.bounces == YES) {
            if(self.alwaysBounceVertical == YES) {
                if(_bouncesTop == NO) {
                    contentOffset.y = MAX(-contentInset.top, contentOffset.y);
                }
                if((_bouncesBottom == NO) && (contentSize.height >= frameSize.height)) {
                    contentOffset.y = MIN(contentSize.height - frameSize.height + contentInset.bottom, contentOffset.y);
                }
            }
            if(self.alwaysBounceHorizontal == YES) {
                if(_bouncesLeft == NO) {
                    contentOffset.x = MAX(-contentInset.left, contentOffset.x);
                }
                if((_bouncesRight == NO) && (contentSize.width >= frameSize.width)) {
                    contentOffset.x = MIN(contentSize.width - frameSize.width + contentInset.right, contentOffset.x);
                }
            }
        }
        if((self.directionalLockEnabled == YES) && (dragging == YES)) {
            switch(_scrollDirection) {
                case GLBDataViewDirectionUnknown: {
                    CGFloat dx = ABS(contentOffset.x - _scrollBeginPosition.x);
                    CGFloat dy = ABS(contentOffset.y - _scrollBeginPosition.y);
                    if(dx > dy) {
                        _scrollDirection = GLBDataViewDirectionHorizontal;
                        contentOffset.y = _scrollBeginPosition.y;
                    } else if(dx < dy) {
                        _scrollDirection = GLBDataViewDirectionVertical;
                        contentOffset.x = _scrollBeginPosition.x;
                    }
                    break;
                }
                case GLBDataViewDirectionHorizontal:
                    contentOffset.y = _scrollBeginPosition.y;
                    break;
                case GLBDataViewDirectionVertical:
                    contentOffset.x = _scrollBeginPosition.x;
                    break;
            }
        }
        if(_canDraggingSearchBar == YES) {
            switch(_searchBarStyle) {
                case GLBDataViewSearchBarStyleStatic:
                    break;
                case GLBDataViewSearchBarStyleInside: {
                    CGFloat inset = _edgeInset.top + _refreshViewInset.top + _containerInset.top;
                    CGFloat offset = (-contentOffset.y) - inset;
                    CGFloat searchBarHeight = _searchBar.glb_frameHeight;
                    searchBarInset = MAX(0.0f, MIN(offset, searchBarHeight));
                    break;
                }
                case GLBDataViewSearchBarStyleOverlay: {
                    CGFloat diff = contentOffset.y - _searchBarOverlayLastPosition;
                    CGFloat searchBarHeight = _searchBar.glb_frameHeight;
                    CGFloat progress = ((searchBarInset - diff) * 0.5f) / searchBarHeight;
                    searchBarInset = MAX(0.0f, MIN(searchBarHeight * progress, searchBarHeight));
                    break;
                }
            }
        }
        if(_topRefreshView != nil) {
            CGFloat progress = 0.0f;
            if((_topRefreshIteractionEnabled == YES) && (contentSize.height > 0.0f)) {
                CGFloat inset = _edgeInset.top + searchBarInset + _containerInset.top;
                if(contentOffset.y < -inset) {
                    progress = -(contentOffset.y + inset);
                }
                if((_canDraggingTopRefresh == YES) && (dragging == YES)) {
                    switch(_topRefreshView.state) {
                        case GLBDataRefreshViewStateIdle:
                            if(progress > 0.0f) {
                                _topRefreshView.state = GLBDataRefreshViewStatePull;
                            }
                            break;
                        case GLBDataRefreshViewStatePull:
                        case GLBDataRefreshViewStateRelease:
                            if(_topRefreshView.triggeredOnRelease == YES) {
                                if(progress >= _topRefreshView.threshold) {
                                    _topRefreshView.state = GLBDataRefreshViewStateRelease;
                                }
                            } else {
                                if(progress <= 0.0f) {
                                    _topRefreshView.state = GLBDataRefreshViewStateIdle;
                                } else if(progress >= _topRefreshView.threshold) {
                                    _topRefreshView.state = GLBDataRefreshViewStateRelease;
                                } else {
                                    _topRefreshView.state = GLBDataRefreshViewStatePull;
                                }
                            }
                            break;
                        default:
                            break;
                    }
                    [_topRefreshView didProgress:progress / _topRefreshView.threshold];
                    refreshViewInset.top = progress;
                }
                if(progress < _topRefreshView.size) {
                    if(_searchBar != nil) {
                        _constraintTopRefreshTop.constant = -(_topRefreshView.size - progress);
                    } else {
                        _constraintTopRefreshTop.constant = _edgeInset.top - (_topRefreshView.size - progress);
                    }
                    _constraintTopRefreshSize.constant = _topRefreshView.size;
                } else {
                    if(_searchBar != nil) {
                        _constraintTopRefreshTop.constant = 0.0f;
                    } else {
                        _constraintTopRefreshTop.constant = _edgeInset.top;
                    }
                    _constraintTopRefreshSize.constant = progress;
                }
            }
        }
        if(_bottomRefreshView != nil) {
            CGFloat progress = 0.0f;
            if((_bottomRefreshIteractionEnabled == YES) && (contentSize.height >= frameSize.height)) {
                CGFloat inset = _edgeInset.bottom + _containerInset.bottom;
                CGFloat limit = (contentSize.height - frameSize.height) - inset;
                if(contentOffset.y > limit) {
                    progress = contentOffset.y - limit;
                }
                if((_canDraggingBottomRefresh == YES) && (dragging == YES)) {
                    switch(_bottomRefreshView.state) {
                        case GLBDataRefreshViewStateIdle:
                            if(progress > 0.0f) {
                                _bottomRefreshView.state = GLBDataRefreshViewStatePull;
                            }
                            break;
                        case GLBDataRefreshViewStatePull:
                        case GLBDataRefreshViewStateRelease:
                            if(_bottomRefreshView.triggeredOnRelease == YES) {
                                if(progress >= _bottomRefreshView.threshold) {
                                    _bottomRefreshView.state = GLBDataRefreshViewStateRelease;
                                }
                            } else {
                                if(progress <= 0.0f) {
                                    _bottomRefreshView.state = GLBDataRefreshViewStateIdle;
                                } else if(progress >= _bottomRefreshView.threshold) {
                                    _bottomRefreshView.state = GLBDataRefreshViewStateRelease;
                                } else {
                                    _bottomRefreshView.state = GLBDataRefreshViewStatePull;
                                }
                            }
                            break;
                        default:
                            break;
                    }
                    [_bottomRefreshView didProgress:progress / _topRefreshView.threshold];
                    refreshViewInset.bottom = progress;
                }
                if(progress < _bottomRefreshView.size) {
                    _constraintBottomRefreshBottom.constant = _edgeInset.bottom - (_bottomRefreshView.size - progress);
                    _constraintBottomRefreshSize.constant = _bottomRefreshView.size;
                } else {
                    _constraintBottomRefreshBottom.constant = _edgeInset.bottom;
                    _constraintBottomRefreshSize.constant = progress;
                }
            }
        }
        if(_leftRefreshView != nil) {
            CGFloat progress = 0.0f;
            if((_leftRefreshIteractionEnabled == YES) && (contentSize.width >= FLT_EPSILON)) {
                CGFloat inset = _edgeInset.left + _containerInset.left;
                if(contentOffset.x < -inset) {
                    progress = -(contentOffset.x + inset);
                }
                if((_canDraggingLeftRefresh == YES) && (dragging == YES)) {
                    switch(_leftRefreshView.state) {
                        case GLBDataRefreshViewStateIdle:
                            if(progress > 0.0f) {
                                _leftRefreshView.state = GLBDataRefreshViewStatePull;
                            }
                            break;
                        case GLBDataRefreshViewStatePull:
                        case GLBDataRefreshViewStateRelease:
                            if(_leftRefreshView.triggeredOnRelease == YES) {
                                if(progress >= _leftRefreshView.threshold) {
                                    _leftRefreshView.state = GLBDataRefreshViewStateRelease;
                                }
                            } else {
                                if(progress <= 0.0f) {
                                    _leftRefreshView.state = GLBDataRefreshViewStateIdle;
                                } else if(progress >= _leftRefreshView.threshold) {
                                    _leftRefreshView.state = GLBDataRefreshViewStateRelease;
                                } else {
                                    _leftRefreshView.state = GLBDataRefreshViewStatePull;
                                }
                            }
                            break;
                        default:
                            break;
                    }
                    [_leftRefreshView didProgress:progress / _topRefreshView.threshold];
                    refreshViewInset.left = progress;
                }
                if(progress < _leftRefreshView.size) {
                    _constraintLeftRefreshLeft.constant = _edgeInset.left - (_leftRefreshView.size - progress);
                    _constraintLeftRefreshSize.constant = _leftRefreshView.size;
                } else {
                    _constraintLeftRefreshLeft.constant = _edgeInset.left;
                    _constraintLeftRefreshSize.constant = progress;
                }
            }
        }
        if(_rightRefreshView != nil) {
            CGFloat progress = 0.0f;
            if((_rightRefreshIteractionEnabled == YES) && (contentSize.width >= frameSize.width)) {
                CGFloat inset = _edgeInset.right + _containerInset.right;
                CGFloat limit = (contentSize.width - frameSize.width) - inset;
                if(contentOffset.x > limit) {
                    progress = contentOffset.x - limit;
                }
                if((_canDraggingRightRefresh == YES) && (dragging == YES)) {
                    switch(_rightRefreshView.state) {
                        case GLBDataRefreshViewStateIdle:
                            if(progress > 0.0f) {
                                _rightRefreshView.state = GLBDataRefreshViewStatePull;
                            }
                            break;
                        case GLBDataRefreshViewStatePull:
                        case GLBDataRefreshViewStateRelease:
                            if(_rightRefreshView.triggeredOnRelease == YES) {
                                if(progress >= _rightRefreshView.threshold) {
                                    _rightRefreshView.state = GLBDataRefreshViewStateRelease;
                                }
                            } else {
                                if(progress <= 0.0f) {
                                    _rightRefreshView.state = GLBDataRefreshViewStateIdle;
                                } else if(progress >= _rightRefreshView.threshold) {
                                    _rightRefreshView.state = GLBDataRefreshViewStateRelease;
                                } else {
                                    _rightRefreshView.state = GLBDataRefreshViewStatePull;
                                }
                            }
                            break;
                        default:
                            break;
                    }
                    [_rightRefreshView didProgress:progress / _topRefreshView.threshold];
                    refreshViewInset.right = progress;
                }
                if(progress < _rightRefreshView.size) {
                    _constraintRightRefreshRight.constant = _edgeInset.right - (_rightRefreshView.size - progress);
                    _constraintRightRefreshSize.constant = _rightRefreshView.size;
                } else {
                    _constraintRightRefreshRight.constant = _edgeInset.right;
                    _constraintRightRefreshSize.constant = progress;
                }
            }
        }
        if((_searchBarInset != searchBarInset) || (UIEdgeInsetsEqualToEdgeInsets(_refreshViewInset, refreshViewInset) == NO)) {
            _searchBarInset = searchBarInset;
            _refreshViewInset = refreshViewInset;
            [self _updateInsets:(dragging == NO)];
        }
    }
    [_container _didScrollDragging:dragging decelerating:decelerating];
}

- (void)_willEndDraggingWithVelocity:(CGPoint)velocity contentOffset:(inout CGPoint*)contentOffset contentSize:(CGSize)contentSize visibleSize:(CGSize)visibleSize {
    if(self.pagingEnabled == NO) {
        if(_canDraggingSearchBar == YES) {
            CGFloat searchBarHeight = _searchBar.glb_frameHeight;
            switch(_searchBarStyle) {
                case GLBDataViewSearchBarStyleStatic:
                    _canDraggingSearchBar = NO;
                    break;
                case GLBDataViewSearchBarStyleInside: {
                    if(_searchBarInset >= (searchBarHeight * 0.33f)) {
                        [self _showSearchBarAnimated:YES velocity:velocity.y complete:^{
                            _canDraggingSearchBar = NO;
                        }];
                    } else {
                        [self _hideSearchBarAnimated:YES velocity:velocity.y complete:^{
                            _canDraggingSearchBar = NO;
                        }];
                    }
                    break;
                }
                case GLBDataViewSearchBarStyleOverlay: {
                    if(_searchBarInset >= (searchBarHeight * 0.33f)) {
                        [self _showSearchBarAnimated:YES velocity:velocity.y complete:^{
                            _canDraggingSearchBar = NO;
                        }];
                    } else {
                        [self _hideSearchBarAnimated:YES velocity:velocity.y complete:^{
                            _canDraggingSearchBar = NO;
                        }];
                    }
                    break;
                }
            }
        }
        if(_canDraggingTopRefresh == YES) {
            switch(_topRefreshView.state) {
                case GLBDataRefreshViewStateRelease: {
                    if([self containsActionForKey:GLBDataViewTopRefreshTriggered] == YES) {
                        [self _showTopRefreshAnimated:YES velocity:velocity.y complete:^{
                            [self performActionForKey:GLBDataViewTopRefreshTriggered withArguments:@[ self, _topRefreshView ]];
                            _canDraggingTopRefresh = NO;
                        }];
                    } else {
                        [self _hideTopRefreshAnimated:YES velocity:velocity.y complete:^{
                            _canDraggingTopRefresh = NO;
                        }];
                    }
                    break;
                }
                case GLBDataRefreshViewStatePull: {
                    [self _hideTopRefreshAnimated:YES velocity:velocity.y complete:^{
                        _canDraggingTopRefresh = NO;
                    }];
                    break;
                }
                default:
                    _canDraggingTopRefresh = NO;
                    break;
            }
        }
        if(_canDraggingBottomRefresh == YES) {
            switch(_bottomRefreshView.state) {
                case GLBDataRefreshViewStateRelease: {
                    if([self containsActionForKey:GLBDataViewBottomRefreshTriggered] == YES) {
                        [self _showBottomRefreshAnimated:YES velocity:velocity.y complete:^{
                            [self performActionForKey:GLBDataViewBottomRefreshTriggered withArguments:@[ self, _bottomRefreshView ]];
                            _canDraggingBottomRefresh = NO;
                        }];
                    } else {
                        [self _hideBottomRefreshAnimated:YES velocity:velocity.y complete:^{
                            _canDraggingBottomRefresh = NO;
                        }];
                    }
                    break;
                }
                case GLBDataRefreshViewStatePull: {
                    [self _hideBottomRefreshAnimated:YES velocity:velocity.y complete:^{
                        _canDraggingBottomRefresh = NO;
                    }];
                    break;
                }
                default:
                    _canDraggingBottomRefresh = NO;
                    break;
            }
        }
        if(_canDraggingLeftRefresh == YES) {
            switch(_leftRefreshView.state) {
                case GLBDataRefreshViewStateRelease: {
                    if([self containsActionForKey:GLBDataViewLeftRefreshTriggered] == YES) {
                        [self _showLeftRefreshAnimated:YES velocity:velocity.x complete:^{
                            [self performActionForKey:GLBDataViewLeftRefreshTriggered withArguments:@[ self, _leftRefreshView ]];
                            _canDraggingLeftRefresh = NO;
                        }];
                    } else {
                        [self _hideLeftRefreshAnimated:YES velocity:velocity.x complete:^{
                            _canDraggingLeftRefresh = NO;
                        }];
                    }
                    break;
                }
                case GLBDataRefreshViewStatePull: {
                    [self _hideLeftRefreshAnimated:YES velocity:velocity.x complete:^{
                        _canDraggingLeftRefresh = NO;
                    }];
                    break;
                }
                default:
                    _canDraggingLeftRefresh = NO;
                    break;
            }
        }
        if(_canDraggingRightRefresh == YES) {
            switch(_rightRefreshView.state) {
                case GLBDataRefreshViewStateRelease: {
                    if([self containsActionForKey:GLBDataViewRightRefreshTriggered] == YES) {
                        [self _showRightRefreshAnimated:YES velocity:velocity.x complete:^{
                            [self performActionForKey:GLBDataViewLeftRefreshTriggered withArguments:@[ self, _rightRefreshView ]];
                            _canDraggingRightRefresh = NO;
                        }];
                    } else {
                        [self _hideRightRefreshAnimated:YES velocity:velocity.x complete:^{
                            _canDraggingRightRefresh = NO;
                        }];
                    }
                    break;
                }
                case GLBDataRefreshViewStatePull: {
                    [self _hideRightRefreshAnimated:YES velocity:velocity.x complete:^{
                        _canDraggingRightRefresh = NO;
                    }];
                    break;
                }
                default:
                    _canDraggingRightRefresh = NO;
                    break;
            }
        }
    }
    [_container _willEndDraggingWithVelocity:velocity contentOffset:contentOffset contentSize:contentSize visibleSize:visibleSize];
}

- (void)_didEndDraggingWillDecelerate:(BOOL)decelerate {
    if(decelerate == NO) {
#if __has_include("GLBPageControl.h")
        [_pageControl updatePageNumberForScrollView:self];
#endif
    }
    [_container _didEndDraggingWillDecelerate:decelerate];
}

- (void)_willBeginDecelerating {
    [_container _willBeginDecelerating];
}

- (void)_didEndDecelerating {
#if __has_include("GLBPageControl.h")
    [_pageControl updatePageNumberForScrollView:self];
#endif
    [_container _didEndDecelerating];
}

- (void)_didEndScrollingAnimation {
#if __has_include("GLBPageControl.h")
        [_pageControl updatePageNumberForScrollView:self];
#endif
    [_container _didEndScrollingAnimation];
}

- (void)_showSearchBarAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(GLBSimpleBlock)complete {
    _showedSearchBar = YES;
    
    CGFloat from = _searchBarInset;
    CGFloat to = _searchBar.glb_frameHeight;
    [self _updateSuperviewConstraints];
    
    if(animated == YES) {
        [UIView animateWithDuration:ABS(from - to) / ABS(velocity)
                              delay:0.01f
                            options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut)
                         animations:^{
                             [self _setSearchBarInset:to force:YES];
                             [self.superview layoutIfNeeded];
                         } completion:^(BOOL finished) {
                             if(complete != nil) {
                                 complete();
                             }
                         }];
    } else {
        [self _setSearchBarInset:to force:YES];
        if(complete != nil) {
            complete();
        }
    }
}

- (void)_hideSearchBarAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(GLBSimpleBlock)complete {
    _showedSearchBar = NO;
    
    CGFloat from = _searchBarInset;
    CGFloat to = 0.0f;
    [self _updateSuperviewConstraints];
    
    if(animated == YES) {
        [UIView animateWithDuration:ABS(from - to) / ABS(velocity)
                              delay:0.01f
                            options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut)
                         animations:^{
                             [self _setSearchBarInset:to force:YES];
                             [self.superview layoutIfNeeded];
                         } completion:^(BOOL finished) {
                             if(complete != nil) {
                                 complete();
                             }
                         }];
    } else {
        [self _setSearchBarInset:to force:YES];
        if(complete != nil) {
            complete();
        }
    }
}

- (void)_showTopRefreshAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(GLBSimpleBlock)complete {
    [_topRefreshView _showAnimated:animated velocity:velocity complete:complete];
}

- (void)_hideTopRefreshAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(GLBSimpleBlock)complete {
    [_topRefreshView _hideAnimated:animated velocity:velocity complete:complete];
}

- (void)_showBottomRefreshAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(GLBSimpleBlock)complete {
    [_bottomRefreshView _showAnimated:animated velocity:velocity complete:complete];
}

- (void)_hideBottomRefreshAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(GLBSimpleBlock)complete {
    [_bottomRefreshView _hideAnimated:animated velocity:velocity complete:complete];
}

- (void)_showLeftRefreshAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(GLBSimpleBlock)complete {
    [_leftRefreshView _showAnimated:animated velocity:velocity complete:complete];
}

- (void)_hideLeftRefreshAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(GLBSimpleBlock)complete {
    [_leftRefreshView _hideAnimated:animated velocity:velocity complete:complete];
}

- (void)_showRightRefreshAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(GLBSimpleBlock)complete {
    [_rightRefreshView _showAnimated:animated velocity:velocity complete:complete];
}

- (void)_hideRightRefreshAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(GLBSimpleBlock)complete {
    [_rightRefreshView _hideAnimated:animated velocity:velocity complete:complete];
}

- (void)_changedPageControl {
#if __has_include("GLBPageControl.h")
    [_pageControl setScrollViewContentOffsetForCurrentPage:self animated:YES];
#endif
}

- (void)_animateContentOffset:(CADisplayLink*)displayLink {
    if(_scrollBeginTime > DBL_EPSILON) {
        CFTimeInterval deltaTime = _scrollDisplayLink.timestamp - _scrollBeginTime;
        CGFloat progress = (CGFloat)(deltaTime / _scrollDuration);
        if(progress < 1.0f) {
            CGFloat adjustedProgress = (CGFloat)GLBDataViewTimingFunctionValue(_scrollTimingFunction, progress);
            if(1.0f - adjustedProgress < 0.001f) {
                [self _stopAnimateContentOffset];
            } else {
                [self _animateContentOffsetByProgress:adjustedProgress];
            }
        } else {
            [self _stopAnimateContentOffset];
        }
    } else {
        _scrollBeginTime = _scrollDisplayLink.timestamp;
        _scrollBeginContentOffset = self.contentOffset;
    }
}

- (void)_animateContentOffsetByProgress:(CGFloat)progress {
    self.contentOffset = GLBPointAddPoint(_scrollBeginContentOffset, GLBPointMul(_scrollDeltaContentOffset, progress));
}

- (void)_stopAnimateContentOffset {
    _scrollDisplayLink.paused = YES;
    _scrollBeginTime = 0.0;
    self.contentOffset = GLBPointAddPoint(_scrollBeginContentOffset, _scrollDeltaContentOffset);
    if([self.delegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)] == YES) {
        [self.delegate scrollViewDidEndScrollingAnimation:self];
    }
}

#pragma mark - Actions

- (void)_handlerLongPressGestureRecognizer:(UILongPressGestureRecognizer*)gestureRecognizer {
    CGPoint location = [gestureRecognizer locationInView:self];
    switch(gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            GLBDataViewItem* item = [self itemForPoint:location];
            [self batchDuration:GLBDataViewMovingDuration update:^{
                [self beganMoveItem:item animated:YES];
                [_container _beginMovingItem:_movingItem location:location];
                [self performActionForKey:GLBDataViewMovingBegin withArguments:@[ item ]];
            }];
            _movingItemLastOffset = location;
            break;
        }
        case UIGestureRecognizerStateChanged: {
            if(_movingItem != nil) {
                CGRect bounds = self.bounds;
                CGPoint contentOffset = self.contentOffset;
                CGSize contentSize = self.contentSize;
                CGPoint moveContentOffset = CGPointZero;
                CGRect itemFrame = _movingItem.updateFrame;
                if(contentSize.width > bounds.size.width) {
                    CGFloat bsx = CGRectGetMinX(bounds);
                    CGFloat bex = CGRectGetMaxX(bounds);
                    CGFloat lw = itemFrame.size.width;
                    CGFloat lsx = location.x - lw;
                    CGFloat lex = location.x + lw;
                    if((bsx > lsx) && (bsx > 0.0f)) {
                        moveContentOffset.x = (lsx - bsx) / (lw * 0.25f);
                    } else if((bex < lex) && (bex < contentSize.width)) {
                        moveContentOffset.x = (lex - bex) / (lw * 0.25f);
                    }
                }
                if(contentSize.height > bounds.size.height) {
                    CGFloat bsy = CGRectGetMinY(bounds);
                    CGFloat bey = CGRectGetMaxY(bounds);
                    CGFloat lh = itemFrame.size.height;
                    CGFloat lsy = location.y - lh;
                    CGFloat ley = location.y + lh;
                    if((bsy > lsy) && (bsy > 0.0f)) {
                        moveContentOffset.y = (lsy - bsy) / (lh * 0.25f);
                    } else if((bey < ley) && (bey < contentSize.height)) {
                        moveContentOffset.y = (ley - bey) / (lh * 0.25f);
                    }
                }
                location.x += moveContentOffset.x;
                location.y += moveContentOffset.y;
                CGPoint delta = CGPointMake(location.x - _movingItemLastOffset.x, location.y - _movingItemLastOffset.y);
                BOOL allowsSorting = (_updating == NO);
                if((ABS(moveContentOffset.x) > FLT_EPSILON) || (ABS(moveContentOffset.y) > FLT_EPSILON)) {
                    CGPoint newContentOffset = CGPointMake(contentOffset.x + moveContentOffset.x, contentOffset.y + moveContentOffset.y);
                    [UIView animateWithDuration:GLBDataViewMovingDuration animations:^{
                        [self setContentOffset:newContentOffset animated:NO];
                        [_container _movingItem:_movingItem location:location delta:delta allowsSorting:allowsSorting];
                    } completion:^(BOOL finished) {
                        [self _handlerLongPressGestureRecognizer:gestureRecognizer];
                    }];
                } else {
                    [_container _movingItem:_movingItem location:location delta:delta allowsSorting:allowsSorting];
                }
                _movingItemLastOffset = location;
            }
            break;
        }
        default: {
            GLBDataViewItem* item = _movingItem;
            if(item != nil) {
                [self batchDuration:GLBDataViewMovingDuration update:^{
                    [_container _endMovingItem:_movingItem location:location];
                    [self endedMoveItemAnimated:YES];
                    [self performActionForKey:GLBDataViewMovingEnd withArguments:@[ item ]];
                }];
            }
            break;
        }
    }
}

#pragma mark - GLBScrollViewExtension

- (void)saveInputState {
    _saveContainerInset = _containerInset;
}

- (void)showInputIntersectionRect:(CGRect)intersectionRect {
    self.containerInsetBottom = intersectionRect.size.height;
}

- (void)restoreInputState {
    self.containerInset = _saveContainerInset;
}

#pragma mark - GLBSearchBarDelegate

- (void)searchBarBeginSearch:(GLBSearchBar*)searchBar {
    [self performActionForKey:GLBDataViewSearchBegin withArguments:@[ searchBar ]];
    [_container searchBarBeginSearch:searchBar];
}

- (void)searchBarEndSearch:(GLBSearchBar*)searchBar {
    [self performActionForKey:GLBDataViewSearchEnd withArguments:@[ searchBar ]];
    [_container searchBarEndSearch:searchBar];
}

- (void)searchBarBeginEditing:(GLBSearchBar*)searchBar {
    [self performActionForKey:GLBDataViewSearchBeginEditing withArguments:@[ searchBar ]];
    [_container searchBarBeginEditing:searchBar];
}

- (void)searchBar:(GLBSearchBar*)searchBar textChanged:(NSString*)textChanged {
    [self performActionForKey:GLBDataViewSearchTextChanged withArguments:@[ searchBar, textChanged ]];
    [_container searchBar:searchBar textChanged:textChanged];
}

- (void)searchBarEndEditing:(GLBSearchBar*)searchBar {
    [self performActionForKey:GLBDataViewSearchEndEditing withArguments:@[ searchBar ]];
    [_container searchBarEndEditing:searchBar];
}

- (void)searchBarPressedClear:(GLBSearchBar*)searchBar {
    [self performActionForKey:GLBDataViewSearchPressedClear withArguments:@[ searchBar ]];
    [_container searchBarPressedClear:searchBar];
}

- (void)searchBarPressedReturn:(GLBSearchBar*)searchBar {
    [self performActionForKey:GLBDataViewSearchPressedReturn withArguments:@[ searchBar ]];
    [_container searchBarPressedReturn:searchBar];
}

- (void)searchBarPressedCancel:(GLBSearchBar*)searchBar {
    [self performActionForKey:GLBDataViewSearchPressedCancel withArguments:@[ searchBar ]];
    [_container searchBarPressedCancel:searchBar];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    if(gestureRecognizer == _longPressGestureRecognizer) {
        CGPoint location = [gestureRecognizer locationInView:self];
        GLBDataViewItem* item = [self itemForPoint:location];
        return [self shouldBeganMoveItem:item];
    }
    return YES;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

double GLBDataViewCubicFunctionValue(double a, double b, double c, double d, double x) {
    return (a * x * x * x) + (b * x * x) + (c * x) + d;
}

double GLBDataViewCubicDerivativeValue(double a, double b, double c, double __unused d, double x) {
    return (3 * a * x * x) + (2 * b * x) + c;
}

double GLBDataViewRootOfCubic(double a, double b, double c, double d, double x) {
    double lx = 1;
    int y = 0;
    while((y <= GLBDataViewMaximumSteps) && (fabs(lx - x) > GLBDataViewApproximationTolerance)) {
        lx = x;
        x = x - (GLBDataViewCubicFunctionValue(a, b, c, d, x) / GLBDataViewCubicDerivativeValue(a, b, c, d, x));
        y++;
    }
    return x;
}

double GLBDataViewTimingFunctionValue(CAMediaTimingFunction* function, double x) {
    float a[2], b[2], c[2], d[2];
    [function getControlPointAtIndex:0 values:a];
    [function getControlPointAtIndex:1 values:b];
    [function getControlPointAtIndex:2 values:c];
    [function getControlPointAtIndex:3 values:d];
    double t = GLBDataViewRootOfCubic(-a[0] + 3 * b[0] - 3 * c[0] + d[0], 3 * a[0] - 6 * b[0] + 3 * c[0], -3 * a[0] + 3 * b[0], a[0] - x, x);
    return GLBDataViewCubicFunctionValue(-a[1] + 3 * b[1] - 3 * c[1] + d[1], 3 * a[1] - 6 * b[1] + 3 * c[1], -3 * a[1] + 3 * b[1], a[1], t);
}

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBDataContentView

#pragma mark - NSKeyValueCoding

#pragma mark - Init / Free

- (instancetype)initWithCoder:(NSCoder*)coder {
    self = [super initWithCoder:coder];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.autoresizingMask = UIViewAutoresizingNone;
    self.translatesAutoresizingMaskIntoConstraints = YES;
    self.clipsToBounds = YES;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBDataBatch

#pragma mark - Init / Free

- (instancetype)initWithDuration:(NSTimeInterval)duration update:(GLBSimpleBlock)update complete:(GLBSimpleBlock)complete {
    self = [super init];
    if(self != nil) {
        _duration = duration;
        _update = update;
        _complete = complete;
        [self setup];
    }
    return self;
}

- (void)setup {
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBDataViewDelegateProxy

#pragma mark - Init / Free

- (instancetype)initWithDataView:(GLBDataView*)view {
    self = [super init];
    if(self != nil) {
        _view = view;
    }
    return self;
}

#pragma mark - NSObject

- (BOOL)respondsToSelector:(SEL)selector {
    return (([_delegate respondsToSelector:selector] == YES) || ([super respondsToSelector:selector] == YES));
}

- (void)forwardInvocation:(NSInvocation*)invocation {
    [invocation invokeWithTarget:_delegate];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView*)scrollView {
    [_view _willBeginDragging];
    if([_delegate respondsToSelector:_cmd] == YES) {
        [_delegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    [_view _didScrollDragging:_view.dragging decelerating:_view.decelerating];
    if([_delegate respondsToSelector:_cmd] == YES) {
        [_delegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView*)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint*)targetContentOffset {
    CGFloat vx = (ABS(velocity.x) > FLT_EPSILON) ? (velocity.x * 1000.0f) : _view.velocity;
    CGFloat vy = (ABS(velocity.y) > FLT_EPSILON) ? (velocity.y * 1000.0f) : _view.velocity;
    CGFloat nvx = MAX(_view.velocityMin, MIN(ABS(vx), _view.velocityMax));
    CGFloat nvy = MAX(_view.velocityMin, MIN(ABS(vy), _view.velocityMax));
    [_view _willEndDraggingWithVelocity:CGPointMake((vx > FLT_EPSILON) ? nvx : -nvx, (vy > FLT_EPSILON) ? nvy : -nvy) contentOffset:targetContentOffset contentSize:scrollView.contentSize visibleSize:_view.glb_boundsSize];
    if([_delegate respondsToSelector:_cmd] == YES) {
        [_delegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate {
    [_view _didEndDraggingWillDecelerate:decelerate];
    if([_delegate respondsToSelector:_cmd] == YES) {
        [_delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView*)scrollView {
    [_view _willBeginDecelerating];
    if([_delegate respondsToSelector:_cmd] == YES) {
        [_delegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView {
    [_view _didEndDecelerating];
    if([_delegate respondsToSelector:_cmd] == YES) {
        [_delegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView*)scrollView {
    [_view _didEndScrollingAnimation];
    if([_delegate respondsToSelector:_cmd] == YES) {
        [_delegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView*)scrollView {
    if([_delegate respondsToSelector:_cmd] == YES) {
        return [_delegate scrollViewShouldScrollToTop:scrollView];
    }
    return YES;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

NSString* GLBDataViewSelectItem = @"GLBDataViewSelectItem";
NSString* GLBDataViewDeselectItem = @"GLBDataViewDeselectItem";

/*--------------------------------------------------*/

NSString* GLBDataViewMovingBegin = @"GLBDataViewMovingBegin";
NSString* GLBDataViewMovingEnd = @"GLBDataViewMovingEnd";

/*--------------------------------------------------*/

NSString* GLBDataViewSearchBegin = @"GLBDataViewSearchBegin";
NSString* GLBDataViewSearchEnd = @"GLBDataViewSearchEnd";
NSString* GLBDataViewSearchBeginEditing = @"GLBDataViewSearchBeginEditing";
NSString* GLBDataViewSearchTextChanged = @"GLBDataViewSearchTextChanged";
NSString* GLBDataViewSearchEndEditing = @"GLBDataViewSearchEndEditing";
NSString* GLBDataViewSearchPressedClear = @"GLBDataViewSearchPressedClear";
NSString* GLBDataViewSearchPressedReturn = @"GLBDataViewSearchPressedReturn";
NSString* GLBDataViewSearchPressedCancel = @"GLBDataViewSearchPressedCancel";

/*--------------------------------------------------*/

NSString* GLBDataViewTopRefreshTriggered = @"GLBDataViewTopRefreshTriggered";
NSString* GLBDataViewBottomRefreshTriggered = @"GLBDataViewBottomRefreshTriggered";
NSString* GLBDataViewLeftRefreshTriggered = @"GLBDataViewLeftRefreshTriggered";
NSString* GLBDataViewRightRefreshTriggered = @"GLBDataViewRightRefreshTriggered";

/*--------------------------------------------------*/

NSString* GLBDataViewAnimateRestore = @"GLBDataViewAnimateRestore";
NSString* GLBDataViewAnimateInsert = @"GLBDataViewAnimateInsert";
NSString* GLBDataViewAnimateDelete = @"GLBDataViewAnimateDelete";
NSString* GLBDataViewAnimateReplaceOut = @"GLBDataViewAnimateReplaceOut";
NSString* GLBDataViewAnimateReplaceIn = @"GLBDataViewAnimateReplaceIn";

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
