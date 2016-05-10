/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

@class GLBKVO;

/*--------------------------------------------------*/

typedef void (^GLBKVOBlock)(GLBKVO* kvo, id oldValue, id newValue);

/*--------------------------------------------------*/

@interface GLBKVO : NSObject

@property(nonatomic, readonly, weak) id subject;
@property(nonatomic, readonly, strong) NSString* keyPath;
@property(nonatomic, copy) GLBKVOBlock block;

- (instancetype)initWithSubject:(id)subject keyPath:(NSString*)keyPath block:(GLBKVOBlock)block;

- (void)setup NS_REQUIRES_SUPER;

- (void)stopObservation;

@end

/*--------------------------------------------------*/

@interface NSObject (GLBKVO)

- (GLBKVO*)glb_observeKeyPath:(NSString*)keyPath withBlock:(GLBKVOBlock)block;
- (GLBKVO*)glb_observeSelector:(SEL)selector withBlock:(GLBKVOBlock)block;

@end

/*--------------------------------------------------*/
