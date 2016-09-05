/*--------------------------------------------------*/

#import "GLBWaveSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBWaveSpinnerView

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime() + 1.2;
    CGFloat barWidth = (CGFloat)(self.size / 5);
    for(NSInteger i = 0; i < 5; i++) {
        CALayer* bar = [CALayer layer];
        bar.backgroundColor = self.color.CGColor;
        bar.frame = CGRectMake(barWidth * i, 0, barWidth - 3, self.size);
        bar.transform = CATransform3DMakeScale(1, (CGFloat)(0.3), 0);
        [self.layer addSublayer:bar];

        CAKeyframeAnimation* barAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        barAnimation.removedOnCompletion = NO;
        barAnimation.beginTime = beginTime - (1.2 - (0.1 * i));
        barAnimation.duration = 1.2;
        barAnimation.repeatCount = HUGE_VALF;
        barAnimation.keyTimes = @[
            @(0), @(0.2), @(0.4), @(1)
        ];
        barAnimation.timingFunctions = @[
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
        ];
        barAnimation.values = @[
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, (CGFloat)(0.4), 0)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 0)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, (CGFloat)(0.4), 0)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, (CGFloat)(0.4), 0)]
        ];

        [bar addAnimation:barAnimation forKey:@"bar"];
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
