/*--------------------------------------------------*/

#import "UIScrollView+GLBUI.h"
#import "GLBDataViewTypes.h"
#import "GLBSearchBar.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBDataContainer;
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

@class GLBPageControl;

/*--------------------------------------------------*/

@protocol GLBDataRefreshView;

/*--------------------------------------------------*/

@interface GLBDataContentView : UIView
@end

/*--------------------------------------------------*/

@interface GLBDataView : UIScrollView < UIGestureRecognizerDelegate, GLBScrollViewExtension, GLBSearchBarDelegate >

@property(nonatomic, readonly, strong) GLBDataContentView* contentView;

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

@property(nonatomic, strong) __kindof GLBDataContainer* container;
@property(nonatomic) UIEdgeInsets containerInset;
@property(nonatomic) CGFloat containerInsetTop;
@property(nonatomic) CGFloat containerInsetRight;
@property(nonatomic) CGFloat containerInsetBottom;
@property(nonatomic) CGFloat containerInsetLeft;
@property(nonatomic, readonly, strong) NSArray< __kindof GLBDataViewItem* >* visibleItems;
@property(nonatomic, readonly, strong) NSArray< __kindof GLBDataViewCell* >* visibleCells;
@property(nonatomic, readonly, strong) NSArray< __kindof GLBDataViewItem* >* selectedItems;
@property(nonatomic, readonly, strong) NSArray< __kindof GLBDataViewCell* >* selectedCells;
@property(nonatomic, readonly, strong) NSArray< __kindof GLBDataViewItem* >* highlightedItems;
@property(nonatomic, readonly, strong) NSArray< __kindof GLBDataViewCell* >* highlightedCells;
@property(nonatomic, readonly, strong) NSArray< __kindof GLBDataViewItem* >* editingItems;
@property(nonatomic, readonly, strong) NSArray< __kindof GLBDataViewCell* >* editingCells;
@property(nonatomic, readonly, strong) __kindof GLBDataViewItem* movingItem;
@property(nonatomic, readonly, strong) __kindof GLBDataViewCell* movingCell;
@property(nonatomic, readonly, assign, getter=isAnimating) BOOL animating;
@property(nonatomic, readonly, assign, getter=isUpdating) BOOL updating;
@property(nonatomic, readonly, assign, getter=isTransiting) BOOL transiting;

@property(nonatomic, weak) IBOutlet __kindof GLBPageControl* pageControl;

@property(nonatomic) IBInspectable BOOL searchBarIteractionEnabled;
@property(nonatomic, getter=isShowedSearchBar) IBInspectable BOOL showedSearchBar;
@property(nonatomic) IBInspectable GLBDataViewSearchBarStyle searchBarStyle;
@property(nonatomic, strong) IBOutlet __kindof GLBSearchBar* searchBar;
@property(nonatomic, readonly, assign) CGFloat searchBarInset;

@property(nonatomic) IBInspectable BOOL topRefreshIteractionEnabled;
@property(nonatomic) IBInspectable BOOL topRefreshBelowDataView;
@property(nonatomic, strong) IBOutlet __kindof GLBDataRefreshView* topRefreshView;
@property(nonatomic) IBInspectable BOOL bottomRefreshIteractionEnabled;
@property(nonatomic) IBInspectable BOOL bottomRefreshBelowDataView;
@property(nonatomic, strong) IBOutlet __kindof GLBDataRefreshView* bottomRefreshView;
@property(nonatomic) IBInspectable BOOL leftRefreshIteractionEnabled;
@property(nonatomic) IBInspectable BOOL leftRefreshBelowDataView;
@property(nonatomic, strong) IBOutlet __kindof GLBDataRefreshView* leftRefreshView;
@property(nonatomic) IBInspectable BOOL rightRefreshIteractionEnabled;
@property(nonatomic) IBInspectable BOOL rightRefreshBelowDataView;
@property(nonatomic, strong) IBOutlet __kindof GLBDataRefreshView* rightRefreshView;
@property(nonatomic, readonly, assign) UIEdgeInsets refreshViewInset;

- (void)setup NS_REQUIRES_SUPER;

- (void)registerIdentifier:(NSString*)identifier withViewClass:(Class)viewClass;
- (void)unregisterIdentifier:(NSString*)identifier;
- (void)unregisterAllIdentifiers;

- (void)registerActionWithTarget:(id)target action:(SEL)action forKey:(id)key;
- (void)registerActionWithTarget:(id)target action:(SEL)action forIdentifier:(id)identifier forKey:(id)key;
- (void)unregisterActionWithTarget:(id)target forKey:(id)key;
- (void)unregisterActionWithTarget:(id)target forIdentifier:(id)identifier forKey:(id)key;
- (void)unregisterActionsWithTarget:(id)target;
- (void)unregisterAllActions;

- (BOOL)containsActionForKey:(id)key;
- (BOOL)containsActionForIdentifier:(id)identifier forKey:(id)key;

- (void)performActionForKey:(id)key withArguments:(NSArray*)arguments;
- (void)performActionForIdentifier:(id)identifier forKey:(id)key withArguments:(NSArray*)arguments;

- (Class)cellClassWithItem:(GLBDataViewItem*)item;

- (void)dequeueCellWithItem:(GLBDataViewItem*)item;
- (void)enqueueCellWithItem:(GLBDataViewItem*)item;

