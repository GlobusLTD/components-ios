/*--------------------------------------------------*/

#import "GLBDataSource+Private.h"

/*--------------------------------------------------*/

@implementation GLBDataSource

#pragma mark - Synthesize

@synthesize updating = _updating;
@synthesize error = _error;

#pragma mark - Init / Free

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
}

- (void)dealloc {
    [self _cancel];
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

#pragma mark - Public

- (void)load {
    [self _load];
}

- (void)reset {
    [self _reset];
}

- (void)cancel {
    [self _cancel];
}

#pragma mark - Private

- (void)_load {
    if([self _shouldUpdate] == YES) {
        [self _startUpdating];
    } else {
        [self _finishUpdating];
    }
}

- (void)_reset {
}

- (void)_cancel {
}

- (BOOL)_shouldUpdate {
    return NO;
}

- (void)_startUpdating {
    _updating = YES;
}

- (void)_finishUpdating {
    _updating = NO;
}

@end

/*--------------------------------------------------*/
