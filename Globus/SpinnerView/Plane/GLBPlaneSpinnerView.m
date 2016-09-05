/*--------------------------------------------------*/

#import "GLBPlaneSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#include "GLBTransform3D.h"

/*--------------------------------------------------*/

@implementation GLBPlaneSpinnerView

- (void)prepareAnimation {
    [super prepareAnimation];
    
    CALayer* plane = [CALayer layer];
    plane.frame = CGRectInset(CGRectMake(0, 0, self.size, self.size), 2, 2);
    plane.backgroundColor = self.color.CGColor;
    plane.anchorPoint = CGPointMake(0.5, 0.5);
    plane.anchorPointZ = 0.5;
    plane.shouldRasterize = YES;
    plane.rasterizationScale = [[UIScreen mainScreen] scale];
    [self.layer addSublayer:plane];

    CAKeyframeAnimation* planeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    planeAnimation.removedOnCompletion = NO;
    planeAnimation.repeatCount = HUGE_VALF;
    planeAnimation.duration = 1.2;
    planeAnimation.keyTimes = @[
        @(0), @(0.5), @(1)
    ];
    planeAnimation.timingFunctions = @[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
    ];
    planeAnimation.values = @[
        [NSValue valueWithCATransform3D:GLBTransform3DRotationWithPerspective((CGFloat)(1.0 / 120.0), 0, 0, 0, 0)],
        [NSValue valueWithCATransform3D:GLBTransform3DRotationWithPerspective((CGFloat)(1.0 / 120.0), (CGFloat)(M_PI), 0, 1, 0)],
        [NSValue valueWithCATransform3D:GLBTransform3DRotationWithPerspective((CGFloat)(1.0 / 120.0), (CGFloat)(M_PI), 0, 0, 1)]
    ];
    [plane addAnimation:planeAnimation forKey:@"plane"];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/

