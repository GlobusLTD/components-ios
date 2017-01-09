/*--------------------------------------------------*/

#include "GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBPopoverController : NSObject

@property(nonatomic, nonnull, readonly, strong) UIViewController* controller;

+ (instancetype _Nullable)presentController:(UIViewController* _Nonnull)controller
                                   fromView:(UIView* _Nonnull)view
                            arrowTargetView:(UIView* _Nonnull)arrowTargetView
                             arrowDirection:(UIPopoverArrowDirection)arrowDirection
                                   animated:(BOOL)animated NS_SWIFT_NAME(present(controller:fromView:arrowTargetView:arrowDirection:animated:));

- (instancetype _Nullable)initWithController:(UIViewController* _Nonnull)controller
                                    fromView:(UIView* _Nonnull)view
                             arrowTargetView:(UIView* _Nonnull)arrowTargetView
                              arrowDirection:(UIPopoverArrowDirection)arrowDirection;

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
