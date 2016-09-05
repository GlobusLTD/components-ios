/****************************************************/
/*                                                  */
/* This file is part of the Globus Components iOS   */
/* Copyright 2014-2016 Globus-Ltd.                  */
/* http://www.globus-ltd.com                        */
/* Created by Alexander Trifonov                    */
/*                                                  */
/* For the full copyright and license information,  */
/* please view the LICENSE file that contained      */
/* MIT License and was distributed with             */
/* this source code.                                */
/*                                                  */
/****************************************************/

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
