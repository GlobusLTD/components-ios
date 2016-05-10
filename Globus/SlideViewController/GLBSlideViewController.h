/*--------------------------------------------------*/

#import "GLBBaseViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBSlideViewControllerStyle) {
    GLBSlideViewControllerStyleStands,
    GLBSlideViewControllerStyleLeaves,
    GLBSlideViewControllerStylePushes
};

/*--------------------------------------------------*/

@interface GLBSlideViewController : GLBBaseViewController < GLBViewController >

@property(nonatomic, readonly, getter=isSwipeDragging) BOOL swipeDragging;
@property(nonatomic, readonly, getter=isSwipeDecelerating) BOOL swipeDecelerating;
@property(nonatomic) IBInspectable CGFloat swipeVelocity;
@property(nonatomic) IBInspectable CGFloat swipeDamping;
@property(nonatomic) IBInspectable BOOL swipeUseSpring;

@property(nonatomic, readonly, strong) UIView* backgroundView;
@property(nonatomic, strong) IBOutlet __kindof UIViewController* backgroundViewController;

@property(nonatomic, readonly, strong) UIView* leftView;
@property(nonatomic, strong) IBOutlet __kindof UIViewController* leftViewController;
@property(nonatomic) IBInspectable GLBSlideViewControllerStyle leftViewControllerStyle;
@property(nonatomic) IBInspectable CGFloat leftViewControllerWidth;
@property(nonatomic) IBInspectable BOOL leftViewControllerIteractionShowEnabled;
@property(nonatomic) IBInspectable BOOL leftViewControllerIteractionHideEnabled;
@property(nonatomic) IBInspectable CGFloat leftViewControllerShowOffset;
@property(nonatomic) IBInspectable CGFloat leftViewControllerHideOffset;
@property(nonatomic) IBInspectable CGFloat leftViewControllerShowAlpha;
@property(nonatomic) IBInspectable CGFloat leftViewControllerHideAlpha;
@property(nonatomic, getter=isShowedLeftViewController) IBInspectable BOOL showedLeftViewController;

@property(nonatomic, readonly, strong) UIView* rightView;
@property(nonatomic, strong) IBOutlet __kindof UIViewController* rightViewController;
@property(nonatomic) IBInspectable GLBSlideViewControllerStyle rightViewControllerStyle;
@property(nonatomic) IBInspectable CGFloat rightViewControllerWidth;
@property(nonatomic) IBInspectable BOOL rightViewControllerIteractionShowEnabled;
@property(nonatomic) IBInspectable BOOL rightViewControllerIteractionHideEnabled;
@property(nonatomic) IBInspectable CGFloat rightViewControllerShowOffset;
@property(nonatomic) IBInspectable CGFloat rightViewControllerHideOffset;
@property(nonatomic) IBInspectable CGFloat rightViewControllerShowAlpha;
@property(nonatomic) IBInspectable CGFloat rightViewControllerHideAlpha;
@property(nonatomic, getter=isShowedRightViewController) IBInspectable BOOL showedRightViewController;

@property(nonatomic, readonly, strong) UIView* centerView;
@property(nonatomic, strong) IBOutlet __kindof UIViewController* centerViewController;
@property(nonatomic) IBInspectable CGFloat centerViewControllerShowOffset;
@property(nonatomic) IBInspectable CGFloat centerViewControllerHideOffset;
@property(nonatomic) IBInspectable CGFloat centerViewControllerShowAlpha;
@property(nonatomic) IBInspectable CGFloat centerViewControllerHideAlpha;

@property(nonatomic, getter=isDraggingStatusBar) BOOL draggingStatusBar;
@property(nonatomic) BOOL canUseScreenshot;

- (void)setBackgroundViewController:(UIViewController*)backgroundViewController animated:(BOOL)animated complete:(GLBSimpleBlock)complete;
- (void)setLeftViewController:(UIViewController*)leftViewController animated:(BOOL)animated complete:(GLBSimpleBlock)complete;
- (void)setRightViewController:(UIViewController*)rightViewController animated:(BOOL)animated complete:(GLBSimpleBlock)complete;
- (void)setCenterViewController:(UIViewController*)centerViewController animated:(BOOL)animated complete:(GLBSimpleBlock)complete;

- (void)showLeftViewControllerAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete;
- (void)hideLeftViewControllerAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete;

- (void)showRightViewControllerAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete;
- (void)hideRightViewControllerAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete;

@end

/*--------------------------------------------------*/

@protocol GLBSlideViewControllerDelegate < NSObject >

@optional
- (BOOL)canShowLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController;
- (void)willShowLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(CGFloat)duration;
- (void)didShowLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController;
- (void)willHideLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(CGFloat)duration;
- (void)didHideLeftViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController;

@optional
- (BOOL)canShowRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController;
- (void)willShowRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(CGFloat)duration;
- (void)didShowRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController;
- (void)willHideRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(CGFloat)duration;
- (void)didHideRightViewControllerInSlideViewController:(GLBSlideViewController*)slideViewController;

@optional
- (BOOL)canShowControllerInSlideViewController:(GLBSlideViewController*)slideViewController;
- (void)willShowControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(CGFloat)duration;
- (void)didShowControllerInSlideViewController:(GLBSlideViewController*)slideViewController;
- (void)willHideControllerInSlideViewController:(GLBSlideViewController*)slideViewController duration:(CGFloat)duration;
- (void)didHideControllerInSlideViewController:(GLBSlideViewController*)slideViewController;

@optional
- (void)willBeganLeftSwipeInSlideViewController:(GLBSlideViewController*)slideViewController;
- (void)didBeganLeftSwipeInSlideViewController:(GLBSlideViewController*)slideViewController;
- (void)movingLeftSwipeInSlideViewController:(GLBSlideViewController*)slideViewController progress:(CGFloat)progress;
- (void)willEndedLeftSwipeInSlideViewController:(GLBSlideViewController*)slideViewController;
- (void)didEndedLeftSwipeInSlideViewController:(GLBSlideViewController*)slideViewController;

@optional
- (void)willBeganRightSwipeInSlideViewController:(GLBSlideViewController*)slideViewController;
- (void)didBeganRightSwipeInSlideViewController:(GLBSlideViewController*)slideViewController;
- (void)movingRightSwipeInSlideViewController:(GLBSlideViewController*)slideViewController progress:(CGFloat)progress;
- (void)willEndedRightSwipeInSlideViewController:(GLBSlideViewController*)slideViewController;
- (void)didEndedRightSwipeInSlideViewController:(GLBSlideViewController*)slideViewController;

@optional
- (void)willBeganSwipeInSlideViewController:(GLBSlideViewController*)slideViewController;
- (void)didBeganSwipeInSlideViewController:(GLBSlideViewController*)slideViewController;
- (void)movingSwipeInSlideViewController:(GLBSlideViewController*)slideViewController progress:(CGFloat)progress;
- (void)willEndedSwipeInSlideViewController:(GLBSlideViewController*)slideViewController;
- (void)didEndedSwipeInSlideViewController:(GLBSlideViewController*)slideViewController;

@end

/*--------------------------------------------------*/

@interface UIViewController (GLBSlideViewController)

@property(nonatomic, weak) GLBSlideViewController* glb_slideViewController;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
