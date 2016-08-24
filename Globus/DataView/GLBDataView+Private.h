/*--------------------------------------------------*/

#import "GLBDataView.h"
#import "GLBDataContainer+Private.h"
#import "GLBDataItem+Private.h"
#import "GLBDataCell+Private.h"
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
@class GLBDataContentView;

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
    GLBDataContainer* _container;
    UIEdgeInsets _containerInset;
    UIEdgeInsets _saveContainerInset;
    NSMutableArray* _visibleItems;
    NSMutableArray* _selectedItems;
    NSMutableArray* _highlightedItems;
    NSMutableArray* _editingItems;
    GLBDataItem* _movingItem;
    CGPoint _movingItemLastOffset;
    NSMutableDictionary* _registersViews;
    GLBActions* _registersActions;
    NSMutableDictionary* _queueCells;
    NSMutableArray* _queueBatch;
    NSMutableArray* _reloadedBeforeItems;
    NSMutableArray* _reloadedAfterItems;
    NSMutableArray* _deletedItems;
    NSMutableArray* _insertedItems;
    BOOL _animating;
    BOOL _updating;
    BOOL _transiting;
    BOOL _invalidLayout;
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

@property(nonatomic, strong) GLBDataViewDelegateProxy* delegateProxy;
@property(nonatomic) GLBDataViewDirection scrollDirection;
@property(nonatomic) UIEdgeInsets saveContainerInset;
@property(nonatomic) CGPoint scrollBeginPosition;

@property(nonatomic) CGPoint movingItemLastOffset;

@property(nonatomic, strong) NSMutableDictionary* registersViews;
@property(nonatomic, strong) GLBActions* registersActions;
@property(nonatomic, strong) NSMutableDictionary* queueCells;
@property(nonatomic, strong) NSMutableArray* queueBatch;
@property(nonatomic, strong) NSMutableArray* reloadedBeforeItems;
@property(nonatomic, strong) NSMutableArray* reloadedAfterItems;
@property(nonatomic, strong) NSMutableArray* deletedItems;
@property(nonatomic, strong) NSMutableArray* insertedItems;
@property(nonatomic, getter=isAnimating) BOOL animating;
@property(nonatomic, getter=isUpdating) BOOL updating;
@property(nonatomic) BOOL invalidLayout;

@property(nonatomic) CGFloat searchBarInset;
@property(nonatomic) CGFloat searchBarOverlayLastPosition;
@property(nonatomic, weak) NSLayoutConstraint* constraintSearchBarTop;
@property(nonatomic, weak) NSLayoutConstraint* constraintSearchBarLeft;
@property(nonatomic, weak) NSLayoutConstraint* constraintSearchBarRight;

@property(nonatomic) UIEdgeInsets refreshViewInset;
@property(nonatomic, weak) NSLayoutConstraint* constraintTopRefreshTop;
@property(nonatomic, weak) NSLayoutConstraint* constraintTopRefreshLeft;
@property(nonatomic, weak) NSLayoutConstraint* constraintTopRefreshRight;
@property(nonatomic, weak) NSLayoutConstraint* constraintTopRefreshSize;
@property(nonatomic, weak) NSLayoutConstraint* constraintBottomRefreshBottom;
@property(nonatomic, weak) NSLayoutConstraint* constraintBottomRefreshLeft;
@property(nonatomic, weak) NSLayoutConstraint* constraintBottomRefreshRight;
@property(nonatomic, weak) NSLayoutConstraint* constraintBottomRefreshSize;
@property(nonatomic, weak) NSLayoutConstraint* constraintLeftRefreshTop;
@property(nonatomic, weak) NSLayoutConstraint* constraintLeftRefreshBottom;
@property(nonatomic, weak) NSLayoutConstraint* constraintLeftRefreshLeft;
@property(nonatomic, weak) NSLayoutConstraint* constraintLeftRefreshSize;
@property(nonatomic, weak) NSLayoutConstraint* constraintRightRefreshTop;
@property(nonatomic, weak) NSLayoutConstraint* constraintRightRefreshBottom;
@property(nonatomic, weak) NSLayoutConstraint* constraintRightRefreshRight;
@property(nonatomic, weak) NSLayoutConstraint* constraintRightRefreshSize;

@property(nonatomic, strong) CADisplayLink* scrollDisplayLink;
@property(nonatomic, strong) CAMediaTimingFunction* scrollTimingFunction;
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

@property(nonatomic, strong) UILongPressGestureRecognizer* longPressGestureRecognizer;

