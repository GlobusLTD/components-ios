/*--------------------------------------------------*/

#import "GLBPulseSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBPulseSpinnerView

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime();
    
    CALayer* circle = [CALayer layer];
    circle.frame = CGRectInset(CGRectMake(0, 0, self.size, self.size), 2, 2);
    circle.backgroundColor = self.color.CGColor;
    circle.anchorPoint = CGPointMake(0.5, 0.5);
    circle.opacity = 1;
    circle.cornerRadius = CGRectGetHeight(circle.bounds) / 2;
    circle.transform = CATransform3DMakeScale(0, 0, 0);
    [self.layer addSublayer:circle];

    CAKeyframeAnimation* scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.values = @[
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 0)],
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 0)]
    ];
    CAKeyframeAnimation* opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.values = @[
        @(1),
        @(0)
    ];
    
    CAAnimationGroup* groupAnimation = [CAAnimationGroup animation];
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.beginTime = beginTime;
    groupAnimation.repeatCount = HUGE_VALF;
    groupAnimation.duration = 1;
    groupAnimation.animations = @[ scaleAnimation, opacityAnimation ];
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [circle addAnimation:groupAnimation forKey:@"circle"];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
