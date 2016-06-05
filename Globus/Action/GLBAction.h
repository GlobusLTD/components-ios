/*--------------------------------------------------*/

#include "NSObject+GLBNS.h"

/*--------------------------------------------------*/

@interface GLBAction : NSObject < GLBObjectDebugProtocol >

@property(nonatomic, readonly, nullable, weak) id target;
@property(nonatomic, readonly, nonnull, assign) SEL action;
@property(nonatomic, readonly, nullable, weak) NSThread* thread;

+ (_Nullable instancetype)actionWithTarget:(_Nonnull id)target action:(_Nonnull SEL)action;
+ (_Nullable instancetype)actionWithTarget:(_Nonnull id)target action:(_Nonnull SEL)action inThread:(NSThread* _Nullable)thread;
- (_Nullable instancetype)initWithTarget:(_Nonnull id)target action:(_Nonnull SEL)action inThread:(NSThread* _Nullable)thread;

- (void)setup NS_REQUIRES_SUPER;

- (_Nullable id)performWithArguments:(NSArray* _Nullable)arguments;

@end

/*--------------------------------------------------*/

@interface GLBActions: NSObject < GLBObjectDebugProtocol >

@property(nonatomic, nonnull, strong) id defaultGroup;

- (void)setup NS_REQUIRES_SUPER;

- (void)addActionWithTarget:(_Nonnull id)target action:(nonnull SEL)action forKey:(_Nonnull id)key;
- (void)addActionWithTarget:(_Nonnull id)target action:(nonnull SEL)action inGroup:(_Nonnull id)group forKey:(_Nonnull id)key;
- (void)addAction:(GLBAction* _Nonnull)action forKey:(id _Nonnull)key;
- (void)addAction:(GLBAction* _Nonnull)action inGroup:(id _Nonnull)group forKey:(id _Nonnull)key;

- (void)removeAction:(GLBAction* _Nonnull)action;

- (void)removeAllActionsByTarget:(_Nonnull id)target;
- (void)removeAllActionsByTarget:(_Nonnull id)target forKey:(_Nonnull id)key;
- (void)removeAllActionsByTarget:(_Nonnull id)target inGroup:(_Nonnull id)group forKey:(_Nonnull id)key;
- (void)removeAllActionsInGroup:(_Nonnull id)group;
- (void)removeAllActionsForKey:(_Nonnull id)key;
- (void)removeAllActionsInGroup:(_Nonnull id)group forKey:(_Nonnull id)key;
- (void)removeAllActions;

- (BOOL)containsActionForKey:(_Nonnull id)key;
- (BOOL)containsActionInGroup:(_Nonnull id)group forKey:(_Nonnull id)key;

- (void)performForKey:(_Nonnull id)key withArguments:(NSArray* _Nullable)arguments;
- (void)performInGroup:(_Nonnull id)group forKey:(_Nonnull id)key withArguments:(NSArray* _Nullable)arguments;

@end

/*--------------------------------------------------*/
