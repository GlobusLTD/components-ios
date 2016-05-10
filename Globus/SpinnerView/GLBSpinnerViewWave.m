/*--------------------------------------------------*/

#import "GLBSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBSpinnerViewWave

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime() + 1.2f;
    CGFloat barWidth = self.size / 5.0f;
    for(NSInteger i = 0; i < 5; i++) {
        CALayer* bar = [CALayer layer];
        bar.backgroundColor = self.color.CGColor;
        bar.frame = CGRectMake(barWidth * i, 0.0f, barWidth - 3.0f, self.size);
        bar.transform = CATransform3DMakeScale(1.0f, 0.3f, 0.0f);
        [self.layer addSublayer:bar];

        CAKeyframeAnimation* barAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        barAnimation.removedOnCompletion = NO;
        barAnimation.beginTime = beginTime - (1.2f - (0.1f * i));
        barAnimation.duration = 1.2f;
        barAnimation.repeatCount = HUGE_VALF;
        barAnimation.keyTimes = @[ @(0.0f), @(0.2f), @(0.4f), @(1.0f) ];
        barAnimation.timingFunctions = @[
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
        ];
        barAnimation.values = @[
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 0.4f, 0.0f)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 0.0f)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 0.4f, 0.0f)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 0.4f, 0.0f)]
        ];

        [bar addAnimation:barAnimation forKey:@"bar"];
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
