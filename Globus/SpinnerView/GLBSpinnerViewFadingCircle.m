/*--------------------------------------------------*/

#import "GLBSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBSpinnerViewFadingCircle

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime();
    CGFloat squareSize = self.size / 6.0f;
    CGFloat squareSize2 = squareSize * 0.5f;
    CGFloat radius = self.size * 0.5f;
    CGFloat radius2 = radius - squareSize2;
    for(NSInteger i = 0; i < 12; i++) {
        CGFloat angle = i * (M_PI_2 / 3.0f);
        CGFloat x = (radius + (sinf(angle) * radius2)) - squareSize2;
        CGFloat y = (radius - (cosf(angle) * radius2)) - squareSize2;
        
        CALayer* square = [CALayer layer];
        square.frame = CGRectMake(x, y, squareSize, squareSize);
        square.transform = CATransform3DRotate(CATransform3DIdentity, angle, 0.0f, 0.0f, 1.0f);
        square.anchorPoint = CGPointMake(0.5f, 0.5f);
        square.backgroundColor = self.color.CGColor;
        square.opacity = 0.0f;
        [self.layer addSublayer:square];

        CAKeyframeAnimation* squareAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        squareAnimation.removedOnCompletion = NO;
        squareAnimation.repeatCount = HUGE_VALF;
        squareAnimation.duration = 1.0;
        squareAnimation.beginTime = beginTime + (0.084 * i);
        squareAnimation.keyTimes = @[@(0.0), @(0.5), @(1.0)];
        squareAnimation.timingFunctions = @[
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
        ];
        squareAnimation.values = @[@(1.0), @(0.0), @(0.0)];
        [square addAnimation:squareAnimation forKey:@"square"];
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
