/*--------------------------------------------------*/

#import "GLBSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#include "GLBTransform3D.h"

/*--------------------------------------------------*/

@implementation GLBSpinnerViewCircleFlip

- (void)prepareAnimation {
    [super prepareAnimation];
    
    CALayer* circle = [CALayer layer];
    circle.frame = CGRectInset(CGRectMake(0.0f, 0.0f, self.size, self.size), 2.0f, 2.0f);
    circle.backgroundColor = self.color.CGColor;
    circle.cornerRadius = self.size * 0.5f;
    circle.anchorPoint = CGPointMake(0.5f, 0.5f);
    circle.anchorPointZ = 0.5;
    circle.shouldRasterize = YES;
    circle.rasterizationScale = UIScreen.mainScreen.scale;
    [self.layer addSublayer:circle];
    
    CAKeyframeAnimation* circleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    circleAnimation.removedOnCompletion = NO;
    circleAnimation.repeatCount = HUGE_VALF;
    circleAnimation.duration = 1.2;
    circleAnimation.keyTimes = @[@(0.0), @(0.5), @(1.0)];
    circleAnimation.timingFunctions = @[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
    ];
    circleAnimation.values = @[
        [NSValue valueWithCATransform3D:GLBTransform3DRotationWithPerspective(1.0f / 120.0f, 0.0f, 0.0f, 0.0f, 0.0f)],
        [NSValue valueWithCATransform3D:GLBTransform3DRotationWithPerspective(1.0f / 120.0f, M_PI, 0.0f, 1.0f, 0.0f)],
        [NSValue valueWithCATransform3D:GLBTransform3DRotationWithPerspective(1.0f / 120.0f, M_PI, 0.0f, 0.0f, 1.0f)]
    ];
    [circle addAnimation:circleAnimation forKey:@"circle"];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
