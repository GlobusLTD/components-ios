/*--------------------------------------------------*/

#import "GLBDataViewTypes.h"
#import "GLBSearchBar.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBDataViewContainer;
@class GLBDataViewItem;
@class GLBDataViewCell;
@class GLBDataRefreshView;

/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBDataViewSearchBarStyle) {
    GLBDataViewSearchBarStyleStatic,
    GLBDataViewSearchBarStyleInside,
    GLBDataViewSearchBarStyleOverlay
};

/*--------------------------------------------------*/

@class GLBDataContentView;
@class GLBPageControl;

/*--------------------------------------------------*/

@protocol GLBDataRefreshView;

/*--------------------------------------------------*/

@interface GLBDataView : UIScrollView < UIGestureRecognizerDelegate, GLBScrollViewExtension, GLBSearchBarDelegate >

@property(nonatomic, nullable, readonly, strong) GLBDataContentView* contentView;

@property(nonatomic) IBInspectable CGFloat velocity;
@property(nonatomic) IBInspectable CGFloat velocityMin;
@property(nonatomic) IBInspectable CGFloat velocityMax;

@property(nonatomic) IBInspectable BOOL allowsSelection;
@property(nonatomic) IBInspectable BOOL allowsOnceSelection;
@property(nonatomic) IBInspectable BOOL allowsMultipleSelection;
@property(nonatomic) IBInspectable BOOL allowsEditing;
@property(nonatomic) IBInspectable BOOL allowsMultipleEditing;
@property(nonatomic) IBInspectable BOOL allowsMoving;
@property(nonatomic) IBInspectable BOOL allowsMultipleMoving;
@property(nonatomic) IBInspectable BOOL bouncesTop;
@property(nonatomic) IBInspectable BOOL bouncesLeft;
@property(nonatomic) IBInspectable BOOL bouncesRight;
@property(nonatomic) IBInspectable BOOL bouncesBottom;

@property(nonatomic) UIEdgeInsets edgeInset;
@property(nonatomic) CGFloat edgeInsetTop;
@property(nonatomic) CGFloat edgeInsetRight;
@property(nonatomic) CGFloat edgeInsetBottom;
@property(nonatomic) CGFloat edgeInsetLeft;

@property(nonatomic, nullable, strong) __kindof GLBDataViewContainer* container;
@property(nonatomic) UIEdgeInsets containerInset;
@property(nonatomic) CGFloat containerInsetTop;
@property(nonatomic) CGFloat containerInsetRight;
@property(nonatomic) CGFloat containerInsetBottom;
@property(nonatomic) CGFloat containerInsetLeft;
@property(nonatomic, nonnull, readonly, strong) NSArray< __kindof GLBDataViewItem* >* visibleItems;
@property(nonatomic, nonnull, readonly, strong) NSArray< __kindof GLBDataViewCell* >* visibleCells;
@property(nonatomic, nonnull, readonly, strong) NSArray< __kindof GLBDataViewItem* >* selectedItems;
@property(nonatomic, nonnull, readonly, strong) NSArray< __kindof GLBDataViewCell* >* selectedCells;
@property(nonatomic, nonnull, readonly, strong) NSArray< __kindof GLBDataViewItem* >* highlightedItems;
@property(nonatomic, nonnull, readonly, strong) NSArray< __kindof GLBDataViewCell* >* highlightedCells;
@property(nonatomic, nonnull, readonly, strong) NSArray< __kindof GLBDataViewItem* >* editingItems;
@property(nonatomic, nonnull, readonly, strong) NSArray< __kindof GLBDataViewCell* >* editingCells;
@property(nonatomic, nullable, readonly, strong) __kindof GLBDataViewItem* movingItem;
@property(nonatomic, nullable, readonly, strong) __kindof GLBDataViewCell* movingCell;
@property(nonatomic, readonly, assign, getter=isAnimating) BOOL animating;
@property(nonatomic, readonly, assign, getter=isUpdating) BOOL updating;
@property(nonatomic, readonly, assign, getter=isTransiting) BOOL transiting;

@property(nonatomic, weak, nullable) IBOutlet __kindof GLBPageControl* pageControl;

@property(nonatomic) IBInspectable BOOL searchBarIteractionEnabled;
@property(nonatomic, getter=isShowedSearchBar) IBInspectable BOOL showedSearchBar;
@property(nonatomic) IBInspectable GLBDataViewSearchBarStyle searchBarStyle;
@property(nonatomic, nullable, strong) IBOutlet __kindof GLBSearchBar* searchBar;
@property(nonatomic, readonly, assign) CGFloat searchBarInset;

