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

@interface GLBDataViewCell : UIView< UIGestureRecognizerDelegate, GLBSearchBarDelegate, GLBWindowExtension, GLBNibExtension >

@property(nonatomic, nullable, readonly, weak) __kindof GLBDataView* dataView;
@property(nonatomic, nullable, readonly, weak) __kindof GLBDataViewItem* item;
@property(nonatomic) BOOL hideKeyboardIfTouched;
@property(nonatomic, readonly, assign, getter=isSelected) BOOL selected;
@property(nonatomic, readonly, assign, getter=isHighlighted) BOOL highlighted;
@property(nonatomic, readonly, assign, getter=isEditing) BOOL editing;
@property(nonatomic, readonly, assign, getter=isMoving) BOOL moving;

@property(nonatomic, nullable, readonly, strong) UILongPressGestureRecognizer* pressGestureRecognizer;
@property(nonatomic, nullable, readonly, strong) UILongPressGestureRecognizer* longPressGestureRecognizer;

@property(nonatomic, nullable, strong) IBOutlet UIView* rootView;
@property(nonatomic) UIOffset rootViewOffset;
@property(nonatomic) CGSize rootViewSize;

@property(nonatomic, nonnull, readonly, strong) NSArray< UIView* >* orderedSubviews;

+ (CGSize)sizeForItem:(nonnull id)item availableSize:(CGSize)size;

- (CGSize)sizeForAvailableSize:(CGSize)size;
- (UILayoutPriority)fittingHorizontalPriority;
- (UILayoutPriority)fittingVerticalPriority;

- (nonnull instancetype)initWithNib:(nullable UINib*)nib;

- (void)setup NS_REQUIRES_SUPER;

- (void)willShow;
- (void)update;
- (void)reload GLB_DEPRECATED;
- (void)didHide;

- (void)refreshConstraints;

- (BOOL)containsActionForKey:(nonnull id)key;
- (BOOL)containsActionForIdentifier:(nonnull id)identifier forKey:(nonnull id)key;

- (void)performActionForKey:(nonnull id)key withArguments:(nullable NSArray*)arguments;

- (void)pressed NS_REQUIRES_SUPER;
- (void)longPressed NS_REQUIRES_SUPER;

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

- (void)willBeginDragging;

- (void)beginTransition;
- (void)transitionResize;
- (void)endTransition;

@end

/*--------------------------------------------------*/

extern NSString* _Nonnull GLBDataViewCellPressed;
extern NSString* _Nonnull GLBDataViewCellLongPressed;

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
