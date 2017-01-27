/*--------------------------------------------------*/

#import "GLBModelContext.h"

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelContext

#pragma mark - Singleton

+ (instancetype)shared {
    static GLBModelContext* instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [self new];
    });
    return instance;
}

#pragma mark - Init / Free

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _queue = dispatch_queue_create("GLBModelContext::Worker::Queue", DISPATCH_QUEUE_SERIAL);
}

- (void)dealloc {
}

#pragma mark - Public

- (void)sync:(GLBSimpleBlock)work {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [self async:work complete:^{
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

- (void)async:(GLBSimpleBlock)work complete:(GLBSimpleBlock)complete {
    [self asyncQueue:nil work:work complete:complete];
}

- (void)asyncQueue:(dispatch_queue_t)queue work:(GLBSimpleBlock)work complete:(GLBSimpleBlock)complete {
    dispatch_async(_queue, ^{
        work();
        if(queue != nil) {
            dispatch_async(queue, complete);
        } else {
            complete();
        }
    });
}

@end

/*--------------------------------------------------*/
