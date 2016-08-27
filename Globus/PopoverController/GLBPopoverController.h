/*--------------------------------------------------*/

#include "GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBPopoverController : NSObject

@property(nonatomic, readonly, strong) UIViewController* controller;

+ (instancetype)presentController:(UIViewController*)controller
                         fromView:(UIView*)view
                  arrowTargetView:(UIView*)arrowTargetView
                   arrowDirection:(UIPopoverArrowDirection)arrowDirection
                         animated:(BOOL)animated;

- (instancetype)initWithController:(UIViewController*)controller
                          fromView:(UIView*)view
                   arrowTargetView:(UIView*)arrowTargetView
                    arrowDirection:(UIPopoverArrowDirection)arrowDirection;

- (void)presentAnimated:(BOOL)animated;
- (void)dismissAnimated:(BOOL)animated;

@end

/*--------------------------------------------------*/

@interface UIViewController (GLBPopoverController)

@property(nonatomic, strong) GLBPopoverController* glb_popoverController;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
