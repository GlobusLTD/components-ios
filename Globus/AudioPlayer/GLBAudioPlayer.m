/*--------------------------------------------------*/

#import "GLBAudioPlayer.h"
#import "GLBAudioSession.h"
#import "GLBAction.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBAudioPlayer () < AVAudioPlayerDelegate, GLBAudioSessionObserver > {
    AVAudioPlayer* _player;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBAudioPlayer

#pragma mark Init / Free

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _sessionActiveOptions = 0;
    _sessionCategory = AVAudioSessionCategoryPlayback;
    _sessionCategoryOptions = AVAudioSessionCategoryOptionMixWithOthers;
    _sessionMode = AVAudioSessionModeDefault;
    
    [GLBAudioSession.shared addObserver:self];
}

- (void)dealloc {
    [GLBAudioSession.shared removeObserver:self];
}

#pragma mark Property

- (NSUInteger)numberOfChannels {
    return _player.numberOfChannels;
}

- (void)setCurrentTime:(NSTimeInterval)currentTime {
    BOOL isPlaying = _player.isPlaying;
    if(isPlaying == YES) {
        [_player stop];
    }
    _player.currentTime = currentTime;
    if(isPlaying == YES) {
        [_player play];
    }
}

- (NSTimeInterval)currentTime {
    return _player.currentTime;
}

- (NSTimeInterval)duration {
    return _player.duration;
}

- (void)setVolume:(CGFloat)volume {
    _player.volume = volume;
}

- (CGFloat)volume {
    return _player.volume;
}

- (void)setPan:(CGFloat)pan {
    _player.pan = pan;
}

- (CGFloat)pan {
    return _player.pan;
}

- (void)setEnableRate:(BOOL)enableRate {
    _player.enableRate = enableRate;
}

- (BOOL)enableRate {
    return _player.enableRate;
}

- (void)setRate:(CGFloat)rate {
    _player.rate = rate;
}

- (CGFloat)rate {
    return _player.rate;
}

- (void)setNumberOfLoops:(NSInteger)numberOfLoops {
    _player.numberOfLoops = numberOfLoops;
}

- (NSInteger)numberOfLoops {
    return _player.numberOfLoops;
}

- (void)setMeteringEnabled:(BOOL)meteringEnabled {
    _player.meteringEnabled = meteringEnabled;
}

- (BOOL)isMeteringEnabled {
    return _player.isMeteringEnabled;
}

- (CGFloat)peakPower {
    CGFloat result = 0.0f;
    if(_prepared == YES) {
        NSUInteger numberOfChannels = _player.numberOfChannels;
        for(NSUInteger channel = 0; channel < numberOfChannels; channel++) {
            result += [_player peakPowerForChannel:channel];
        }
        result /= numberOfChannels;
    }
    return result;
}

- (CGFloat)averagePower {
    CGFloat result = 0.0f;
    if(_prepared == YES) {
        NSUInteger numberOfChannels = _player.numberOfChannels;
        for(NSUInteger channel = 0; channel < numberOfChannels; channel++) {
            result += [_player averagePowerForChannel:channel];
        }
        result /= numberOfChannels;
    }
    return result;
}

#pragma mark Public

- (BOOL)prepareWithData:(NSData*)data {
    if(_prepared == NO) {
        [GLBAudioSession activateWithOptions:_sessionActiveOptions category:_sessionCategory categoryOptions:_sessionCategoryOptions mode:_sessionMode block:^(NSError* error) {
            if(error != nil) {
                _error = error;
                if(_actionError != nil) {
                    [_actionError performWithArguments:@[ self, _error ]];
                }
            } else {
                _player = [[AVAudioPlayer alloc] initWithData:data error:&error];
                if(_player != nil) {
                    _player.delegate = self;
                    if([_player prepareToPlay] == YES) {
                        _prepared = YES;
                        if(_actionPrepared != nil) {
                            [_actionPrepared performWithArguments:@[ self ]];
                        }
                    } else {
                        _player.delegate = nil;
                        _player = nil;
                    }
                } else if(error != nil) {
                    _error = error;
                    if(_actionError != nil) {
                        [_actionError performWithArguments:@[ self, _error ]];
                    }
                }
            }
        }];
    }
    return _prepared;
}

