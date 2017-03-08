/*--------------------------------------------------*/

#import "GLBSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBSpinnerView ()

@property(nonatomic, getter=isAnimating) BOOL animating;

- (void)applicationDidEnterBackground;
- (void)applicationWillEnterForeground;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

const static CGFloat DefaultSize = 42;

/*--------------------------------------------------*/

@implementation GLBSpinnerView

- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, DefaultSize, DefaultSize)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder*)coder {
    self = [super initWithCoder:coder];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _size = DefaultSize;
    _color = [UIColor colorWithWhite:1.0 alpha:0.8f];
    _hidesWhenStopped = NO;
    
    self.backgroundColor = UIColor.clearColor;
    self.hidden = NO;
    self.layer.timeOffset = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationWillEnterForeground) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

#pragma Property

-(void)setSize:(CGFloat)size {
    if(_size != size) {
        _size = size;
        [self invalidateIntrinsicContentSize];
        if(_animating == YES) {
            [self prepareAnimation];
        }
    }
}

- (void)setColor:(UIColor*)color {
    if([_color isEqual:color] == NO) {
        _color = color;
        if(_animating == YES) {
            [self prepareAnimation];
        }
    }
}

- (void)setHidesWhenStopped:(BOOL)hidesWhenStopped {
    if(_hidesWhenStopped != hidesWhenStopped) {
        _hidesWhenStopped = hidesWhenStopped;
        if(_hidesWhenStopped == YES) {
            if(_animating == NO) {
                self.layer.sublayers = nil;
                self.hidden = YES;
            }
        } else {
            self.hidden = NO;
            if(_animating == YES) {
                [self prepareAnimation];
            }
        }
    }
}

#pragma mark - Public override

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(_size, _size);
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(_size, _size);
}

#pragma mark - Public

- (void)startAnimating {
    if(_animating == NO) {
        _animating = YES;
        self.hidden = NO;
        if(self.layer.sublayers.count < 1) {
            [self prepareAnimation];
        }
        CFTimeInterval currentTime = CACurrentMediaTime();
        CFTimeInterval pausedTime = self.layer.timeOffset;
        self.layer.beginTime = [self.layer convertTime:currentTime fromLayer:nil] - pausedTime;
        self.layer.timeOffset = 0.0;
        self.layer.speed = 1.0;
    }
}

- (void)stopAnimating {
    if(_animating == YES) {
        _animating = NO;
        if(_hidesWhenStopped == YES) {
            self.layer.sublayers = nil;
            self.hidden = YES;
        }
        self.layer.timeOffset = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        self.layer.speed = 0.0;
    }
}

- (void)prepareAnimation {
    self.layer.sublayers = nil;
}

#pragma mark - Private

- (void)applicationDidEnterBackground {
    if(_animating == YES) {
        self.layer.sublayers = nil;
    }
}

- (void)applicationWillEnterForeground {
    if(_animating == YES) {
        [self prepareAnimation];
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
