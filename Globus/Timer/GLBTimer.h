/*--------------------------------------------------*/

#import "GLBAction.h"

/*--------------------------------------------------*/

@interface GLBTimer : NSObject

@property(nonatomic, readonly, getter=isDelaying) BOOL delaying;
@property(nonatomic, readonly, getter=isStarted) BOOL started;
@property(nonatomic, readonly, getter=isPaused) BOOL paused;
@property(nonatomic) NSTimeInterval interval;
@property(nonatomic) NSTimeInterval delay;
@property(nonatomic) NSUInteger repeat;
@property(nonatomic, readonly) NSTimeInterval duration;
@property(nonatomic, readonly) NSTimeInterval elapsed;
@property(nonatomic, readonly) NSUInteger repeated;

@property(nonatomic, nullable, strong) GLBAction* actionStarted;
@property(nonatomic, nullable, strong) GLBAction* actionRepeat;
@property(nonatomic, nullable, strong) GLBAction* actionFinished;
@property(nonatomic, nullable, strong) GLBAction* actionStoped;
@property(nonatomic, nullable, strong) GLBAction* actionPaused;
@property(nonatomic, nullable, strong) GLBAction* actionResumed;

+ (nonnull instancetype)timerWithInterval:(NSTimeInterval)interval NS_SWIFT_UNAVAILABLE("Use init(interval:)");
+ (nonnull instancetype)timerWithInterval:(NSTimeInterval)interval repeat:(NSUInteger)repeat NS_SWIFT_UNAVAILABLE("Use init(interval:repeat:)");
+ (nonnull instancetype)timerWithInterval:(NSTimeInterval)interval delay:(NSTimeInterval)delay repeat:(NSUInteger)repeat NS_SWIFT_UNAVAILABLE("Use init(interval:delay:repeat:)");

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithInterval:(NSTimeInterval)interval;
- (nonnull instancetype)initWithInterval:(NSTimeInterval)interval repeat:(NSUInteger)repeat;
- (nonnull instancetype)initWithInterval:(NSTimeInterval)interval delay:(NSTimeInterval)delay repeat:(NSUInteger)repeat NS_DESIGNATED_INITIALIZER;

- (void)setup NS_REQUIRES_SUPER;

- (void)start;
- (void)stop;

- (void)pause;
- (void)resume;

- (void)restart;

@end

/*--------------------------------------------------*/
