/*--------------------------------------------------*/

#import "GLBWindow.h"
#import "GLBTransitionController.h"
#import "NSString+GLBNS.h"
#import "UIViewController+GLBUI.h"
#import "UIScrollView+GLBUI.h"
#import "UIDevice+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@protocol GLBPageViewControllerDelegate;
@protocol GLBPageDecorDelegate;

/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBPageViewControllerOrientation) {
    GLBPageViewControllerOrientationHorizontal,
    GLBPageViewControllerOrientationVertical
};

/*--------------------------------------------------*/

typedef NS_ENUM(NSInteger, GLBPageViewControllerDirection) {
    GLBPageViewControllerDirectionForward,
    GLBPageViewControllerDirectionReverse
};

/*--------------------------------------------------*/

@interface GLBPageViewController : UIViewController < GLBWindowExtension, GLBViewControllerExtension >

@property(nonatomic) IBInspectable GLBPageViewControllerOrientation orientation;
@property(nonatomic, nullable, strong) UIViewController< GLBPageViewControllerDelegate >* viewController;
@property(nonatomic, readonly, getter = isAnimating) BOOL animating;
@property(nonatomic) IBInspectable BOOL userInteractionEnabled;
@property(nonatomic) IBInspectable CGFloat draggingRate;
@property(nonatomic) IBInspectable CGFloat bounceRate;
@property(nonatomic) IBInspectable CGFloat thresholdHorizontal;
@property(nonatomic) IBInspectable CGFloat thresholdVertical;

- (void)setViewController:(nullable UIViewController< GLBPageViewControllerDelegate >*)viewController direction:(GLBPageViewControllerDirection)direction animated:(BOOL)animated;
- (void)setViewController:(nullable UIViewController< GLBPageViewControllerDelegate >*)viewController direction:(GLBPageViewControllerDirection)direction duration:(NSTimeInterval)duration animated:(BOOL)animated;

@end

/*--------------------------------------------------*/

@protocol GLBPageViewControllerDelegate < NSObject >

@required
- (BOOL)allowBeforeViewControllerInPageViewController:(nonnull GLBPageViewController*)pageController;
- (BOOL)allowAfterViewControllerInPageViewController:(nonnull GLBPageViewController*)pageController;

@optional
- (void)willAppearInPageViewController:(nonnull GLBPageViewController*)pageController direction:(GLBPageViewControllerDirection)direction;
- (void)didAppearInPageViewController:(nonnull GLBPageViewController*)pageController direction:(GLBPageViewControllerDirection)direction;
- (void)willDisappearInPageViewController:(nonnull GLBPageViewController*)pageController direction:(GLBPageViewControllerDirection)direction;
- (void)didDisappearInPageViewController:(nonnull GLBPageViewController*)pageController direction:(GLBPageViewControllerDirection)direction;

@optional
- (nullable UIViewController< GLBPageViewControllerDelegate >*)beforeViewControllerInPageViewController:(nonnull GLBPageViewController*)pageController;
- (UIEdgeInsets)beforeDecorInsetsInPageViewController:(nonnull GLBPageViewController*)pageController;
- (CGSize)beforeDecorSizeInPageViewController:(nonnull GLBPageViewController*)pageController;
- (nullable UIView< GLBPageDecorDelegate >*)beforeDecorViewInPageViewController:(nonnull GLBPageViewController*)pageController;

@optional
- (nullable UIViewController< GLBPageViewControllerDelegate >*)afterViewControllerInPageViewController:(nonnull GLBPageViewController*)pageController;
- (UIEdgeInsets)afterDecorInsetsInPageViewController:(nonnull GLBPageViewController*)pageController;
- (CGSize)afterDecorSizeInPageViewController:(nonnull GLBPageViewController*)pageController;
- (nullable UIView< GLBPageDecorDelegate >*)afterDecorViewInPageViewController:(nonnull GLBPageViewController*)pageController;

@end

/*--------------------------------------------------*/

@protocol GLBPageDecorDelegate < NSObject >

@optional
- (void)pageController:(nonnull GLBPageViewController*)pageController applyFromProgress:(CGFloat)progress;

@end

/*--------------------------------------------------*/

@interface UIViewController (GLBPageViewController)

@property(nonatomic, nullable, weak) GLBPageViewController* glb_pageController;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
