/*--------------------------------------------------*/

#include "NSObject+GLBNS.h"

/*--------------------------------------------------*/

@protocol GLBObserverProtocol;

/*--------------------------------------------------*/

@interface GLBObserver : NSObject < GLBObjectDebugProtocol >

@property(nonatomic, nonnull, assign) Protocol* protocol;

- (_Nullable instancetype)initWithProtocol:(Protocol* _Nonnull)protocol;

- (void)setup NS_REQUIRES_SUPER;

- (BOOL)containsObserver:(_Nonnull id< GLBObserverProtocol >)observer;

- (void)addObserver:(_Nonnull id< GLBObserverProtocol >)observer;
- (void)removeObserver:(_Nonnull id< GLBObserverProtocol >)observer;

- (void)performSelector:(_Nonnull SEL)selector withArguments:(NSArray* _Nullable)arguments;

@end

/*--------------------------------------------------*/

@protocol GLBObserverProtocol < NSObject >
@end

/*--------------------------------------------------*/
