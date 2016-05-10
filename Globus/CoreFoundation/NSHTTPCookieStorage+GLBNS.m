/*--------------------------------------------------*/

#import "NSHTTPCookieStorage+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSHTTPCookieStorage (GLB_NS)

+ (void)glb_clearCookieWithDomain:(NSString*)domain {
    NSHTTPCookieStorage* storage = NSHTTPCookieStorage.sharedHTTPCookieStorage;
    for(NSHTTPCookie* cookie in storage.cookies) {
        NSRange range = [cookie.domain rangeOfString:domain];
        if(range.length > 0) {
            [storage deleteCookie:cookie];
        }
    }
    [NSUserDefaults.standardUserDefaults synchronize];
}

@end

/*--------------------------------------------------*/
