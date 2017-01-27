/*--------------------------------------------------*/

#import "GLBWindow.h"
#import "NSArray+GLBNS.h"
#import "NSString+GLBNS.h"
#import "UIApplication+GLBUI.h"
#import "UIViewController+GLBUI.h"
#import "UIDevice+GLBUI.h"
#include "GLBCG.h"

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

@interface GLBSlideViewController : UIViewController< GLBWindowExtension, GLBViewControllerExtension >

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

- (void)setBackgroundViewController:(nullable UIViewController*)backgroundViewController animated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;
- (void)setLeftViewController:(nullable UIViewController*)leftViewController animated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;
- (void)setRightViewController:(nullable UIViewController*)rightViewController animated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;
- (void)setCenterViewController:(nullable UIViewController*)centerViewController animated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;

- (void)showLeftViewControllerAnimated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;
- (void)hideLeftViewControllerAnimated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;

- (void)showRightViewControllerAnimated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;
- (void)hideRightViewControllerAnimated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;

@end

/*--------------------------------------------------*/

@protocol GLBSlideViewControllerDelegate < NSObject >

@optional
- (BOOL)canShowLeftViewControllerInSlideViewController:(nonnull GLBSlideViewController*)slideViewController;
- (BOOL)canShowLeftViewControllerInSlideViewController:(nonnull GLBSlideViewController*)slideViewController touch:(CGPoint)touch bounds:(CGRect)bounds;
- (void)willShowLeftViewControllerInSlideViewController:(nonnull GLBSlideViewController*)slideViewController duration:(NSTimeInterval)duration;
- (void)didShowLeftViewControllerInSlideViewController:(nonnull GLBSlideViewController*)slideViewController;
- (void)willHideLeftViewControllerInSlideViewController:(nonnull GLBSlideViewController*)slideViewController duration:(NSTimeInterval)duration;
- (void)didHideLeftViewControllerInSlideViewController:(nonnull GLBSlideViewController*)slideViewController;

@optional
- (BOOL)canShowRightViewControllerInSlideViewController:(nonnull GLBSlideViewController*)slideViewController;
- (BOOL)canShowRightViewControllerInSlideViewController:(nonnull GLBSlideViewController*)slideViewController touch:(CGPoint)touch bounds:(CGRect)bounds;
- (void)willShowRightViewControllerInSlideViewController:(nonnull GLBSlideViewController*)slideViewController duration:(NSTimeInterval)duration;
- (void)didShowRightViewControllerInSlideViewController:(nonnull GLBSlideViewController*)slideViewController;
- (void)willHideRightViewControllerInSlideViewController:(nonnull GLBSlideViewController*)slideViewController duration:(NSTimeInterval)duration;
- (void)didHideRightViewControllerInSlideViewController:(nonnull GLBSlideViewController*)slideViewController;

@optional
- (BOOL)canShowViewControllerInSlideViewController:(nonnull GLBSlideViewController*)slideViewController;
- (void)willShowViewControllerInSlideViewController:(nonnull GLBSlideViewController*)slideViewController duration:(NSTimeInterval)duration;
- (void)didShowViewControllerInSlideViewController:(nonnull GLBSlideViewController*)slideViewController;
- (void)willHideViewControllerInSlideViewController:(nonnull GLBSlideViewController*)slideViewController duration:(NSTimeInterval)duration;
- (void)didHideViewControllerInSlideViewController:(nonnull GLBSlideViewController*)slideViewController;

@optional
- (void)willBeganLeftSwipeInSlideViewController:(nonnull GLBSlideViewController*)slideViewController;
- (void)didBeganLeftSwipeInSlideViewController:(nonnull GLBSlideViewController*)slideViewController;
- (void)movingLeftSwipeInSlideViewController:(nonnull GLBSlideViewController*)slideViewController progress:(CGFloat)progress;
- (void)willEndedLeftSwipeInSlideViewController:(nonnull GLBSlideViewController*)slideViewController;
- (void)didEndedLeftSwipeInSlideViewController:(nonnull GLBSlideViewController*)slideViewController;

@optional
- (void)willBeganRightSwipeInSlideViewController:(nonnull GLBSlideViewController*)slideViewController;
- (void)didBeganRightSwipeInSlideViewController:(nonnull GLBSlideViewController*)slideViewController;
- (void)movingRightSwipeInSlideViewController:(nonnull GLBSlideViewController*)slideViewController progress:(CGFloat)progress;
- (void)willEndedRightSwipeInSlideViewController:(nonnull GLBSlideViewController*)slideViewController;
- (void)didEndedRightSwipeInSlideViewController:(nonnull GLBSlideViewController*)slideViewController;

@optional
- (void)willBeganSwipeInSlideViewController:(nonnull GLBSlideViewController*)slideViewController;
- (void)didBeganSwipeInSlideViewController:(nonnull GLBSlideViewController*)slideViewController;
- (void)movingSwipeInSlideViewController:(nonnull GLBSlideViewController*)slideViewController progress:(CGFloat)progress;
- (void)willEndedSwipeInSlideViewController:(nonnull GLBSlideViewController*)slideViewController;
- (void)didEndedSwipeInSlideViewController:(nonnull GLBSlideViewController*)slideViewController;

@end

/*--------------------------------------------------*/

@interface UIViewController (GLBSlideViewController)

@property(nonatomic, nullable, weak) GLBSlideViewController* glb_slideViewController;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
