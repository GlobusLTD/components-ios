/*--------------------------------------------------*/

#import "GLBFadingCircleSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBFadingCircleSpinnerView

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime();
    CGFloat squareSize = self.size / 6;
    CGFloat squareSize2 = squareSize / 2;
    CGFloat radius = self.size / 2;
    CGFloat radius2 = radius - squareSize2;
    for(NSInteger i = 0; i < 12; i++) {
        CGFloat angle = i * (CGFloat)(M_PI_2 / 3);
        CGFloat x = (radius + (sinf(angle) * radius2)) - squareSize2;
        CGFloat y = (radius - (cosf(angle) * radius2)) - squareSize2;
        
        CALayer* square = [CALayer layer];
        square.frame = CGRectMake(x, y, squareSize, squareSize);
        square.transform = CATransform3DRotate(CATransform3DIdentity, angle, 0, 0, 1);
        square.anchorPoint = CGPointMake(0.5f, 0.5f);
        square.backgroundColor = self.color.CGColor;
        square.opacity = 0;
        [self.layer addSublayer:square];

        CAKeyframeAnimation* squareAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        squareAnimation.removedOnCompletion = NO;
        squareAnimation.repeatCount = HUGE_VALF;
        squareAnimation.duration = 1;
        squareAnimation.beginTime = beginTime + (0.084 * i);
        squareAnimation.timingFunctions = @[
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
        ];
        squareAnimation.keyTimes = @[
            @(0), @(0), @(1)
        ];
        squareAnimation.values = @[
            @(1), @(0), @(0)
        ];
        [square addAnimation:squareAnimation forKey:@"square"];
    }
}

@end

/*--------------------------------------------------*/
/* Legacy                                           */
/*--------------------------------------------------*/

@implementation GLBSpinnerViewFadingCircle
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
