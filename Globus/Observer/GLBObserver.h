/*--------------------------------------------------*/

#include "NSObject+GLBNS.h"

/*--------------------------------------------------*/

@protocol GLBObserverProtocol;

/*--------------------------------------------------*/

typedef void(^GLBObserverPerformBlock)(id< GLBObserverProtocol > observer);

/*--------------------------------------------------*/

@interface GLBObserver : NSObject < GLBObjectDebugProtocol >

@property(nonatomic, assign, nonnull) Protocol* protocol;
@property(nonatomic, readonly, assign) NSUInteger count;

- (_Nullable instancetype)initWithProtocol:(Protocol* _Nonnull)protocol;

- (void)setup NS_REQUIRES_SUPER;

- (BOOL)containsObserver:(_Nonnull id< GLBObserverProtocol >)observer;

- (void)addObserver:(_Nonnull id< GLBObserverProtocol >)observer;
- (void)removeObserver:(_Nonnull id< GLBObserverProtocol >)observer;

- (void)performSelector:(_Nonnull SEL)selector block:(_Nonnull GLBObserverPerformBlock)block;

@end

/*--------------------------------------------------*/

@protocol GLBObserverProtocol < NSObject >
@end

/*--------------------------------------------------*/