- (BOOL)prepareWithName:(NSString*)name {
    return [self prepareWithPath:NSBundle.mainBundle.resourcePath name:name];
}

- (BOOL)prepareWithPath:(NSString*)path name:(NSString*)name {
    return [self prepareWithURL:[NSURL URLWithString:[path stringByAppendingPathComponent:name]]];
}

- (BOOL)prepareWithURL:(NSURL*)url {
    if(_prepared == NO) {
        [GLBAudioSession activateWithOptions:_sessionActiveOptions category:_sessionCategory categoryOptions:_sessionCategoryOptions mode:_sessionMode block:^(NSError* error) {
            if(error != nil) {
                _error = error;
                if(_actionError != nil) {
                    [_actionError performWithArguments:@[ self, _error ]];
                }
            } else {
                _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
                if(_player != nil) {
                    _player.delegate = self;
                    _error = nil;
                    if([_player prepareToPlay] == YES) {
                        _prepared = YES;
                        _url = url;
                        if(_actionPrepared != nil) {
                            [_actionPrepared performWithArguments:@[ self ]];
                        }
                    } else {
                        _player = nil;
                    }
                } else if(error != nil) {
                    _error = error;
                    if(_actionError != nil) {
                        [_actionError performWithArguments:@[ self, _error ]];
                    }
                }
            }
        }];
    }
    return _prepared;
}

- (void)clean {
    if(_prepared == YES) {
        _prepared = NO;
        _playing = NO;
        _paused = NO;
        if(_player.isPlaying == YES) {
            [_player stop];
        }
        _player = nil;
        if(_actionCleaned != nil) {
            [_actionCleaned performWithArguments:@[ self ]];
        }
    }
}

- (BOOL)play {
    if((_prepared == YES) && (_playing == NO)) {
        if([_player play] == YES) {
            _playing = YES;
            if(_actionPlaying != nil) {
                [_actionPlaying performWithArguments:@[ self ]];
            }
        }
    }
    return _player.isPlaying;
}

- (void)stop {
    if((_prepared == YES) && (_playing == YES)) {
        _playing = NO;
        _paused = NO;
        _player.currentTime = 0.0f;
        [_player stop];
        if(_actionStoped != nil) {
            [_actionStoped performWithArguments:@[ self ]];
        }
    }
}

- (void)resume {
    if((_prepared == YES) && (_playing == YES) && (_paused == YES)) {
        if([_player play] == YES) {
            _paused = NO;
            if(_actionResumed != nil) {
                [_actionResumed performWithArguments:@[ self ]];
            }
        }
    }
}

- (void)pause {
    if((_prepared == YES) && (_playing == YES) && (_paused == NO)) {
        _paused = YES;
        [_player pause];
        if(_actionPaused != nil) {
            [_actionPaused performWithArguments:@[ self ]];
        }
    }
}

- (void)updateMeters {
    if(_prepared == YES) {
        [_player updateMeters];
    }
}

- (CGFloat)peakPowerForChannel:(NSUInteger)channelNumber {
    CGFloat result = 0.0f;
    if(_prepared == YES) {
        result = [_player peakPowerForChannel:channelNumber];
    }
    return result;
}

- (CGFloat)averagePowerForChannel:(NSUInteger)channelNumber {
    CGFloat result = 0.0f;
    if(_prepared == YES) {
        result = [_player averagePowerForChannel:channelNumber];
    }
    return result;
}

#pragma mark - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer* __unused)player successfully:(BOOL __unused)successfully {
    _playing = NO;
    if(_actionFinished != nil) {
        [_actionFinished performWithArguments:@[ self ]];
    }
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer* __unused)player error:(NSError*)error {
    _error = error;
    if(_actionError != nil) {
        [_actionError performWithArguments:@[ self, _error ]];
    }
}

#pragma mark -  GLBAudioSessionObserver < NSObject >

- (void)audioSessionEndInterruptionWithFlags:(NSUInteger)flags {
    if((flags & AVAudioSessionInterruptionFlags_ShouldResume) != 0) {
        if((_prepared == YES) && (_playing == YES) && (_paused == NO)) {
            [_player play];
        }
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
