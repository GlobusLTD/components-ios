/*--------------------------------------------------*/

#import "GLBBounceSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBBounceSpinnerView

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime();
    for(NSInteger i = 0; i < 2; i++) {
        CALayer* circle = [CALayer layer];
        circle.frame = CGRectInset(CGRectMake(0, 0, self.size, self.size), 2, 2);
        circle.backgroundColor = self.color.CGColor;
        circle.anchorPoint = CGPointMake(0.5, 0.5);
        circle.opacity = (CGFloat)(0.6);
        circle.cornerRadius = CGRectGetHeight(circle.bounds) / 2;
        circle.transform = CATransform3DMakeScale(0, 0, 0);
        [self.layer addSublayer:circle];
        
        CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.removedOnCompletion = NO;
        animation.repeatCount = HUGE_VALF;
        animation.duration = 2;
        animation.beginTime = beginTime - (1 * i);
        animation.keyTimes = @[
            @(0), @(0.5), @(1)
        ];
        animation.timingFunctions = @[
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
        ];
        animation.values = @[
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 0)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 0)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 0)]
        ];
        [circle addAnimation:animation forKey:@"spinner"];
    }
}

@end

/*--------------------------------------------------*/
/* Legacy                                           */
/*--------------------------------------------------*/

@implementation GLBSpinnerViewBounce
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
