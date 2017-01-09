/*--------------------------------------------------*/

#import "GLBBaseViewController.h"

/*--------------------------------------------------*/

#import "NSArray+GLBNS.h"

/*--------------------------------------------------*/

#include "GLBCG.h"

/*--------------------------------------------------*/

#import "UIApplication+GLBUI.h"
#import "UIDevice+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBSlideViewControllerStyle) {
    GLBSlideViewControllerStyleStands,
    GLBSlideViewControllerStyleLeaves,
    GLBSlideViewControllerStylePushes,
    GLBSlideViewControllerStyleStretch
};

/*--------------------------------------------------*/

@interface GLBSlideViewController : GLBBaseViewController < GLBViewController >

@property(nonatomic, getter=isAnimating) IBInspectable BOOL animating;
@property(nonatomic, readonly, getter=isSwipeDragging) BOOL swipeDragging;
@property(nonatomic, readonly, getter=isSwipeDecelerating) BOOL swipeDecelerating;
@property(nonatomic) IBInspectable CGFloat swipeVelocity;
@property(nonatomic) IBInspectable CGFloat swipeDamping;
@property(nonatomic) IBInspectable BOOL swipeUseSpring;

@property(nonatomic) IBInspectable CGFloat leftEdgeOffset;
@property(nonatomic) IBInspectable CGFloat rightEdgeOffset;

@property(nonatomic, nonnull, readonly, strong) UIView* backgroundView;
@property(nonatomic, nullable, strong) IBOutlet __kindof UIViewController* backgroundViewController;

@property(nonatomic, nonnull, readonly, strong) UIView* leftView;
@property(nonatomic, nullable, strong) IBOutlet __kindof UIViewController* leftViewController;
@property(nonatomic) IBInspectable GLBSlideViewControllerStyle leftViewControllerStyle;
@property(nonatomic) IBInspectable CGFloat leftViewControllerWidth;
@property(nonatomic) IBInspectable BOOL leftViewControllerIteractionShowEnabled;
@property(nonatomic) IBInspectable BOOL leftViewControllerIteractionHideEnabled;
@property(nonatomic) IBInspectable CGFloat leftViewControllerShowOffset;
@property(nonatomic) IBInspectable CGFloat leftViewControllerHideOffset;
@property(nonatomic) IBInspectable CGFloat leftViewControllerShowAlpha;
@property(nonatomic) IBInspectable CGFloat leftViewControllerHideAlpha;
@property(nonatomic, getter=isShowedLeftViewController) IBInspectable BOOL showedLeftViewController;

@property(nonatomic, nonnull, readonly, strong) UIView* rightView;
@property(nonatomic, nullable, strong) IBOutlet __kindof UIViewController* rightViewController;
@property(nonatomic) IBInspectable GLBSlideViewControllerStyle rightViewControllerStyle;
@property(nonatomic) IBInspectable CGFloat rightViewControllerWidth;
@property(nonatomic) IBInspectable BOOL rightViewControllerIteractionShowEnabled;
@property(nonatomic) IBInspectable BOOL rightViewControllerIteractionHideEnabled;
@property(nonatomic) IBInspectable CGFloat rightViewControllerShowOffset;
@property(nonatomic) IBInspectable CGFloat rightViewControllerHideOffset;
@property(nonatomic) IBInspectable CGFloat rightViewControllerShowAlpha;
@property(nonatomic) IBInspectable CGFloat rightViewControllerHideAlpha;
@property(nonatomic, getter=isShowedRightViewController) IBInspectable BOOL showedRightViewController;

@property(nonatomic, nonnull, readonly, strong) UIView* centerView;
@property(nonatomic, nullable, strong) IBOutlet __kindof UIViewController* centerViewController;
@property(nonatomic) IBInspectable CGFloat centerViewControllerShowOffset;
@property(nonatomic) IBInspectable CGFloat centerViewControllerHideOffset;
@property(nonatomic) IBInspectable CGFloat centerViewControllerShowAlpha;
@property(nonatomic) IBInspectable CGFloat centerViewControllerHideAlpha;

