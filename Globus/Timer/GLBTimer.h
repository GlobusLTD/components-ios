/*--------------------------------------------------*/

#import "GLBAction.h"

/*--------------------------------------------------*/

@class GLBAction;

/*--------------------------------------------------*/

@interface GLBTimer : NSObject

@property(nonatomic, readonly, assign, getter=isDelaying) BOOL delaying;
@property(nonatomic, readonly, assign, getter=isStarted) BOOL started;
@property(nonatomic, readonly, assign, getter=isPaused) BOOL paused;
@property(nonatomic) NSTimeInterval interval;
@property(nonatomic) NSTimeInterval delay;
@property(nonatomic) NSUInteger repeat;
@property(nonatomic, readonly, assign) NSTimeInterval duration;
@property(nonatomic, readonly, assign) NSTimeInterval elapsed;
@property(nonatomic, readonly, assign) NSUInteger repeated;

@property(nonatomic, strong) GLBAction* actionStarted;
@property(nonatomic, strong) GLBAction* actionRepeat;
@property(nonatomic, strong) GLBAction* actionFinished;
@property(nonatomic, strong) GLBAction* actionStoped;
@property(nonatomic, strong) GLBAction* actionPaused;
@property(nonatomic, strong) GLBAction* actionResumed;

+ (instancetype)timerWithInterval:(NSTimeInterval)interval;
+ (instancetype)timerWithInterval:(NSTimeInterval)interval repeat:(NSUInteger)repeat;
+ (instancetype)timerWithInterval:(NSTimeInterval)interval delay:(NSTimeInterval)delay repeat:(NSUInteger)repeat;

- (instancetype)initWithInterval:(NSTimeInterval)interval;
- (instancetype)initWithInterval:(NSTimeInterval)interval repeat:(NSUInteger)repeat;
- (instancetype)initWithInterval:(NSTimeInterval)interval delay:(NSTimeInterval)delay repeat:(NSUInteger)repeat;

- (void)setup NS_REQUIRES_SUPER;

- (void)start;
- (void)stop;

- (void)pause;
- (void)resume;

@end

/*--------------------------------------------------*/
