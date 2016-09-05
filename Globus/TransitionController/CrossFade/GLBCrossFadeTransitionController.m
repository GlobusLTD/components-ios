/*--------------------------------------------------*/

#import "GLBCrossFadeTransitionController.h"
#import "GLBTransitionController+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBCrossFadeTransitionController

#pragma mark - Transition

- (void)_startTransition {
    self.fromView.frame = self.initialFrameFromViewController;
    if(self.fromView.superview == nil) {
        [self.containerView addSubview:self.fromView];
    }
    self.toView.frame = self.finalFrameToViewController;
    if(self.toView.superview == nil) {
        [self.containerView addSubview:self.toView];
    }
    [self.containerView sendSubviewToBack:self.toView];
    
    [UIView animateWithDuration:self.duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.fromView.alpha = 0;
                     } completion:^(BOOL finished) {
                         if([self isCancelled] == YES) {
                             self.fromView.alpha = 1;
                         } else {
                             [self.fromView removeFromSuperview];
                             self.fromView.alpha = 1;
                         }
                         [self _completeTransition];
                     }];
}

#pragma mark - Interactive

- (void)_startInteractive {
    [super _startInteractive];
    
    self.fromView.frame = self.initialFrameFromViewController;
    if(self.fromView.superview == nil) {
        [self.containerView addSubview:self.fromView];
    }
    self.toView.frame = self.finalFrameToViewController;
    if(self.toView.superview == nil) {
        [self.containerView addSubview:self.toView];
    }
    [self.containerView sendSubviewToBack:self.toView];
}

- (void)_updateInteractive:(CGFloat)percentComplete {
    [super _updateInteractive:percentComplete];
    
    self.fromView.alpha = 1 - percentComplete;
}

- (void)_finishInteractive {
    [super _finishInteractive];
    
    [UIView animateWithDuration:self.duration * self.percentComplete
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.fromView.alpha = 0;
                         self.toView.alpha = 1;
                     } completion:^(BOOL finished) {
                         self.fromView.alpha = 1;
                         self.toView.alpha = 1;
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
                         self.fromView.alpha = 1;
                         self.toView.alpha = 0;
                     } completion:^(BOOL finished) {
                         self.fromView.alpha = 1;
                         self.toView.alpha = 1;
                         [self.toView removeFromSuperview];
                         [self _completeInteractive];
                     }];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
