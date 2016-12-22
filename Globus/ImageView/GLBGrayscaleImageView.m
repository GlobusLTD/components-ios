/*--------------------------------------------------*/

#import "GLBGrayscaleImageView.h"
#import "GLBImageView+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBGrayscaleImageView ()
@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBGrayscaleImageView

#pragma mark - Init / Free

- (void)setup {
    [super setup];
    
    _enabled = YES;
    self.processingKey = [self _buildProcessingKey];
}

#pragma mark - Property

- (void)setEnabled:(BOOL)enabled {
    if(_enabled != enabled) {
        _enabled = enabled;
        self.processingKey = [self _buildProcessingKey];
    }
}

#pragma mark - Private

- (NSString*)_buildProcessingKey {
    if(_enabled == YES) {
        return @"Grayscale";
    }
    return nil;
}

#pragma mark - GLBImageManagerTarget

- (UIImage*)imageManager:(GLBImageManager*)imageManager processing:(NSString*)processing image:(UIImage*)image {
    return [image glb_grayscale];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
