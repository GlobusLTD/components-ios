/*--------------------------------------------------*/

#import "GLBAudioRecorder.h"
#import "GLBAudioSession.h"
#import "GLBAction.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBAudioRecorder () < AVAudioRecorderDelegate > {
    AVAudioRecorder* _recorder;
    BOOL _waitFinished;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBAudioRecorder

#pragma mark Synthesize

@synthesize duration = _duration;

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
    _sessionCategory = AVAudioSessionCategoryRecord;
    _sessionCategoryOptions = AVAudioSessionCategoryOptionDefaultToSpeaker;
    _sessionMode = AVAudioSessionModeDefault;
    
    _format = kAudioFormatAppleIMA4;
    _quality = AVAudioQualityMin;
    _sampleRate = 44100.0;
    _numberOfChannels = 1;
    _bitRate = 12800.0;
}

#pragma mark Property

- (BOOL)isRecording {
    return _recorder.isRecording;
}

- (NSURL*)url {
    return _recorder.url;
}

- (NSTimeInterval)duration {
    if(_recorder.isRecording == YES) {
        _duration = _recorder.currentTime;
    }
    return _duration;
}

- (void)setMeteringEnabled:(BOOL)meteringEnabled {
    _recorder.meteringEnabled = meteringEnabled;
}

- (BOOL)isMeteringEnabled {
    return _recorder.isMeteringEnabled;
}

- (CGFloat)peakPower {
    CGFloat result = 0.0;
    if(_prepared == YES) {
        for(NSUInteger channel = 0; channel < _numberOfChannels; channel++) {
            result += [_recorder peakPowerForChannel:channel];
        }
        result /= _numberOfChannels;
    }
    return result;
}

- (CGFloat)averagePower {
    CGFloat result = 0.0;
    if(_prepared == YES) {
        for(NSUInteger channel = 0; channel < _numberOfChannels; channel++) {
            result += [_recorder averagePowerForChannel:channel];
        }
        result /= _numberOfChannels;
    }
    return result;
}

#pragma mark Public

- (BOOL)prepareWithName:(NSString*)name {
    return [self prepareWithPath:NSFileManager.glb_documentDirectory name:name];
}

- (BOOL)prepareWithPath:(NSString*)path name:(NSString*)name {
    return [self prepareWithUrl:[NSURL URLWithString:[path stringByAppendingPathComponent:name]]];
}

- (BOOL)prepareWithUrl:(NSURL*)url {
    if(_prepared == NO) {
        [GLBAudioSession recordPermission:^{
            [GLBAudioSession activateWithOptions:_sessionActiveOptions category:_sessionCategory categoryOptions:_sessionCategoryOptions mode:_sessionMode block:^(NSError* error) {
                if(_error != nil) {
                    _error = error;
                    if(_actionError != nil) {
                        [_actionError performWithArguments:@[ self, _error ]];
                    }
                } else {
                    _recorder = [[AVAudioRecorder alloc] initWithURL:url settings:self._recorderSettings error:&error];
                    if(_recorder != nil) {
                        if([_recorder prepareToRecord] == YES) {
                            _recorder.delegate = self;
                            _prepared = YES;
                            if(_actionPrepared != nil) {
                                [_actionPrepared performWithArguments:@[ self, _error ]];
                            }
                        } else {
                            _recorder.delegate = nil;
                            _recorder = nil;
                        }
                    } else if(error != nil) {
                        _error = error;
                        if(_actionError != nil) {
                            [_actionError performWithArguments:@[ self, _error ]];
                        }
                    }
                }
            }];
        }];
    }
    return _prepared;
}

- (void)clean {
    if(_prepared == YES) {
        _waitFinished = YES;
        _prepared = NO;
        _duration = _recorder.currentTime;
        if(_recorder.isRecording == YES) {
            [_recorder stop];
        }
        _recorder = nil;
        if(_actionCleaned != nil) {
            [_actionCleaned performWithArguments:@[ self ]];
        }
    }
}

- (BOOL)start {
    if((_prepared == YES) && (_started == NO)) {
        if([_recorder record] == YES) {
            _started = YES;
            if(_actionStarted != nil) {
                [_actionStarted performWithArguments:@[ self ]];
            }
        }
    }
    return _started;
}

- (void)stop {
    if((_prepared == YES) && (_started == YES) && (_waitFinished == NO)) {
        _duration = _recorder.currentTime;
        _waitFinished = YES;
        [_recorder stop];
        if(_actionStoped != nil) {
            [_actionStoped performWithArguments:@[ self ]];
        }
    }
}

- (void)pause {
    if((_prepared == YES) && (_started == YES) && (_paused == NO)) {
        _paused = YES;
        _duration = _recorder.currentTime;
        [_recorder pause];
        if(_actionPaused != nil) {
            [_actionPaused performWithArguments:@[ self ]];
        }
    }
}

- (void)resume {
    if((_prepared == YES) && (_started == YES) && (_paused == YES)) {
        _paused = NO;
        [_recorder record];
        if(_actionResumed != nil) {
            [_actionResumed performWithArguments:@[ self ]];
        }
    }
}

- (void)updateMeters {
    if(_prepared == YES) {
        [_recorder updateMeters];
    }
}

- (CGFloat)peakPowerForChannel:(NSUInteger)channelNumber {
    CGFloat result = 0.0;
    if(_prepared == YES) {
        result = [_recorder peakPowerForChannel:channelNumber];
    }
    return result;
}

- (CGFloat)averagePowerForChannel:(NSUInteger)channelNumber {
    CGFloat result = 0.0;
    if(_prepared == YES) {
        result = [_recorder averagePowerForChannel:channelNumber];
    }
    return result;
}

#pragma mark Private

- (NSDictionary*)_recorderSettings {
    return @{
        AVFormatIDKey: @(_format),
        AVEncoderAudioQualityKey : @(_quality),
        AVEncoderBitRateKey : @(_bitRate),
        AVNumberOfChannelsKey : @(_numberOfChannels),
        AVSampleRateKey : @(_sampleRate),
    };
}

#pragma mark AVAudioRecorderDelegate

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder*)recorder successfully:(BOOL)successfully {
    _waitFinished = NO;
    _started = NO;
    _paused = NO;
    if(_actionFinished != nil) {
        [_actionFinished performWithArguments:@[ self ]];
    }
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder*)recorder error:(NSError*)error {
    _error = error;
    if(_actionError != nil) {
        [_actionError performWithArguments:@[ self, _error ]];
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
