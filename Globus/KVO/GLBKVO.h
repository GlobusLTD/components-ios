/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

@class GLBKVO;

/*--------------------------------------------------*/

typedef void (^GLBKVOBlock)(GLBKVO* _Nonnull kvo, id _Nullable oldValue, id _Nullable newValue);

/*--------------------------------------------------*/

@interface GLBKVO : NSObject

@property(nonatomic, nullable, readonly, weak) id subject;
@property(nonatomic, nonnull, readonly, strong) NSString* keyPath;
@property(nonatomic, nonnull, copy) GLBKVOBlock block;

- (instancetype _Nonnull)initWithSubject:(id _Nonnull)subject keyPath:(NSString* _Nonnull)keyPath block:(GLBKVOBlock _Nonnull)block;

- (void)setup NS_REQUIRES_SUPER;

- (void)stopObservation;

@end

/*--------------------------------------------------*/

@interface NSObject (GLBKVO)

- (GLBKVO* _Nonnull)glb_observeKeyPath:(NSString* _Nonnull)keyPath withBlock:(GLBKVOBlock _Nonnull)block;
- (GLBKVO* _Nonnull)glb_observeSelector:(SEL _Nonnull)selector withBlock:(GLBKVOBlock _Nonnull)block;

@end

/*--------------------------------------------------*/
