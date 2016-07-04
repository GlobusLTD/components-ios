/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"
#import "NSString+GLBNS.h"
#import "NSPointerArray+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSObject (GLB_NS)

+ (NSString*)glb_className {
    return NSStringFromClass(self.class);
}

- (NSString*)glb_className {
    return NSStringFromClass(self.class);
}

- (NSString*)glb_debug {
    NSPointerArray* context = [NSPointerArray strongObjectsPointerArray];
    return [self glb_debugContext:context indent:0 root:YES];
}

- (NSString*)glb_debugContext:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    NSMutableString* string = [NSMutableString string];
    if([self respondsToSelector:@selector(glb_debugString:context:indent:root:)] == YES) {
        [self glb_debugString:string context:context indent:indent root:root];
    } else {
        if(root == YES) {
            [string glb_appendString:@"\t" repeat:indent];
        }
        [string appendFormat:@"%@", self];
    }
    return string.copy;
}

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    [string appendFormat:@"%p", self];
}

@end

/*--------------------------------------------------*/
