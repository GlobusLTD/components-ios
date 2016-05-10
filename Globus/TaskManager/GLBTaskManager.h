/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

typedef NS_ENUM(NSInteger, GLBTaskPriority) {
	GLBTaskPriorityLow,
	GLBTaskPriorityNormal,
	GLBTaskPriorityHigh
};

/*--------------------------------------------------*/

@class GLBTask;

/*--------------------------------------------------*/

typedef void (^GLBTaskManagerEnumBlock)(id task, BOOL* stop);

/*--------------------------------------------------*/

@interface GLBTaskManager : NSObject

@property(nonatomic) NSUInteger maxConcurrentTask;

- (void)setup NS_REQUIRES_SUPER;

- (void)addTask:(GLBTask*)task;
- (void)addTask:(GLBTask*)task priority:(GLBTaskPriority)priority;
- (void)cancelTask:(GLBTask*)task;
- (void)cancelAllTasks;

- (void)enumirateTasksUsingBlock:(GLBTaskManagerEnumBlock)block;
- (NSArray*)tasks;
- (NSUInteger)countTasks;

- (void)updating;
- (void)updated;

- (void)wait;

#if defined(GLB_TARGET_IOS)
- (void)startBackgroundSession;
- (void)stopBackgroundSession;
#endif

@end

/*--------------------------------------------------*/

@interface GLBTask : NSObject

@property(nonatomic, getter=isRepeat) BOOL repeat;
@property(nonatomic) NSTimeInterval repeatTimeout;
@property(nonatomic, readonly, assign, getter=isCanceled) BOOL cancel;

- (void)setup NS_REQUIRES_SUPER;

- (void)setNeedRework;

- (BOOL)willStart NS_REQUIRES_SUPER;
- (void)working NS_REQUIRES_SUPER;
- (void)didComplete NS_REQUIRES_SUPER;
- (void)didCancel NS_REQUIRES_SUPER;

- (void)cancel;

@end

/*--------------------------------------------------*/
