/*--------------------------------------------------*/

#import "GLBVideoPlayerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

static NSString* GLBVideoPlayerViewItemStatusKeyPath = @"status";
static NSString* GLBVideoPlayerViewItemRateKeyPath = @"rate";
static NSString* GLBVideoPlayerViewItemLoadedTimeRangesKeyPath = @"loadedTimeRanges";

/*--------------------------------------------------*/

@interface GLBVideoPlayerView ()

@property(nonatomic, strong) AVPlayerItem* playerItem;
@property(nonatomic, strong) id playerObserver;

@end

/*--------------------------------------------------*/

@implementation GLBVideoPlayerView

#pragma mark - Init

@synthesize player = _player;
@synthesize playerLayer = _playerLayer;

#pragma mark - Init / Free

- (instancetype)initWithCoder:(NSCoder*)coder {
    self = [super initWithCoder:coder];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.clipsToBounds = YES;
    
    _displayMode = GLBVideoPlayerViewDisplayModeAspectFit;
}

- (void)dealloc {
    self.playerItem = nil;
}

#pragma mark - UIView

- (void)didMoveToWindow {
    [super didMoveToWindow];
    
    if(self.window != nil) {
        [self.layer addSublayer:self.playerLayer];
    } else {
        [self.playerLayer removeFromSuperlayer];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if(_playerLayer != nil) {
        _playerLayer.frame = self.bounds;
    }
}

#pragma mark - Property

- (AVPlayer*)player {
    if(_player == nil) {
        _player = [AVPlayer new];
    }
    return _player;
}

- (AVPlayerLayer*)playerLayer {
    if(_playerLayer == nil) {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _playerLayer.frame = self.bounds;
        _playerLayer.videoGravity = [self.class _videoGravityFromDisplayMode:_displayMode];
    }
    return _playerLayer;
}

- (void)setPlayerItem:(AVPlayerItem*)playerItem {
    if(_playerItem != playerItem) {
        if(_playerItem != nil) {
            [self.player removeTimeObserver:_playerObserver];
            [_playerItem removeObserver:self
                             forKeyPath:GLBVideoPlayerViewItemLoadedTimeRangesKeyPath];
            [_playerItem removeObserver:self
                             forKeyPath:GLBVideoPlayerViewItemRateKeyPath];
            [_playerItem removeObserver:self
                             forKeyPath:GLBVideoPlayerViewItemStatusKeyPath];
            [NSNotificationCenter.defaultCenter removeObserver:self
                                                          name:AVPlayerItemDidPlayToEndTimeNotification
                                                        object:_playerItem];
        }
        _playerItem = playerItem;
        if(_playerItem != nil) {
            __weak typeof(self) weakSelf = self;
            [NSNotificationCenter.defaultCenter addObserver:self
                                                   selector:@selector(_notificationDidPlayToEndTime)
                                                       name:AVPlayerItemDidPlayToEndTimeNotification
                                                     object:_playerItem];
            [_playerItem addObserver:self
                          forKeyPath:GLBVideoPlayerViewItemStatusKeyPath
                             options:NSKeyValueObservingOptionNew
                             context:NULL];
            [_playerItem addObserver:self
                          forKeyPath:GLBVideoPlayerViewItemRateKeyPath
                             options:NSKeyValueObservingOptionNew
                             context:NULL];
            [_playerItem addObserver:self
                          forKeyPath:GLBVideoPlayerViewItemLoadedTimeRangesKeyPath
                             options:NSKeyValueObservingOptionNew
                             context:NULL];
            [self.player replaceCurrentItemWithPlayerItem:_playerItem];
            _playerObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_global_queue(0, 0) usingBlock:^(CMTime time) {
                [weakSelf _notificationPeriodicTime:time];
            }];
        }
    }
}

- (void)setDisplayMode:(GLBVideoPlayerViewDisplayMode)displayMode {
    if(_displayMode != displayMode) {
        _displayMode = displayMode;
        if(_playerLayer != nil) {
            _playerLayer.videoGravity = [self.class _videoGravityFromDisplayMode:_displayMode];
        }
    }
}

- (void)setMuted:(BOOL)muted {
    self.player.muted = muted;
}

- (BOOL)isMuted {
    return self.player.isMuted;
}

- (void)setVolume:(CGFloat)volume {
    self.player.volume = (float)volume;
}

- (CGFloat)volume {
    return self.player.volume;
}

#pragma mark - Public

- (void)prepareWithItem:(AVPlayerItem*)item {
    if(_prepared == NO) {
        self.playerItem = [item copy];
    }
}

