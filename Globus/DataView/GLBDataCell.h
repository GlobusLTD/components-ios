/*--------------------------------------------------*/

#import "GLBDataViewTypes.h"
#import "GLBWindow.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBDataView;
@class GLBDataItem;

/*--------------------------------------------------*/

@interface GLBDataCell : UIView< UIGestureRecognizerDelegate, GLBSearchBarDelegate, GLBWindowExtension >

@property(nonatomic, readonly, strong) NSString* identifier;
@property(nonatomic, readonly, weak) __kindof GLBDataView* view;
@property(nonatomic, readonly, weak) __kindof GLBDataItem* item;
@property(nonatomic) BOOL hideKeyboardIfTouched;
@property(nonatomic, readonly, assign, getter=isSelected) BOOL selected;
@property(nonatomic, readonly, assign, getter=isHighlighted) BOOL highlighted;
@property(nonatomic, readonly, assign, getter=isEditing) BOOL editing;
@property(nonatomic, readonly, assign, getter=isMoving) BOOL moving;

@property(nonatomic, readonly, strong) UILongPressGestureRecognizer* pressGestureRecognizer;
@property(nonatomic, readonly, strong) UILongPressGestureRecognizer* longPressGestureRecognizer;

@property(nonatomic, strong) IBOutlet UIView* rootView;
@property(nonatomic) UIOffset rootViewOffset;
@property(nonatomic) CGSize rootViewSize;

@property(nonatomic, readonly, strong) NSArray< UIView* >* orderedSubviews;

+ (CGSize)sizeForItem:(id)item availableSize:(CGSize)size;

- (CGSize)sizeForItem:(id)item availableSize:(CGSize)size;
- (UILayoutPriority)fittingHorizontalPriority;
- (UILayoutPriority)fittingVerticalPriority;

- (instancetype)initWithIdentifier:(NSString*)identifier;
- (instancetype)initWithIdentifier:(NSString*)identifier nib:(UINib*)nib;

- (void)setup NS_REQUIRES_SUPER;

- (void)willShow;
- (void)reload;
- (void)didHide;

- (BOOL)containsActionForKey:(id)key;
- (BOOL)containsActionForIdentifier:(id)identifier forKey:(id)key;

- (void)performActionForKey:(id)key withArguments:(NSArray*)arguments;

- (void)selectedAnimated:(BOOL)animated NS_REQUIRES_SUPER;
- (void)deselectedAnimated:(BOOL)animated NS_REQUIRES_SUPER;

- (void)highlightedAnimated:(BOOL)animated NS_REQUIRES_SUPER;
- (void)unhighlightedAnimated:(BOOL)animated NS_REQUIRES_SUPER;

- (void)beginEditingAnimated:(BOOL)animated NS_REQUIRES_SUPER;
- (void)endEditingAnimated:(BOOL)animated NS_REQUIRES_SUPER;

- (void)beginMovingAnimated:(BOOL)animated NS_REQUIRES_SUPER;
- (void)endMovingAnimated:(BOOL)animated NS_REQUIRES_SUPER;

- (void)validateLayoutForBounds:(CGRect)bounds;
- (void)invalidateLayoutForBounds:(CGRect)bounds;

- (void)beginTransition;
- (void)endTransition;

@end

/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBDataSwipeCellStyle) {
    GLBDataSwipeCellStyleStands,
    GLBDataSwipeCellStyleLeaves,
    GLBDataSwipeCellStylePushes,
    GLBDataSwipeCellStyleStretch
};

/*--------------------------------------------------*/

@interface GLBDataCellSwipe : GLBDataCell

@property(nonatomic, readonly, strong) UIPanGestureRecognizer* panGestureRecognizer;

@property(nonatomic, getter=isSwipeEnabled) BOOL swipeEnabled;
@property(nonatomic) IBInspectable GLBDataSwipeCellStyle swipeStyle;
@property(nonatomic) IBInspectable CGFloat swipeThreshold;
@property(nonatomic) IBInspectable CGFloat swipeVelocity;
@property(nonatomic) IBInspectable CGFloat swipeDamping;
@property(nonatomic) IBInspectable BOOL swipeUseSpring;
@property(nonatomic, readonly, getter=isSwipeDragging) BOOL swipeDragging;
@property(nonatomic, readonly, getter=isSwipeDecelerating) BOOL swipeDecelerating;

@property(nonatomic, getter=isShowedLeftSwipeView) IBInspectable BOOL showedLeftSwipeView;
@property(nonatomic, getter=isLeftSwipeEnabled) IBInspectable BOOL leftSwipeEnabled;
@property(nonatomic, strong) IBOutlet UIView* leftSwipeView;
@property(nonatomic) CGFloat leftSwipeOffset;
@property(nonatomic) CGFloat leftSwipeSize;
@property(nonatomic) CGFloat leftSwipeStretchSize;
@property(nonatomic) CGFloat leftSwipeStretchMinThreshold;
@property(nonatomic) CGFloat leftSwipeStretchMaxThreshold;

@property(nonatomic, getter=isShowedRightSwipeView) IBInspectable BOOL showedRightSwipeView;
@property(nonatomic, getter=isRightSwipeEnabled) IBInspectable BOOL rightSwipeEnabled;
@property(nonatomic, strong) IBOutlet UIView* rightSwipeView;
@property(nonatomic) CGFloat rightSwipeOffset;
@property(nonatomic) CGFloat rightSwipeSize;
@property(nonatomic) CGFloat rightSwipeStretchSize;
@property(nonatomic) CGFloat rightSwipeStretchMinThreshold;
@property(nonatomic) CGFloat rightSwipeStretchMaxThreshold;

- (void)setShowedLeftSwipeView:(BOOL)showedLeftSwipeView animated:(BOOL)animated;
- (void)setShowedRightSwipeView:(BOOL)showedRightSwipeView animated:(BOOL)animated;
- (void)hideAnySwipeViewAnimated:(BOOL)animated;

- (void)willBeganSwipe NS_REQUIRES_SUPER;
- (void)didBeganSwipe NS_REQUIRES_SUPER;
- (void)movingSwipe:(CGFloat)progress NS_REQUIRES_SUPER;
- (void)willEndedSwipe:(CGFloat)progress NS_REQUIRES_SUPER;
- (void)didEndedSwipe:(CGFloat)progress NS_REQUIRES_SUPER;

- (CGFloat)endedSwipeProgress:(CGFloat)progress;

@end

/*--------------------------------------------------*/

extern NSString* GLBDataCellPressed;
extern NSString* GLBDataCellLongPressed;

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
