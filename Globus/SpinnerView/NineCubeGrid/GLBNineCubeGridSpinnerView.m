/*--------------------------------------------------*/

#import "GLBNineCubeGridSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBNineCubeGridSpinnerView

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
                    square.transform = CATransform3DMakeScale(0, 0, 0);
                    
                    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
                    animation.removedOnCompletion = NO;
                    animation.repeatCount = HUGE_VALF;
                    animation.duration = 1.5;
                    animation.beginTime = beginTime + (0.1 * sum);
                    animation.keyTimes = @[
                        @(0), @(0.4), @(0.6), @(1)
                    ];
                    animation.timingFunctions = @[
                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                    ];
                    animation.values = @[
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 0)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 0)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 0)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 0)]
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
/* Legacy                                           */
/*--------------------------------------------------*/

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

@implementation GLBSpinnerViewNineCubeGrid
@end

#pragma clang diagnostic pop

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
