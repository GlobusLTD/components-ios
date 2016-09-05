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

#import "NSObject+GLBDebug.h"

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation NSObject (GLB_NSDebug)

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
#pragma mark -
/*--------------------------------------------------*/

@implementation NSDictionary (GLB_NSDebug)

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    NSUInteger baseIndent = indent + 1;
    [string appendString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        NSString* keyDebug = [key glb_debugContext:context indent:baseIndent root:NO];
        NSString* valueDebug = [value glb_debugContext:context indent:baseIndent root:NO];
        if((keyDebug != nil) && (valueDebug != nil)) {
            [string glb_appendString:@"\t" repeat:baseIndent];
            [string appendFormat:@"%@ : %@,\n", keyDebug, valueDebug];
        }
    }];
    [string glb_appendString:@"\t" repeat:indent];
    [string appendString:@"}"];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation NSArray (GLB_NSDebug)

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    NSUInteger baseIndent = indent + 1;
    [string appendString:@"[\n"];
    for(id object in self) {
        NSString* item = [object glb_debugContext:context indent:baseIndent root:NO];
        if(item != nil) {
            [string glb_appendString:@"\t" repeat:baseIndent];
            [string appendFormat:@"%@,\n", item];
        }
    }
    [string glb_appendString:@"\t" repeat:indent];
    [string appendString:@"]"];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation NSOrderedSet (GLB_NSDebug)

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    NSUInteger baseIndent = indent + 1;
    [string appendString:@"(\n"];
    for(id object in self) {
        NSString* item = [object glb_debugContext:context indent:baseIndent root:NO];
        if(item != nil) {
            [string glb_appendString:@"\t" repeat:baseIndent];
            [string appendFormat:@"%@,\n", item];
        }
    }
    [string glb_appendString:@"\t" repeat:indent];
    [string appendString:@")"];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation NSSet (GLB_NSDebug)

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    NSUInteger baseIndent = indent + 1;
    [string appendString:@"(\n"];
    for(id object in self) {
        NSString* item = [object glb_debugContext:context indent:baseIndent root:NO];
        if(item != nil) {
            [string glb_appendString:@"\t" repeat:baseIndent];
            [string appendFormat:@"%@,\n", item];
        }
    }
    [string glb_appendString:@"\t" repeat:indent];
    [string appendString:@")"];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation NSPointerArray (GLB_NSDebug)

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    NSUInteger baseIndent = indent + 1;
    [string appendString:@"[\n"];
    for(id object in self) {
        NSString* item = [object glb_debugContext:context indent:baseIndent root:NO];
        if(item != nil) {
            [string glb_appendString:@"\t" repeat:baseIndent];
            [string appendFormat:@"%@,\n", item];
        }
    }
    [string glb_appendString:@"\t" repeat:indent];
    [string appendString:@"]"];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation NSString (GLB_NSDebug)

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    [string appendFormat:@"\"%@\"", self];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation NSNumber (GLB_NSDebug)

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    [string appendFormat:@"%@", self];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation NSDate (GLB_NSDebug)

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    static NSDateFormatter* dateFormatter = nil;
    if(dateFormatter == nil) {
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:SSS ZZ";
    }
    dateFormatter.locale = NSLocale.currentLocale;
    
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    [string appendFormat:@"%@", [dateFormatter stringFromDate:self]];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation NSNull (GLB_NSDebug)

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    [string appendFormat:@"<NSNull>"];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation NSData (GLB_NSDebug)

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    [string appendFormat:@"%@", self.glb_base64String];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation NSURL (GLB_NSDebug)

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    [self.absoluteString glb_debugString:string context:context indent:indent root:root];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation NSError (GLB_NSDebug)

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
