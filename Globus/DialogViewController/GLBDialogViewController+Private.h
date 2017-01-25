/*--------------------------------------------------*/

#import "GLBDialogViewController.h"

/*--------------------------------------------------*/

#if __has_include("GLBBlurView.h")
#import "GLBBlurView.h"
#endif

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBBlurView;

/*--------------------------------------------------*/

@interface GLBDialogViewController () < UIGestureRecognizerDelegate >

@property(nonatomic, nullable, strong) UIWindow* dialogWindow;
@property(nonatomic, nullable, weak) UIWindow* ownerWindow;
@property(nonatomic, nullable, strong) UIViewController* ownerViewController;

@property(nonatomic, nullable, readonly, strong) UITapGestureRecognizer* tapGesture;
@property(nonatomic, nullable, readonly, strong) GLBBlurView* backgroundView;
@property(nonatomic, nullable, readonly, strong) UIViewController* contentViewController;
@property(nonatomic, nullable, readonly, strong) NSLayoutConstraint* constraintContentViewHorizontalAlignment;
@property(nonatomic, nullable, readonly, strong) NSLayoutConstraint* constraintContentViewVerticalAlignment;
@property(nonatomic, nullable, readonly, strong) NSLayoutConstraint* constraintContentViewWidth;
@property(nonatomic, nullable, readonly, strong) NSLayoutConstraint* constraintContentViewHeight;
@property(nonatomic, nullable, readonly, strong) NSLayoutConstraint* constraintContentViewMinWidth;
@property(nonatomic, nullable, readonly, strong) NSLayoutConstraint* constraintContentViewMinHeight;
@property(nonatomic, nullable, readonly, strong) NSLayoutConstraint* constraintContentViewMaxWidth;
@property(nonatomic, nullable, readonly, strong) NSLayoutConstraint* constraintContentViewMaxHeight;
@property(nonatomic, nullable, readonly, strong) NSLayoutConstraint* constraintContentViewTop;
@property(nonatomic, nullable, readonly, strong) NSLayoutConstraint* constraintContentViewBottom;
@property(nonatomic, nullable, readonly, strong) NSLayoutConstraint* constraintContentViewLeft;
@property(nonatomic, nullable, readonly, strong) NSLayoutConstraint* constraintContentViewRight;
@property(nonatomic) BOOL autoUpdateConstraintContentView;
@property(nonatomic) BOOL needClearConstraintContentView;

- (void)_updateConstraintContentView;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
