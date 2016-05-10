/*--------------------------------------------------*/

#import "GLBTransitionController+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/

@interface GLBTransitionControllerMaterial ()
@end

/*--------------------------------------------------*/

@implementation GLBTransitionControllerMaterial

#pragma mark - Transition

- (void)_startTransition {
    if(self.sourceView != nil) {
        self.sourceFrame = [_sourceView.superview convertRect:self.sourceView.frame toView:nil];
    }
    self.toView.frame = self.containerView.bounds;
    self.fromView.frame = self.containerView.bounds;
    [self.containerView addSubview:self.toView];
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
    CGRect startFrame = [self.containerView.superview convertRect:self.sourceFrame toView:self.containerView];
    
    UIView* animatedView = [[UIView alloc] initWithFrame:startFrame];
    animatedView.glb_cornerRadius = startFrame.size.height * 0.5f;
    animatedView.backgroundColor = self.backgroundColor;
    animatedView.clipsToBounds = YES;
    [self.containerView addSubview:animatedView];
    
    [self.containerView bringSubviewToFront:self.toView];
    self.toView.layer.opacity = 0.0f;
    
    CGFloat size = MAX(CGRectGetHeight(self.containerView.frame), CGRectGetWidth(self.containerView.frame)) * 1.2f;
    CGFloat scaleFactor = size / CGRectGetWidth(animatedView.frame);
    CGAffineTransform transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
    [UIView transitionWithView:animatedView duration:self.duration * 0.7f options:0 animations:^{
        animatedView.transform = transform;
        animatedView.center = self.containerView.center;
        animatedView.backgroundColor = self.toView.backgroundColor;
    } completion:nil];
    [UIView animateWithDuration:self.duration * 0.42f delay:self.duration * 0.58f options:0 animations:^{
        self.toView.layer.opacity = 1.0f;
    } completion:^(BOOL finished) {
        [animatedView removeFromSuperview];
        [self _completeTransition];
    }];}

- (void)_startTransitionReverse {
    CGRect startFrame = [self.containerView.superview convertRect:self.sourceFrame toView:self.containerView];
    
    UIView* animatedView = [[UIView alloc] initWithFrame:startFrame];
    animatedView.glb_cornerRadius = startFrame.size.height * 0.5f;
    animatedView.backgroundColor = self.backgroundColor;
    animatedView.clipsToBounds = YES;
    [self.containerView addSubview:animatedView];
    
    [self.containerView bringSubviewToFront:self.fromView];
    
    CGFloat size = MAX(CGRectGetHeight(self.containerView.frame), CGRectGetWidth(self.containerView.frame)) * 1.2f;
    CGFloat scaleFactor = size / CGRectGetWidth(animatedView.frame);
    CGAffineTransform transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
    
    animatedView.transform = transform;
    animatedView.center = self.containerView.center;
    animatedView.backgroundColor = self.fromView.backgroundColor;
    
    [UIView animateWithDuration:self.duration * 0.7f animations:^{
        self.fromView.layer.opacity = 0.0f;
    } completion:^(BOOL finished) {
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * self.duration * 0.32f), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:animatedView duration:self.duration * 0.58f options:0 animations:^{
            animatedView.transform = CGAffineTransformIdentity;
            animatedView.backgroundColor = self.backgroundColor;
            animatedView.frame = startFrame;
        } completion:^(BOOL finished) {
            [animatedView removeFromSuperview];
            [self _completeTransition];
        }];
    });

}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
