/*--------------------------------------------------*/

#import "GLBObserver.h"

/*--------------------------------------------------*/

#import "NSDictionary+GLBNS.h"
#import "NSPointerArray+GLBNS.h"
#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

#import <objc/runtime.h>

/*--------------------------------------------------*/

@interface GLBObserver () {
    NSMutableDictionary< NSString*, NSMethodSignature* >* _signatures;
    NSPointerArray* _observers;
}

@end

/*--------------------------------------------------*/

@implementation GLBObserver

#pragma mark - Init / Free

- (instancetype)initWithProtocol:(Protocol*)protocol {
    self = [super init];
    if(self != nil) {
        _protocol = protocol;
        [self setup];
    }
    return self;
}

- (void)setup {
    _signatures = [NSMutableDictionary dictionary];
    _observers = [NSPointerArray weakObjectsPointerArray];
}

#pragma mark - Public

- (BOOL)containsObserver:(id< GLBObserverProtocol >)observer {
    return ([_observers glb_indexForPointer:(__bridge void*)(observer)] != NSNotFound);
}

- (void)addObserver:(id< GLBObserverProtocol >)observer {
    NSInteger index = [_observers glb_indexForPointer:(__bridge void*)(observer)];
    if(index == NSNotFound) {
        [_observers addPointer:(__bridge void*)(observer)];
    }
}

- (void)removeObserver:(id< GLBObserverProtocol >)observer {
    [_observers glb_removePointer:(__bridge void*)(observer)];
}

- (void)performSelector:(SEL)selector withArguments:(NSArray*)arguments {
    NSString* selectorName = NSStringFromSelector(selector);
    if(selectorName != nil) {
        NSMethodSignature* signature = _signatures[selectorName];
        if(signature == nil) {
            struct objc_method_description desc = protocol_getMethodDescription(_protocol, selector, YES, YES);
            if(desc.name == NULL) {
                desc = protocol_getMethodDescription(_protocol, selector, NO, YES);
            }
            if(desc.name != NULL) {
                signature = [NSMethodSignature signatureWithObjCTypes:desc.types];
                if(signature != nil) {
                    _signatures[selectorName] = signature;
                }
            }
        }
        if(signature != nil) {
            NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
            if(invocation != nil) {
                invocation.selector = selector;
                NSInteger argumentCount = MIN(signature.numberOfArguments - 2, arguments.count);
                for(NSInteger argumentIndex = 0; argumentIndex < argumentCount; ++argumentIndex) {
                    id arg = arguments[argumentIndex];
                    if(arg != nil) {
                        [invocation setArgument:(void*)&arg atIndex:argumentIndex + 2];
                    }
                }
                for(NSUInteger observerIndex = 0; observerIndex < _observers.count; observerIndex++) {
                    id observer = [_observers pointerAtIndex:observerIndex];
                    if([observer respondsToSelector:selector] == YES) {
                        [invocation invokeWithTarget:observer];
                    }
                }
            }
        }
    }
}

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    NSUInteger baseIndent = indent + 1;
    [string appendFormat:@"<%@::%@ \n", self.glb_className, NSStringFromProtocol(_protocol)];
    if(_observers.count > 0) {
        [_observers glb_debugString:string context:context indent:baseIndent root:YES];
    }
    [string glb_appendString:@"\t" repeat:indent];
    [string appendString:@">"];
}

@end

/*--------------------------------------------------*/