- (void)prepareWithURL:(NSURL*)url {
    if(_prepared == NO) {
        self.playerItem = [[AVPlayerItem alloc] initWithURL:url];
        if(_playerItem != nil) {
            _url = url.copy;
        }
    }
}

- (void)clean {
    if(_prepared == YES) {
        _url = nil;
        _prepared = NO;
        _playing = NO;
        _paused = NO;
        _buffer = 0.0;
        _rate = 0.0;
        self.playerItem = nil;
        if(_actionCleaned != nil) {
            [_actionCleaned performWithArguments:@[ self ]];
        }
    }
}

- (void)play {
    if((_prepared == YES) && (_playing == NO)) {
        _playing = YES;
        [self.player play];
        if(_actionPlaying != nil) {
            [_actionPlaying performWithArguments:@[ self ]];
        }
    }
}

- (void)seek:(CGFloat)to {
    if((_prepared == YES) && (_playing == YES) && (_paused == NO)) {
        Float64 seconds = CMTimeGetSeconds(self.playerItem.asset.duration);
        [self.player seekToTime:CMTimeMake((int64_t)GLB_CEIL(seconds * to), 1)];
    }
}

- (void)stop {
    if((_prepared == YES) && (_playing == YES)) {
        _playing = NO;
        _paused = NO;
        [self.player seekToTime:CMTimeMake(0, 1)];
        [self.player pause];
        if(_actionStoped != nil) {
            [_actionStoped performWithArguments:@[ self ]];
        }
    }
}

- (void)resume {
    if((_prepared == YES) && (_playing == YES) && (_paused == YES)) {
        _paused = NO;
        [self.player play];
        if(_actionResumed != nil) {
            [_actionResumed performWithArguments:@[ self ]];
        }
    }
}

- (void)pause {
    if((_prepared == YES) && (_playing == YES) && (_paused == NO)) {
        _paused = YES;
        [self.player pause];
        if(_actionPaused != nil) {
            [_actionPaused performWithArguments:@[ self ]];
        }
    }
}

#pragma mark - Private

+ (NSString*)_videoGravityFromDisplayMode:(GLBVideoPlayerViewDisplayMode)displayMode {
    switch(displayMode) {
        case GLBVideoPlayerViewDisplayModeAspectFit: return AVLayerVideoGravityResizeAspect;
        case GLBVideoPlayerViewDisplayModeAspectFill: return AVLayerVideoGravityResizeAspectFill;
    }
}

#pragma mark - Notification

- (void)_notificationPeriodicTime:(CMTime)time {
    if(CMTIME_IS_INDEFINITE(_playerItem.duration) == NO) {
        _rate = (CGFloat)(CMTimeGetSeconds(time) / CMTimeGetSeconds(_playerItem.duration));
        if(_actionUpdateRate != nil) {
            [_actionUpdateRate performWithArguments:@[ self ]];
        }
    }
}

- (void)_notificationDidPlayToEndTime {
    _rate = 1.0;
    _buffer = 1.0;
    if(_actionFinished != nil) {
        [_actionFinished performWithArguments:@[ self ]];
    }
}

#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if([keyPath isEqualToString:GLBVideoPlayerViewItemStatusKeyPath] == YES) {
        AVPlayerStatus status = [change[NSKeyValueChangeNewKey] integerValue];
        if(status == AVPlayerStatusReadyToPlay) {
            _prepared = YES;
            _duration = (CGFloat)CMTimeGetSeconds(_playerItem.asset.duration);
            if(_actionPrepared != nil) {
                [_actionPrepared performWithArguments:@[ self ]];
            }
        } else if(status == AVPlayerStatusFailed) {
            if(_actionError != nil) {
                [_actionError performWithArguments:@[ self ]];
            }
        }
    } else if([keyPath isEqualToString:GLBVideoPlayerViewItemLoadedTimeRangesKeyPath] == YES) {
        if(CMTIME_IS_INDEFINITE(_playerItem.duration) == NO) {
            CMTimeRange timeRange = [_playerItem.loadedTimeRanges.firstObject CMTimeRangeValue];
            Float64 duration = CMTimeGetSeconds(_playerItem.asset.duration);
            Float64 current = CMTimeGetSeconds(timeRange.duration);
            _buffer = (CGFloat)(current / duration);
            if(_actionUpdateBuffer != nil) {
                [_actionUpdateBuffer performWithArguments:@[ self ]];
            }
        }
    } else if([keyPath isEqualToString:GLBVideoPlayerViewItemRateKeyPath] == YES) {
        _rate = [change[NSKeyValueChangeNewKey] floatValue];
        if(_actionUpdateRate != nil) {
            [_actionUpdateRate performWithArguments:@[ self ]];
        }
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
