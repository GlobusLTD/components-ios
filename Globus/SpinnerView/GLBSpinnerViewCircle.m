/*--------------------------------------------------*/

#import "GLBSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBSpinnerViewCircle

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime();
    CGFloat circleSize = self.size * 0.25f;
    CGFloat circleSize2 = circleSize * 0.5f;
    CGFloat radius = self.size * 0.5f;
    CGFloat radius2 = radius - circleSize2;
    for(NSInteger i = 0; i < 8; i++) {
        CGFloat angle = i * M_PI_4;
        CGFloat x = (radius + (sinf(angle) * radius2)) - circleSize2;
        CGFloat y = (radius - (cosf(angle) * radius2)) - circleSize2;
        
        CALayer* circle = [CALayer layer];
        circle.frame = CGRectMake(x, y, circleSize, circleSize);
        circle.backgroundColor = self.color.CGColor;
        circle.anchorPoint = CGPointMake(0.5f, 0.5f);
        circle.cornerRadius = circleSize * 0.5f;
        circle.transform = CATransform3DMakeScale(0.0f, 0.0f, 0.0f);
        [self.layer addSublayer:circle];
  
        CAKeyframeAnimation* circleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        circleAnimation.removedOnCompletion = NO;
        circleAnimation.repeatCount = HUGE_VALF;
        circleAnimation.duration = 1.0f;
        circleAnimation.beginTime = beginTime + (0.125f * i);
        circleAnimation.keyTimes = @[@(0.0f), @(0.5f), @(1.0f)];
        circleAnimation.timingFunctions = @[
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
        ];
        circleAnimation.values = @[
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0f, 0.0f, 0.0f)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 0.0f)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0f, 0.0f, 0.0f)]
        ];
        [circle addAnimation:circleAnimation forKey:@"circle"];
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