@property(nonatomic, getter=isDraggingStatusBar) BOOL draggingStatusBar;
@property(nonatomic) BOOL canUseScreenshot;

- (void)setBackgroundViewController:(UIViewController* _Nullable)backgroundViewController animated:(BOOL)animated complete:(GLBSimpleBlock _Nullable)complete;
- (void)setLeftViewController:(UIViewController* _Nullable)leftViewController animated:(BOOL)animated complete:(GLBSimpleBlock _Nullable)complete;
- (void)setRightViewController:(UIViewController* _Nullable)rightViewController animated:(BOOL)animated complete:(GLBSimpleBlock _Nullable)complete;
- (void)setCenterViewController:(UIViewController* _Nullable)centerViewController animated:(BOOL)animated complete:(GLBSimpleBlock _Nullable)complete;

- (void)showLeftViewControllerAnimated:(BOOL)animated complete:(GLBSimpleBlock _Nullable)complete;
- (void)hideLeftViewControllerAnimated:(BOOL)animated complete:(GLBSimpleBlock _Nullable)complete;

- (void)showRightViewControllerAnimated:(BOOL)animated complete:(GLBSimpleBlock _Nullable)complete;
- (void)hideRightViewControllerAnimated:(BOOL)animated complete:(GLBSimpleBlock _Nullable)complete;

@end

/*--------------------------------------------------*/

@protocol GLBSlideViewControllerDelegate < NSObject >

@optional
- (BOOL)canShowLeftViewControllerInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController;
- (BOOL)canShowLeftViewControllerInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController touch:(CGPoint)touch bounds:(CGRect)bounds;
- (void)willShowLeftViewControllerInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController duration:(NSTimeInterval)duration;
- (void)didShowLeftViewControllerInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController;
- (void)willHideLeftViewControllerInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController duration:(NSTimeInterval)duration;
- (void)didHideLeftViewControllerInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController;

@optional
- (BOOL)canShowRightViewControllerInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController;
- (BOOL)canShowRightViewControllerInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController touch:(CGPoint)touch bounds:(CGRect)bounds;
- (void)willShowRightViewControllerInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController duration:(NSTimeInterval)duration;
- (void)didShowRightViewControllerInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController;
- (void)willHideRightViewControllerInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController duration:(NSTimeInterval)duration;
- (void)didHideRightViewControllerInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController;

@optional
- (BOOL)canShowViewControllerInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController;
- (void)willShowViewControllerInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController duration:(NSTimeInterval)duration;
- (void)didShowViewControllerInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController;
- (void)willHideViewControllerInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController duration:(NSTimeInterval)duration;
- (void)didHideViewControllerInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController;

@optional
- (void)willBeganLeftSwipeInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController;
- (void)didBeganLeftSwipeInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController;
- (void)movingLeftSwipeInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController progress:(CGFloat)progress;
- (void)willEndedLeftSwipeInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController;
- (void)didEndedLeftSwipeInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController;

@optional
- (void)willBeganRightSwipeInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController;
- (void)didBeganRightSwipeInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController;
- (void)movingRightSwipeInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController progress:(CGFloat)progress;
- (void)willEndedRightSwipeInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController;
- (void)didEndedRightSwipeInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController;

@optional
- (void)willBeganSwipeInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController;
- (void)didBeganSwipeInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController;
- (void)movingSwipeInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController progress:(CGFloat)progress;
- (void)willEndedSwipeInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController;
- (void)didEndedSwipeInSlideViewController:(GLBSlideViewController* _Nonnull)slideViewController;

@end

/*--------------------------------------------------*/

@interface UIViewController (GLBSlideViewController)

@property(nonatomic, nullable, weak) GLBSlideViewController* glb_slideViewController;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
