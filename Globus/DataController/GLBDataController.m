/*--------------------------------------------------*/

#import "GLBDataController+Private.h"

/*--------------------------------------------------*/

@implementation GLBDataController

#pragma mark - Public constructors

@synthesize delegate = _delegate;
@synthesize updating = _updating;
@synthesize error = _error;

#pragma mark - Public constructors

+ (instancetype)dataController {
    return [self new];
}

+ (instancetype)dataControllerWithDelegate:(id< GLBDataControllerDelegate >)delegate {
    return [[self alloc] initWithDelegate:delegate];
}

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithDelegate:(id< GLBDataControllerDelegate >)delegate {
    self = [super init];
    if(self != nil) {
        _delegate = delegate;
        [self setup];
    }
    return self;
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

#pragma mark - Public instance methods

- (void)setup {
}

- (void)load {
    [self _load:NO];
}

- (void)reload {
    [self _load:YES];
}

- (void)cancel {
}

#pragma mark - Private instance methods

- (void)_load:(BOOL)force {
    if([self _shouldUpdate:force] == YES) {
        [self _startUpdating:force notify:YES];
    } else {
        [self _finishUpdating:force notify:YES];
    }
}

- (BOOL)_shouldUpdate:(BOOL)force {
    return NO;
}

- (void)_startUpdating:(BOOL)force notify:(BOOL)notify {
    _updating = YES;
    if((notify == YES) && (_delegate != nil)) {
        [_delegate startUpdatingInDataController:self];
    }
}

- (void)_finishUpdating:(BOOL)force notify:(BOOL)notify {
    _updating = NO;
    if((notify == YES) && (_delegate != nil)) {
        [_delegate finishUpdatingInDataController:self];
    }
}

@end

/*--------------------------------------------------*/
