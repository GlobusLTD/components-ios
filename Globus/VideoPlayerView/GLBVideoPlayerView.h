/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/

#import "GLBAction.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import <AVFoundation/AVFoundation.h>

/*--------------------------------------------------*/

@class GLBVideoPlayerView;

/*--------------------------------------------------*/

typedef void(^GLBVideoPlayerViewBlock)(GLBVideoPlayerView* _Nonnull videoPlayerView);
typedef void(^GLBVideoPlayerViewFloatBlock)(GLBVideoPlayerView* _Nonnull videoPlayerView, CGFloat value);

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
@property(nonatomic, readonly) CGFloat buffer;
@property(nonatomic, readonly) CGFloat rate;
@property(nonatomic, readonly) CGFloat duration;

@property(nonatomic, readonly, getter=isPrepared) BOOL prepared;
@property(nonatomic, readonly, getter=isPlaying) BOOL playing;
@property(nonatomic, readonly, getter=isPaused) BOOL paused;

@property(nonatomic, nullable, copy) GLBVideoPlayerViewBlock blockPrepared;
@property(nonatomic, nullable, strong) GLBAction* actionPrepared;

@property(nonatomic, nullable, copy) GLBVideoPlayerViewBlock blockCleaned;
@property(nonatomic, nullable, strong) GLBAction* actionCleaned;

@property(nonatomic, nullable, copy) GLBVideoPlayerViewBlock blockPlaying;
@property(nonatomic, nullable, strong) GLBAction* actionPlaying;

@property(nonatomic, nullable, copy) GLBVideoPlayerViewBlock blockStoped;
@property(nonatomic, nullable, strong) GLBAction* actionStoped;

@property(nonatomic, nullable, copy) GLBVideoPlayerViewBlock blockFinished;
@property(nonatomic, nullable, strong) GLBAction* actionFinished;

@property(nonatomic, nullable, copy) GLBVideoPlayerViewBlock blockResumed;
@property(nonatomic, nullable, strong) GLBAction* actionResumed;

@property(nonatomic, nullable, copy) GLBVideoPlayerViewBlock blockPaused;
@property(nonatomic, nullable, strong) GLBAction* actionPaused;

@property(nonatomic, nullable, copy) GLBVideoPlayerViewBlock blockError;
@property(nonatomic, nullable, strong) GLBAction* actionError;

@property(nonatomic, nullable, copy) GLBVideoPlayerViewFloatBlock blockUpdateBuffer;
@property(nonatomic, nullable, strong) GLBAction* actionUpdateBuffer;

@property(nonatomic, nullable, copy) GLBVideoPlayerViewFloatBlock blockUpdateRate;
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