- (__kindof GLBDataViewItem*)itemForPoint:(CGPoint)point;
- (__kindof GLBDataViewItem*)itemForData:(id)data;
- (__kindof GLBDataViewCell*)cellForData:(id)data;

- (BOOL)isSelectedItem:(GLBDataViewItem*)item;
- (BOOL)shouldSelectItem:(GLBDataViewItem*)item;
- (BOOL)shouldDeselectItem:(GLBDataViewItem*)item;
- (void)selectItem:(GLBDataViewItem*)item animated:(BOOL)animated;
- (void)deselectItem:(GLBDataViewItem*)item animated:(BOOL)animated;
- (void)deselectAllItemsAnimated:(BOOL)animated;

- (BOOL)isHighlightedItem:(GLBDataViewItem*)item;
- (BOOL)shouldHighlightItem:(GLBDataViewItem*)item;
- (BOOL)shouldUnhighlightItem:(GLBDataViewItem*)item;
- (void)highlightItem:(GLBDataViewItem*)item animated:(BOOL)animated;
- (void)unhighlightItem:(GLBDataViewItem*)item animated:(BOOL)animated;
- (void)unhighlightAllItemsAnimated:(BOOL)animated;

- (BOOL)isEditingItem:(GLBDataViewItem*)item;
- (BOOL)shouldBeganEditItem:(GLBDataViewItem*)item;
- (BOOL)shouldEndedEditItem:(GLBDataViewItem*)item;
- (void)beganEditItem:(GLBDataViewItem*)item animated:(BOOL)animated;
- (void)endedEditItem:(GLBDataViewItem*)item animated:(BOOL)animated;
- (void)endedEditAllItemsAnimated:(BOOL)animated;

- (BOOL)isMovingItem:(GLBDataViewItem*)item;
- (BOOL)shouldBeganMoveItem:(GLBDataViewItem*)item;
- (BOOL)shouldEndedMoveItem:(GLBDataViewItem*)item;
- (void)beganMoveItem:(GLBDataViewItem*)item animated:(BOOL)animated;
- (void)endedMoveItemAnimated:(BOOL)animated;

- (void)beginUpdateAnimated:(BOOL)animated;
- (void)update:(GLBSimpleBlock)update;
- (void)endUpdate;

- (void)batchUpdate:(GLBSimpleBlock)update;
- (void)batchUpdate:(GLBSimpleBlock)update complete:(GLBSimpleBlock)complete;
- (void)batchDuration:(NSTimeInterval)duration update:(GLBSimpleBlock)update;
- (void)batchDuration:(NSTimeInterval)duration update:(GLBSimpleBlock)update complete:(GLBSimpleBlock)complete;

- (void)beginTransition;
- (void)endTransition;

- (void)setNeedValidateLayout;
- (void)validateLayoutIfNeed;

- (void)animateContentOffset:(CGPoint)contentOffset
          withTimingFunction:(CAMediaTimingFunction*)timingFunction;

- (void)animateContentOffset:(CGPoint)contentOffset
          withTimingFunction:(CAMediaTimingFunction*)timingFunction
                    duration:(CFTimeInterval)duration;

- (void)stopAnimateContentOffset;

- (void)scrollToItem:(GLBDataViewItem*)item scrollPosition:(GLBDataViewPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToRect:(CGRect)rect scrollPosition:(GLBDataViewPosition)scrollPosition animated:(BOOL)animated;

- (void)showSearchBarAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete;
- (void)hideSearchBarAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete;

- (void)showTopRefreshAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete;
- (void)hideTopRefreshAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete;
- (void)showBottomRefreshAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete;
- (void)hideBottomRefreshAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete;
- (void)showLeftRefreshAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete;
- (void)hideLeftRefreshAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete;
- (void)showRightRefreshAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete;
- (void)hideRightRefreshAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete;

@end

/*--------------------------------------------------*/

extern NSString* GLBDataViewSelectItem;
extern NSString* GLBDataViewDeselectItem;

/*--------------------------------------------------*/

extern NSString* GLBDataViewMovingBegin;
extern NSString* GLBDataViewMovingEnd;

/*--------------------------------------------------*/

extern NSString* GLBDataViewSearchBegin;
extern NSString* GLBDataViewSearchEnd;
extern NSString* GLBDataViewSearchBeginEditing;
extern NSString* GLBDataViewSearchTextChanged;
extern NSString* GLBDataViewSearchEndEditing;
extern NSString* GLBDataViewSearchPressedClear;
extern NSString* GLBDataViewSearchPressedReturn;
extern NSString* GLBDataViewSearchPressedCancel;

/*--------------------------------------------------*/

extern NSString* GLBDataViewTopRefreshTriggered;
extern NSString* GLBDataViewBottomRefreshTriggered;
extern NSString* GLBDataViewLeftRefreshTriggered;
extern NSString* GLBDataViewRightRefreshTriggered;

/*--------------------------------------------------*/

extern NSString* GLBDataViewAnimateRestore;
extern NSString* GLBDataViewAnimateInsert;
extern NSString* GLBDataViewAnimateDelete;
extern NSString* GLBDataViewAnimateReplaceOut;
extern NSString* GLBDataViewAnimateReplaceIn;

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
