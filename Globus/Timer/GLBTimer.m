/*--------------------------------------------------*/

#import "GLBTimer.h"

/*--------------------------------------------------*/

@interface GLBTimer () {
    NSDate* _startDelayDate;
    NSDate* _startDate;
    NSDate* _pauseDate;
    NSUInteger _repeated;
    NSTimer* _timer;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBTimer

#pragma mark Init / Free

+ (instancetype)timerWithInterval:(NSTimeInterval)interval {
    return [[self alloc] initWithInterval:interval];
}

+ (instancetype)timerWithInterval:(NSTimeInterval)interval repeat:(NSUInteger)repeat {
    return [[self alloc] initWithInterval:interval repeat:repeat];
}

+ (instancetype)timerWithInterval:(NSTimeInterval)interval delay:(NSTimeInterval)delay repeat:(NSUInteger)repeat {
    return [[self alloc] initWithInterval:interval delay:delay repeat:repeat];
}

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithInterval:(NSTimeInterval)interval {
    return [self initWithInterval:interval delay:0 repeat:0];
}

- (instancetype)initWithInterval:(NSTimeInterval)interval repeat:(NSUInteger)repeat {
    return [self initWithInterval:interval delay:0 repeat:repeat];
}

- (instancetype)initWithInterval:(NSTimeInterval)interval delay:(NSTimeInterval)delay repeat:(NSUInteger)repeat {
    self = [super init];
    if(self != nil) {
        _interval = interval;
        _repeat = repeat;
        _delay = delay;
        [self setup];
    }
    return self;
}

- (void)setup {
}

- (void)dealloc {
    [self stop];
}

#pragma mark Public

- (void)start {
    if(_started == NO) {
        _started = YES;
        _paused = NO;
        if(_delay > DBL_EPSILON) {
            _startDate = [NSDate.date dateByAddingTimeInterval:_delay];
            _delaying = YES;
        } else {
            _startDate = [NSDate.date dateByAddingTimeInterval:_interval];
            _delaying = NO;
        }
        _pauseDate = nil;
        _repeated = 0;
        _timer = [[NSTimer alloc] initWithFireDate:_startDate
                                          interval:_interval
                                            target:self
                                          selector:@selector(timerHandler)
                                          userInfo:nil
                                           repeats:((_delaying == YES) || (_repeat != 0))];
        if(_timer != nil) {
            if(_delaying == NO) {
                if(_blockStarted != nil) {
                    _blockStarted(self);
                }
                if(_actionStarted != nil) {
                    [_actionStarted performWithArguments:@[ self ]];
                }
            }
            [NSRunLoop.mainRunLoop addTimer:_timer forMode:NSRunLoopCommonModes];
        }
    }
}

- (void)stop {
    if(_started == YES) {
        _delaying = NO;
        _started = NO;
        _paused = NO;
        _startDate = nil;
        _pauseDate = nil;
        _repeated = 0;
        if(_timer != nil) {
            [_timer invalidate];
            _timer = nil;
        }
        if(_blockStoped != nil) {
            _blockStoped(self);
        }
        if(_actionStoped != nil) {
            [_actionStoped performWithArguments:@[ self ]];
        }
    }
}

- (void)pause {
    if((_started == YES) && (_paused == NO)) {
        _paused = YES;
        _pauseDate = NSDate.date;
        if(_timer != nil) {
            [_timer invalidate];
            _timer = nil;
        }
        if(_blockPaused != nil) {
            _blockPaused(self);
        }
        if(_actionPaused != nil) {
            [_actionPaused performWithArguments:@[ self ]];
        }
    }
}

- (void)resume {
    if((_started == YES) && (_paused == YES)) {
        _paused = NO;
        
        _startDate = [_startDate dateByAddingTimeInterval:(NSDate.date.timeIntervalSince1970 - _pauseDate.timeIntervalSince1970)];
        _pauseDate = nil;
        _timer = [[NSTimer alloc] initWithFireDate:_startDate
                                          interval:_interval
                                            target:self
                                          selector:@selector(timerHandler)
                                          userInfo:nil
                                           repeats:(_repeat != 0)];
        if(_timer != nil) {
            if(_blockResumed != nil) {
                _blockResumed(self);
            }
            if(_actionResumed != nil) {
                [_actionResumed performWithArguments:@[ self ]];
            }
            [NSRunLoop.mainRunLoop addTimer:_timer forMode:NSRunLoopCommonModes];
        }
    }
}

- (void)restart {
    if(_started == YES) {
        [self stop];
        [self start];
    }
}

#pragma mark Property

- (void)setInterval:(NSTimeInterval)interval {
    if((_started == NO) && (_interval != interval)) {
        _interval = interval;
    }
}

- (void)setRepeat:(NSUInteger)repeat {
    if((_started == NO) && (_repeat != repeat)) {
        _repeat = repeat;
    }
}

- (void)setDelay:(NSTimeInterval)delay {
    if((_started == NO) && (_delay != delay)) {
        _delay = delay;
    }
}

- (NSTimeInterval)duration {
    if(_repeat != 0) {
        if(_repeat == NSNotFound) {
            return DBL_MAX;
        } else {
            return _interval * _repeat;
        }
    }
    return _interval;
}

- (NSTimeInterval)elapsed {
    if(_startDate != nil) {
        return [NSDate.date timeIntervalSinceDate:_startDate];
    }
    return 0.0;
}

#pragma mark Private

- (void)timerHandler {
    if(_delaying == YES) {
        _delaying = NO;
        if(_blockStarted != nil) {
            _blockStarted(self);
        }
        if(_actionStarted != nil) {
            [_actionStarted performWithArguments:@[ self ]];
        }
    } else {
        BOOL finished = NO;
        _repeated++;
        if(_repeat == NSNotFound) {
            if(_blockRepeat != nil) {
                _blockRepeat(self);
            }
            [_actionRepeat performWithArguments:@[ self ]];
        } else if(_repeat != 0) {
            if(_blockRepeat != nil) {
                _blockRepeat(self);
            }
            [_actionRepeat performWithArguments:@[ self ]];
            if(_repeated >= _repeat) {
                finished = YES;
            }
        } else {
            finished = YES;
        }
        if(finished == YES) {
            _started = NO;
            _paused = NO;
            if(_timer != nil) {
                [_timer invalidate];
                _timer = nil;
            }
            if(_blockFinished != nil) {
                _blockFinished(self);
            }
            if(_actionFinished != nil) {
                [_actionFinished performWithArguments:@[ self ]];
            }
        }
    }
}

@end

/*--------------------------------------------------*/
