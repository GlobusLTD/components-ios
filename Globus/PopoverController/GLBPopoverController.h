/*--------------------------------------------------*/

#include "GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBPopoverController : NSObject

@property(nonatomic, nonnull, readonly, strong) UIViewController* viewController;

+ (nonnull instancetype)presentViewController:(nonnull UIViewController*)viewController
                                      fromView:(nonnull UIView*)view
                               arrowTargetView:(nonnull UIView*)arrowTargetView
                                arrowDirection:(UIPopoverArrowDirection)arrowDirection
                                      animated:(BOOL)animated NS_SWIFT_UNAVAILABLE("Use init(viewController:fromView:arrowTargetView:arrowDirection:animated:)");

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithViewController:(nonnull UIViewController*)viewController
                                       fromView:(nonnull UIView*)view
                                arrowTargetView:(nonnull UIView*)arrowTargetView
                                 arrowDirection:(UIPopoverArrowDirection)arrowDirection NS_DESIGNATED_INITIALIZER;

- (void)presentAnimated:(BOOL)animated;
- (void)dismissAnimated:(BOOL)animated;

@end

/*--------------------------------------------------*/

@interface UIViewController (GLBPopoverController)

@property(nonatomic, nullable, strong) GLBPopoverController* glb_popoverController;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
