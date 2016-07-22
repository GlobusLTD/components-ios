/*--------------------------------------------------*/

#import "UIViewController+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBDialogViewController;
@class GLBDialogAnimationController;

/*--------------------------------------------------*/

typedef NS_ENUM(NSInteger, GLBDialogViewControllerAlignmentVertical) {
    GLBDialogViewControllerAlignmentVerticalTop = -1,
    GLBDialogViewControllerAlignmentVerticalCenter = 0,
    GLBDialogViewControllerAlignmentVerticalBottom = 1
};

typedef NS_ENUM(NSInteger, GLBDialogViewControllerAlignmentHorizontal) {
    GLBDialogViewControllerAlignmentHorizontalLeft = -1,
    GLBDialogViewControllerAlignmentHorizontalCenter = 0,
    GLBDialogViewControllerAlignmentHorizontalRight = 1
};

typedef NS_ENUM(NSUInteger, GLBDialogViewControllerSizeBehaviour) {
    GLBDialogViewControllerSizeBehaviourFit = 0,
    GLBDialogViewControllerSizeBehaviourFill = 1
};

/*--------------------------------------------------*/

typedef void(^GLBDialogViewControllerBlock)(GLBDialogViewController* dialogViewController);

/*--------------------------------------------------*/

@interface GLBDialogViewController : UIViewController

@property(nonatomic, strong) GLBDialogAnimationController* animationController;

@property(nonatomic) CGFloat animationDuration;

@property(nonatomic, getter=isBackgroundBlurred) BOOL backgroundBlurred;
@property(nonatomic) CGFloat backgroundBlurRadius;
@property(nonatomic) NSUInteger backgroundBlurIterations;
@property(nonatomic, getter = isBackgroundBlurDynamic) IBInspectable BOOL backgroundBlurDynamic;
@property(nonatomic) IBInspectable NSTimeInterval backgroundBlurUpdateInterval;
@property(nonatomic, strong) UIColor* backgroundColor;
@property(nonatomic, strong) UIColor* backgroundTintColor;
@property(nonatomic) CGFloat backgroundAlpha;

@property(nonatomic) GLBDialogViewControllerAlignmentVertical contentVerticalAlignment;
@property(nonatomic) CGFloat contentVerticalOffset;
@property(nonatomic) GLBDialogViewControllerAlignmentHorizontal contentHorizontalAlignment;
@property(nonatomic) CGFloat contentHorizontalOffset;
@property(nonatomic) GLBDialogViewControllerSizeBehaviour contentWidthBehaviour;
@property(nonatomic) GLBDialogViewControllerSizeBehaviour contentHeightBehaviour;
@property(nonatomic) CGSize contentSize;
@property(nonatomic) CGFloat contentWidth;
@property(nonatomic) CGFloat contentHeight;
@property(nonatomic) CGSize contentMinSize;
@property(nonatomic) CGFloat contentMinWidth;
@property(nonatomic) CGFloat contentMinHeight;
@property(nonatomic) CGSize contentMaxSize;
@property(nonatomic) CGFloat contentMaxWidth;
@property(nonatomic) CGFloat contentMaxHeight;
@property(nonatomic) UIEdgeInsets contentInset;
@property(nonatomic) CGFloat contentInsetTop;
@property(nonatomic) CGFloat contentInsetBottom;
@property(nonatomic) CGFloat contentInsetLeft;
@property(nonatomic) CGFloat contentInsetRight;

@property(nonatomic, copy) GLBDialogViewControllerBlock touchedOutsideContent;
@property(nonatomic, copy) GLBDialogViewControllerBlock dismiss;

- (instancetype)initWithContentViewController:(UIViewController*)contentViewController;

- (void)presentViewController:(UIViewController*)viewController withCompletion:(GLBDialogViewControllerBlock)completion;
- (void)presentWithCompletion:(GLBDialogViewControllerBlock)completion;
- (void)dismissWithCompletion:(GLBDialogViewControllerBlock)completion;

@end

/*--------------------------------------------------*/

@interface GLBDialogAnimationController : NSObject

- (void)presentDialogViewController:(GLBDialogViewController*)dialogViewController completion:(GLBSimpleBlock)completion;
- (void)dismissDialogViewController:(GLBDialogViewController*)dialogViewController completion:(GLBSimpleBlock)completion;

@end

/*--------------------------------------------------*/

@interface GLBDialogDefaultAnimationController : GLBDialogAnimationController
@end

/*--------------------------------------------------*/

@protocol GLBDialogContentViewController < NSObject >

@optional
- (void)willPresentDialogViewController:(GLBDialogViewController*)dialogViewController;
- (void)didPresentDialogViewController:(GLBDialogViewController*)dialogViewController;

@optional
- (void)willDismissDialogViewController:(GLBDialogViewController*)dialogViewController;
- (void)didDismissDialogViewController:(GLBDialogViewController*)dialogViewController;

@end

/*--------------------------------------------------*/

@interface UIViewController (GLBDialogViewController)

@property(nonatomic, weak) GLBDialogViewController* glb_dialogViewController;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
