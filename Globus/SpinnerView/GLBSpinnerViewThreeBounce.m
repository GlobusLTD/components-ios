/*--------------------------------------------------*/

#import "GLBSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBSpinnerViewThreeBounce

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime();
    CGFloat offset = self.size / 8.0f;
    CGFloat circleSize = offset * 2.0f;
    CGFloat circleSize2 = circleSize * 0.5f;
    for (NSInteger i=0; i < 3; i+=1) {
        CALayer* circle = [CALayer layer];
        circle.frame = CGRectMake(i * 3.0f * offset, (self.size * 0.5f) - circleSize2, circleSize, circleSize);
        circle.backgroundColor = self.color.CGColor;
        circle.anchorPoint = CGPointMake(0.5f, 0.5f);
        circle.cornerRadius = circleSize * 0.5f;
        circle.transform = CATransform3DMakeScale(0.0f, 0.0f, 0.0f);
        [self.layer addSublayer:circle];
        
        CAKeyframeAnimation* circleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        circleAnimation.removedOnCompletion = NO;
        circleAnimation.repeatCount = HUGE_VALF;
        circleAnimation.duration = 1.5f;
        circleAnimation.beginTime = beginTime + (0.25f * i);
        circleAnimation.keyTimes = @[ @(0.0f), @(0.5f), @(1.0f) ];
        circleAnimation.timingFunctions = @[
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
        ];
        circleAnimation.values = @[
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0f, 0.0f, 0.0f)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 0.0f)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0f, 0.0f, 0.0f)]
        ];
        [circle addAnimation:circleAnimation forKey:@"circle"];
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
