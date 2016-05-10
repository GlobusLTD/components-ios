/*--------------------------------------------------*/

#import "GLBSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#include "GLBCG.h"

/*--------------------------------------------------*/

@implementation GLBSpinnerViewFadingCircleAlt

- (void)setup {
    [super setup];
    
    _numberOfCircle = 12;
    _factorCircle = 0.25f;
    _factorRadius = 0.5f;
    _minScale = 0.1f;
    _minOpacity = 0.0f;
}

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime();
    CGFloat squareSize = self.size * _factorCircle;
    CGFloat squareSize2 = squareSize * 0.5f;
    CGFloat radius = self.size * _factorRadius;
    CGFloat radius2 = radius - squareSize2;
    for(NSInteger i = 0; i < _numberOfCircle;  i++) {
        CGFloat angle = GLB_DEG_TO_RAD * ((360.0f / _numberOfCircle) * i);
        CGFloat x = (radius + (cosf(angle) * radius2)) - squareSize2;
        CGFloat y = (radius - (sinf(angle) * radius2)) - squareSize2;
        
        CALayer* circle = [CALayer layer];
        circle.backgroundColor = self.color.CGColor;
        circle.frame = CGRectMake(x, y, squareSize, squareSize);
        circle.anchorPoint = CGPointMake(0.5f, 0.5f);
        circle.cornerRadius = radius * 0.25f;
        circle.rasterizationScale = UIScreen.mainScreen.scale;
        circle.shouldRasterize = YES;
        [self.layer addSublayer:circle];

        CAKeyframeAnimation* transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        transformAnimation.values = @[
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 0.0f)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(_minScale, _minScale, 0.0f)]
        ];
        CAKeyframeAnimation* opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.values = @[ @(1.0f), @(_minOpacity) ];
        
        CAAnimationGroup* groupAnimation = [[CAAnimationGroup alloc] init];
        groupAnimation.removedOnCompletion = NO;
        groupAnimation.repeatCount = HUGE_VALF;
        groupAnimation.duration = 0.1f * _numberOfCircle;
        groupAnimation.beginTime = beginTime - (groupAnimation.duration - (0.1f * i));
        groupAnimation.animations = @[ transformAnimation, opacityAnimation ];
        [circle addAnimation:groupAnimation forKey:@"group"];
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
