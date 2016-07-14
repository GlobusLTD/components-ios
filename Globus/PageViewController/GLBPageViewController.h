/*--------------------------------------------------*/

#import "GLBBaseViewController.h"

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
@property(nonatomic, strong) UIViewController< GLBPageViewControllerDelegate >* viewController;
@property(nonatomic, readonly, assign, getter = isAnimating) BOOL animating;
@property(nonatomic) IBInspectable BOOL userInteractionEnabled;
@property(nonatomic) IBInspectable CGFloat draggingRate;
@property(nonatomic) IBInspectable CGFloat bounceRate;
@property(nonatomic) IBInspectable CGFloat thresholdHorizontal;
@property(nonatomic) IBInspectable CGFloat thresholdVertical;

- (void)setViewController:(UIViewController< GLBPageViewControllerDelegate >*)viewController direction:(GLBPageViewControllerDirection)direction animated:(BOOL)animated;
- (void)setViewController:(UIViewController< GLBPageViewControllerDelegate >*)viewController direction:(GLBPageViewControllerDirection)direction duration:(NSTimeInterval)duration animated:(BOOL)animated;

@end

/*--------------------------------------------------*/

@protocol GLBPageViewControllerDelegate < NSObject >

@required
- (BOOL)allowBeforeViewControllerInPageViewController:(GLBPageViewController*)pageController;
- (BOOL)allowAfterViewControllerInPageViewController:(GLBPageViewController*)pageController;

@optional
- (void)willAppearInPageViewController:(GLBPageViewController*)pageController direction:(GLBPageViewControllerDirection)direction;
- (void)didAppearInPageViewController:(GLBPageViewController*)pageController direction:(GLBPageViewControllerDirection)direction;
- (void)willDisappearInPageViewController:(GLBPageViewController*)pageController direction:(GLBPageViewControllerDirection)direction;
- (void)didDisappearInPageViewController:(GLBPageViewController*)pageController direction:(GLBPageViewControllerDirection)direction;

@optional
- (UIViewController< GLBPageViewControllerDelegate >*)beforeViewControllerInPageViewController:(GLBPageViewController*)pageController;
- (UIEdgeInsets)beforeDecorInsetsInPageViewController:(GLBPageViewController*)pageController;
- (CGSize)beforeDecorSizeInPageViewController:(GLBPageViewController*)pageController;
- (UIView< GLBPageDecorDelegate >*)beforeDecorViewInPageViewController:(GLBPageViewController*)pageController;

@optional
- (UIViewController< GLBPageViewControllerDelegate >*)afterViewControllerInPageViewController:(GLBPageViewController*)pageController;
- (UIEdgeInsets)afterDecorInsetsInPageViewController:(GLBPageViewController*)pageController;
- (CGSize)afterDecorSizeInPageViewController:(GLBPageViewController*)pageController;
- (UIView< GLBPageDecorDelegate >*)afterDecorViewInPageViewController:(GLBPageViewController*)pageController;

@end

/*--------------------------------------------------*/

@protocol GLBPageDecorDelegate < NSObject >

@optional
- (void)pageController:(GLBPageViewController*)pageController applyFromProgress:(CGFloat)progress;

@end

/*--------------------------------------------------*/

@interface UIViewController (GLBPageViewController)

@property(nonatomic, weak) GLBPageViewController* glb_pageController;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