@property(nonatomic) IBInspectable BOOL topRefreshIteractionEnabled;
@property(nonatomic) IBInspectable BOOL topRefreshBelowDataView;
@property(nonatomic, nullable, strong) IBOutlet __kindof GLBDataRefreshView* topRefreshView;
@property(nonatomic) IBInspectable BOOL bottomRefreshIteractionEnabled;
@property(nonatomic) IBInspectable BOOL bottomRefreshBelowDataView;
@property(nonatomic, nullable, strong) IBOutlet __kindof GLBDataRefreshView* bottomRefreshView;
@property(nonatomic) IBInspectable BOOL leftRefreshIteractionEnabled;
@property(nonatomic) IBInspectable BOOL leftRefreshBelowDataView;
@property(nonatomic, nullable, strong) IBOutlet __kindof GLBDataRefreshView* leftRefreshView;
@property(nonatomic) IBInspectable BOOL rightRefreshIteractionEnabled;
@property(nonatomic) IBInspectable BOOL rightRefreshBelowDataView;
@property(nonatomic, nullable, strong) IBOutlet __kindof GLBDataRefreshView* rightRefreshView;
@property(nonatomic, readonly, assign) UIEdgeInsets refreshViewInset;

- (void)setup NS_REQUIRES_SUPER;

- (void)registerIdentifier:(nonnull NSString*)identifier withViewClass:(nonnull Class)viewClass;
- (void)unregisterIdentifier:(nonnull NSString*)identifier;
- (void)unregisterAllIdentifiers;

- (void)registerActionWithTarget:(nonnull id)target action:(nonnull SEL)action forKey:(nonnull id)key;
- (void)registerActionWithTarget:(nonnull id)target action:(nonnull SEL)action forIdentifier:(nonnull id)identifier forKey:(nonnull id)key;
- (void)unregisterActionWithTarget:(nonnull id)target forKey:(nonnull id)key;
- (void)unregisterActionWithTarget:(nonnull id)target forIdentifier:(nonnull id)identifier forKey:(nonnull id)key;
- (void)unregisterActionsWithTarget:(nonnull id)target;
- (void)unregisterAllActions;

- (BOOL)containsActionForKey:(nonnull id)key;
- (BOOL)containsActionForIdentifier:(nonnull id)identifier forKey:(nonnull id)key;

- (void)performActionForKey:(nonnull id)key withArguments:(nullable NSArray*)arguments;
- (void)performActionForIdentifier:(nonnull id)identifier forKey:(nonnull id)key withArguments:(nullable NSArray*)arguments;

- (nullable Class)cellClassWithItem:(nonnull GLBDataViewItem*)item;

- (nullable __kindof GLBDataViewCell*)dequeueCellWithItem:(nonnull GLBDataViewItem*)item;
- (void)enqueueCell:(nonnull GLBDataViewCell*)cell;

- (nullable __kindof GLBDataViewItem*)itemForPoint:(CGPoint)point;
- (nullable __kindof GLBDataViewItem*)itemForData:(nonnull id)data;
- (nullable __kindof GLBDataViewCell*)cellForData:(nonnull id)data;

- (BOOL)isSelectedItem:(nonnull GLBDataViewItem*)item;
- (BOOL)shouldSelectItem:(nonnull GLBDataViewItem*)item;
- (BOOL)shouldDeselectItem:(nonnull GLBDataViewItem*)item;
- (void)selectItem:(nonnull GLBDataViewItem*)item animated:(BOOL)animated;
- (void)deselectItem:(nonnull GLBDataViewItem*)item animated:(BOOL)animated;
- (void)deselectAllItemsAnimated:(BOOL)animated;

- (BOOL)isHighlightedItem:(nonnull GLBDataViewItem*)item;
- (BOOL)shouldHighlightItem:(nonnull GLBDataViewItem*)item;
- (BOOL)shouldUnhighlightItem:(nonnull GLBDataViewItem*)item;
- (void)highlightItem:(nonnull GLBDataViewItem*)item animated:(BOOL)animated;
- (void)unhighlightItem:(nonnull GLBDataViewItem*)item animated:(BOOL)animated;
- (void)unhighlightAllItemsAnimated:(BOOL)animated;

