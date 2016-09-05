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
