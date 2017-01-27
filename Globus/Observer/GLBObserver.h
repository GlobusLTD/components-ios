/*--------------------------------------------------*/

#import "NSObject+GLBDebug.h"
#import "NSPointerArray+GLBNS.h"
#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

@protocol GLBObserverProtocol;

/*--------------------------------------------------*/

typedef void(^GLBObserverPerformBlock)(_Nonnull id< GLBObserverProtocol > observer);

/*--------------------------------------------------*/

@interface GLBObserver : NSObject < GLBObjectDebugProtocol >

@property(nonatomic, nonnull, assign) Protocol* protocol;
@property(nonatomic, readonly, assign) NSUInteger count;

+ (nonnull instancetype)observerWithProtocol:(nonnull Protocol*)protocol NS_SWIFT_UNAVAILABLE("Use init(protocol:)");

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithProtocol:(nonnull Protocol*)protocol NS_DESIGNATED_INITIALIZER;

- (void)setup NS_REQUIRES_SUPER;

- (BOOL)containsObserver:(nonnull id< GLBObserverProtocol >)observer;

- (void)addObserver:(nonnull id< GLBObserverProtocol >)observer;
- (void)removeObserver:(nonnull id< GLBObserverProtocol >)observer;

- (void)performSelector:(nonnull SEL)selector block:(nonnull GLBObserverPerformBlock)block;

@end

/*--------------------------------------------------*/

@protocol GLBObserverProtocol < NSObject >
@end

/*--------------------------------------------------*/
