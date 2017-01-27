/*--------------------------------------------------*/

#import "NSFileManager+GLBNS.h"
#import "GLBAudioSession.h"
#import "GLBAction.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBAudioRecorder : NSObject

@property(nonatomic) AVAudioSessionSetActiveOptions sessionActiveOptions;
@property(nonatomic, nonnull, strong) NSString* sessionCategory;
@property(nonatomic) AVAudioSessionCategoryOptions sessionCategoryOptions;
@property(nonatomic, nonnull, strong) NSString* sessionMode;

@property(nonatomic) AudioFormatID format;
@property(nonatomic) AVAudioQuality quality;
@property(nonatomic) NSUInteger bitRate;
@property(nonatomic) NSUInteger numberOfChannels;
@property(nonatomic) CGFloat sampleRate;
@property(nonatomic, nullable, readonly, strong) NSURL* url;
@property(nonatomic, nullable, readonly, strong) NSError* error;

@property(nonatomic, readonly, assign) NSTimeInterval duration;
@property(nonatomic, getter=isMeteringEnabled) BOOL meteringEnabled;
@property(nonatomic, readonly, assign) CGFloat peakPower;
@property(nonatomic, readonly, assign) CGFloat averagePower;

@property(nonatomic, readonly, assign, getter=isPrepared) BOOL prepared;
@property(nonatomic, readonly, assign, getter=isStarted) BOOL started;
@property(nonatomic, readonly, assign, getter=isRecording) BOOL recording;
@property(nonatomic, readonly, assign, getter=isPaused) BOOL paused;

@property(nonatomic, nullable, strong) GLBAction* actionPrepared;
@property(nonatomic, nullable, strong) GLBAction* actionCleaned;
@property(nonatomic, nullable, strong) GLBAction* actionStarted;
@property(nonatomic, nullable, strong) GLBAction* actionStoped;
@property(nonatomic, nullable, strong) GLBAction* actionFinished;
@property(nonatomic, nullable, strong) GLBAction* actionResumed;
@property(nonatomic, nullable, strong) GLBAction* actionPaused;
@property(nonatomic, nullable, strong) GLBAction* actionError;

- (void)setup NS_REQUIRES_SUPER;

- (BOOL)prepareWithName:(nonnull NSString*)name;
- (BOOL)prepareWithPath:(nonnull NSString*)path name:(nonnull NSString*)name;
- (BOOL)prepareWithUrl:(nonnull NSURL*)url;
- (void)clean;

- (BOOL)start;
- (void)stop;

- (void)resume;
- (void)pause;

- (void)updateMeters;

- (CGFloat)peakPowerForChannel:(NSUInteger)channelNumber;
- (CGFloat)averagePowerForChannel:(NSUInteger)channelNumber;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
