/*--------------------------------------------------*/

#import "GLBDialogViewController.h"
#import "GLBSlideViewController.h"
#import "GLBBlurView.h"

/*--------------------------------------------------*/

#import "UIWindow+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDialogViewController () < UIGestureRecognizerDelegate >

@property(nonatomic, strong) UIWindow* dialogWindow;
@property(nonatomic, weak) UIWindow* ownerWindow;
@property(nonatomic, strong) UIViewController* ownerViewController;

@property(nonatomic, readonly, strong) UITapGestureRecognizer* tapGesture;
@property(nonatomic, readonly, strong) GLBBlurView* backgroundView;
@property(nonatomic, readonly, strong) UIViewController* contentViewController;
@property(nonatomic, readonly, strong) NSLayoutConstraint* constraintContentViewHorizontalAlignment;
@property(nonatomic, readonly, strong) NSLayoutConstraint* constraintContentViewVerticalAlignment;
@property(nonatomic, readonly, strong) NSLayoutConstraint* constraintContentViewWidth;
@property(nonatomic, readonly, strong) NSLayoutConstraint* constraintContentViewHeight;
@property(nonatomic, readonly, strong) NSLayoutConstraint* constraintContentViewMinWidth;
@property(nonatomic, readonly, strong) NSLayoutConstraint* constraintContentViewMinHeight;
@property(nonatomic, readonly, strong) NSLayoutConstraint* constraintContentViewMaxWidth;
@property(nonatomic, readonly, strong) NSLayoutConstraint* constraintContentViewMaxHeight;
@property(nonatomic, readonly, strong) NSLayoutConstraint* constraintContentViewTop;
@property(nonatomic, readonly, strong) NSLayoutConstraint* constraintContentViewBottom;
@property(nonatomic, readonly, strong) NSLayoutConstraint* constraintContentViewLeft;
@property(nonatomic, readonly, strong) NSLayoutConstraint* constraintContentViewRight;
@property(nonatomic) BOOL autoUpdateConstraintContentView;
@property(nonatomic) BOOL needClearConstraintContentView;

- (void)_updateConstraintContentView;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
