/*--------------------------------------------------*/

#import "GLBFadingCircleAltSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#include "GLBCG.h"

/*--------------------------------------------------*/

@implementation GLBFadingCircleAltSpinnerView

- (void)setup {
    [super setup];
    
    _numberOfCircle = 12;
    _factorCircle = 0.25f;
    _factorRadius = 0.5f;
    _minScale = 0.1f;
    _minOpacity = 0;
}

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime();
    CGFloat squareSize = self.size * _factorCircle;
    CGFloat squareSize2 = (CGFloat)(squareSize * 0.5);
    CGFloat radius = self.size * _factorRadius;
    CGFloat radius2 = radius - squareSize2;
    for(NSUInteger i = 0; i < _numberOfCircle;  i++) {
        CGFloat angle = (CGFloat)(GLB_DEG_TO_RAD * ((360.0 / _numberOfCircle) * i));
        CGFloat x = (radius + (cosf(angle) * radius2)) - squareSize2;
        CGFloat y = (radius - (sinf(angle) * radius2)) - squareSize2;
        
        CALayer* circle = [CALayer layer];
        circle.backgroundColor = self.color.CGColor;
        circle.frame = CGRectMake(x, y, squareSize, squareSize);
        circle.anchorPoint = CGPointMake(0.5, 0.5);
        circle.cornerRadius = radius / 4;
        circle.rasterizationScale = UIScreen.mainScreen.scale;
        circle.shouldRasterize = YES;
        [self.layer addSublayer:circle];

        CAKeyframeAnimation* transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        transformAnimation.values = @[
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 0)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(_minScale, _minScale, 0)]
        ];
        CAKeyframeAnimation* opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.values = @[
            @(1), @(_minOpacity)
        ];
        
        CAAnimationGroup* groupAnimation = [[CAAnimationGroup alloc] init];
        groupAnimation.removedOnCompletion = NO;
        groupAnimation.repeatCount = HUGE_VALF;
        groupAnimation.duration = (CGFloat)(0.1 * _numberOfCircle);
        groupAnimation.beginTime = beginTime - (groupAnimation.duration - (0.1 * i));
        groupAnimation.animations = @[
            transformAnimation, opacityAnimation
        ];
        [circle addAnimation:groupAnimation forKey:@"group"];
    }
}

@end

/*--------------------------------------------------*/
/* Legacy                                           */
/*--------------------------------------------------*/

@implementation GLBSpinnerViewFadingCircleAlt
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
