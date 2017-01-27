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

+ (nonnull instancetype)dialogViewControllerWithContentViewController:(nonnull UIViewController*)contentViewController NS_SWIFT_UNAVAILABLE("Use init(contentViewController:)");

- (nullable instancetype)initWithCoder:(nonnull NSCoder*)coder NS_UNAVAILABLE;
- (nonnull instancetype)initWithNibName:(nullable NSString*)nib bundle:(nullable NSBundle*)bundle NS_UNAVAILABLE;
- (nonnull instancetype)initWithContentViewController:(nonnull UIViewController*)contentViewController NS_DESIGNATED_INITIALIZER;

- (void)presentViewController:(nullable UIViewController*)viewController withCompletion:(nullable GLBDialogViewControllerBlock)completion;
- (void)presentWithCompletion:(nullable GLBDialogViewControllerBlock)completion;
- (void)dismissWithCompletion:(nullable GLBDialogViewControllerBlock)completion;

@end

/*--------------------------------------------------*/

@interface GLBDialogAnimationController : NSObject

- (void)presentDialogViewController:(nonnull GLBDialogViewController*)dialogViewController completion:(nonnull GLBSimpleBlock)completion;
- (void)dismissDialogViewController:(nonnull GLBDialogViewController*)dialogViewController completion:(nonnull GLBSimpleBlock)completion;

@end

/*--------------------------------------------------*/

@interface GLBDialogDefaultAnimationController : GLBDialogAnimationController
@end

/*--------------------------------------------------*/

@protocol GLBDialogContentViewController < NSObject >

@optional
- (void)willPresentDialogViewController:(nonnull GLBDialogViewController*)dialogViewController;
- (void)didPresentDialogViewController:(nonnull GLBDialogViewController*)dialogViewController;

@optional
- (void)willDismissDialogViewController:(nonnull GLBDialogViewController*)dialogViewController;
- (void)didDismissDialogViewController:(nonnull GLBDialogViewController*)dialogViewController;

@end

/*--------------------------------------------------*/

@interface UIViewController (GLBDialogViewController)

@property(nonatomic, nullable, weak) GLBDialogViewController* glb_dialogViewController;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
