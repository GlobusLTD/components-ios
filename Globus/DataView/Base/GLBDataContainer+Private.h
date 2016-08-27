/*--------------------------------------------------*/

#import "GLBDataContainer.h"
#import "GLBDataViewItem+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataContainer () {
@protected
    __weak GLBDataView* _view;
    __weak GLBDataContainer* _parent;
    BOOL _hidden;
    BOOL _allowAutoAlign;
    UIEdgeInsets _alignInsets;
    GLBDataContainerAlign _alignPosition;
    UIOffset _alignThreshold;
    CGRect _frame;
}

@property(nonatomic, weak) __kindof GLBDataView* view;
@property(nonatomic, weak) __kindof GLBDataContainer* parent;

- (void)_willChangeView;
- (void)_didChangeView;
- (void)_willChangeParent;
- (void)_didChangeParent;

- (void)_willBeginDragging;
- (void)_didScrollDragging:(BOOL)dragging decelerating:(BOOL)decelerating;
- (void)_willEndDraggingWithVelocity:(CGPoint)velocity contentOffset:(inout CGPoint*)contentOffset contentSize:(CGSize)contentSize visibleSize:(CGSize)visibleSize;
- (void)_didEndDraggingWillDecelerate:(BOOL)decelerate;
- (void)_willBeginDecelerating;
- (void)_didEndDecelerating;
- (void)_didEndScrollingAnimation;

- (void)_beginUpdateAnimated:(BOOL)animated;
- (void)_updateAnimated:(BOOL)animated;
- (void)_endUpdateAnimated:(BOOL)animated;

- (CGPoint)_alignPointWithContentOffset:(CGPoint)contentOffset contentSize:(CGSize)contentSize visibleSize:(CGSize)visibleSize;
- (CGPoint)_alignWithVelocity:(CGPoint)velocity contentOffset:(CGPoint)contentOffset contentSize:(CGSize)contentSize visibleSize:(CGSize)visibleSize;

- (CGRect)_validateLayoutForAvailableFrame:(CGRect)frame;

- (CGRect)_frameForAvailableFrame:(CGRect)frame;
- (void)_layoutForAvailableFrame:(CGRect)frame;
- (void)_willLayoutForBounds:(CGRect)bounds;
- (void)_didLayoutForBounds:(CGRect)bounds;

- (void)_beginMovingItem:(GLBDataViewItem*)item location:(CGPoint)location;
- (void)_movingItem:(GLBDataViewItem*)item location:(CGPoint)location delta:(CGPoint)delta allowsSorting:(BOOL)allowsSorting;
- (void)_endMovingItem:(GLBDataViewItem*)item location:(CGPoint)location;

- (void)_beginTransition;
- (void)_transitionResize;
- (void)_endTransition;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
