/*--------------------------------------------------*/

#import "GLBThreeBounceSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBThreeBounceSpinnerView

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime();
    CGFloat offset = (CGFloat)(self.size / 8);
    CGFloat circleSize = offset * 2;
    CGFloat circleSize2 = circleSize / 2;
    for (NSInteger i = 0; i < 3; i += 1) {
        CALayer* circle = [CALayer layer];
        circle.frame = CGRectMake(i * 3 * offset, (self.size / 2) - circleSize2, circleSize, circleSize);
        circle.backgroundColor = self.color.CGColor;
        circle.anchorPoint = CGPointMake(0.5, 0.5);
        circle.cornerRadius = circleSize / 2;
        circle.transform = CATransform3DMakeScale(0, 0, 0);
        [self.layer addSublayer:circle];
        
        CAKeyframeAnimation* circleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        circleAnimation.removedOnCompletion = NO;
        circleAnimation.repeatCount = HUGE_VALF;
        circleAnimation.duration = 1.5;
        circleAnimation.beginTime = beginTime + (0.25 * i);
        circleAnimation.keyTimes = @[
            @(0), @(0.5), @(1)
        ];
        circleAnimation.timingFunctions = @[
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
        ];
        circleAnimation.values = @[
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 0)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 0)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 0)]
        ];
        [circle addAnimation:circleAnimation forKey:@"circle"];
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
