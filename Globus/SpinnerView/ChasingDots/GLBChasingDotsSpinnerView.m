/*--------------------------------------------------*/

#import "GLBChasingDotsSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBChasingDotsSpinnerView

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime();

    CALayer* spinner = [CALayer layer];
    spinner.frame = CGRectMake(0, 0, self.size, self.size);
    spinner.anchorPoint = CGPointMake(0.5, 0.5);
    spinner.transform = CATransform3DIdentity;
    spinner.shouldRasterize = YES;
    spinner.rasterizationScale = UIScreen.mainScreen.scale;
    [self.layer addSublayer:spinner];

    CAKeyframeAnimation* spinnerAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    spinnerAnimation.removedOnCompletion = NO;
    spinnerAnimation.repeatCount = HUGE_VALF;
    spinnerAnimation.duration = 2;
    spinnerAnimation.beginTime = beginTime;
    spinnerAnimation.keyTimes = @[
        @(0), @(0.25), @(0.5), @(0.75), @(1)
    ];
    spinnerAnimation.timingFunctions = @[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]
    ];
    spinnerAnimation.values = @[
       [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 1)],
       [NSValue valueWithCATransform3D:CATransform3DMakeRotation((CGFloat)(M_PI_2), 0, 0, 1)],
       [NSValue valueWithCATransform3D:CATransform3DMakeRotation((CGFloat)(M_PI), 0, 0, 1)],
       [NSValue valueWithCATransform3D:CATransform3DMakeRotation((CGFloat)(3 * M_PI_2), 0, 0, 1)],
       [NSValue valueWithCATransform3D:CATransform3DMakeRotation((CGFloat)(2 * M_PI), 0, 0, 1)]
    ];
    [spinner addAnimation:spinnerAnimation forKey:@"spinner"];
    
    for(NSInteger i = 0; i < 2; i++) {
        CGFloat offset = (CGFloat)(self.size * 0.3 * i);
        
        CALayer* circle = [CALayer layer];
        circle.frame = CGRectOffset(CGRectApplyAffineTransform(CGRectMake(0, 0, self.size, self.size), CGAffineTransformMakeScale(0.6f, 0.6f)), offset, offset);
        circle.backgroundColor = self.color.CGColor;
        circle.anchorPoint = CGPointMake(0.5, 0.5);
        circle.cornerRadius = CGRectGetHeight(circle.bounds) * (CGFloat)0.5;
        circle.transform = CATransform3DMakeScale(0, 0, 0);
        [spinner addSublayer:circle];
        
        CAKeyframeAnimation* circleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        circleAnimation.removedOnCompletion = NO;
        circleAnimation.repeatCount = HUGE_VALF;
        circleAnimation.duration = 2;
        circleAnimation.beginTime = beginTime - (1 * i);
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

