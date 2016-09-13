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

@property(nonatomic, readonly, strong, nullable) GLBDataContentView* contentView;

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

@property(nonatomic, strong, nullable) __kindof GLBDataViewContainer* container;
@property(nonatomic) UIEdgeInsets containerInset;
@property(nonatomic) CGFloat containerInsetTop;
@property(nonatomic) CGFloat containerInsetRight;
@property(nonatomic) CGFloat containerInsetBottom;
@property(nonatomic) CGFloat containerInsetLeft;
@property(nonatomic, readonly, strong, nonnull) NSArray< __kindof GLBDataViewItem* >* visibleItems;
@property(nonatomic, readonly, strong, nonnull) NSArray< __kindof GLBDataViewCell* >* visibleCells;
@property(nonatomic, readonly, strong, nonnull) NSArray< __kindof GLBDataViewItem* >* selectedItems;
@property(nonatomic, readonly, strong, nonnull) NSArray< __kindof GLBDataViewCell* >* selectedCells;
@property(nonatomic, readonly, strong, nonnull) NSArray< __kindof GLBDataViewItem* >* highlightedItems;
@property(nonatomic, readonly, strong, nonnull) NSArray< __kindof GLBDataViewCell* >* highlightedCells;
@property(nonatomic, readonly, strong, nonnull) NSArray< __kindof GLBDataViewItem* >* editingItems;
@property(nonatomic, readonly, strong, nonnull) NSArray< __kindof GLBDataViewCell* >* editingCells;
@property(nonatomic, readonly, strong, nonnull) __kindof GLBDataViewItem* movingItem;
@property(nonatomic, readonly, strong, nonnull) __kindof GLBDataViewCell* movingCell;
@property(nonatomic, readonly, assign, getter=isAnimating) BOOL animating;
@property(nonatomic, readonly, assign, getter=isUpdating) BOOL updating;
@property(nonatomic, readonly, assign, getter=isTransiting) BOOL transiting;

@property(nonatomic, weak, nullable) IBOutlet __kindof GLBPageControl* pageControl;

@property(nonatomic) IBInspectable BOOL searchBarIteractionEnabled;
@property(nonatomic, getter=isShowedSearchBar) IBInspectable BOOL showedSearchBar;
@property(nonatomic) IBInspectable GLBDataViewSearchBarStyle searchBarStyle;
@property(nonatomic, strong, nullable) IBOutlet __kindof GLBSearchBar* searchBar;
@property(nonatomic, readonly, assign) CGFloat searchBarInset;

@property(nonatomic) IBInspectable BOOL topRefreshIteractionEnabled;
@property(nonatomic) IBInspectable BOOL topRefreshBelowDataView;
@property(nonatomic, strong, nullable) IBOutlet __kindof GLBDataRefreshView* topRefreshView;
@property(nonatomic) IBInspectable BOOL bottomRefreshIteractionEnabled;
@property(nonatomic) IBInspectable BOOL bottomRefreshBelowDataView;
@property(nonatomic, strong, nullable) IBOutlet __kindof GLBDataRefreshView* bottomRefreshView;
@property(nonatomic) IBInspectable BOOL leftRefreshIteractionEnabled;
@property(nonatomic) IBInspectable BOOL leftRefreshBelowDataView;
@property(nonatomic, strong, nullable) IBOutlet __kindof GLBDataRefreshView* leftRefreshView;
@property(nonatomic) IBInspectable BOOL rightRefreshIteractionEnabled;
@property(nonatomic) IBInspectable BOOL rightRefreshBelowDataView;
@property(nonatomic, strong, nullable) IBOutlet __kindof GLBDataRefreshView* rightRefreshView;
@property(nonatomic, readonly, assign) UIEdgeInsets refreshViewInset;

- (void)setup NS_REQUIRES_SUPER;

- (void)registerIdentifier:(NSString* _Nonnull)identifier withViewClass:(Class _Nonnull)viewClass;
- (void)unregisterIdentifier:(NSString* _Nonnull)identifier;
- (void)unregisterAllIdentifiers;

- (void)registerActionWithTarget:(_Nonnull id)target action:(_Nonnull SEL)action forKey:(_Nonnull id)key;
- (void)registerActionWithTarget:(_Nonnull id)target action:(_Nonnull SEL)action forIdentifier:(_Nonnull id)identifier forKey:(_Nonnull id)key;
- (void)unregisterActionWithTarget:(_Nonnull id)target forKey:(_Nonnull id)key;
- (void)unregisterActionWithTarget:(_Nonnull id)target forIdentifier:(_Nonnull id)identifier forKey:(_Nonnull id)key;
- (void)unregisterActionsWithTarget:(_Nonnull id)target;
- (void)unregisterAllActions;

- (BOOL)containsActionForKey:(_Nonnull id)key;
- (BOOL)containsActionForIdentifier:(_Nonnull id)identifier forKey:(_Nonnull id)key;

- (void)performActionForKey:(_Nonnull id)key withArguments:(NSArray* _Nullable)arguments;
- (void)performActionForIdentifier:(_Nonnull id)identifier forKey:(_Nonnull id)key withArguments:(NSArray* _Nullable)arguments;

- (_Nullable Class)cellClassWithItem:(GLBDataViewItem*_Nonnull )item;

