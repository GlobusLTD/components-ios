/*--------------------------------------------------*/

#import "GLBMaterialTransitionController.h"
#import "GLBTransitionController+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBMaterialTransitionController ()
@end

/*--------------------------------------------------*/

@implementation GLBMaterialTransitionController

#pragma mark - Init / Free

- (void)setup {
    [super setup];
    
    _backgroundColor = UIColor.whiteColor;
}

#pragma mark - Transition

- (void)_startTransition {
    CGRect containerFrame = self.containerView.bounds;
    if(_sourceView != nil) {
        _sourceFrame = [_sourceView.superview convertRect:_sourceView.frame toView:nil];
    } else {
        CGFloat defaultSize = MIN(containerFrame.size.width, containerFrame.size.height) * 0.1f;
        _sourceFrame = CGRectMake(
            (containerFrame.origin.x + (containerFrame.size.width * 0.5f)) + (defaultSize * 0.5f),
            (containerFrame.origin.y + (containerFrame.size.height * 0.5f)) + (defaultSize * 0.5f),
            defaultSize,
            defaultSize
        );
    }
    self.toView.frame = containerFrame;
    self.fromView.frame = containerFrame;
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
    CGRect startFrame = [self.containerView.superview convertRect:_sourceFrame toView:self.containerView];
    
    UIView* animatedView = [[UIView alloc] initWithFrame:startFrame];
    animatedView.glb_cornerRadius = startFrame.size.height * 0.5f;
    animatedView.backgroundColor = _backgroundColor;
    animatedView.clipsToBounds = YES;
    [self.containerView addSubview:animatedView];
    
    [self.containerView bringSubviewToFront:self.toView];
    self.toView.layer.opacity = 0;
    
    CGFloat size = (CGFloat)(MAX(CGRectGetHeight(self.containerView.frame), CGRectGetWidth(self.containerView.frame)) * 1.2);
    CGFloat scaleFactor = size / CGRectGetWidth(animatedView.frame);
    CGAffineTransform transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
    [UIView transitionWithView:animatedView duration:self.duration * 0.7 options:0 animations:^{
        animatedView.transform = transform;
        animatedView.center = self.containerView.center;
        animatedView.backgroundColor = self.toView.backgroundColor;
    } completion:nil];
    [UIView animateWithDuration:self.duration * 0.42 delay:self.duration * 0.58 options:0 animations:^{
        self.toView.layer.opacity = 1;
    } completion:^(BOOL finished) {
        [animatedView removeFromSuperview];
        [self _completeTransition];
    }];
}

- (void)_startTransitionReverse {
    CGRect startFrame = [self.containerView.superview convertRect:_sourceFrame toView:self.containerView];
    
    UIView* animatedView = [[UIView alloc] initWithFrame:startFrame];
    animatedView.glb_cornerRadius = startFrame.size.height / 2;
    animatedView.backgroundColor = _backgroundColor;
    animatedView.clipsToBounds = YES;
    [self.containerView addSubview:animatedView];
    
    [self.containerView bringSubviewToFront:self.fromView];
    
    CGFloat size = (CGFloat)(MAX(CGRectGetHeight(self.containerView.frame), CGRectGetWidth(self.containerView.frame)) * 1.2);
    CGFloat scaleFactor = size / CGRectGetWidth(animatedView.frame);
    CGAffineTransform transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
    
    animatedView.transform = transform;
    animatedView.center = self.containerView.center;
    animatedView.backgroundColor = self.fromView.backgroundColor;
    
    [UIView animateWithDuration:self.duration * 0.7 animations:^{
        self.fromView.layer.opacity = 0;
    } completion:^(BOOL finished) {
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC * self.duration * 0.32)), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:animatedView duration:self.duration * 0.58 options:0 animations:^{
            animatedView.transform = CGAffineTransformIdentity;
            animatedView.backgroundColor = _backgroundColor;
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
