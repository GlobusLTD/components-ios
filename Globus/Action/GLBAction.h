/*--------------------------------------------------*/

#import "NSObject+GLBDebug.h"
#import "NSDictionary+GLBNS.h"
#import "NSArray+GLBNS.h"
#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

@interface GLBAction : NSObject < GLBObjectDebugProtocol >

@property(nonatomic, nullable, readonly, weak) id target;
@property(nonatomic, nonnull, readonly, assign) SEL action;
@property(nonatomic, nullable, readonly, weak) NSThread* thread;

+ (instancetype _Nonnull)actionWithTarget:(id _Nonnull)target action:(SEL _Nonnull)action NS_SWIFT_UNAVAILABLE("Use init(target:action:)");
+ (instancetype _Nonnull)actionWithTarget:(id _Nonnull)target action:(SEL _Nonnull)action inThread:(NSThread* _Nullable)thread NS_SWIFT_UNAVAILABLE("Use init(target:action:inThread:)");

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithTarget:(id _Nonnull)target action:(SEL _Nonnull)action;
- (instancetype _Nonnull)initWithTarget:(id _Nonnull)target action:(SEL _Nonnull)action inThread:(NSThread* _Nullable)thread NS_DESIGNATED_INITIALIZER;

- (void)setup NS_REQUIRES_SUPER;

- (id _Nullable)performWithArguments:(NSArray* _Nullable)arguments;

@end

/*--------------------------------------------------*/

@interface GLBActions: NSObject < GLBObjectDebugProtocol >

@property(nonatomic, nonnull, strong) id defaultGroup;

- (void)setup NS_REQUIRES_SUPER;

- (GLBAction* _Nonnull)addActionWithTarget:(id _Nonnull)target action:(SEL _Nonnull)action forKey:(id _Nonnull)key;
- (GLBAction* _Nonnull)addActionWithTarget:(id _Nonnull)target action:(SEL _Nonnull)action inGroup:(id _Nonnull)group forKey:(id _Nonnull)key;
- (void)addAction:(GLBAction* _Nonnull)action forKey:(id _Nonnull)key;
- (void)addAction:(GLBAction* _Nonnull)action inGroup:(id _Nonnull)group forKey:(id _Nonnull)key;

- (void)removeAction:(GLBAction* _Nonnull)action;

- (void)removeAllActionsByTarget:(id _Nonnull)target;
- (void)removeAllActionsByTarget:(id _Nonnull)target forKey:(id _Nonnull)key;
- (void)removeAllActionsByTarget:(id _Nonnull)target inGroup:(id _Nonnull)group forKey:(id _Nonnull)key;
- (void)removeAllActionsInGroup:(id _Nonnull)group;
- (void)removeAllActionsForKey:(id _Nonnull)key;
- (void)removeAllActionsInGroup:(id _Nonnull)group forKey:(id _Nonnull)key;
- (void)removeAllActions;

- (BOOL)containsActionForKey:(id _Nonnull)key;
- (BOOL)containsActionInGroup:(id _Nonnull)group forKey:(id _Nonnull)key;

- (void)performForKey:(id _Nonnull)key withArguments:(NSArray* _Nullable)arguments;
- (void)performInGroup:(id _Nonnull)group forKey:(id _Nonnull)key withArguments:(NSArray* _Nullable)arguments;

@end

/*--------------------------------------------------*/