- (__kindof GLBDataViewCell* _Nullable)dequeueCellWithItem:(GLBDataViewItem* _Nonnull)item;
- (void)enqueueCell:(GLBDataViewCell* _Nonnull)cell;

- (__kindof GLBDataViewItem* _Nullable)itemForPoint:(CGPoint)point;
- (__kindof GLBDataViewItem* _Nullable)itemForData:(_Nonnull id)data;
- (__kindof GLBDataViewCell* _Nullable)cellForData:(_Nonnull id)data;

- (BOOL)isSelectedItem:(GLBDataViewItem* _Nonnull)item;
- (BOOL)shouldSelectItem:(GLBDataViewItem* _Nonnull)item;
- (BOOL)shouldDeselectItem:(GLBDataViewItem* _Nonnull)item;
- (void)selectItem:(GLBDataViewItem* _Nonnull)item animated:(BOOL)animated;
- (void)deselectItem:(GLBDataViewItem* _Nonnull)item animated:(BOOL)animated;
- (void)deselectAllItemsAnimated:(BOOL)animated;

- (BOOL)isHighlightedItem:(GLBDataViewItem* _Nonnull)item;
- (BOOL)shouldHighlightItem:(GLBDataViewItem* _Nonnull)item;
- (BOOL)shouldUnhighlightItem:(GLBDataViewItem* _Nonnull)item;
- (void)highlightItem:(GLBDataViewItem* _Nonnull)item animated:(BOOL)animated;
- (void)unhighlightItem:(GLBDataViewItem* _Nonnull)item animated:(BOOL)animated;
- (void)unhighlightAllItemsAnimated:(BOOL)animated;

- (BOOL)isEditingItem:(GLBDataViewItem* _Nonnull)item;
- (BOOL)shouldBeganEditItem:(GLBDataViewItem* _Nonnull)item;
- (BOOL)shouldEndedEditItem:(GLBDataViewItem* _Nonnull)item;
- (void)beganEditItem:(GLBDataViewItem* _Nonnull)item animated:(BOOL)animated;
- (void)endedEditItem:(GLBDataViewItem* _Nonnull)item animated:(BOOL)animated;
- (void)endedEditAllItemsAnimated:(BOOL)animated;

- (BOOL)isMovingItem:(GLBDataViewItem* _Nonnull)item;
- (BOOL)shouldBeganMoveItem:(GLBDataViewItem* _Nonnull)item;
- (BOOL)shouldEndedMoveItem:(GLBDataViewItem* _Nonnull)item;
- (void)beganMoveItem:(GLBDataViewItem* _Nonnull)item animated:(BOOL)animated;
- (void)endedMoveItemAnimated:(BOOL)animated;

- (void)beginUpdateAnimated:(BOOL)animated;
- (void)update:(_Nullable GLBSimpleBlock)update;
- (void)endUpdate;

- (void)batchUpdate:(_Nullable GLBSimpleBlock)update;
- (void)batchUpdate:(_Nullable GLBSimpleBlock)update complete:(_Nullable GLBSimpleBlock)complete;
- (void)batchDuration:(NSTimeInterval)duration update:(_Nullable GLBSimpleBlock)update;
- (void)batchDuration:(NSTimeInterval)duration update:(_Nullable GLBSimpleBlock)update complete:(_Nullable GLBSimpleBlock)complete;

- (void)beginTransition;
- (void)endTransition;

- (void)setNeedValidateLayout;
- (void)validateLayoutIfNeed;

- (void)animateContentOffset:(CGPoint)contentOffset
          withTimingFunction:(CAMediaTimingFunction* _Nonnull)timingFunction;

- (void)animateContentOffset:(CGPoint)contentOffset
          withTimingFunction:(CAMediaTimingFunction* _Nonnull)timingFunction
                    duration:(CFTimeInterval)duration;

- (void)stopAnimateContentOffset;

- (void)scrollToItem:(GLBDataViewItem* _Nonnull)item scrollPosition:(GLBDataViewPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToRect:(CGRect)rect scrollPosition:(GLBDataViewPosition)scrollPosition animated:(BOOL)animated;

- (void)showSearchBarAnimated:(BOOL)animated complete:(_Nullable GLBSimpleBlock)complete;
- (void)hideSearchBarAnimated:(BOOL)animated complete:(_Nullable GLBSimpleBlock)complete;

- (void)showTopRefreshAnimated:(BOOL)animated complete:(_Nullable GLBSimpleBlock)complete;
- (void)hideTopRefreshAnimated:(BOOL)animated complete:(_Nullable GLBSimpleBlock)complete;
- (void)showBottomRefreshAnimated:(BOOL)animated complete:(_Nullable GLBSimpleBlock)complete;
- (void)hideBottomRefreshAnimated:(BOOL)animated complete:(_Nullable GLBSimpleBlock)complete;
- (void)showLeftRefreshAnimated:(BOOL)animated complete:(_Nullable GLBSimpleBlock)complete;
- (void)hideLeftRefreshAnimated:(BOOL)animated complete:(_Nullable GLBSimpleBlock)complete;
- (void)showRightRefreshAnimated:(BOOL)animated complete:(_Nullable GLBSimpleBlock)complete;
- (void)hideRightRefreshAnimated:(BOOL)animated complete:(_Nullable GLBSimpleBlock)complete;

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
