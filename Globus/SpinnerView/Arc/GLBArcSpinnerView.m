/*--------------------------------------------------*/

#import "GLBArcSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBArcSpinnerView

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime();
    CGRect frame  = CGRectInset(CGRectMake(0, 0, self.size, self.size), 2, 2);
    CGFloat radius = CGRectGetWidth(frame) / 2;
    CGPoint center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));

    CALayer* circle = [CALayer layer];
    circle.frame = CGRectMake(0, 0, self.size, self.size);
    circle.backgroundColor = self.color.CGColor;
    circle.anchorPoint = CGPointMake(0.5, 0.5);
    circle.cornerRadius = self.size / 2;
    [self.layer addSublayer:circle];

    CAShapeLayer* mask = [CAShapeLayer layer];
    mask.frame = CGRectMake(0, 0, self.size, self.size);
    mask.path = [[UIBezierPath bezierPathWithArcCenter:center
                                                radius:radius
                                            startAngle:0
                                              endAngle:(CGFloat)(((M_PI * 2) / 360) * 300)
                                             clockwise:YES] CGPath];
    mask.strokeColor = UIColor.blackColor.CGColor;
    mask.fillColor = UIColor.clearColor.CGColor;
    mask.lineWidth = 2;
    mask.cornerRadius = (CGFloat)(self.size * 0.5);
    mask.anchorPoint = CGPointMake(0.5, 0.5);
    circle.mask = mask;

    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.removedOnCompletion = NO;
    animation.repeatCount = HUGE_VALF;
    animation.duration = 0.8;
    animation.beginTime = beginTime;
    animation.keyTimes = @[
        @(0), @(0.5), @(1)
    ];
    animation.values = @[
        @(0),
		@(M_PI),
		@(M_PI * 2)
    ];

    [circle addAnimation:animation forKey:@"circle"];
}

@end

/*--------------------------------------------------*/
/* Legacy                                           */
/*--------------------------------------------------*/

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

@implementation GLBSpinnerViewArc
@end

#pragma clang diagnostic pop

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
