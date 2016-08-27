/*--------------------------------------------------*/

#import "GLBDataViewTypes.h"
#import "GLBSearchBar.h"
#import "GLBWindow.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBDataView;
@class GLBDataViewItem;

/*--------------------------------------------------*/

@interface GLBDataViewCell : UIView< UIGestureRecognizerDelegate, GLBSearchBarDelegate, GLBWindowExtension >

@property(nonatomic, readonly, strong) NSString* identifier;
@property(nonatomic, readonly, weak) __kindof GLBDataView* view;
@property(nonatomic, readonly, weak) __kindof GLBDataViewItem* item;
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

- (CGSize)sizeForAvailableSize:(CGSize)size;
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
- (void)transitionResize;
- (void)endTransition;

@end

/*--------------------------------------------------*/

extern NSString* GLBDataViewCellPressed;
extern NSString* GLBDataViewCellLongPressed;

/*--------------------------------------------------*/
/* Legacy                                           */
/*--------------------------------------------------*/

@interface GLBDataCell : GLBDataViewCell
@end

#define GLBDataCellPressed GLBDataViewCellPressed
#define GLBDataCellLongPressed GLBDataViewCellLongPressed

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
