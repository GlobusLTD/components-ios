/*--------------------------------------------------*/

#import "GLBAudioSession.h"
#import "GLBAction.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBAudioPlayer;

/*--------------------------------------------------*/

typedef void(^GLBAudioPlayerBlock)(GLBAudioPlayer* _Nonnull audioPlayer);
typedef void(^GLBAudioPlayerErrorBlock)(GLBAudioPlayer* _Nonnull audioPlayer, NSError* _Nonnull error);

/*--------------------------------------------------*/

@interface GLBAudioPlayer : NSObject

@property(nonatomic) AVAudioSessionSetActiveOptions sessionActiveOptions;
@property(nonatomic, nonnull, strong) NSString* sessionCategory;
@property(nonatomic) AVAudioSessionCategoryOptions sessionCategoryOptions;
@property(nonatomic, nonnull, strong) NSString* sessionMode;

@property(nonatomic, nullable, readonly, strong) NSURL* url;
@property(nonatomic, nullable, readonly, strong) NSError* error;

@property(nonatomic, readonly) NSUInteger numberOfChannels;
@property(nonatomic) NSTimeInterval currentTime;
@property(nonatomic, readonly) NSTimeInterval duration;
@property(nonatomic) CGFloat volume;
@property(nonatomic) CGFloat pan;
@property(nonatomic) BOOL enableRate;
@property(nonatomic) CGFloat rate;
@property(nonatomic) NSInteger numberOfLoops;
@property(nonatomic, getter=isMeteringEnabled) BOOL meteringEnabled;
@property(nonatomic, readonly) CGFloat peakPower;
@property(nonatomic, readonly) CGFloat averagePower;

@property(nonatomic, readonly, getter=isPrepared) BOOL prepared;
@property(nonatomic, readonly, getter=isPlaying) BOOL playing;
@property(nonatomic, readonly, getter=isPaused) BOOL paused;

@property(nonatomic, nullable, copy) GLBAudioPlayerBlock blockPrepared;
@property(nonatomic, nullable, copy) GLBAudioPlayerBlock blockCleaned;
@property(nonatomic, nullable, copy) GLBAudioPlayerBlock blockPlaying;
@property(nonatomic, nullable, copy) GLBAudioPlayerBlock blockStoped;
@property(nonatomic, nullable, copy) GLBAudioPlayerBlock blockFinished;
@property(nonatomic, nullable, copy) GLBAudioPlayerBlock blockResumed;
@property(nonatomic, nullable, copy) GLBAudioPlayerBlock blockPaused;
@property(nonatomic, nullable, copy) GLBAudioPlayerErrorBlock blockError;

@property(nonatomic, nullable, strong) GLBAction* actionPrepared;
@property(nonatomic, nullable, strong) GLBAction* actionCleaned;
@property(nonatomic, nullable, strong) GLBAction* actionPlaying;
@property(nonatomic, nullable, strong) GLBAction* actionStoped;
@property(nonatomic, nullable, strong) GLBAction* actionFinished;
@property(nonatomic, nullable, strong) GLBAction* actionResumed;
@property(nonatomic, nullable, strong) GLBAction* actionPaused;
@property(nonatomic, nullable, strong) GLBAction* actionError;

- (void)setup NS_REQUIRES_SUPER;

- (BOOL)prepareWithData:(nonnull NSData*)data;
- (BOOL)prepareWithName:(nonnull NSString*)name;
- (BOOL)prepareWithPath:(nonnull NSString*)path name:(nonnull NSString*)name;
- (BOOL)prepareWithURL:(nonnull NSURL*)url;
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
