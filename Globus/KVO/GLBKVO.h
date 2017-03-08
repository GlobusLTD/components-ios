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

- (nonnull instancetype)initWithSubject:(nonnull id)subject
                                keyPath:(nonnull NSString*)keyPath
                                  block:(nonnull GLBKVOBlock)block;

@end

/*--------------------------------------------------*/

@interface NSObject (GLBKVO)

- (nonnull GLBKVO*)glb_observeKeyPath:(nonnull NSString*)keyPath withBlock:(nonnull GLBKVOBlock)block;
- (nonnull GLBKVO*)glb_observeSelector:(nonnull SEL)selector withBlock:(nonnull GLBKVOBlock)block;

@end

/*--------------------------------------------------*/
