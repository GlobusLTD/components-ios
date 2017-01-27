/*--------------------------------------------------*/

#import "GLBAudioSession.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBAudioSession () < AVAudioSessionDelegate > {
    GLBObserver* _observer;
}

@property(nonatomic, strong) MPVolumeView* volumeView;
@property(nonatomic, strong) UISlider* volumeSlider;

@end

/*--------------------------------------------------*/

@implementation GLBAudioSession

#pragma mark - Init / Free

@synthesize volumeView = _volumeView;
@synthesize volumeSlider = _volumeSlider;

#pragma mark - Init / Free

+ (instancetype)shared {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _observer = [[GLBObserver alloc] initWithProtocol:@protocol(GLBAudioSessionObserver)];
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(_notificationInterruption:)
                                               name:AVAudioSessionInterruptionNotification
                                             object:AVAudioSession.sharedInstance];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

#pragma mark - Property

- (MPVolumeView*)volumeView {
    if(_volumeView == nil) {
        _volumeView = [MPVolumeView new];
        _volumeView.showsRouteButton = NO;
        _volumeView.showsVolumeSlider = NO;
    }
    return _volumeView;
}

- (UISlider*)volumeSlider {
    if(_volumeSlider == nil) {
        [self.volumeView.subviews glb_each:^(UIView* view) {
            if([view isKindOfClass:UISlider.class] == YES) {
                _volumeSlider = (UISlider*)view;
            }
        }];
        if(_volumeSlider != nil) {
            [_volumeSlider addTarget:self action:@selector(_volumeChanged:) forControlEvents:UIControlEventValueChanged];
        }
    }
    return _volumeSlider;
}

- (void)setVolume:(CGFloat)volume {
    self.volumeSlider.value = (float)volume;
}

- (CGFloat)volume {
    return self.volumeSlider.value;
}

#pragma mark - Public

- (void)addObserver:(id< GLBAudioSessionObserver >)observer {
    [_observer addObserver:observer];
}

- (void)removeObserver:(id< GLBAudioSessionObserver >)observer {
    [_observer removeObserver:observer];
}

+ (void)activateWithOptions:(AVAudioSessionSetActiveOptions)activeOptions
                   category:(NSString*)category
            categoryOptions:(AVAudioSessionCategoryOptions)categoryOptions
                       mode:(NSString*)mode
                      block:(GLBAudioSessionActivateBlock)block {
    NSError* error = nil;
    AVAudioSession* audioSession = AVAudioSession.sharedInstance;
    if((category != nil) && (([audioSession.category isEqualToString:category] == NO) || (audioSession.categoryOptions != categoryOptions))) {
        if([audioSession setCategory:category withOptions:categoryOptions error:&error] == NO) {
            if(block != nil) {
                block(error);
            }
            return;
        }
    }
    if((mode != nil) && ([audioSession.mode isEqualToString:mode] == NO)) {
        if([audioSession setMode:mode error:&error] == NO) {
            if(block != nil) {
                block(error);
            }
            return;
        }
    }
    if([audioSession setActive:YES withOptions:activeOptions error:&error] == NO) {
        if(block != nil) {
            block(error);
        }
        return;
    }
    if(block != nil) {
        block(nil);
    }
}

+ (void)recordPermission:(GLBAudioSessionPermissionBlock)block {
    AVAudioSession* audioSession = AVAudioSession.sharedInstance;
    if(audioSession.recordPermission != AVAudioSessionRecordPermissionGranted) {
        [audioSession requestRecordPermission:^(BOOL granted) {
            if(granted == YES) {
                if(block != nil) {
                    block();
                }
            }
        }];
    } else if(block != nil) {
        block();
    }
}

#pragma mark - Action

- (void)_volumeChanged:(id)sender {
    [self _notifyChangeDeviceVolume:_volumeSlider.value];
}

#pragma mark - NSNotification

- (void)_notificationInterruption:(NSNotification*)notification {
    AVAudioSessionInterruptionType type = [notification.userInfo[AVAudioSessionInterruptionTypeKey] unsignedIntegerValue];
    switch(type) {
        case AVAudioSessionInterruptionTypeBegan: {
            [self _notifyBeginInterruption];
            break;
        }
        case AVAudioSessionInterruptionTypeEnded: {
            AVAudioSessionInterruptionOptions options = [notification.userInfo[AVAudioSessionInterruptionOptionKey] unsignedIntegerValue];
            [self _notifyEndInterruptionWithFlags:options];
            break;
        }
    }
}
#pragma mark - Observer

- (void)_notifyBeginInterruption {
    [_observer performSelector:@selector(audioSessionBeginInterruption) block:^(id< GLBAudioSessionObserver > observer) {
        [observer audioSessionBeginInterruption];
    }];
}

- (void)_notifyEndInterruptionWithFlags:(NSUInteger)flags {
    [_observer performSelector:@selector(audioSessionEndInterruptionWithFlags:) block:^(id< GLBAudioSessionObserver > observer) {
        [observer audioSessionEndInterruptionWithFlags:flags];
    }];
}

- (void)_notifyChangeDeviceVolume:(CGFloat)volume {
    [_observer performSelector:@selector(audioSessionChangeDeviceVolume:) block:^(id< GLBAudioSessionObserver > observer) {
        [observer audioSessionChangeDeviceVolume:volume];
    }];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
