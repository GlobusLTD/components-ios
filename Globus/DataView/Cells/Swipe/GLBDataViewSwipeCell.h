/*--------------------------------------------------*/

#import "GLBDataViewCell.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBDataViewSwipeCellStyle) {
    GLBDataViewSwipeCellStyleStands,
    GLBDataViewSwipeCellStyleLeaves,
    GLBDataViewSwipeCellStylePushes,
    GLBDataViewSwipeCellStyleStretch
};

/*--------------------------------------------------*/

@interface GLBDataViewSwipeCell : GLBDataViewCell

@property(nonatomic, readonly, strong) UIPanGestureRecognizer* panGestureRecognizer;

@property(nonatomic, getter=isSwipeEnabled) BOOL swipeEnabled;
@property(nonatomic) IBInspectable GLBDataViewSwipeCellStyle swipeStyle;
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
#endif
/*--------------------------------------------------*/
