/*--------------------------------------------------*/

#import "GLBRoundView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBRoundView ()

- (void)_updateCorners;
- (void)_updateShadow;
 
@end

/*--------------------------------------------------*/

@implementation GLBRoundView

#pragma mark - Init / Free

- (instancetype)initWithCoder:(NSCoder*)coder {
    self = [super initWithCoder:coder];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.clipsToBounds = YES;
}

#pragma mark - Property override

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self _updateCorners];
    [self _updateShadow];
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    [self _updateCorners];
    [self _updateShadow];
}

#pragma mark - Property

- (void)setRoundCorners:(BOOL)roundCorners {
    if(_roundCorners != roundCorners) {
        _roundCorners = roundCorners;
        [self _updateCorners];
        [self _updateShadow];
    }
}

- (void)setAutomaticShadowPath:(BOOL)automaticShadowPath {
    if(_automaticShadowPath != automaticShadowPath) {
        _automaticShadowPath = automaticShadowPath;
        self.clipsToBounds = (_automaticShadowPath == NO);
        [self _updateShadow];
    }
}

#pragma mark - Private

- (void)_updateCorners {
    if(_roundCorners == YES) {
        CGRect bounds = self.bounds;
        self.glb_cornerRadius = GLB_CEIL(MIN(bounds.size.width - 1, bounds.size.height - 1) / 2);
    }
}

- (void)_updateShadow {
    if(_automaticShadowPath == YES) {
        CGRect bounds = self.bounds;
        if((bounds.size.width > 0) && (bounds.size.height > 0)) {
            self.glb_shadowPath = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:self.glb_cornerRadius];
        }
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
