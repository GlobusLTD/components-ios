/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import <UIKit/UIKit.h>

/*--------------------------------------------------*/

@class GLBTransitionController;

/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBTransitionOperation) {
    GLBTransitionOperationPresent,
    GLBTransitionOperationDismiss,
    GLBTransitionOperationPush,
    GLBTransitionOperationPop
};

/*--------------------------------------------------*/

@interface GLBTransitionController : NSObject < UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning >

@property(nonatomic, readonly, weak) id< UIViewControllerContextTransitioning > transitionContext;
@property(nonatomic) GLBTransitionOperation operation;
@property(nonatomic) NSTimeInterval duration;
@property(nonatomic, readonly, assign) CGFloat percentComplete;
@property(nonatomic, readonly, assign) CGFloat completionSpeed;
@property(nonatomic, readonly, assign) UIViewAnimationCurve completionCurve;
@property(nonatomic, readonly, assign, getter=isInteractive) BOOL interactive;

- (void)setup NS_REQUIRES_SUPER;

- (BOOL)isAnimated;
- (BOOL)isCancelled;

- (void)beginInteractive;
- (void)updateInteractive:(CGFloat)percentComplete;
- (void)finishInteractive;
- (void)cancelInteractive;
- (void)endInteractive;

@end

/*--------------------------------------------------*/

@interface GLBTransitionControllerCrossFade : GLBTransitionController

@end

/*--------------------------------------------------*/

@interface GLBTransitionControllerCards : GLBTransitionController

@end

/*--------------------------------------------------*/

@interface GLBTransitionControllerSlide : GLBTransitionController

@property(nonatomic) CGFloat ratio;

- (instancetype)initWithRatio:(CGFloat)ratio;

@end

/*--------------------------------------------------*/

@interface GLBTransitionControllerMaterial : GLBTransitionController

@property(nonatomic, weak) UIView* sourceView;
@property(nonatomic) CGRect sourceFrame;

@property(nonatomic, strong) UIColor* backgroundColor;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
