/*--------------------------------------------------*/

#import "GLBTaskManager.h"

/*--------------------------------------------------*/

#if defined(GLB_TARGET_IOS)
#import <UIKit/UIKit.h>
#endif

/*--------------------------------------------------*/

@interface GLBTaskManager () {
    NSOperationQueue* _queueManager;
#if defined(GLB_TARGET_IOS)
    UIBackgroundTaskIdentifier _backgroundTaskId;
#endif
    NSUInteger _updateCount;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@class GLBTaskOperation;

/*--------------------------------------------------*/

@interface GLBTask ()

@property(nonatomic, readonly, weak) GLBTaskManager* taskManager;
@property(nonatomic, weak) GLBTaskOperation* taskOperation;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface GLBTaskOperation : NSOperation

@property(nonatomic, readonly, weak) GLBTaskManager* taskManager;
@property(nonatomic, readonly, strong) GLBTask* task;

- (instancetype)initWithTaskManager:(GLBTaskManager*)taskManager task:(GLBTask*)task;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBTaskManager

#pragma mark - Init / Free

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        _queueManager = [NSOperationQueue new];
#if defined(GLB_TARGET_IOS)
        _backgroundTaskId = UIBackgroundTaskInvalid;
#endif
        [self setup];
    }
    return self;
}

- (void)setup {
}

#pragma mark - Public

- (void)setMaxConcurrentTask:(NSInteger)maxConcurrentTask {
    [self updating];
    _queueManager.maxConcurrentOperationCount = maxConcurrentTask;
    [self updated];
}

- (NSInteger)maxConcurrentTask {
    return [_queueManager maxConcurrentOperationCount];
}

- (void)addTask:(GLBTask*)task {
    [self addTask:task priority:GLBTaskPriorityNormal];
}

- (void)addTask:(GLBTask*)task priority:(GLBTaskPriority)priority {
    [self updating];
    GLBTaskOperation* operation = [[GLBTaskOperation alloc] initWithTaskManager:self task:task];
    if(operation != nil) {
        operation.queuePriority = (NSOperationQueuePriority)priority;
        [_queueManager addOperation:operation];
    }
    [self updated];
}

- (void)cancelTask:(GLBTask*)task {
    [self updating];
    [[_queueManager operations] enumerateObjectsUsingBlock:^(GLBTaskOperation* operation, NSUInteger index __unused, BOOL* stop) {
        if([task isEqual:operation.task] == YES) {
            [operation cancel];
            *stop = YES;
        }
    }];
    [self updated];
}

- (void)cancelAllTasks {
    [self updating];
    [[_queueManager operations] enumerateObjectsUsingBlock:^(GLBTaskOperation* operation, NSUInteger index __unused, BOOL* stop __unused) {
        [operation cancel];
    }];
    [self updated];
}

- (void)enumirateTasksUsingBlock:(GLBTaskManagerEnumBlock)block {
    [self updating];
    [[_queueManager operations] enumerateObjectsUsingBlock:^(GLBTaskOperation* operation, NSUInteger index __unused, BOOL* stop) {
        block(operation.task, stop);
    }];
    [self updated];
}

- (NSArray*)tasks {
    NSMutableArray* result = NSMutableArray.array;
    if(result != nil) {
        [self updating];
        [[_queueManager operations] enumerateObjectsUsingBlock:^(GLBTaskOperation* operation, NSUInteger index __unused, BOOL* stop __unused) {
            [result addObject:operation.task];
        }];
        [self updated];
    }
    return [result copy];
}

- (NSUInteger)countTasks {
    [self updating];
    NSUInteger result = _queueManager.operationCount;
    [self updated];
    return result;
}

- (void)updating {
    if(_updateCount == 0) {
        _queueManager.suspended = YES;
    }
    _updateCount++;
}

- (void)updated {
    if(_updateCount == 1) {
        _queueManager.suspended = NO;
    }
    _updateCount--;
}

- (void)wait {
    [_queueManager waitUntilAllOperationsAreFinished];
}

#if defined(GLB_TARGET_IOS)

- (void)startBackgroundSession {
    if(_backgroundTaskId == UIBackgroundTaskInvalid) {
        _backgroundTaskId = [UIApplication.sharedApplication beginBackgroundTaskWithExpirationHandler:^{
            [self cancelAllTasks];
            [self stopBackgroundSession];
        }];
    }
}

- (void)stopBackgroundSession {
    if(_backgroundTaskId != UIBackgroundTaskInvalid) {
        [UIApplication.sharedApplication endBackgroundTask:_backgroundTaskId];
        _backgroundTaskId = UIBackgroundTaskInvalid;
    }
}

#endif

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBTask

#pragma mark - Synthesize

@synthesize taskOperation = _taskOperation;

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

#pragma mark - Public

- (BOOL)isCanceled {
    return [_taskOperation isCancelled];
}

- (void)setNeedRework {
    _repeat = YES;
}

- (BOOL)willStart {
    return YES;
}

- (void)working {
    _repeat = NO;
}

- (void)didComplete {
}

- (void)didCancel {
}

- (void)cancel {
    if(_taskOperation != nil) {
        [_taskOperation cancel];
    }
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBTaskOperation

#pragma mark - Synthesize

@synthesize task = _task;

#pragma mark - Init / Free

- (instancetype)initWithTaskManager:(GLBTaskManager*)taskManager task:(GLBTask*)task {
    self = [super init];
    if(self != nil) {
        _taskManager = taskManager;
        _task = task;
        
        _task.taskOperation = self;
        
        self.completionBlock = ^{
            if(task.isCanceled == YES) {
                @autoreleasepool {
                    [task didCancel];
                }
            } else {
                @autoreleasepool {
                    [task didComplete];
                }
            }
            task.taskOperation = nil;
        };
    }
    return self;
}

#pragma mark - NSOperation

- (void)main {
    if(_task != nil) {
        if([_task willStart] == NO) {
            [self cancel];
            return;
        }
        while(self.isCancelled == NO) {
            @autoreleasepool {
                [_task working];
            }
            if(_task.isRepeat == YES) {
                if(_task.repeatTimeout > FLT_EPSILON) {
                    [NSThread sleepForTimeInterval:_task.repeatTimeout];
                }
            } else {
                break;
            }
        }
    }
}

- (void)cancel {
    [super cancel];
    
    _task.taskOperation = nil;
}

@end

/*--------------------------------------------------*/
