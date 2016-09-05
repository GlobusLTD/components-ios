/*--------------------------------------------------*/

#import "GLBCircleSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBCircleSpinnerView

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime();
    CGFloat circleSize = self.size / 4;
    CGFloat circleSize2 = circleSize / 2;
    CGFloat radius = self.size / 2;
    CGFloat radius2 = radius - circleSize2;
    for(NSInteger i = 0; i < 8; i++) {
        CGFloat angle = (CGFloat)(i * M_PI_4);
        CGFloat x = (radius + (GLB_SIN(angle) * radius2)) - circleSize2;
        CGFloat y = (radius - (GLB_COS(angle) * radius2)) - circleSize2;
        
        CALayer* circle = [CALayer layer];
        circle.frame = CGRectMake(x, y, circleSize, circleSize);
        circle.backgroundColor = self.color.CGColor;
        circle.anchorPoint = CGPointMake(0.5, 0.5);
        circle.cornerRadius = circleSize / 2;
        circle.transform = CATransform3DMakeScale(0, 0, 0);
        [self.layer addSublayer:circle];
  
        CAKeyframeAnimation* circleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        circleAnimation.removedOnCompletion = NO;
        circleAnimation.repeatCount = HUGE_VALF;
        circleAnimation.duration = 1;
        circleAnimation.beginTime = beginTime + (0.125 * i);
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
