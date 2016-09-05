/*--------------------------------------------------*/

#import "GLBWordPressSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBWordPressSpinnerView

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime();
    
    CALayer* spinner = [CALayer layer];
    spinner.frame = CGRectMake(0, 0, self.size, self.size);
    spinner.anchorPoint = CGPointMake(0.5, 0.5);
    spinner.transform = CATransform3DIdentity;
    spinner.backgroundColor = self.color.CGColor;
    spinner.rasterizationScale = UIScreen.mainScreen.scale;
    spinner.shouldRasterize = YES;
    [self.layer addSublayer:spinner];

    CAKeyframeAnimation* spinnerAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    spinnerAnimation.removedOnCompletion = NO;
    spinnerAnimation.repeatCount = HUGE_VALF;
    spinnerAnimation.duration = 1;
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
    [spinner addAnimation:spinnerAnimation forKey:@"spinner-animation"];

    CAShapeLayer* circleMask = [CAShapeLayer layer];
    circleMask.frame = spinner.bounds;
    circleMask.fillColor = UIColor.blackColor.CGColor;
    circleMask.anchorPoint = CGPointMake(0.5, 0.5);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, nil, spinner.frame);

    CGFloat circleSize = (CGFloat)(self.size * 0.25);
    CGPathAddEllipseInRect(path, nil, CGRectMake(CGRectGetMidX(spinner.frame) - (circleSize / 2), 3, circleSize, circleSize));
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
