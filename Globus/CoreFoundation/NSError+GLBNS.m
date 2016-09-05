/**
 * This file is part of the GLB (the library of globus-ltd)
 * Copyright 2014-2016 Globus-LTD. http://www.globus-ltd.com
 * Created by Alexander Trifonov
 *
 * For the full copyright and license information, please view the LICENSE
 * file that contained MIT License
 * and was distributed with this source code.
 */

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

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
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
        NSString* userInfo = [self.userInfo glb_debugContext:context indent:baseIndent root:NO];
        if(userInfo != nil) {
            [string glb_appendString:@"\t" repeat:baseIndent];
            [string appendFormat:@"UserInfo : %@\n", userInfo];
        }
    }
    [string glb_appendString:@"\t" repeat:indent];
    [string appendString:@">"];
}

@end

/*--------------------------------------------------*/
