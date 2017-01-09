/*--------------------------------------------------*/

#import "GLBBaseViewController.h"

/*--------------------------------------------------*/

#import "UIScrollView+GLBUI.h"

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

@interface GLBPageViewController : GLBBaseViewController < GLBViewController >

@property(nonatomic) IBInspectable GLBPageViewControllerOrientation orientation;
@property(nonatomic, nullable, strong) UIViewController< GLBPageViewControllerDelegate >* viewController;
@property(nonatomic, readonly, assign, getter = isAnimating) BOOL animating;
@property(nonatomic) IBInspectable BOOL userInteractionEnabled;
@property(nonatomic) IBInspectable CGFloat draggingRate;
@property(nonatomic) IBInspectable CGFloat bounceRate;
@property(nonatomic) IBInspectable CGFloat thresholdHorizontal;
@property(nonatomic) IBInspectable CGFloat thresholdVertical;

- (void)setViewController:(UIViewController< GLBPageViewControllerDelegate >* _Nullable)viewController direction:(GLBPageViewControllerDirection)direction animated:(BOOL)animated;
- (void)setViewController:(UIViewController< GLBPageViewControllerDelegate >* _Nullable)viewController direction:(GLBPageViewControllerDirection)direction duration:(NSTimeInterval)duration animated:(BOOL)animated;

@end

/*--------------------------------------------------*/

@protocol GLBPageViewControllerDelegate < NSObject >

@required
- (BOOL)allowBeforeViewControllerInPageViewController:(GLBPageViewController* _Nonnull)pageController;
- (BOOL)allowAfterViewControllerInPageViewController:(GLBPageViewController* _Nonnull)pageController;

@optional
- (void)willAppearInPageViewController:(GLBPageViewController* _Nonnull)pageController direction:(GLBPageViewControllerDirection)direction;
- (void)didAppearInPageViewController:(GLBPageViewController* _Nonnull)pageController direction:(GLBPageViewControllerDirection)direction;
- (void)willDisappearInPageViewController:(GLBPageViewController* _Nonnull)pageController direction:(GLBPageViewControllerDirection)direction;
- (void)didDisappearInPageViewController:(GLBPageViewController* _Nonnull)pageController direction:(GLBPageViewControllerDirection)direction;

@optional
- (UIViewController< GLBPageViewControllerDelegate >* _Nullable)beforeViewControllerInPageViewController:(GLBPageViewController* _Nonnull)pageController;
- (UIEdgeInsets)beforeDecorInsetsInPageViewController:(GLBPageViewController* _Nonnull)pageController;
- (CGSize)beforeDecorSizeInPageViewController:(GLBPageViewController* _Nonnull)pageController;
- (UIView< GLBPageDecorDelegate >* _Nullable)beforeDecorViewInPageViewController:(GLBPageViewController* _Nonnull)pageController;

@optional
- (UIViewController< GLBPageViewControllerDelegate >* _Nullable)afterViewControllerInPageViewController:(GLBPageViewController* _Nonnull)pageController;
- (UIEdgeInsets)afterDecorInsetsInPageViewController:(GLBPageViewController* _Nonnull)pageController;
- (CGSize)afterDecorSizeInPageViewController:(GLBPageViewController* _Nonnull)pageController;
- (UIView< GLBPageDecorDelegate >* _Nullable)afterDecorViewInPageViewController:(GLBPageViewController* _Nonnull)pageController;

@end

/*--------------------------------------------------*/

@protocol GLBPageDecorDelegate < NSObject >

@optional
- (void)pageController:(GLBPageViewController* _Nonnull)pageController applyFromProgress:(CGFloat)progress;

@end

/*--------------------------------------------------*/

@interface UIViewController (GLBPageViewController)

@property(nonatomic, nullable, weak) GLBPageViewController* glb_pageController;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
