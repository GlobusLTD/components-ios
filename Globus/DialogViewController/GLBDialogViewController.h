/*--------------------------------------------------*/

#import "UIApplication+GLBUI.h"
#import "UIViewController+GLBUI.h"
#import "UIWindow+GLBUI.h"

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

typedef void(^GLBDialogViewControllerBlock)(GLBDialogViewController* _Nonnull dialogViewController);

/*--------------------------------------------------*/

@interface GLBDialogViewController : UIViewController

@property(nonatomic, getter=isPresented) BOOL presented;

@property(nonatomic, nullable, strong) GLBDialogAnimationController* animationController;

@property(nonatomic) CGFloat animationDuration;

@property(nonatomic, getter=isBackgroundBlurred) BOOL backgroundBlurred;
@property(nonatomic) CGFloat backgroundBlurRadius;
@property(nonatomic) NSUInteger backgroundBlurIterations;
@property(nonatomic, getter = isBackgroundBlurDynamic) IBInspectable BOOL backgroundBlurDynamic;
@property(nonatomic) IBInspectable NSTimeInterval backgroundBlurUpdateInterval;
@property(nonatomic, nullable, strong) UIColor* backgroundColor;
@property(nonatomic, nullable, strong) UIColor* backgroundTintColor;
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

@property(nonatomic, nullable, copy) GLBDialogViewControllerBlock touchedOutsideContent;
@property(nonatomic, nullable, copy) GLBDialogViewControllerBlock dismiss;

- (instancetype _Nonnull)initWithContentViewController:(UIViewController* _Nonnull)contentViewController;

- (void)presentViewController:(UIViewController* _Nullable)viewController withCompletion:(GLBDialogViewControllerBlock _Nullable)completion;
- (void)presentWithCompletion:(GLBDialogViewControllerBlock _Nullable)completion;
- (void)dismissWithCompletion:(GLBDialogViewControllerBlock _Nullable)completion;

@end

/*--------------------------------------------------*/

@interface GLBDialogAnimationController : NSObject

- (void)presentDialogViewController:(GLBDialogViewController* _Nonnull)dialogViewController completion:(GLBSimpleBlock _Nonnull)completion;
- (void)dismissDialogViewController:(GLBDialogViewController* _Nonnull)dialogViewController completion:(GLBSimpleBlock _Nonnull)completion;

@end

/*--------------------------------------------------*/

@interface GLBDialogDefaultAnimationController : GLBDialogAnimationController
@end

/*--------------------------------------------------*/

@protocol GLBDialogContentViewController < NSObject >

@optional
- (void)willPresentDialogViewController:(GLBDialogViewController* _Nonnull)dialogViewController;
- (void)didPresentDialogViewController:(GLBDialogViewController* _Nonnull)dialogViewController;

@optional
- (void)willDismissDialogViewController:(GLBDialogViewController* _Nonnull)dialogViewController;
- (void)didDismissDialogViewController:(GLBDialogViewController* _Nonnull)dialogViewController;

@end

/*--------------------------------------------------*/

@interface UIViewController (GLBDialogViewController)

@property(nonatomic, nullable, weak) GLBDialogViewController* glb_dialogViewController;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
