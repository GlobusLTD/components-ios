/*--------------------------------------------------*/

#import "GLBSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBSpinnerViewWordPress

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime();
    
    CALayer* spinner = [CALayer layer];
    spinner.frame = CGRectMake(0.0f, 0.0f, self.size, self.size);
    spinner.anchorPoint = CGPointMake(0.5f, 0.5f);
    spinner.transform = CATransform3DIdentity;
    spinner.backgroundColor = self.color.CGColor;
    spinner.rasterizationScale = UIScreen.mainScreen.scale;
    spinner.shouldRasterize = YES;
    [self.layer addSublayer:spinner];

    CAKeyframeAnimation* spinnerAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    spinnerAnimation.removedOnCompletion = NO;
    spinnerAnimation.repeatCount = HUGE_VALF;
    spinnerAnimation.duration = 1.0f;
    spinnerAnimation.beginTime = beginTime;
    spinnerAnimation.keyTimes = @[ @(0.0f), @(0.25f), @(0.5f), @(0.75f), @(1.0f) ];
    spinnerAnimation.timingFunctions = @[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]
    ];
    spinnerAnimation.values = @[
        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.0f, 0.0f, 0.0f, 1.0f)],
        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0f, 0.0f, 1.0f)],
        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f)],
        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(3.0f * M_PI_2, 0.0f, 0.0f, 1.0f)],
        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(2.0f * M_PI, 0.0f, 0.0f, 1.0f)]
    ];
    [spinner addAnimation:spinnerAnimation forKey:@"spinner-animation"];

    CAShapeLayer* circleMask = [CAShapeLayer layer];
    circleMask.frame = spinner.bounds;
    circleMask.fillColor = UIColor.blackColor.CGColor;
    circleMask.anchorPoint = CGPointMake(0.5f, 0.5f);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, nil, spinner.frame);

    CGFloat circleSize = self.size * 0.25f;
    CGPathAddEllipseInRect(path, nil, CGRectMake(CGRectGetMidX(spinner.frame) - circleSize * 0.5f, 3.0f, circleSize, circleSize));
    CGPathCloseSubpath(path);
    circleMask.path = path;
    circleMask.fillRule = kCAFillRuleEvenOdd;
    CGPathRelease(path);

    spinner.mask = circleMask;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
