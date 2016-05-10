/*--------------------------------------------------*/

#import "GLBSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBSpinnerView9CubeGrid

- (void)prepareAnimation {
    [super prepareAnimation];
    
    NSTimeInterval beginTime = CACurrentMediaTime();
    CGFloat squareSize = self.size / 3;
    for(NSInteger sum = 0; sum < 5; sum++) {
        for(NSInteger x = 0; x < 3; x++) {
            for(NSInteger y = 0; y < 3; y++) {
                if(x + y == sum) {
                    CALayer* square = [CALayer layer];
                    square.frame = CGRectMake(x * squareSize, y * squareSize, squareSize, squareSize);
                    square.backgroundColor = self.color.CGColor;
                    square.transform = CATransform3DMakeScale(0.0f, 0.0f, 0.0f);
                    
                    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
                    animation.removedOnCompletion = NO;
                    animation.repeatCount = HUGE_VALF;
                    animation.duration = 1.5f;
                    animation.beginTime = beginTime + (0.1f * sum);
                    animation.keyTimes = @[@(0.0f), @(0.4f), @(0.6f), @(1.0f)];
                    animation.timingFunctions = @[
                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                    ];
                    animation.values = @[
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0f, 0.0f, 0.0f)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 0.0f)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 0.0f)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0f, 0.0f, 0.0f)]
                    ];
                    [self.layer addSublayer:square];
                    [square addAnimation:animation forKey:@"square"];
                }
            }
        }
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
