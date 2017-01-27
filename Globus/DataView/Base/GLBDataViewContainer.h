/*--------------------------------------------------*/

#import "GLBDataViewTypes.h"
#import "GLBSearchBar.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBDataView;
@class GLBDataViewContainer;
@class GLBDataViewItem;
@class GLBDataViewCell;

/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBDataViewContainerOrientation) {
    GLBDataViewContainerOrientationVertical,
    GLBDataViewContainerOrientationHorizontal,
};

typedef NS_OPTIONS(NSUInteger, GLBDataViewContainerAlign) {
    GLBDataViewContainerAlignNone = GLBDataViewPositionNone,
    GLBDataViewContainerAlignTop = GLBDataViewPositionTop,
    GLBDataViewContainerAlignCenteredVertically = GLBDataViewPositionCenteredVertically,
    GLBDataViewContainerAlignBottom = GLBDataViewPositionBottom,
    GLBDataViewContainerAlignLeft = GLBDataViewPositionLeft,
    GLBDataViewContainerAlignCenteredHorizontally = GLBDataViewPositionCenteredHorizontally,
    GLBDataViewContainerAlignRight = GLBDataViewPositionRight,
    GLBDataViewContainerAlignCentered = GLBDataViewContainerAlignCenteredVertically | GLBDataViewContainerAlignCenteredHorizontally,
};

/*--------------------------------------------------*/

typedef void(^GLBDataViewContainerConfigureItemBlock)(__kindof GLBDataViewItem* _Nonnull item);

/*--------------------------------------------------*/

@interface GLBDataViewContainer : NSObject< GLBSearchBarDelegate >

@property(nonatomic, nullable, readonly, weak) __kindof GLBDataView* dataView;
@property(nonatomic, nullable, readonly, weak) __kindof GLBDataViewContainer* container;
@property(nonatomic, readonly, assign) CGRect frame;
@property(nonatomic, getter=isHidden) BOOL hidden;
@property(nonatomic, readonly, assign, getter=isHiddenInHierarchy) BOOL hiddenInHierarchy;
@property(nonatomic) BOOL allowAutoAlign;
@property(nonatomic) UIEdgeInsets alignInsets;
@property(nonatomic) GLBDataViewContainerAlign alignPosition;
@property(nonatomic) UIOffset alignThreshold;

- (void)setup NS_REQUIRES_SUPER;

- (void)willChangeDataView NS_REQUIRES_SUPER;
- (void)didChangeDataView NS_REQUIRES_SUPER;
- (void)willChangeContainer NS_REQUIRES_SUPER;
- (void)didChangeContainer NS_REQUIRES_SUPER;

- (void)setNeedResize;
- (void)setNeedUpdate;
- (void)setNeedReload GLB_DEPRECATED;

- (nonnull NSArray*)allItems;

- (nullable __kindof GLBDataViewItem*)itemForPoint:(CGPoint)point;
- (nullable __kindof GLBDataViewItem*)itemForData:(nonnull id)data;
- (nullable __kindof GLBDataViewCell*)cellForData:(nonnull id)data;

- (BOOL)containsActionForKey:(nonnull id)key;
- (BOOL)containsActionForIdentifier:(nonnull id)identifier forKey:(nonnull id)key;

- (void)performActionForKey:(nonnull id)key withArguments:(nullable NSArray*)arguments;
- (void)performActionForIdentifier:(nonnull id)identifier forKey:(nonnull id)key withArguments:(nullable NSArray*)arguments;

- (void)willBeginDragging;
- (void)didScrollDragging:(BOOL)dragging decelerating:(BOOL)decelerating;
- (void)willEndDraggingWithVelocity:(CGPoint)velocity contentOffset:(nullable inout CGPoint*)contentOffset contentSize:(CGSize)contentSize visibleSize:(CGSize)visibleSize;
- (void)didEndDraggingWillDecelerate:(BOOL)decelerate;
- (void)willBeginDecelerating;
- (void)didEndDecelerating;
- (void)didEndScrollingAnimation;

- (void)beginUpdateAnimated:(BOOL)animated;
- (void)updateAnimated:(BOOL)animated;
- (void)endUpdateAnimated:(BOOL)animated;

- (CGPoint)alignPoint;
- (CGPoint)alignPointWithContentOffset:(CGPoint)contentOffset contentSize:(CGSize)contentSize visibleSize:(CGSize)visibleSize;
- (CGPoint)alignWithVelocity:(CGPoint)velocity contentOffset:(CGPoint)contentOffset contentSize:(CGSize)contentSize visibleSize:(CGSize)visibleSize;
- (void)align;

- (CGRect)validateLayoutForAvailableFrame:(CGRect)frame;

- (CGRect)frameForAvailableFrame:(CGRect)frame;
- (void)layoutForAvailableFrame:(CGRect)frame;
- (void)willLayoutForBounds:(CGRect)bounds;
- (void)didLayoutForBounds:(CGRect)bounds;

- (void)beginMovingItem:(nonnull GLBDataViewItem*)item location:(CGPoint)location;
- (void)movingItem:(nonnull GLBDataViewItem*)item location:(CGPoint)location delta:(CGPoint)delta allowsSorting:(BOOL)allowsSorting;
- (void)endMovingItem:(nonnull GLBDataViewItem*)item location:(CGPoint)location;

- (void)beginTransition;
- (void)transitionResize;
- (void)endTransition;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
