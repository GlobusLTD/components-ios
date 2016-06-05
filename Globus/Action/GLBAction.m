/*--------------------------------------------------*/

#import "GLBAction.h"

/*--------------------------------------------------*/

#import "NSArray+GLBNS.h"
#import "NSDictionary+GLBNS.h"
#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

@interface GLBAction ()

@property(nonatomic, strong) NSMethodSignature* signature;

@end

/*--------------------------------------------------*/

@implementation GLBAction

#pragma mark - Init / Free

+ (id)actionWithTarget:(id)target action:(SEL)action {
    return [[self alloc] initWithTarget:target action:action inThread:nil];
}

+ (id)actionWithTarget:(id)target action:(SEL)action inThread:(NSThread*)thread {
    return [[self alloc] initWithTarget:target action:action inThread:thread];
}

- (instancetype)initWithTarget:(id)target action:(SEL)action inThread:(NSThread*)thread {
    self = [super init];
    if(self != nil) {
        _target = target;
        _action = action;
        _thread = thread;
        [self setup];
    }
    return self;
}

- (void)setup {
    _signature = [_target methodSignatureForSelector:_action];
}

#pragma mark - Public

- (id)performWithArguments:(NSArray*)arguments {
    id result = nil;
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:_signature];
    if(invocation != nil) {
        invocation.target = _target;
        invocation.selector = _action;
        NSInteger count = MIN(_signature.numberOfArguments - 2, arguments.count);
        for(NSInteger index = 0; index < count; ++index) {
            id arg = arguments[index];
            [invocation setArgument:(void*)&arg atIndex:index + 2];
        }
        if(_thread != nil) {
            [self performSelector:@selector(_performInvocation:) onThread:_thread withObject:invocation waitUntilDone:YES];
        } else {
            [invocation invoke];
        }
        if(_signature.methodReturnLength == sizeof(id)) {
            [invocation getReturnValue:&result];
        }
    }
    return result;
}

#pragma mark - Private

- (void)_performInvocation:(NSInvocation*)invocation {
    [invocation invoke];
}

#pragma mark - Debug

- (NSString*)debugDescription {
    return [self glb_debug];
}

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    [string appendFormat:@"%@ %@ (%@)", self.glb_className, NSStringFromClass([_target class]), NSStringFromSelector(_action)];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface GLBActions () {
    NSMutableDictionary* _actions;
}

@end

/*--------------------------------------------------*/

@implementation GLBActions

#pragma mark - Init / Free

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _defaultGroup = NSNull.null;
    _actions = NSMutableDictionary.dictionary;
}

- (void)dealloc {
}

#pragma mark - Public

- (void)addActionWithTarget:(id)target action:(SEL)action forKey:(id)key {
    [self addAction:[GLBAction actionWithTarget:target action:action] inGroup:_defaultGroup forKey:key];
}

- (void)addActionWithTarget:(id)target action:(SEL)action inGroup:(id)group forKey:(id)key {
    [self addAction:[GLBAction actionWithTarget:target action:action] inGroup:group forKey:key];
}

- (void)addAction:(GLBAction*)action forKey:(id)key {
    [self addAction:action inGroup:_defaultGroup forKey:key];
}

- (void)addAction:(GLBAction*)action inGroup:(id)group forKey:(id)key {
    NSMutableDictionary* existGroupActions = _actions[group];
    NSMutableArray* existActions = nil;
    if(existGroupActions == nil) {
        existActions = [NSMutableArray array];
        existGroupActions = [NSMutableDictionary dictionaryWithObject:existActions forKey:key];
        _actions[group] = existGroupActions;
    } else {
        existActions = existGroupActions[key];
        if(existActions == nil) {
            existActions = [NSMutableArray array];
            existGroupActions[key] = existActions;
        }
    }
    [existActions addObject:action];
}

- (void)removeAction:(GLBAction*)action {
    [_actions glb_each:^(id existActionsGroup, NSMutableDictionary* existGroupActions) {
        [existGroupActions glb_each:^(id existActionsKey, NSMutableArray* existActions) {
            [existActions removeObject:action];
        }];
    }];
}

- (void)removeAllActionsByTarget:(id)target {
    [_actions glb_each:^(id existActionsGroup, NSMutableDictionary* existGroupActions) {
        [existGroupActions glb_each:^(id existActionsKey, NSMutableArray* existActions) {
            [existActions glb_each:^(GLBAction* existAction) {
                if(existAction.target == target) {
                    [existActions removeObject:existActionsKey];
                }
            }];
        }];
    }];
}

- (void)removeAllActionsByTarget:(id)target forKey:(id)key {
    [self removeAllActionsByTarget:target inGroup:_defaultGroup forKey:key];
}

- (void)removeAllActionsByTarget:(id)target inGroup:(id)group forKey:(id)key {
    NSMutableDictionary* existGroupActions = _actions[group];
    if(existGroupActions != nil) {
        NSMutableArray* existActions = existGroupActions[key];
        [existActions glb_each:^(GLBAction* existAction) {
            if(existAction.target == target) {
                [existActions removeObject:existAction];
            }
        }];
    }
}

- (void)removeAllActionsInGroup:(id)group {
    [_actions removeObjectForKey:group];
}

- (void)removeAllActionsForKey:(id)key {
    [self removeAllActionsInGroup:_defaultGroup forKey:key];
}

- (void)removeAllActionsInGroup:(id)group forKey:(id)key {
    NSMutableDictionary* existGroupActions = _actions[group];
    if(existGroupActions != nil) {
        [existGroupActions removeObjectForKey:key];
    }
}

- (void)removeAllActions {
    [_actions removeAllObjects];
}

- (BOOL)containsActionForKey:(id)key {
    return [self containsActionInGroup:_defaultGroup forKey:key];
}

- (BOOL)containsActionInGroup:(id)group forKey:(id)key {
    NSMutableDictionary* existGroupActions = _actions[group];
    if(existGroupActions != nil) {
        return (existGroupActions[key] != nil);
    }
    return NO;
}

- (void)performForKey:(id)key withArguments:(NSArray*)arguments {
    NSMutableDictionary* existGroupActions = _actions[_defaultGroup];
    if(existGroupActions != nil) {
        NSMutableArray* existActions = existGroupActions[key];
        [existActions glb_each:^(GLBAction* existAction) {
            [existAction performWithArguments:arguments];
        }];
    }
}

- (void)performInGroup:(id)group forKey:(id)key withArguments:(NSArray*)arguments {
    NSMutableDictionary* existGroupActions = _actions[group];
    if(existGroupActions == nil) {
        return [self performForKey:key withArguments:arguments];
    }
    NSMutableArray* existActions = existGroupActions[key];
    if(existActions.count < 1) {
        return [self performForKey:key withArguments:arguments];
    }
    [existActions glb_each:^(GLBAction* existAction) {
        [existAction performWithArguments:arguments];
    }];
}

#pragma mark - Debug

- (NSString*)debugDescription {
    return [self glb_debug];
}

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    NSUInteger baseIndent = indent + 1;
    NSUInteger newIndent = baseIndent + 1;
    [string appendFormat:@"%@\n", self.glb_className];
    if(_defaultGroup != nil) {
        [string glb_appendString:@"\t" repeat:baseIndent];
        [string appendFormat:@"DefaultGroup : %@\n", [_defaultGroup glb_debug]];
    }
    if(_actions.count > 0) {
        [string glb_appendString:@"\t" repeat:baseIndent];
        [string appendString:@"Actions : "];
        [_actions glb_debugString:string indent:newIndent root:NO];
        [string appendString:@"\n"];
    }
}

@end

/*--------------------------------------------------*/
