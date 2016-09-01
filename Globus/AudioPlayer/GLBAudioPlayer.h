/*--------------------------------------------------*/

#import "GLBAudioSession.h"
#import "GLBAction.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import <AVFoundation/AVFoundation.h>

/*--------------------------------------------------*/

@class GLBAction;

/*--------------------------------------------------*/

@interface GLBAudioPlayer : NSObject

@property(nonatomic) AVAudioSessionSetActiveOptions sessionActiveOptions;
@property(nonatomic, strong) NSString* sessionCategory;
@property(nonatomic) AVAudioSessionCategoryOptions sessionCategoryOptions;
@property(nonatomic, strong) NSString* sessionMode;

@property(nonatomic, readonly, strong) NSURL* url;
@property(nonatomic, readonly, strong) NSError* error;

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

@property(nonatomic, strong) GLBAction* actionPrepared;
@property(nonatomic, strong) GLBAction* actionCleaned;
@property(nonatomic, strong) GLBAction* actionPlaying;
@property(nonatomic, strong) GLBAction* actionStoped;
@property(nonatomic, strong) GLBAction* actionFinished;
@property(nonatomic, strong) GLBAction* actionResumed;
@property(nonatomic, strong) GLBAction* actionPaused;
@property(nonatomic, strong) GLBAction* actionError;

- (void)setup NS_REQUIRES_SUPER;

- (BOOL)prepareWithData:(NSData*)data;
- (BOOL)prepareWithName:(NSString*)name;
- (BOOL)prepareWithPath:(NSString*)path name:(NSString*)name;
- (BOOL)prepareWithURL:(NSURL*)url;
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
