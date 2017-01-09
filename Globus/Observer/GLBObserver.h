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

+ (instancetype _Nonnull)observerWithProtocol:(Protocol* _Nonnull)protocol NS_SWIFT_UNAVAILABLE("Use init(protocol:)");

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithProtocol:(Protocol* _Nonnull)protocol NS_DESIGNATED_INITIALIZER;

- (void)setup NS_REQUIRES_SUPER;

- (BOOL)containsObserver:(id< GLBObserverProtocol > _Nonnull)observer;

- (void)addObserver:(id< GLBObserverProtocol > _Nonnull)observer;
- (void)removeObserver:(id< GLBObserverProtocol > _Nonnull)observer;

- (void)performSelector:(SEL _Nonnull)selector block:(GLBObserverPerformBlock _Nonnull)block;

@end

/*--------------------------------------------------*/

@protocol GLBObserverProtocol < NSObject >
@end

/*--------------------------------------------------*/
