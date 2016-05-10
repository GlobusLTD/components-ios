/*--------------------------------------------------*/

#import "GLBSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBSpinnerViewPulse

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime();
    
    CALayer* circle = [CALayer layer];
    circle.frame = CGRectInset(CGRectMake(0.0f, 0.0f, self.size, self.size), 2.0f, 2.0f);
    circle.backgroundColor = self.color.CGColor;
    circle.anchorPoint = CGPointMake(0.5f, 0.5f);
    circle.opacity = 1.0f;
    circle.cornerRadius = CGRectGetHeight(circle.bounds) * 0.5f;
    circle.transform = CATransform3DMakeScale(0.0f, 0.0f, 0.0f);
    [self.layer addSublayer:circle];

    CAKeyframeAnimation* scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.values = @[
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0f, 0.0f, 0.0f)],
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 0.0f)]
    ];
    CAKeyframeAnimation* opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.values = @[
        @(1.0f),
        @(0.0f)
    ];
    
    CAAnimationGroup* groupAnimation = [CAAnimationGroup animation];
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.beginTime = beginTime;
    groupAnimation.repeatCount = HUGE_VALF;
    groupAnimation.duration = 1.0f;
    groupAnimation.animations = @[ scaleAnimation, opacityAnimation ];
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [circle addAnimation:groupAnimation forKey:@"circle"];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
