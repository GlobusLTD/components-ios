/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"
#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSObject (GLB_NS)

+ (NSString*)glb_className {
    return NSStringFromClass(self.class);
}

- (NSString*)glb_className {
    return NSStringFromClass(self.class);
}

- (NSString*)glb_debug {
    return [self glb_debugIndent:0 root:YES];
}

- (NSString*)glb_debugIndent:(NSUInteger)indent root:(BOOL)root {
    NSMutableString* string = [NSMutableString string];
    if([self respondsToSelector:@selector(glb_debugString:indent:root:)] == YES) {
        [self glb_debugString:string indent:indent root:root];
    } else {
        if(root == YES) {
            [string glb_appendString:@"\t" repeat:indent];
        }
        [string appendFormat:@"%@", self];
    }
    return string.copy;
}

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    [string appendFormat:@"%p", self];
}

@end

/*--------------------------------------------------*/
