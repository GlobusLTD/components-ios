/*--------------------------------------------------*/

#import "GLBBlurImageView.h"
#import "GLBImageView+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBBlurImageView ()
@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBBlurImageView

#pragma mark - Init / Free

- (void)setup {
    [super setup];
    
    _blurEnabled = YES;
    _blurRadius = 20.0;
    _blurIterations = 4;
    self.processingKey = [self _buildProcessingKey];
}

#pragma mark - Property

- (void)setBlurEnabled:(BOOL)blurEnabled {
    if(_blurEnabled != blurEnabled) {
        _blurEnabled = blurEnabled;
        self.processingKey = [self _buildProcessingKey];
    }
}

- (void)setBlurRadius:(CGFloat)blurRadius {
    if(_blurRadius != blurRadius) {
        _blurRadius = blurRadius;
        self.processingKey = [self _buildProcessingKey];
    }
}

- (void)setBlurIterations:(NSUInteger)blurIterations {
    if(_blurIterations != blurIterations) {
        _blurIterations = blurIterations;
        self.processingKey = [self _buildProcessingKey];
    }
}

- (void)setBlurTintColor:(UIColor*)blurTintColor {
    if([_blurTintColor isEqual:blurTintColor] == NO) {
        _blurTintColor = blurTintColor;
        self.processingKey = [self _buildProcessingKey];
    }
}

#pragma mark - Private

- (NSString*)_buildProcessingKey {
    if((_blurEnabled == YES) && (_blurRadius > FLT_EPSILON) && (_blurIterations > 0)) {
        NSMutableString* key = [NSMutableString stringWithFormat:@"Blur;radius=%0.5f;iter=%d;", (float)_blurRadius, (int)_blurIterations];
        if(_blurTintColor != nil) {
            [key appendFormat:@"tint=%@", [_blurTintColor glb_stringValue]];
        }
        return key;
    }
    return nil;
}

#pragma mark - GLBImageManagerTarget

- (UIImage*)imageManager:(GLBImageManager*)imageManager processing:(NSString*)processing image:(UIImage*)image {
    return [image glb_blurredImageWithRadius:_blurRadius iterations:_blurIterations tintColor:_blurTintColor];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
