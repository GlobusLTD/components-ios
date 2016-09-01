/*--------------------------------------------------*/

#import "GLBSlideTransitionController.h"
#import "GLBTransitionController+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBSlideTransitionController

#pragma mark - Init / Free

- (instancetype)initWithRatio:(CGFloat)ratio {
    self = [super init];
    if(self != nil) {
        _ratio = MAX(0, MIN(ratio, 1));
    }
    return self;
}

- (void)setup {
    [super setup];
    
    _ratio = 1;
}

#pragma mark - Private override

- (void)_prepareTransitionContext {
    [super _prepareTransitionContext];
    
    CGRect containerFrame = self.containerView.frame;
    switch(self.operation) {
        case GLBTransitionOperationPresent:
        case GLBTransitionOperationPush: {
            if(CGRectIsEmpty(self.initialFrameFromViewController) == YES) {
                self.initialFrameFromViewController = containerFrame;
            }
            if(CGRectIsEmpty(self.finalFrameFromViewController) == YES) {
                if(CGRectIsEmpty(self.finalFrameToViewController) == NO) {
                    self.finalFrameFromViewController = CGRectMake(self.initialFrameFromViewController.origin.x - self.initialFrameFromViewController.size.width, self.initialFrameFromViewController.origin.y, self.initialFrameFromViewController.size.width, self.initialFrameFromViewController.size.height);
                } else {
                    self.finalFrameFromViewController = CGRectMake(containerFrame.origin.x - containerFrame.size.width, containerFrame.origin.y, containerFrame.size.width, containerFrame.size.height);
                }
            }
            if(CGRectIsEmpty(self.initialFrameToViewController) == YES) {
                if(CGRectIsEmpty(self.finalFrameToViewController) == NO) {
                    self.initialFrameToViewController = CGRectMake(self.finalFrameToViewController.origin.x + (self.finalFrameToViewController.size.width * self.ratio), self.finalFrameToViewController.origin.y, self.finalFrameToViewController.size.width, self.finalFrameToViewController.size.height);
                } else {
                    self.initialFrameToViewController = CGRectMake(containerFrame.origin.x + (containerFrame.size.width * self.ratio), containerFrame.origin.y, containerFrame.size.width, containerFrame.size.height);
                }
            }
            if(CGRectIsEmpty(self.finalFrameToViewController) == YES) {
                self.finalFrameToViewController = containerFrame;
            }
            break;
        }
        case GLBTransitionOperationDismiss:
        case GLBTransitionOperationPop: {
            if(CGRectIsEmpty(self.initialFrameFromViewController) == YES) {
                self.initialFrameFromViewController = containerFrame;
            }
            if(CGRectIsEmpty(self.finalFrameFromViewController) == YES) {
                if(CGRectIsEmpty(self.finalFrameToViewController) == NO) {
                    self.finalFrameFromViewController = CGRectMake(self.initialFrameFromViewController.origin.x + self.initialFrameFromViewController.size.width, self.initialFrameFromViewController.origin.y, self.initialFrameFromViewController.size.width, self.initialFrameFromViewController.size.height);
                } else {
                    self.finalFrameFromViewController = CGRectMake(containerFrame.origin.x + containerFrame.size.width, containerFrame.origin.y, containerFrame.size.width, containerFrame.size.height);
                }
            }
            if(CGRectIsEmpty(self.initialFrameToViewController) == YES) {
                if(CGRectIsEmpty(self.finalFrameToViewController) == NO) {
                    self.initialFrameToViewController = CGRectMake(self.finalFrameToViewController.origin.x - (self.finalFrameToViewController.size.width * self.ratio), self.finalFrameToViewController.origin.y, self.finalFrameToViewController.size.width, self.finalFrameToViewController.size.height);
                } else {
                    self.initialFrameToViewController = CGRectMake(containerFrame.origin.x - (containerFrame.size.width * self.ratio), containerFrame.origin.y, containerFrame.size.width, containerFrame.size.height);
                }
            }
            if(CGRectIsEmpty(self.finalFrameToViewController) == YES) {
                self.finalFrameToViewController = containerFrame;
            }
            break;
        }
    }
}

#pragma mark - Transition

- (void)_startTransition {
    self.fromView.frame = self.initialFrameFromViewController;
    self.toView.frame = self.initialFrameToViewController;
    
    [self.containerView addSubview:self.toView];
    [self.containerView sendSubviewToBack:self.toView];
    
    [UIView animateWithDuration:self.duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.fromView.frame = self.finalFrameFromViewController;
                         self.toView.frame = self.finalFrameToViewController;
                     } completion:^(BOOL finished) {
                         if([self isCancelled] == YES) {
                             self.fromView.frame = self.initialFrameFromViewController;
                             self.toView.frame = self.initialFrameToViewController;
                         } else {
                             self.fromView.frame = self.finalFrameFromViewController;
                             self.toView.frame = self.finalFrameToViewController;
                             [self.fromView removeFromSuperview];
                         }
                         [self _completeTransition];
                     }];
}

#pragma mark - Interactive

- (void)_startInteractive {
    [super _startInteractive];
    
    self.fromView.frame = self.initialFrameFromViewController;
    self.toView.frame = self.initialFrameToViewController;
    
    [self.containerView addSubview:self.toView];
    [self.containerView sendSubviewToBack:self.toView];
}

- (void)_updateInteractive:(CGFloat)percentComplete {
    [super _updateInteractive:percentComplete];
    
    self.fromView.frame = GLBRectLerp(self.initialFrameFromViewController, self.finalFrameFromViewController, percentComplete);
    self.toView.frame = GLBRectLerp(self.initialFrameToViewController, self.finalFrameToViewController, percentComplete);
}

- (void)_finishInteractive {
    [super _finishInteractive];
    
    [UIView animateWithDuration:self.duration * self.percentComplete
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.fromView.frame = self.finalFrameFromViewController;
                         self.toView.frame = self.finalFrameToViewController;
                     } completion:^(BOOL finished) {
                         self.fromView.frame = self.finalFrameFromViewController;
                         self.toView.frame = self.finalFrameToViewController;
                         [self.fromView removeFromSuperview];
                         [self _completeInteractive];
                     }];
}

- (void)_cancelInteractive {
    [super _cancelInteractive];
    
    [UIView animateWithDuration:self.duration * (1 - self.percentComplete)
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.fromView.frame = self.initialFrameFromViewController;
                         self.toView.frame = self.initialFrameToViewController;
                     } completion:^(BOOL finished) {
                         self.fromView.frame = self.initialFrameFromViewController;
                         self.toView.frame = self.initialFrameToViewController;
                         [self.toView removeFromSuperview];
                         [self _completeInteractive];
                     }];
}

@end

/*--------------------------------------------------*/
/* Legacy                                           */
/*--------------------------------------------------*/

@implementation GLBTransitionControllerSlide
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
