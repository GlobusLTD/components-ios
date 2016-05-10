/*--------------------------------------------------*/

#import "GLBImageView.h"
#import "GLBDownloader.h"

/*--------------------------------------------------*/

@interface GLBImageDownloader () < GLBDownloaderDelegate > {
    GLBDownloader* _downloader;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBImageView

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

- (void)setImage:(UIImage*)image {
    if(image == nil) {
        image = _defaultImage;
    }
    super.image = image;
}

- (void)setImageUrl:(NSURL*)imageUrl {
    [self setImageUrl:imageUrl complete:nil failure:nil];
}

- (void)setImageUrl:(NSURL*)imageUrl complete:(GLBSimpleBlock)complete failure:(GLBSimpleBlock)failure {
    if([_imageUrl isEqual:imageUrl] == NO) {
        if(_imageUrl != nil) {
            [GLBImageDownloader.shared cancelByTarget:self];
        }
        _imageUrl = imageUrl;
        super.image = _defaultImage;
        [GLBImageDownloader.shared downloadWithUrl:_imageUrl byTarget:self completeBlock:^(UIImage* image, NSURL* url __unused) {
            super.image = image;
            if(complete != nil) {
                complete();
            }
        } failureBlock:^(NSURL* url __unused) {
            if(failure != nil) {
                failure();
            }
        }];
    } else {
        if(complete != nil) {
            complete();
        }
    }
}

#pragma mark - Private

- (void)_updateCorners {
    if(_roundCorners == YES) {
        CGRect bounds = self.bounds;
        self.layer.cornerRadius = ceilf(MIN(bounds.size.width - 1.0f, bounds.size.height - 1.0f) * 0.5f);
    }
}

- (void)_updateShadow {
    if(_automaticShadowPath == YES) {
        CGRect bounds = self.bounds;
        if((bounds.size.width > 0.0f) && (bounds.size.height > 0.0f)) {
            self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:self.layer.cornerRadius] CGPath];
        }
    }
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBImageDownloader

#pragma mark - Init / Free

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        _downloader = [GLBDownloader downloaderWithDelegate:self];
    }
    return self;
}

#pragma mark - Public

+ (instancetype)shared {
    static id shared = nil;
    if(shared == nil) {
        @synchronized(self) {
            if(shared == nil) {
                shared = [self new];
            }
        }
    }
    return shared;
}

- (BOOL)isExistImageWithUrl:(NSURL*)url {
    return [_downloader isExistEntryByUrl:url];
}

- (UIImage*)imageWithUrl:(NSURL*)url {
    return [_downloader entryByUrl:url];
}

- (void)setImage:(UIImage*)image byUrl:(NSURL*)url {
    [_downloader setEntry:image byUrl:url];
}

- (void)removeByUrl:(NSURL*)url {
    [_downloader removeEntryByUrl:url];
}

- (void)cleanup {
    [_downloader cleanup];
}

- (void)downloadWithUrl:(NSURL*)url byTarget:(id)target complete:(GLBImageDownloaderCompleteBlock)complete failure:(GLBImageDownloaderFailureBlock)failure {
    [_downloader downloadWithUrl:url byTarget:target complete:complete failure:failure];
}

- (void)cancelByUrl:(NSURL*)url {
    [_downloader cancelByUrl:url];
}

- (void)cancelByTarget:(id)target {
    [_downloader cancelByTarget:target];
}

#pragma mark - GLBDownloaderDelegate

- (id)downloader:(GLBDownloader* __unused)downloader entryFromData:(NSData*)data {
    return [UIImage imageWithData:data];
}

- (NSData*)downloader:(GLBDownloader* __unused)downloader entryToData:(id)entry {
    return UIImagePNGRepresentation(entry);
}

@end

/*--------------------------------------------------*/
