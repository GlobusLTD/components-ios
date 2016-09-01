/*--------------------------------------------------*/

#import "GLBDataViewSwipeCell.h"
#import "GLBDataViewCell+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBDataCellSwipeDirection) {
    GLBDataCellSwipeDirectionUnknown,
    GLBDataCellSwipeDirectionLeft,
    GLBDataCellSwipeDirectionRight
};

/*--------------------------------------------------*/

@interface GLBDataViewSwipeCell () {
@protected
    UIPanGestureRecognizer* _panGestureRecognizer;
    BOOL _swipeEnabled;
    GLBDataViewSwipeCellStyle _swipeStyle;
    CGFloat _swipeThreshold;
    CGFloat _swipeVelocity;
    CGFloat _swipeDamping;
    BOOL _swipeUseSpring;
    BOOL _swipeDragging;
    BOOL _swipeDecelerating;
    BOOL _showedLeftSwipeView;
    BOOL _leftSwipeEnabled;
    UIView* _leftSwipeView;
    CGFloat _leftSwipeOffset;
    CGFloat _leftSwipeSize;
    CGFloat _leftSwipeStretchSize;
    CGFloat _leftSwipeStretchMinThreshold;
    CGFloat _leftSwipeStretchMaxThreshold;
    BOOL _showedRightSwipeView;
    BOOL _rightSwipeEnabled;
    UIView* _rightSwipeView;
    CGFloat _rightSwipeOffset;
    CGFloat _rightSwipeSize;
    CGFloat _rightSwipeStretchSize;
    CGFloat _rightSwipeStretchMinThreshold;
    CGFloat _rightSwipeStretchMaxThreshold;
    NSLayoutConstraint* _constraintLeftSwipeViewOffsetX;
    NSLayoutConstraint* _constraintLeftSwipeViewCenterY;
    NSLayoutConstraint* _constraintLeftSwipeViewWidth;
    NSLayoutConstraint* _constraintLeftSwipeViewHeight;
    NSLayoutConstraint* _constraintRightSwipeViewOffsetX;
    NSLayoutConstraint* _constraintRightSwipeViewCenterY;
    NSLayoutConstraint* _constraintRightSwipeViewWidth;
    NSLayoutConstraint* _constraintRightSwipeViewHeight;
    CGFloat _panSwipeLastOffset;
    CGFloat _panSwipeLastVelocity;
    CGFloat _panSwipeProgress;
    CGFloat _panSwipeLeftWidth;
    CGFloat _panSwipeRightWidth;
    GLBDataCellSwipeDirection _panSwipeDirection;
}

@property(nonatomic, strong) UIPanGestureRecognizer* panGestureRecognizer;
@property(nonatomic, getter=isSwipeDragging) BOOL swipeDragging;
@property(nonatomic, getter=isSwipeDecelerating) BOOL swipeDecelerating;

@property(nonatomic, strong) NSLayoutConstraint* constraintLeftSwipeViewOffsetX;
@property(nonatomic, strong) NSLayoutConstraint* constraintLeftSwipeViewCenterY;
@property(nonatomic, strong) NSLayoutConstraint* constraintLeftSwipeViewWidth;
@property(nonatomic, strong) NSLayoutConstraint* constraintLeftSwipeViewHeight;

@property(nonatomic, strong) NSLayoutConstraint* constraintRightSwipeViewOffsetX;
@property(nonatomic, strong) NSLayoutConstraint* constraintRightSwipeViewCenterY;
@property(nonatomic, strong) NSLayoutConstraint* constraintRightSwipeViewWidth;
@property(nonatomic, strong) NSLayoutConstraint* constraintRightSwipeViewHeight;

@property(nonatomic) CGFloat panSwipeLastOffset;
@property(nonatomic) CGFloat panSwipeLastVelocity;
@property(nonatomic) CGFloat panSwipeProgress;
@property(nonatomic) CGFloat panSwipeLeftWidth;
@property(nonatomic) CGFloat panSwipeRightWidth;
@property(nonatomic) GLBDataCellSwipeDirection panSwipeDirection;

- (UIOffset)_rootViewOffsetBySwipeProgress:(CGFloat)swipeProgress;
- (CGFloat)_leftViewOffsetBySwipeProgress:(CGFloat)swipeProgress;
- (CGFloat)_leftViewSizeBySwipeProgress:(CGFloat)swipeProgress;
- (CGFloat)_rightViewOffsetBySwipeProgress:(CGFloat)swipeProgress;
- (CGFloat)_rightViewSizeBySwipeProgress:(CGFloat)swipeProgress;

- (void)_updateSwipeProgress:(CGFloat)swipeProgress speed:(CGFloat)speed endedSwipe:(BOOL)endedSwipe;

- (void)_handlerPanGestureRecognizer:(UIPanGestureRecognizer*)gestureRecognizer;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