- (void)_setEdgeInset:(UIEdgeInsets)edgeInsets force:(BOOL)force;
- (void)_setSearchBarInset:(CGFloat)searchBarInset force:(BOOL)force;
- (void)_setRefreshViewInset:(UIEdgeInsets)refreshViewInset force:(BOOL)force;
- (void)_setContainerInset:(UIEdgeInsets)containerInset force:(BOOL)force;

- (void)_receiveMemoryWarning;

- (GLBDataCell*)_dequeueCellWithItem:(GLBDataItem*)item;
- (void)_enqueueCell:(GLBDataCell*)cell forIdentifier:(NSString*)identifier;

- (void)_pressedItem:(GLBDataItem*)item animated:(BOOL)animated;

- (BOOL)_shouldSelectItem:(GLBDataItem*)item user:(BOOL)user;
- (BOOL)_shouldDeselectItem:(GLBDataItem*)item user:(BOOL)user;
- (void)_selectItem:(GLBDataItem*)item user:(BOOL)user animated:(BOOL)animated;
- (void)_deselectItem:(GLBDataItem*)item user:(BOOL)user animated:(BOOL)animated;
- (void)_deselectAllItemsUser:(BOOL)user animated:(BOOL)animated;

- (void)_appearItem:(GLBDataItem*)item;
- (void)_disappearItem:(GLBDataItem*)item;

- (void)_didInsertItems:(NSArray*)items;
- (void)_didDeleteItems:(NSArray*)items;
- (void)_didReplaceOriginItems:(NSArray*)originItems withItems:(NSArray*)items;

- (void)_validateLayout;
- (void)_layoutForVisible;

- (void)_updateSuperviewConstraints;
- (void)_updateInsets:(BOOL)force;

- (void)_willBeginDragging;
- (void)_didScrollDragging:(BOOL)dragging decelerating:(BOOL)decelerating;
- (void)_willEndDraggingWithVelocity:(CGPoint)velocity contentOffset:(inout CGPoint*)contentOffset contentSize:(CGSize)contentSize visibleSize:(CGSize)visibleSize;
- (void)_didEndDraggingWillDecelerate:(BOOL)decelerate;
- (void)_willBeginDecelerating;
- (void)_didEndDecelerating;
- (void)_didEndScrollingAnimation;

- (void)_showSearchBarAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(GLBSimpleBlock)complete;
- (void)_hideSearchBarAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(GLBSimpleBlock)complete;

- (void)_showTopRefreshAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(GLBSimpleBlock)complete;
- (void)_hideTopRefreshAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(GLBSimpleBlock)complete;
- (void)_showBottomRefreshAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(GLBSimpleBlock)complete;
- (void)_hideBottomRefreshAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(GLBSimpleBlock)complete;
- (void)_showLeftRefreshAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(GLBSimpleBlock)complete;
- (void)_hideLeftRefreshAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(GLBSimpleBlock)complete;
- (void)_showRightRefreshAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(GLBSimpleBlock)complete;
- (void)_hideRightRefreshAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(GLBSimpleBlock)complete;

- (void)_batchUpdate:(GLBSimpleBlock)update animated:(BOOL)animated;
- (void)_batchComplete:(GLBSimpleBlock)complete animated:(BOOL)animated;

- (void)_changedPageControl;

- (void)_animateContentOffset:(CADisplayLink*)displayLink;
- (void)_animateContentOffsetByProgress:(CGFloat)progress;
- (void)_stopAnimateContentOffset;

- (void)_handlerLongPressGestureRecognizer:(UILongPressGestureRecognizer*)gestureRecognizer;

@end

/*--------------------------------------------------*/

@interface GLBDataBatch : NSObject

@property(nonatomic, readonly, assign) NSTimeInterval duration;
@property(nonatomic, readonly, copy) GLBSimpleBlock update;
@property(nonatomic, readonly, copy) GLBSimpleBlock complete;

- (instancetype)initWithDuration:(NSTimeInterval)duration update:(GLBSimpleBlock)update complete:(GLBSimpleBlock)complete;

@end

/*--------------------------------------------------*/

@interface GLBDataViewDelegateProxy : NSObject< UIScrollViewDelegate > {
@protected
    __weak GLBDataView* _view;
    __weak id< UIScrollViewDelegate > _delegate;
@protected
    BOOL _lockDidScroll;
}

@property(nonatomic, weak) GLBDataView* view;
@property(nonatomic, weak) id< UIScrollViewDelegate > delegate;

- (instancetype)initWithDataView:(GLBDataView*)view;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
