/*--------------------------------------------------*/

#import "NSError+GLBNS.h"
#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSError (GLB_NS)

- (BOOL)glb_isURLError {
    return ([self.domain isEqualToString:NSURLErrorDomain] == YES);
}

- (BOOL)glb_URLErrorConnectedToInternet {
    return (self.glb_isURLError == YES) && (self.code == NSURLErrorNotConnectedToInternet);
}

- (BOOL)glb_URLErrorCancelled {
    return (self.glb_isURLError == YES) && (self.code == NSURLErrorCancelled);
}

- (BOOL)glb_URLErrorTimedOut {
    return (self.glb_isURLError == YES) && (self.code == NSURLErrorTimedOut);
}

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    NSUInteger baseIndent = indent + 1;
    [string appendFormat:@"<%@ \n", self.glb_className];
    if(self.domain != nil) {
        [string glb_appendString:@"\t" repeat:baseIndent];
        [string appendFormat:@"Domain : %@\n", self.domain];
    }
    [string glb_appendString:@"\t" repeat:baseIndent];
    [string appendFormat:@"Code : %d\n", (int)self.code];
    if(self.userInfo.count > 0) {
        [string glb_appendString:@"\t" repeat:baseIndent];
        [string appendFormat:@"UserInfo : %@\n", [self.userInfo glb_debugIndent:baseIndent root:NO]];
    }
    [string glb_appendString:@"\t" repeat:indent];
    [string appendString:@">"];
}

@end

/*--------------------------------------------------*/
