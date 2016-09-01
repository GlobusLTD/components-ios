/*--------------------------------------------------*/

#import "NSError+GLBNS.h"

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

@end

/*--------------------------------------------------*/
