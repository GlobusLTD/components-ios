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

#import "NSPointerArray+GLBNS.h"
#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSPointerArray (GLB_NS)

- (NSUInteger)glb_indexForPointer:(nullable void*)pointer {
    for(NSUInteger index = 0; index < self.count; index++) {
        if([self pointerAtIndex:index] == pointer) {
            return index;
        }
    }
    return NSNotFound;
}

- (void)glb_removePointer:(nullable void*)pointer {
    NSUInteger index = [self glb_indexForPointer:pointer];
    if(index != NSNotFound) {
        [self removePointerAtIndex:index];
    }
}

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