- (BOOL)isEditingItem:(nonnull GLBDataViewItem*)item;
- (BOOL)shouldBeganEditItem:(nonnull GLBDataViewItem*)item;
- (BOOL)shouldEndedEditItem:(nonnull GLBDataViewItem*)item;
- (void)beganEditItem:(nonnull GLBDataViewItem*)item animated:(BOOL)animated;
- (void)endedEditItem:(nonnull GLBDataViewItem*)item animated:(BOOL)animated;
- (void)endedEditAllItemsAnimated:(BOOL)animated;

- (BOOL)isMovingItem:(nonnull GLBDataViewItem*)item;
- (BOOL)shouldBeganMoveItem:(nonnull GLBDataViewItem*)item;
- (BOOL)shouldEndedMoveItem:(nonnull GLBDataViewItem*)item;
- (void)beganMoveItem:(nonnull GLBDataViewItem*)item animated:(BOOL)animated;
- (void)endedMoveItemAnimated:(BOOL)animated;

- (void)beginUpdateAnimated:(BOOL)animated;
- (void)update:(nullable GLBSimpleBlock)update;
- (void)endUpdate;

- (void)batchUpdate:(nullable GLBSimpleBlock)update;
- (void)batchUpdate:(nullable GLBSimpleBlock)update complete:(nullable GLBSimpleBlock)complete;
- (void)batchDuration:(NSTimeInterval)duration update:(nullable GLBSimpleBlock)update;
- (void)batchDuration:(NSTimeInterval)duration update:(nullable GLBSimpleBlock)update complete:(nullable GLBSimpleBlock)complete;

- (void)beginTransition;
- (void)endTransition;

- (void)setNeedValidateLayout;
- (void)validateLayoutIfNeed;

- (void)animateContentOffset:(CGPoint)contentOffset
          withTimingFunction:(nonnull CAMediaTimingFunction*)timingFunction;

- (void)animateContentOffset:(CGPoint)contentOffset
          withTimingFunction:(nonnull CAMediaTimingFunction*)timingFunction
                    duration:(CFTimeInterval)duration;

- (void)stopAnimateContentOffset;

- (void)scrollToItem:(nonnull GLBDataViewItem*)item scrollPosition:(GLBDataViewPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToRect:(CGRect)rect scrollPosition:(GLBDataViewPosition)scrollPosition animated:(BOOL)animated;

- (void)showSearchBarAnimated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;
- (void)hideSearchBarAnimated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;

- (void)showTopRefreshAnimated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;
- (void)hideTopRefreshAnimated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;
- (void)showBottomRefreshAnimated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;
- (void)hideBottomRefreshAnimated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;
- (void)showLeftRefreshAnimated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;
- (void)hideLeftRefreshAnimated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;
- (void)showRightRefreshAnimated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;
- (void)hideRightRefreshAnimated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;

@end

/*--------------------------------------------------*/

extern NSString* _Nonnull GLBDataViewSelectItem;
extern NSString* _Nonnull GLBDataViewDeselectItem;

/*--------------------------------------------------*/

extern NSString* _Nonnull GLBDataViewMovingBegin;
extern NSString* _Nonnull GLBDataViewMovingEnd;

/*--------------------------------------------------*/

extern NSString* _Nonnull GLBDataViewSearchBegin;
extern NSString* _Nonnull GLBDataViewSearchEnd;
extern NSString* _Nonnull GLBDataViewSearchBeginEditing;
extern NSString* _Nonnull GLBDataViewSearchTextChanged;
extern NSString* _Nonnull GLBDataViewSearchEndEditing;
extern NSString* _Nonnull GLBDataViewSearchPressedClear;
extern NSString* _Nonnull GLBDataViewSearchPressedReturn;
extern NSString* _Nonnull GLBDataViewSearchPressedCancel;

/*--------------------------------------------------*/

extern NSString* _Nonnull GLBDataViewTopRefreshTriggered;
extern NSString* _Nonnull GLBDataViewBottomRefreshTriggered;
extern NSString* _Nonnull GLBDataViewLeftRefreshTriggered;
extern NSString* _Nonnull GLBDataViewRightRefreshTriggered;

/*--------------------------------------------------*/

extern NSString* _Nonnull GLBDataViewAnimateRestore;
extern NSString* _Nonnull GLBDataViewAnimateInsert;
extern NSString* _Nonnull GLBDataViewAnimateDelete;
extern NSString* _Nonnull GLBDataViewAnimateReplaceOut;
extern NSString* _Nonnull GLBDataViewAnimateReplaceIn;

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
