/*--------------------------------------------------*/

#import "GLBAction.h"

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

@property(nonatomic, nullable, strong) GLBAction* actionStarted;
@property(nonatomic, nullable, strong) GLBAction* actionRepeat;
@property(nonatomic, nullable, strong) GLBAction* actionFinished;
@property(nonatomic, nullable, strong) GLBAction* actionStoped;
@property(nonatomic, nullable, strong) GLBAction* actionPaused;
@property(nonatomic, nullable, strong) GLBAction* actionResumed;

+ (instancetype _Nonnull)timerWithInterval:(NSTimeInterval)interval NS_SWIFT_UNAVAILABLE("Use init(interval:)");
+ (instancetype _Nonnull)timerWithInterval:(NSTimeInterval)interval repeat:(NSUInteger)repeat NS_SWIFT_UNAVAILABLE("Use init(interval:repeat:)");
+ (instancetype _Nonnull)timerWithInterval:(NSTimeInterval)interval delay:(NSTimeInterval)delay repeat:(NSUInteger)repeat NS_SWIFT_UNAVAILABLE("Use init(interval:delay:repeat:)");

- (instancetype _Nonnull)init NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithInterval:(NSTimeInterval)interval;
- (instancetype _Nonnull)initWithInterval:(NSTimeInterval)interval repeat:(NSUInteger)repeat;
- (instancetype _Nonnull)initWithInterval:(NSTimeInterval)interval delay:(NSTimeInterval)delay repeat:(NSUInteger)repeat NS_DESIGNATED_INITIALIZER;

- (void)setup NS_REQUIRES_SUPER;

- (void)start;
- (void)stop;

- (void)pause;
- (void)resume;

- (void)restart;

@end

/*--------------------------------------------------*/
