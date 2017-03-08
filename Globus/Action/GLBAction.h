/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

#import "NSObject+GLBDebug.h"

/*--------------------------------------------------*/

@interface GLBAction : NSObject < GLBObjectDebugProtocol >

@property(nonatomic, nullable, readonly, weak) id target;
@property(nonatomic, nonnull, readonly) SEL action;
@property(nonatomic, nullable, readonly, weak) NSThread* thread;

+ (nonnull instancetype)actionWithTarget:(nonnull id)target action:(nonnull SEL)action NS_SWIFT_UNAVAILABLE("Use init(target:action:)");
+ (nonnull instancetype)actionWithTarget:(nonnull id)target action:(nonnull SEL)action inThread:(nullable NSThread*)thread NS_SWIFT_UNAVAILABLE("Use init(target:action:inThread:)");

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithTarget:(nonnull id)target action:(nonnull SEL)action;
- (nonnull instancetype)initWithTarget:(nonnull id)target action:(nonnull SEL)action inThread:(nullable NSThread*)thread NS_DESIGNATED_INITIALIZER;

- (nullable id)performWithArguments:(nullable NSArray*)arguments;

@end

/*--------------------------------------------------*/

@interface GLBActions: NSObject < GLBObjectDebugProtocol >

@property(nonatomic, nonnull, strong) id defaultGroup;

- (nonnull GLBAction*)addActionWithTarget:(nonnull id)target action:(nonnull SEL)action forKey:(nonnull id)key;
- (nonnull GLBAction*)addActionWithTarget:(nonnull id)target action:(nonnull SEL)action inGroup:(nonnull id)group forKey:(nonnull id)key;
- (void)addAction:(nonnull GLBAction*)action forKey:(nonnull id)key;
- (void)addAction:(nonnull GLBAction*)action inGroup:(nonnull id)group forKey:(nonnull id)key;

- (void)removeAction:(nonnull GLBAction*)action;

- (void)removeAllActionsByTarget:(nonnull id)target;
- (void)removeAllActionsByTarget:(nonnull id)target forKey:(nonnull id)key;
- (void)removeAllActionsByTarget:(nonnull id)target inGroup:(nonnull id)group forKey:(nonnull id)key;
- (void)removeAllActionsInGroup:(nonnull id)group;
- (void)removeAllActionsForKey:(nonnull id)key;
- (void)removeAllActionsInGroup:(nonnull id)group forKey:(nonnull id)key;
- (void)removeAllActions;

- (BOOL)containsActionForKey:(nonnull id)key;
- (BOOL)containsActionInGroup:(nonnull id)group forKey:(nonnull id)key;

- (void)performForKey:(nonnull id)key withArguments:(nullable NSArray*)arguments;
- (void)performInGroup:(nonnull id)group forKey:(nonnull id)key withArguments:(nullable NSArray*)arguments;

@end

/*--------------------------------------------------*/
