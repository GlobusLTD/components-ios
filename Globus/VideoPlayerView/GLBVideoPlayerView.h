/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/

@class GLBAction;

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

@property(nonatomic, readonly, copy) NSURL* url;
@property(nonatomic, readonly, assign) CGFloat buffer;
@property(nonatomic, readonly, assign) CGFloat rate;
@property(nonatomic, readonly, assign) CGFloat duration;

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
@property(nonatomic, strong) GLBAction* actionUpdateBuffer;
@property(nonatomic, strong) GLBAction* actionUpdateRate;

- (void)prepareWithURL:(NSURL*)url;
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
