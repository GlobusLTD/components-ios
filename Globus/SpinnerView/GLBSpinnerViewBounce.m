/*--------------------------------------------------*/

#import "GLBSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBSpinnerViewBounce

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime();
    for(NSInteger i = 0; i < 2; i++) {
        CALayer* circle = [CALayer layer];
        circle.frame = CGRectInset(CGRectMake(0.0f, 0.0f, self.size, self.size), 2.0f, 2.0f);
        circle.backgroundColor = self.color.CGColor;
        circle.anchorPoint = CGPointMake(0.5f, 0.5f);
        circle.opacity = 0.6;
        circle.cornerRadius = CGRectGetHeight(circle.bounds) * 0.5f;
        circle.transform = CATransform3DMakeScale(0.0f, 0.0f, 0.0f);
        [self.layer addSublayer:circle];
        
        CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.removedOnCompletion = NO;
        animation.repeatCount = HUGE_VALF;
        animation.duration = 2.0f;
        animation.beginTime = beginTime - (1.0f * i);
        animation.keyTimes = @[@(0.0f), @(0.5f), @(1.0f)];
        animation.timingFunctions = @[
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
        ];
        animation.values = @[
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0f, 0.0f, 0.0f)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 0.0f)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0f, 0.0f, 0.0f)]
        ];
        [circle addAnimation:animation forKey:@"spinner"];
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
