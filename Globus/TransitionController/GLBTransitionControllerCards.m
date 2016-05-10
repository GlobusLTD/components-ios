/*--------------------------------------------------*/

#import "GLBTransitionController+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBTransitionControllerCards ()

- (void)_startTransitionForward;
- (void)_startTransitionReverse;
- (CATransform3D)_firstTransform;
- (CATransform3D)_secondTransformWithView:(UIView*)view;

@end

/*--------------------------------------------------*/

@implementation GLBTransitionControllerCards

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
                                   delay:0.0f
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.4f animations:^{
                                      self.fromView.layer.transform = t1;
                                      self.fromView.alpha = 0.6f;
                                  }];
                                  [UIView addKeyframeWithRelativeStartTime:0.2f relativeDuration:0.4f animations:^{
                                      self.fromView.layer.transform = t2;
                                  }];
                                  [UIView addKeyframeWithRelativeStartTime:0.6f relativeDuration:0.2f animations:^{
                                      self.toView.frame = CGRectOffset(self.toView.frame, 0.0f, -30.0f);
                                  }];
                                  [UIView addKeyframeWithRelativeStartTime:0.8f relativeDuration:0.2f animations:^{
                                      self.toView.frame = frame;
                                  }];
                              } completion:^(BOOL finished) {
                                  [self _completeTransition];
                              }];
}

- (void)_startTransitionReverse {
    CGRect frame = self.initialFrameFromViewController;
    self.toView.frame = frame;
    self.toView.layer.transform = CATransform3DScale(CATransform3DIdentity, 0.6f, 0.6f, 1.0f);
    self.toView.alpha = 0.6f;
    [self.containerView insertSubview:self.toView belowSubview:self.fromView];
    CGRect frameOffScreen = frame;
    frameOffScreen.origin.y = frame.size.height;
    CATransform3D t1 = [self _firstTransform];
    [UIView animateKeyframesWithDuration:self.duration
                                   delay:0.0f
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.5f animations:^{
                                      self.fromView.frame = frameOffScreen;
                                  }];
                                  [UIView addKeyframeWithRelativeStartTime:0.35f relativeDuration:0.35f animations:^{
                                      self.toView.layer.transform = t1;
                                      self.toView.alpha = 1.0f;
                                  }];
                                  [UIView addKeyframeWithRelativeStartTime:0.75f relativeDuration:0.25f animations:^{
                                      self.toView.layer.transform = CATransform3DIdentity;
                                  }];
                              } completion:^(BOOL finished) {
                                  if(self.isCancelled == YES) {
                                      self.toView.layer.transform = CATransform3DIdentity;
                                      self.toView.alpha = 1.0f;
                                  }
                                  [self _completeTransition];
                              }];
}

- (CATransform3D)_firstTransform {
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0f / -900.0f;
    t1 = CATransform3DScale(t1, 0.95f, 0.95f, 1.0f);
    t1 = CATransform3DRotate(t1, (15.0f * M_PI) / 180.0f, 1.0f, 0.0f, 0.0f);
    return t1;
}

- (CATransform3D)_secondTransformWithView:(UIView*)view {
    CATransform3D t1 = [self _firstTransform];
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = t1.m34;
    t2 = CATransform3DTranslate(t2, 0.0f, view.frame.size.height * -0.08f, 0.0f);
    t2 = CATransform3DScale(t2, 0.8f, 0.8f, 1.0f);
    return t2;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
