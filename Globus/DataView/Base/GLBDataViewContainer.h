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

typedef void(^GLBDataViewContainerConfigureItemBlock)(__kindof GLBDataViewItem* item);

/*--------------------------------------------------*/

@interface GLBDataViewContainer : NSObject< GLBSearchBarDelegate >

@property(nonatomic, readonly, weak) __kindof GLBDataView* dataView;
@property(nonatomic, readonly, weak) __kindof GLBDataViewContainer* container;
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

- (NSArray*)allItems;

- (__kindof GLBDataViewItem*)itemForPoint:(CGPoint)point;
- (__kindof GLBDataViewItem*)itemForData:(id)data;
- (__kindof GLBDataViewCell*)cellForData:(id)data;

- (BOOL)containsActionForKey:(id)key;
- (BOOL)containsActionForIdentifier:(id)identifier forKey:(id)key;

- (void)performActionForKey:(id)key withArguments:(NSArray*)arguments;
- (void)performActionForIdentifier:(id)identifier forKey:(id)key withArguments:(NSArray*)arguments;

- (void)willBeginDragging;
- (void)didScrollDragging:(BOOL)dragging decelerating:(BOOL)decelerating;
- (void)willEndDraggingWithVelocity:(CGPoint)velocity contentOffset:(inout CGPoint*)contentOffset contentSize:(CGSize)contentSize visibleSize:(CGSize)visibleSize;
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

- (void)beginMovingItem:(GLBDataViewItem*)item location:(CGPoint)location;
- (void)movingItem:(GLBDataViewItem*)item location:(CGPoint)location delta:(CGPoint)delta allowsSorting:(BOOL)allowsSorting;
- (void)endMovingItem:(GLBDataViewItem*)item location:(CGPoint)location;

- (void)beginTransition;
- (void)transitionResize;
- (void)endTransition;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
