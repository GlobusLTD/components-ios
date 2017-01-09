/*--------------------------------------------------*/

#import "GLBDataView.h"
#import "GLBDataContentView.h"
#import "GLBDataViewContainer+Private.h"
#import "GLBDataViewItem+Private.h"
#import "GLBDataViewCell+Private.h"
#import "GLBDataRefreshView+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBDataViewDirection) {
    GLBDataViewDirectionUnknown,
    GLBDataViewDirectionHorizontal,
    GLBDataViewDirectionVertical
};

/*--------------------------------------------------*/

@class GLBDataViewDelegateProxy;

/*--------------------------------------------------*/

@interface GLBDataView () {
@protected
    GLBDataViewDelegateProxy* _delegateProxy;
    GLBDataContentView* _contentView;
    CGFloat _velocity;
    CGFloat _velocityMin;
    CGFloat _velocityMax;
    BOOL _allowsSelection;
    BOOL _allowsMultipleSelection;
    BOOL _allowsOnceSelection;
    BOOL _allowsEditing;
    BOOL _allowsMultipleEditing;
    BOOL _allowsMoving;
    BOOL _bouncesTop;
    BOOL _bouncesLeft;
    BOOL _bouncesRight;
    BOOL _bouncesBottom;
    GLBDataViewDirection _scrollDirection;
    CGPoint _scrollBeginPosition;
    UIEdgeInsets _edgeInset;
    GLBDataViewContainer* _container;
    UIEdgeInsets _containerInset;
    UIEdgeInsets _saveContainerInset;
    NSMutableArray* _visibleItems;
    NSMutableArray* _selectedItems;
    NSMutableArray* _highlightedItems;
    NSMutableArray* _editingItems;
    GLBDataViewItem* _movingItem;
    CGPoint _movingItemLastOffset;
    GLBActions* _registersActions;
    NSMutableArray* _queueBatch;
    NSMutableArray* _reloadedBeforeItems;
    NSMutableArray* _reloadedAfterItems;
    NSMutableArray* _deletedItems;
    NSMutableArray* _insertedItems;
    BOOL _animating;
    BOOL _updating;
    BOOL _transiting;
    BOOL _invalidLayout;
    BOOL _invalidatingLayout;
    __weak GLBPageControl* _pageControl;
    BOOL _searchBarIteractionEnabled;
    BOOL _showedSearchBar;
    GLBDataViewSearchBarStyle _searchBarStyle;
    CGFloat _searchBarOverlayLastPosition;
    GLBSearchBar* _searchBar;
    CGFloat _searchBarInset;
    __weak NSLayoutConstraint* _constraintSearchBarTop;
    __weak NSLayoutConstraint* _constraintSearchBarLeft;
    __weak NSLayoutConstraint* _constraintSearchBarRight;
    __weak NSLayoutConstraint* _constraintSearchBarSize;
    BOOL _topRefreshIteractionEnabled;
    BOOL _topRefreshBelowDataView;
    GLBDataRefreshView* _topRefreshView;
    __weak NSLayoutConstraint* _constraintTopRefreshTop;
    __weak NSLayoutConstraint* _constraintTopRefreshLeft;
    __weak NSLayoutConstraint* _constraintTopRefreshRight;
    __weak NSLayoutConstraint* _constraintTopRefreshSize;
    BOOL _bottomRefreshIteractionEnabled;
    BOOL _bottomRefreshBelowDataView;
    GLBDataRefreshView* _bottomRefreshView;
    __weak NSLayoutConstraint* _constraintBottomRefreshBottom;
    __weak NSLayoutConstraint* _constraintBottomRefreshLeft;
    __weak NSLayoutConstraint* _constraintBottomRefreshRight;
    __weak NSLayoutConstraint* _constraintBottomRefreshSize;
    BOOL _leftRefreshIteractionEnabled;
    BOOL _leftRefreshBelowDataView;
    GLBDataRefreshView* _leftRefreshView;
    __weak NSLayoutConstraint* _constraintLeftRefreshBottom;
    __weak NSLayoutConstraint* _constraintLeftRefreshLeft;
    __weak NSLayoutConstraint* _constraintLeftRefreshSize;
    BOOL _rightRefreshIteractionEnabled;
    BOOL _rightRefreshBelowDataView;
    GLBDataRefreshView* _rightRefreshView;
    __weak NSLayoutConstraint* _constraintRightRefreshTop;
    __weak NSLayoutConstraint* _constraintRightRefreshBottom;
    __weak NSLayoutConstraint* _constraintRightRefreshRight;
    __weak NSLayoutConstraint* _constraintRightRefreshSize;
    UIEdgeInsets _refreshViewInset;
    CADisplayLink* _scrollDisplayLink;
    CAMediaTimingFunction* _scrollTimingFunction;
    CFTimeInterval _scrollDuration;
    BOOL _scrollAnimationStarted;
    CFTimeInterval _scrollBeginTime;
    CGPoint _scrollBeginContentOffset;
    CGPoint _scrollDeltaContentOffset;
    BOOL _canDraggingSearchBar;
    BOOL _canDraggingTopRefresh;
    BOOL _canDraggingBottomRefresh;
    BOOL _canDraggingLeftRefresh;
    BOOL _canDraggingRightRefresh;
}

@property(nonatomic, nullable, strong) GLBDataViewDelegateProxy* delegateProxy;
@property(nonatomic) GLBDataViewDirection scrollDirection;
@property(nonatomic) UIEdgeInsets saveContainerInset;
@property(nonatomic) CGPoint scrollBeginPosition;

@property(nonatomic) CGPoint movingItemLastOffset;

