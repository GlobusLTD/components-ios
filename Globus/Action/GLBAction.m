/*--------------------------------------------------*/

#import "GLBAction.h"

/*--------------------------------------------------*/

#import "NSDictionary+GLBNS.h"
#import "NSArray+GLBNS.h"
#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

@interface GLBAction () {
    NSMethodSignature* _signature;
}

@end

/*--------------------------------------------------*/

@implementation GLBAction

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(init)

#pragma mark - Init / Free

+ (id)actionWithTarget:(id)target action:(SEL)action {
    return [[self alloc] initWithTarget:target action:action];
}

+ (id)actionWithTarget:(id)target action:(SEL)action inThread:(NSThread*)thread {
    return [[self alloc] initWithTarget:target action:action inThread:thread];
}

- (instancetype)initWithTarget:(id)target action:(SEL)action {
    return [self initWithTarget:target action:action inThread:nil];
}

- (instancetype)initWithTarget:(id)target action:(SEL)action inThread:(NSThread*)thread {
    self = [super init];
    if(self != nil) {
        _target = target;
        _action = action;
        _thread = thread;
        _signature = [_target methodSignatureForSelector:_action];
    }
    return self;
}

#pragma mark - Public

- (id)performWithArguments:(NSArray*)arguments {
    id result = nil;
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:_signature];
    if(invocation != nil) {
        invocation.target = _target;
        invocation.selector = _action;
        NSUInteger count = MIN(_signature.numberOfArguments - 2, arguments.count);
        for(NSUInteger index = 0; index < count; ++index) {
            id arg = arguments[index];
            if(arg != nil) {
                [invocation setArgument:(void*)&arg atIndex:(NSInteger)(index + 2)];
            }
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

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    NSUInteger baseIndent = indent + 1;
    [string appendFormat:@"<%@ \n", self.glb_className];
    [string glb_appendString:@"\t" repeat:baseIndent];
    [string appendFormat:@"Target : %@\n", [_target glb_className]];
    [string glb_appendString:@"\t" repeat:baseIndent];
    [string appendFormat:@"Action : %@\n", NSStringFromSelector(_action)];
    [string glb_appendString:@"\t" repeat:indent];
    [string appendString:@">"];
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
        _defaultGroup = NSNull.null;
        _actions = NSMutableDictionary.dictionary;
    }
    return self;
}

- (void)dealloc {
}

#pragma mark - Public

- (GLBAction*)addActionWithTarget:(id)target action:(SEL)action forKey:(id)key {
    GLBAction* result = [GLBAction actionWithTarget:target action:action];
    [self addAction:result inGroup:_defaultGroup forKey:key];
    return result;
}

- (GLBAction*)addActionWithTarget:(id)target action:(SEL)action inGroup:(id)group forKey:(id)key {
    GLBAction* result = [GLBAction actionWithTarget:target action:action];
    [self addAction:result inGroup:group forKey:key];
    return result;
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

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    NSUInteger baseIndent = indent + 1;
    [string appendFormat:@"<%@ \n", self.glb_className];
    if(_defaultGroup != nil) {
        [string glb_appendString:@"\t" repeat:baseIndent];
        [string appendFormat:@"DefaultGroup : %@\n", [_defaultGroup glb_debug]];
    }
    if(_actions.count > 0) {
        [string glb_appendString:@"\t" repeat:baseIndent];
        [string appendString:@"Actions : "];
        [_actions glb_debugString:string context:context indent:baseIndent root:NO];
        [string appendString:@"\n"];
    }
    [string glb_appendString:@"\t" repeat:indent];
    [string appendString:@">"];
}

@end

/*--------------------------------------------------*/
