/*--------------------------------------------------*/

#import "GLBImageView+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBImageView

#pragma mark - Synthesize

@synthesize manager = _manager;

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
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    [self _updateCorners];
}

- (void)setImage:(UIImage*)image {
    if(image == nil) {
        image = _defaultImage;
    }
    [self _applyImage:image];
}

#pragma mark - Property

- (void)setManager:(GLBImageManager*)manager {
    if(_manager != manager) {
        if(_manager != nil) {
            [_manager cancelByTarget:self];
        }
        _manager = manager;
        if((_manager != nil) && (_downloading == YES)) {
            [self _applyImage:_defaultImage];
            [self _applyImageUrl:_imageUrl processing:_processingKey];
        }
    }
}

- (GLBImageManager*)manager {
    if(_manager == nil) {
        _manager = [GLBImageManager defaultImageManager];
    }
    return _manager;
}

- (void)setRoundCorners:(BOOL)roundCorners {
    if(_roundCorners != roundCorners) {
        _roundCorners = roundCorners;
        [self _updateCorners];
    }
}

- (void)setImageUrl:(NSURL*)imageUrl {
    if([_imageUrl isEqual:imageUrl] == NO) {
        if(_imageUrl != nil) {
            [self.manager cancelByTarget:self];
            _downloading = NO;
        }
        _imageUrl = imageUrl;
        if(_imageUrl != nil) {
            [self _applyImage:_defaultImage];
            [self _applyImageUrl:_imageUrl processing:_processingKey];
        } else {
            [self _applyImage:_defaultImage];
        }
    }
}

- (void)setProcessingKey:(NSString*)processingKey {
    if([_processingKey isEqualToString:processingKey] == NO) {
        if(_imageUrl != nil) {
            [self.manager cancelByTarget:self];
            _downloading = NO;
        }
        _processingKey = processingKey.copy;
        if(_imageUrl != nil) {
            [self _applyImage:_defaultImage];
            [self _applyImageUrl:_imageUrl processing:_processingKey];
        } else {
            [self _applyImage:_defaultImage];
        }
    }
}

#pragma mark - Public

- (void)startDownload {
    _downloading = YES;
}

- (void)downloadProgress:(NSProgress*)progress {
}

- (void)finishDownload {
    _downloading = NO;
}

#pragma mark - Private

- (void)_updateCorners {
    if(_roundCorners == YES) {
        CGRect bounds = self.bounds;
        self.layer.cornerRadius = GLB_CEIL(MIN(bounds.size.width - 1, bounds.size.height - 1) * (CGFloat)(0.5));
    }
}

- (void)_applyImage:(UIImage*)image {
    if(image.images.count > 0) {
        self.animationImages = image.images;
        self.animationDuration = image.duration;
        if(self.animationRepeatCount > 0) {
            super.image = image.images.lastObject;
        } else {
            super.image = image;
        }
        [self startAnimating];
    } else {
        [self stopAnimating];
        self.animationImages = nil;
        self.animationDuration = 0;
        super.image = image;
    }
}

- (void)_applyImageUrl:(NSURL*)imageUrl processing:(NSString*)processing {
    [self.manager imageByUrl:imageUrl processing:processing target:self];
}

#pragma mark - GLBImageManagerTarget

- (void)imageManager:(GLBImageManager*)imageManager cacheImage:(UIImage*)image {
    [self _applyImage:image];
}

- (UIImage*)imageManager:(GLBImageManager*)imageManager processing:(NSString*)processing image:(UIImage*)image {
    return nil;
}

- (void)startDownloadInImageManager:(GLBImageManager*)imageManager {
    [self startDownload];
}

- (void)finishDownloadInImageManager:(GLBImageManager*)imageManager {
    [self finishDownload];
}

- (void)imageManager:(GLBImageManager*)imageManager downloadProgress:(NSProgress*)progress {
    [self downloadProgress:progress];
}

- (void)imageManager:(GLBImageManager*)imageManager downloadImage:(UIImage*)image {
    [self _applyImage:image];
}

- (void)imageManager:(GLBImageManager*)imageManager downloadError:(NSError*)error {
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
