/*--------------------------------------------------*/

#import "GLBObserver.h"

/*--------------------------------------------------*/

#import "NSDictionary+GLBNS.h"
#import "NSPointerArray+GLBNS.h"
#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

@interface GLBObserver () {
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
    _observers = [NSPointerArray weakObjectsPointerArray];
}

#pragma mark - Property

- (NSUInteger)count {
    return _observers.count;
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

- (void)performSelector:(SEL)selector block:(GLBObserverPerformBlock)block {
    for(NSUInteger observerIndex = 0; observerIndex < _observers.count; observerIndex++) {
        id observer = [_observers pointerAtIndex:observerIndex];
        if([observer respondsToSelector:selector] == YES) {
            block(observer);
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
