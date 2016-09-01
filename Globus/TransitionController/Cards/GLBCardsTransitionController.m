/*--------------------------------------------------*/

#import "GLBCardsTransitionController.h"
#import "GLBTransitionController+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBCardsTransitionController ()

- (void)_startTransitionForward;
- (void)_startTransitionReverse;
- (CATransform3D)_firstTransform;
- (CATransform3D)_secondTransformWithView:(UIView*)view;

@end

/*--------------------------------------------------*/

@implementation GLBCardsTransitionController

#pragma mark - Transition

- (void)_startTransition {
    switch(self.operation) {
        case GLBTransitionOperationPresent:
        case GLBTransitionOperationPush:
            [self _startTransitionForward];
            break;
        case GLBTransitionOperationDismiss:
        case GLBTransitionOperationPop:
            [self _startTransitionReverse];
            break;
    }
}

#pragma mark - Private

- (void)_startTransitionForward {
    CGRect frame = self.initialFrameFromViewController;
    CGRect offScreenFrame = frame;
    offScreenFrame.origin.y = offScreenFrame.size.height;
    self.toView.frame = offScreenFrame;
    [self.containerView insertSubview:self.toView aboveSubview:self.fromView];
    CATransform3D t1 = [self _firstTransform];
    CATransform3D t2 = [self _secondTransformWithView:self.fromView];
    [UIView animateKeyframesWithDuration:self.duration
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.4 animations:^{
                                      self.fromView.layer.transform = t1;
                                      self.fromView.alpha = 0.6f;
                                  }];
                                  [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.4 animations:^{
                                      self.fromView.layer.transform = t2;
                                  }];
                                  [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.2 animations:^{
                                      self.toView.frame = CGRectOffset(self.toView.frame, 0, -30);
                                  }];
                                  [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
                                      self.toView.frame = frame;
                                  }];
                              } completion:^(BOOL finished) {
                                  [self _completeTransition];
                              }];
}

- (void)_startTransitionReverse {
    CGRect frame = self.initialFrameFromViewController;
    self.toView.frame = frame;
    self.toView.layer.transform = CATransform3DScale(CATransform3DIdentity, (CGFloat)(0.6), (CGFloat)(0.6), 1);
    self.toView.alpha = 0.6f;
    [self.containerView insertSubview:self.toView belowSubview:self.fromView];
    CGRect frameOffScreen = frame;
    frameOffScreen.origin.y = frame.size.height;
    CATransform3D t1 = [self _firstTransform];
    [UIView animateKeyframesWithDuration:self.duration
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
                                      self.fromView.frame = frameOffScreen;
                                  }];
                                  [UIView addKeyframeWithRelativeStartTime:0.35 relativeDuration:0.35 animations:^{
                                      self.toView.layer.transform = t1;
                                      self.toView.alpha = 1;
                                  }];
                                  [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
                                      self.toView.layer.transform = CATransform3DIdentity;
                                  }];
                              } completion:^(BOOL finished) {
                                  if(self.isCancelled == YES) {
                                      self.toView.layer.transform = CATransform3DIdentity;
                                      self.toView.alpha = 1;
                                  }
                                  [self _completeTransition];
                              }];
}

- (CATransform3D)_firstTransform {
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1 / -900;
    t1 = CATransform3DScale(t1, (CGFloat)(0.95), (CGFloat)(0.95), 1);
    t1 = CATransform3DRotate(t1, (CGFloat)((15 * M_PI) / 180), 1, 0, 0);
    return t1;
}

- (CATransform3D)_secondTransformWithView:(UIView*)view {
    CATransform3D t1 = [self _firstTransform];
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = t1.m34;
    t2 = CATransform3DTranslate(t2, 0, (CGFloat)(view.frame.size.height * -0.08), 0);
    t2 = CATransform3DScale(t2, (CGFloat)(0.8), (CGFloat)(0.8), 1);
    return t2;
}

@end

/*--------------------------------------------------*/
/* Legacy                                           */
/*--------------------------------------------------*/

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

@implementation GLBTransitionControllerCards
@end

#pragma clang diagnostic pop

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
