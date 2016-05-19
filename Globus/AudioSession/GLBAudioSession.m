/*--------------------------------------------------*/

#import "GLBAudioSession.h"
#import "NSArray+GLBNS.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

/*--------------------------------------------------*/

@interface GLBAudioSession () < AVAudioSessionDelegate > {
    NSMutableArray< NSValue* >* _observers;
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
    static id shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [self new];
    });
    return shared;
}

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _observers = [NSMutableArray array];
    
    AVAudioSession.sharedInstance.delegate = self;
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
    self.volumeSlider.value = volume;
}

- (CGFloat)volume {
    return self.volumeSlider.value;
}

#pragma mark - Public

- (void)addObserver:(id< GLBAudioSessionObserver >)observer {
    if([observer respondsToSelector:@selector(audioSessionChangeDeviceVolume:)] == YES) {
        if(self.volumeSlider == nil) {
            NSLog(@"%s: Not allowed change device volume", __PRETTY_FUNCTION__);
        }
    }
    [_observers addObject:[NSValue valueWithNonretainedObject:observer]];
}

- (void)removeObserver:(id< GLBAudioSessionObserver >)observer {
    [_observers glb_each:^(NSValue* value) {
        if(value.nonretainedObjectValue == observer) {
            [_observers removeObject:value];
        }
    }];
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

#pragma mark - AVAudioSessionDelegate

- (void)beginInterruption {
    [self _notifyBeginInterruption];
}

- (void)endInterruptionWithFlags:(NSUInteger)flags {
    [self _notifyEndInterruptionWithFlags:flags];
}

- (void)inputIsAvailableChanged:(BOOL)isInputAvailable {
    [self _notifyChangedInputAvailable:isInputAvailable];
}

#pragma mark - Observer

- (void)_notifyBeginInterruption {
    [_observers glb_each:^(NSValue* value) {
        id< GLBAudioSessionObserver > observer = value.nonretainedObjectValue;
        if([observer respondsToSelector:@selector(audioSessionBeginInterruption)] == YES) {
            [observer audioSessionBeginInterruption];
        }
    }];
}

- (void)_notifyEndInterruptionWithFlags:(NSUInteger)flags {
    [_observers glb_each:^(NSValue* value) {
        id< GLBAudioSessionObserver > observer = value.nonretainedObjectValue;
        if([observer respondsToSelector:@selector(audioSessionEndInterruptionWithFlags:)] == YES) {
            [observer audioSessionEndInterruptionWithFlags:flags];
        }
    }];
}

- (void)_notifyChangedInputAvailable:(BOOL)inputAvailable {
    [_observers glb_each:^(NSValue* value) {
        id< GLBAudioSessionObserver > observer = value.nonretainedObjectValue;
        if([observer respondsToSelector:@selector(audioSessionChangedInputAvailable:)] == YES) {
            [observer audioSessionChangedInputAvailable:inputAvailable];
        }
    }];
}

- (void)_notifyChangeDeviceVolume:(CGFloat)volume {
    [_observers glb_each:^(NSValue* value) {
        id< GLBAudioSessionObserver > observer = value.nonretainedObjectValue;
        if([observer respondsToSelector:@selector(audioSessionChangeDeviceVolume:)] == YES) {
            [observer audioSessionChangeDeviceVolume:volume];
        }
    }];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
