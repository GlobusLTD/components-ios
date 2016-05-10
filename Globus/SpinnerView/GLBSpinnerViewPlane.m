/*--------------------------------------------------*/

#import "GLBSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#include "GLBTransform3D.h"

/*--------------------------------------------------*/

@implementation GLBSpinnerViewPlane

- (void)prepareAnimation {
    [super prepareAnimation];
    
    CALayer* plane = [CALayer layer];
    plane.frame = CGRectInset(CGRectMake(0.0f, 0.0f, self.size, self.size), 2.0f, 2.0f);
    plane.backgroundColor = self.color.CGColor;
    plane.anchorPoint = CGPointMake(0.5f, 0.5f);
    plane.anchorPointZ = 0.5f;
    plane.shouldRasterize = YES;
    plane.rasterizationScale = [[UIScreen mainScreen] scale];
    [self.layer addSublayer:plane];

    CAKeyframeAnimation* planeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    planeAnimation.removedOnCompletion = NO;
    planeAnimation.repeatCount = HUGE_VALF;
    planeAnimation.duration = 1.2;
    planeAnimation.keyTimes = @[@(0.0), @(0.5), @(1.0)];
    planeAnimation.timingFunctions = @[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
    ];
    planeAnimation.values = @[
        [NSValue valueWithCATransform3D:GLBTransform3DRotationWithPerspective(1.0f / 120.0f, 0.0f, 0.0f, 0.0f, 0.0f)],
        [NSValue valueWithCATransform3D:GLBTransform3DRotationWithPerspective(1.0f / 120.0f, M_PI, 0.0f, 1.0f, 0.0f)],
        [NSValue valueWithCATransform3D:GLBTransform3DRotationWithPerspective(1.0f / 120.0f, M_PI, 0.0f, 0.0f, 1.0f)]
    ];
    [plane addAnimation:planeAnimation forKey:@"plane"];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/

