/*--------------------------------------------------*/

#import "GLBAudioSession.h"
#import "GLBAction.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBAudioPlayer : NSObject

@property(nonatomic) AVAudioSessionSetActiveOptions sessionActiveOptions;
@property(nonatomic, nonnull, strong) NSString* sessionCategory;
@property(nonatomic) AVAudioSessionCategoryOptions sessionCategoryOptions;
@property(nonatomic, nonnull, strong) NSString* sessionMode;

@property(nonatomic, nullable, readonly, strong) NSURL* url;
@property(nonatomic, nullable, readonly, strong) NSError* error;

@property(nonatomic, readonly, assign) NSUInteger numberOfChannels;
@property(nonatomic) NSTimeInterval currentTime;
@property(nonatomic, readonly, assign) NSTimeInterval duration;
@property(nonatomic) CGFloat volume;
@property(nonatomic) CGFloat pan;
@property(nonatomic) BOOL enableRate;
@property(nonatomic) CGFloat rate;
@property(nonatomic) NSInteger numberOfLoops;
@property(nonatomic, getter=isMeteringEnabled) BOOL meteringEnabled;
@property(nonatomic, readonly, assign) CGFloat peakPower;
@property(nonatomic, readonly, assign) CGFloat averagePower;

@property(nonatomic, readonly, assign, getter=isPrepared) BOOL prepared;
@property(nonatomic, readonly, assign, getter=isPlaying) BOOL playing;
@property(nonatomic, readonly, assign, getter=isPaused) BOOL paused;

@property(nonatomic, nullable, strong) GLBAction* actionPrepared;
@property(nonatomic, nullable, strong) GLBAction* actionCleaned;
@property(nonatomic, nullable, strong) GLBAction* actionPlaying;
@property(nonatomic, nullable, strong) GLBAction* actionStoped;
@property(nonatomic, nullable, strong) GLBAction* actionFinished;
@property(nonatomic, nullable, strong) GLBAction* actionResumed;
@property(nonatomic, nullable, strong) GLBAction* actionPaused;
@property(nonatomic, nullable, strong) GLBAction* actionError;

- (void)setup NS_REQUIRES_SUPER;

- (BOOL)prepareWithData:(NSData* _Nonnull)data;
- (BOOL)prepareWithName:(NSString* _Nonnull)name;
- (BOOL)prepareWithPath:(NSString* _Nonnull)path name:(NSString* _Nonnull)name;
- (BOOL)prepareWithURL:(NSURL* _Nonnull)url;
- (void)clean;

- (BOOL)play;
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
