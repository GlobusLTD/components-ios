/*--------------------------------------------------*/

#import "GLBArcAltSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBArcAltSpinnerView

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime();
    CGRect frame  = CGRectInset(CGRectMake(0, 0, self.size, self.size), 2, 2);
    CGFloat radius = CGRectGetWidth(frame) / 2;
    CGPoint center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    
    CALayer* arc = [CALayer layer];
    arc.frame = CGRectMake(0, 0, self.size, self.size);
    arc.backgroundColor = self.color.CGColor;
    arc.anchorPoint = CGPointMake(0.5, 0.5);
    arc.cornerRadius = self.size / 2;
    [self.layer addSublayer:arc];

    CAShapeLayer* mask = [CAShapeLayer layer];
    mask.frame = CGRectMake(0, 0, self.size, self.size);
    mask.path = [[UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:(CGFloat)(M_PI * 2) clockwise:YES] CGPath];
    mask.strokeColor = UIColor.blackColor.CGColor;
    mask.fillColor = UIColor.clearColor.CGColor;
    mask.lineWidth = 2;
    mask.cornerRadius = self.size / 2;
    mask.anchorPoint = CGPointMake(0.5, 0.5);
    arc.mask = mask;

    CAKeyframeAnimation* strokeStartAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.removedOnCompletion = NO;
    strokeStartAnimation.repeatCount = HUGE_VALF;
    strokeStartAnimation.duration = 1.2f;
    strokeStartAnimation.beginTime = beginTime;
    strokeStartAnimation.keyTimes = @[
        @(0), @(0.6), @(1)
    ];
    strokeStartAnimation.values = @[
        @(0), @(0), @(1)
    ];
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
    strokeEndAnimation.keyTimes = @[
        @(0), @(0.4f), @(1)
    ];
    strokeEndAnimation.values = @[
        @(0), @(1), @(1)
    ];
    strokeEndAnimation.timingFunctions = @[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
    ];
    [mask addAnimation:strokeEndAnimation forKey:@"circle-end"];
}

@end

/*--------------------------------------------------*/
/* Legacy                                           */
/*--------------------------------------------------*/

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

@implementation GLBSpinnerViewArcAlt
@end

#pragma clang diagnostic pop

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/

