/*--------------------------------------------------*/

#import "GLBDataViewTypes.h"
#import "GLBSearchBar.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBDataView;
@class GLBDataViewContainer;
@class GLBDataViewCell;
@class GLBDataViewItemAccessibilityElement;

/*--------------------------------------------------*/

@interface GLBDataViewItem : NSObject< GLBSearchBarDelegate >

@property(nonatomic, readonly, weak) __kindof GLBDataView* dataView;
@property(nonatomic, readonly, weak) __kindof GLBDataViewContainer* container;
@property(nonatomic, readonly, strong) NSString* identifier;
@property(nonatomic, readonly, assign) NSUInteger order;
@property(nonatomic, readonly, assign) NSUInteger accessibilityOrder;
@property(nonatomic, strong) id data;
@property(nonatomic, readonly, assign) CGSize size;
@property(nonatomic) CGRect originFrame;
@property(nonatomic) CGRect updateFrame;
@property(nonatomic) CGRect displayFrame;
@property(nonatomic, readonly, assign) CGRect frame;
@property(nonatomic, readonly) BOOL needResize;
@property(nonatomic, getter=isHidden) BOOL hidden;
@property(nonatomic, readonly, assign, getter=isHiddenInHierarchy) BOOL hiddenInHierarchy;
@property(nonatomic) BOOL allowsAlign;
@property(nonatomic) BOOL allowsPressed;
@property(nonatomic) BOOL allowsLongPressed;
@property(nonatomic) BOOL allowsSelection;
@property(nonatomic) BOOL allowsHighlighting;
@property(nonatomic) BOOL allowsEditing;
@property(nonatomic) BOOL allowsMoving;
@property(nonatomic) BOOL persistent;
@property(nonatomic, readonly, assign, getter=isSelected) BOOL selected;
@property(nonatomic, readonly, assign, getter=isHighlighted) BOOL highlighted;
@property(nonatomic, readonly, assign, getter=isEditing) BOOL editing;
@property(nonatomic, readonly, assign, getter=isMoving) BOOL moving;
@property(nonatomic, readonly, strong) __kindof GLBDataViewCell* cell;
@property(nonatomic, readonly, strong) GLBDataViewItemAccessibilityElement* accessibilityElement;

+ (NSArray< __kindof GLBDataViewItem* >*)itemsWithIdentifier:(NSString*)identifier order:(NSUInteger)order dataArray:(NSArray*)dataArray;
+ (NSArray< __kindof GLBDataViewItem* >*)itemsWithIdentifier:(NSString*)identifier order:(NSUInteger)order accessibilityOrder:(NSUInteger)accessibilityOrder dataArray:(NSArray*)dataArray;

+ (instancetype)itemWithIdentifier:(NSString*)identifier order:(NSUInteger)order data:(id)data;
+ (instancetype)itemWithIdentifier:(NSString*)identifier order:(NSUInteger)order accessibilityOrder:(NSUInteger)accessibilityOrder data:(id)data;

- (instancetype)initWithIdentifier:(NSString*)identifier order:(NSUInteger)order data:(id)data;
- (instancetype)initWithIdentifier:(NSString*)identifier order:(NSUInteger)order accessibilityOrder:(NSUInteger)accessibilityOrder data:(id)data;

- (void)setup NS_REQUIRES_SUPER;

- (BOOL)containsActionForKey:(id)key;
- (BOOL)containsActionForIdentifier:(id)identifier forKey:(id)key;

- (void)performActionForKey:(id)key withArguments:(NSArray*)arguments;

- (void)beginUpdateAnimated:(BOOL)animated;
- (void)updateAnimated:(BOOL)animated;
- (void)endUpdateAnimated:(BOOL)animated;

- (void)selectedAnimated:(BOOL)animated NS_REQUIRES_SUPER;
- (void)deselectedAnimated:(BOOL)animated NS_REQUIRES_SUPER;

- (void)highlightedAnimated:(BOOL)animated NS_REQUIRES_SUPER;
- (void)unhighlightedAnimated:(BOOL)animated NS_REQUIRES_SUPER;

- (void)beginEditingAnimated:(BOOL)animated NS_REQUIRES_SUPER;
- (void)endEditingAnimated:(BOOL)animated NS_REQUIRES_SUPER;

- (void)beginMovingAnimated:(BOOL)animated NS_REQUIRES_SUPER;
- (void)endMovingAnimated:(BOOL)animated NS_REQUIRES_SUPER;

- (void)setNeedResize;
- (CGSize)sizeForAvailableSize:(CGSize)size;

- (void)setNeedUpdate;
- (void)setNeedReload GLB_DEPRECATED;

- (void)validateLayoutForBounds:(CGRect)bounds;
- (void)invalidateLayoutForBounds:(CGRect)bounds;

- (void)beginTransition;
- (void)transitionResize;
- (void)endTransition;

@end

/*--------------------------------------------------*/

@interface GLBDataViewItemAccessibilityElement : UIAccessibilityElement

@property(nonatomic, readonly, weak) __kindof GLBDataView* dataView;
@property(nonatomic, readonly, weak) __kindof GLBDataViewItem* item;

+ (instancetype)accessibilityElementWithDataView:(GLBDataView*)dataView item:(GLBDataViewItem*)item;

- (instancetype)initWithDataView:(GLBDataView*)dataView item:(GLBDataViewItem*)item;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
