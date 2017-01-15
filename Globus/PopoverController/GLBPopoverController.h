/*--------------------------------------------------*/

#include "GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBPopoverController : NSObject

@property(nonatomic, nonnull, readonly, strong) UIViewController* viewController;

+ (instancetype _Nonnull)presentViewController:(UIViewController* _Nonnull)viewController
                                      fromView:(UIView* _Nonnull)view
                               arrowTargetView:(UIView* _Nonnull)arrowTargetView
                                arrowDirection:(UIPopoverArrowDirection)arrowDirection
                                      animated:(BOOL)animated NS_SWIFT_UNAVAILABLE("Use init(viewController:fromView:arrowTargetView:arrowDirection:animated:)");

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithViewController:(UIViewController* _Nonnull)viewController
                                       fromView:(UIView* _Nonnull)view
                                arrowTargetView:(UIView* _Nonnull)arrowTargetView
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