@property(nonatomic, nonnull, strong) GLBActions* registersActions;
@property(nonatomic, nonnull, strong) NSMutableArray* queueBatch;
@property(nonatomic, nonnull, strong) NSMutableArray* reloadedBeforeItems;
@property(nonatomic, nonnull, strong) NSMutableArray* reloadedAfterItems;
@property(nonatomic, nonnull, strong) NSMutableArray* deletedItems;
@property(nonatomic, nonnull, strong) NSMutableArray* insertedItems;
@property(nonatomic, getter=isAnimating) BOOL animating;
@property(nonatomic, getter=isUpdating) BOOL updating;
@property(nonatomic) BOOL invalidLayout;

@property(nonatomic) CGFloat searchBarInset;
@property(nonatomic) CGFloat searchBarOverlayLastPosition;
@property(nonatomic, nullable, weak) NSLayoutConstraint* constraintSearchBarTop;
@property(nonatomic, nullable, weak) NSLayoutConstraint* constraintSearchBarLeft;
@property(nonatomic, nullable, weak) NSLayoutConstraint* constraintSearchBarRight;

@property(nonatomic) UIEdgeInsets refreshViewInset;
@property(nonatomic, nullable, weak) NSLayoutConstraint* constraintTopRefreshTop;
@property(nonatomic, nullable, weak) NSLayoutConstraint* constraintTopRefreshLeft;
@property(nonatomic, nullable, weak) NSLayoutConstraint* constraintTopRefreshRight;
@property(nonatomic, nullable, weak) NSLayoutConstraint* constraintTopRefreshSize;
@property(nonatomic, nullable, weak) NSLayoutConstraint* constraintBottomRefreshBottom;
@property(nonatomic, nullable, weak) NSLayoutConstraint* constraintBottomRefreshLeft;
@property(nonatomic, nullable, weak) NSLayoutConstraint* constraintBottomRefreshRight;
@property(nonatomic, nullable, weak) NSLayoutConstraint* constraintBottomRefreshSize;
@property(nonatomic, nullable, weak) NSLayoutConstraint* constraintLeftRefreshTop;
@property(nonatomic, nullable, weak) NSLayoutConstraint* constraintLeftRefreshBottom;
@property(nonatomic, nullable, weak) NSLayoutConstraint* constraintLeftRefreshLeft;
@property(nonatomic, nullable, weak) NSLayoutConstraint* constraintLeftRefreshSize;
@property(nonatomic, nullable, weak) NSLayoutConstraint* constraintRightRefreshTop;
@property(nonatomic, nullable, weak) NSLayoutConstraint* constraintRightRefreshBottom;
@property(nonatomic, nullable, weak) NSLayoutConstraint* constraintRightRefreshRight;
@property(nonatomic, nullable, weak) NSLayoutConstraint* constraintRightRefreshSize;

@property(nonatomic, nullable, strong) CADisplayLink* scrollDisplayLink;
@property(nonatomic, nullable, strong) CAMediaTimingFunction* scrollTimingFunction;
@property(nonatomic) CFTimeInterval scrollDuration;
@property(nonatomic) BOOL scrollAnimationStarted;
@property(nonatomic) CFTimeInterval scrollBeginTime;
@property(nonatomic) CGPoint scrollBeginContentOffset;
@property(nonatomic) CGPoint scrollDeltaContentOffset;

@property(nonatomic) BOOL canDraggingSearchBar;
@property(nonatomic) BOOL canDraggingTopRefresh;
@property(nonatomic) BOOL canDraggingBottomRefresh;
@property(nonatomic) BOOL canDraggingLeftRefresh;
@property(nonatomic) BOOL canDraggingRightRefresh;

@property(nonatomic, nullable, strong) UILongPressGestureRecognizer* longPressGestureRecognizer;

- (void)setEdgeInset:(UIEdgeInsets)edgeInset force:(BOOL)force;
- (void)setContainerInset:(UIEdgeInsets)containerInset force:(BOOL)force;
- (void)setSearchBarInset:(CGFloat)searchBarInset force:(BOOL)force;
- (void)setRefreshViewInset:(UIEdgeInsets)refreshViewInset force:(BOOL)force;

- (void)pressedItem:(GLBDataViewItem* _Nonnull)item animated:(BOOL)animated;

- (void)appearItem:(GLBDataViewItem* _Nonnull)item;
- (void)disappearItem:(GLBDataViewItem* _Nonnull)item;

- (void)didInsertItems:(NSArray< GLBDataViewCell* >* _Nonnull)items;
- (void)didDeleteItems:(NSArray< GLBDataViewCell* >* _Nonnull)items;
- (void)didReplaceOriginItems:(NSArray< GLBDataViewCell* >* _Nonnull)originItems withItems:(NSArray< GLBDataViewCell* >* _Nonnull)items;

@end

/*--------------------------------------------------*/

@interface GLBDataBatch : NSObject

@property(nonatomic, readonly, assign) NSTimeInterval duration;
@property(nonatomic, nullable, readonly, copy) GLBSimpleBlock update;
@property(nonatomic, nullable, readonly, copy) GLBSimpleBlock complete;

- (instancetype _Nonnull)initWithDuration:(NSTimeInterval)duration update:(GLBSimpleBlock _Nullable)update complete:(GLBSimpleBlock _Nullable)complete;

@end

/*--------------------------------------------------*/

@interface GLBDataViewDelegateProxy : NSObject< UIScrollViewDelegate > {
@protected
    __weak GLBDataView* _view;
    __weak id< UIScrollViewDelegate > _delegate;
    BOOL _lockDidScroll;
}

@property(nonatomic, nullable, weak) GLBDataView* view;
@property(nonatomic, nullable, weak) id< UIScrollViewDelegate > delegate;

- (instancetype _Nonnull)initWithDataView:(GLBDataView* _Nonnull)view;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
