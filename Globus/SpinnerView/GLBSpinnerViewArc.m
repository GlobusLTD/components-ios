/*--------------------------------------------------*/

#import "GLBSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBSpinnerViewArc

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime();
    CGRect frame  = CGRectInset(CGRectMake(0.0f, 0.0f, self.size, self.size), 2.0f, 2.0f);
    CGFloat radius = CGRectGetWidth(frame) / 2.0f;
    CGPoint center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));

    CALayer* circle = [CALayer layer];
    circle.frame = CGRectMake(0.0f, 0.0f, self.size, self.size);
    circle.backgroundColor = self.color.CGColor;
    circle.anchorPoint = CGPointMake(0.5f, 0.5f);
    circle.cornerRadius = self.size * 0.5f;
    [self.layer addSublayer:circle];

    CAShapeLayer* mask = [CAShapeLayer layer];
    mask.frame = CGRectMake(0.0f, 0.0f, self.size, self.size);
    mask.path = [[UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0.0f endAngle:((M_PI * 2.0f) / 360.0f) * 300.0f clockwise:YES] CGPath];
    mask.strokeColor = UIColor.blackColor.CGColor;
    mask.fillColor = UIColor.clearColor.CGColor;
    mask.lineWidth = 2.0f;
    mask.cornerRadius = self.size * 0.5f;
    mask.anchorPoint = CGPointMake(0.5f, 0.5f);
    circle.mask = mask;

    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.removedOnCompletion = NO;
    animation.repeatCount = HUGE_VALF;
    animation.duration = 0.8f;
    animation.beginTime = beginTime;
    animation.keyTimes = @[@(0.0f), @(0.5f), @(1.0f)];
    animation.values = @[
        [NSNumber numberWithDouble:0.0f],
		[NSNumber numberWithDouble:M_PI],
		[NSNumber numberWithDouble:M_PI * 2.0f]
    ];

    [circle addAnimation:animation forKey:@"circle"];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
