/*--------------------------------------------------*/

#import "GLBWanderingCubesSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#include "GLBCG.h"

/*--------------------------------------------------*/

@implementation GLBWanderingCubesSpinnerView

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime();
    CGFloat cubeSize = floorf(self.size / 3);
    CGFloat widthMinusCubeSize = self.size - cubeSize;
    for(NSInteger i = 0; i < 2; i++) {
        CALayer* cube = [CALayer layer];
        cube.backgroundColor = self.color.CGColor;
        cube.frame = CGRectMake(0, 0, cubeSize, cubeSize);
        cube.anchorPoint = CGPointMake(0.5, 0.5);
        cube.rasterizationScale = UIScreen.mainScreen.scale;
        cube.shouldRasterize = YES;
        [self.layer addSublayer:cube];
        
        CAKeyframeAnimation* cubeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        cubeAnimation.removedOnCompletion = NO;
        cubeAnimation.beginTime = beginTime - (i * 0.9);
        cubeAnimation.duration = 1.8;
        cubeAnimation.repeatCount = HUGE_VALF;
        cubeAnimation.timingFunctions = @[
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
        ];
        cubeAnimation.keyTimes = @[
            @(0), @(0.25), @(0.50), @(0.75), @(1)
        ];

        CATransform3D t0 = CATransform3DIdentity;
        CATransform3D t1 = CATransform3DMakeTranslation(widthMinusCubeSize, 0, 0);
        t1 = CATransform3DRotate(t1, -90 * GLB_DEG_TO_RAD, 0, 0, 1);
        t1 = CATransform3DScale(t1, 0.5, 0.5, 1);
        CATransform3D t2 = CATransform3DMakeTranslation(widthMinusCubeSize, widthMinusCubeSize, 0);
        t2 = CATransform3DRotate(t2, -180 * GLB_DEG_TO_RAD, 0, 0, 1);
        t2 = CATransform3DScale(t2, 1, 1, 1);
        CATransform3D t3 = CATransform3DMakeTranslation(0, widthMinusCubeSize, 0);
        t3 = CATransform3DRotate(t3, -270 * GLB_DEG_TO_RAD, 0, 0, 1);
        t3 = CATransform3DScale(t3, 0.5, 0.5, 1);
        CATransform3D t4 = CATransform3DMakeTranslation(0, 0, 0);
        t4 = CATransform3DRotate(t4, -360 * GLB_DEG_TO_RAD, 0, 0, 1);
        t4 = CATransform3DScale(t4, 1, 1, 1);
        
        cubeAnimation.values = @[
            [NSValue valueWithCATransform3D:t0],
            [NSValue valueWithCATransform3D:t1],
            [NSValue valueWithCATransform3D:t2],
            [NSValue valueWithCATransform3D:t3],
            [NSValue valueWithCATransform3D:t4]
        ];
        [cube addAnimation:cubeAnimation forKey:@"cube"];
    }
}

@end

/*--------------------------------------------------*/
/* Legacy                                           */
/*--------------------------------------------------*/

@implementation GLBSpinnerViewWanderingCubes
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
