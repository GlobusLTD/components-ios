/*--------------------------------------------------*/

#import "GLBDataViewCell.h"
#import "GLBDataViewItem+Private.h"
#import "GLBDataView+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewCell () {
@protected
    __weak GLBDataView* _dataView;
    __weak GLBDataViewItem* _item;
    BOOL _selected;
    BOOL _highlighted;
    BOOL _editing;
    BOOL _moving;
    UILongPressGestureRecognizer* _pressGestureRecognizer;
    UILongPressGestureRecognizer* _longPressGestureRecognizer;
    UIView* _rootView;
    UIOffset _rootViewOffset;
    CGSize _rootViewSize;
    NSLayoutConstraint* _constraintRootViewCenterX;
    NSLayoutConstraint* _constraintRootViewCenterY;
    NSLayoutConstraint* _constraintRootViewWidth;
    NSLayoutConstraint* _constraintRootViewHeight;
}

@property(nonatomic, weak) GLBDataView* dataView;
@property(nonatomic, weak) GLBDataViewItem* item;
@property(nonatomic, getter=isMoving) BOOL moving;
@property(nonatomic, strong) UILongPressGestureRecognizer* pressGestureRecognizer;
@property(nonatomic, strong) UILongPressGestureRecognizer* longPressGestureRecognizer;
@property(nonatomic, strong) NSLayoutConstraint* constraintRootViewCenterX;
@property(nonatomic, strong) NSLayoutConstraint* constraintRootViewCenterY;
@property(nonatomic, strong) NSLayoutConstraint* constraintRootViewWidth;
@property(nonatomic, strong) NSLayoutConstraint* constraintRootViewHeight;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
