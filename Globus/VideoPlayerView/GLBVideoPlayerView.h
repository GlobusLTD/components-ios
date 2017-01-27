/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/

#import "GLBAction.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import <AVFoundation/AVFoundation.h>

/*--------------------------------------------------*/

typedef NS_ENUM(NSInteger, GLBVideoPlayerViewDisplayMode) {
    GLBVideoPlayerViewDisplayModeAspectFit,
    GLBVideoPlayerViewDisplayModeAspectFill
};

/*--------------------------------------------------*/

@interface GLBVideoPlayerView : UIView

@property(nonatomic) GLBVideoPlayerViewDisplayMode displayMode;
@property(nonatomic, getter=isMuted) BOOL muted;
@property(nonatomic) CGFloat volume;

@property(nonatomic, nonnull, readonly, strong) AVPlayer* player;
@property(nonatomic, nonnull, readonly, strong) AVPlayerLayer* playerLayer;
@property(nonatomic, nullable, readonly, strong) AVPlayerItem* playerItem;

@property(nonatomic, nullable, readonly, copy) NSURL* url;
@property(nonatomic, readonly, assign) CGFloat buffer;
@property(nonatomic, readonly, assign) CGFloat rate;
@property(nonatomic, readonly, assign) CGFloat duration;

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
@property(nonatomic, nullable, strong) GLBAction* actionUpdateBuffer;
@property(nonatomic, nullable, strong) GLBAction* actionUpdateRate;

- (void)setup NS_REQUIRES_SUPER;

- (void)prepareWithItem:(nonnull AVPlayerItem*)item;
- (void)prepareWithURL:(nonnull NSURL*)url;
- (void)clean;

- (void)play;
- (void)seek:(CGFloat)to;
- (void)stop;

- (void)resume;
- (void)pause;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
