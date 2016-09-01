/*--------------------------------------------------*/

#import "GLBCircleFlipSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#include "GLBTransform3D.h"

/*--------------------------------------------------*/

@implementation GLBCircleFlipSpinnerView

- (void)prepareAnimation {
    [super prepareAnimation];
    
    CALayer* circle = [CALayer layer];
    circle.frame = CGRectInset(CGRectMake(0, 0, self.size, self.size), 2, 2);
    circle.backgroundColor = self.color.CGColor;
    circle.cornerRadius = self.size / 2;
    circle.anchorPoint = CGPointMake(0.5, 0.5);
    circle.anchorPointZ = 0.5;
    circle.shouldRasterize = YES;
    circle.rasterizationScale = UIScreen.mainScreen.scale;
    [self.layer addSublayer:circle];
    
    CAKeyframeAnimation* circleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    circleAnimation.removedOnCompletion = NO;
    circleAnimation.repeatCount = HUGE_VALF;
    circleAnimation.duration = 1.2;
    circleAnimation.keyTimes = @[
        @(0), @(0.5), @(1)
    ];
    circleAnimation.timingFunctions = @[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
    ];
    circleAnimation.values = @[
        [NSValue valueWithCATransform3D:GLBTransform3DRotationWithPerspective((CGFloat)(1.0 / 120.0), 0, 0, 0, 0)],
        [NSValue valueWithCATransform3D:GLBTransform3DRotationWithPerspective((CGFloat)(1.0 / 120.0), (CGFloat)(M_PI), 0, 1, 0)],
        [NSValue valueWithCATransform3D:GLBTransform3DRotationWithPerspective((CGFloat)(1.0 / 120.0), (CGFloat)(M_PI), 0, 0, 1)]
    ];
    [circle addAnimation:circleAnimation forKey:@"circle"];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
