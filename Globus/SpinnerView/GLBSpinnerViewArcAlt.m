/*--------------------------------------------------*/

#import "GLBSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBSpinnerViewArcAlt

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime();
    CGRect frame  = CGRectInset(CGRectMake(0.0f, 0.0f, self.size, self.size), 2.0f, 2.0f);
    CGFloat radius = CGRectGetWidth(frame) / 2.0f;
    CGPoint center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    
    CALayer* arc = [CALayer layer];
    arc.frame = CGRectMake(0.0f, 0.0f, self.size, self.size);
    arc.backgroundColor = self.color.CGColor;
    arc.anchorPoint = CGPointMake(0.5f, 0.5f);
    arc.cornerRadius = self.size * 0.5f;
    [self.layer addSublayer:arc];

    CAShapeLayer* mask = [CAShapeLayer layer];
    mask.frame = CGRectMake(0.0f, 0.0f, self.size, self.size);
    mask.path = [[UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0.0f endAngle:M_PI * 2.0f clockwise:YES] CGPath];
    mask.strokeColor = UIColor.blackColor.CGColor;
    mask.fillColor = UIColor.clearColor.CGColor;
    mask.lineWidth = 2.0f;
    mask.cornerRadius = self.size * 0.5f;
    mask.anchorPoint = CGPointMake(0.5f, 0.5f);
    arc.mask = mask;

    CAKeyframeAnimation* strokeStartAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.removedOnCompletion = NO;
    strokeStartAnimation.repeatCount = HUGE_VALF;
    strokeStartAnimation.duration = 1.2f;
    strokeStartAnimation.beginTime = beginTime;
    strokeStartAnimation.keyTimes = @[@(0.0f), @(0.6f), @(1.0f)];
    strokeStartAnimation.values = @[@(0.0f), @(0.0f), @(1.0f)];
    strokeStartAnimation.timingFunctions = @[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
    ];
    [mask addAnimation:strokeStartAnimation forKey:@"circle-start"];
    
    CAKeyframeAnimation* strokeEndAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.removedOnCompletion = NO;
    strokeEndAnimation.repeatCount = HUGE_VALF;
    strokeEndAnimation.duration = 1.2f;
    strokeEndAnimation.beginTime = beginTime;
    strokeEndAnimation.keyTimes = @[@(0.0f), @(0.4f), @(1.0f)];
    strokeEndAnimation.values = @[@(0.0f), @(1.0f), @(1.0f)];
    strokeEndAnimation.timingFunctions = @[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
    ];
    [mask addAnimation:strokeEndAnimation forKey:@"circle-end"];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/

