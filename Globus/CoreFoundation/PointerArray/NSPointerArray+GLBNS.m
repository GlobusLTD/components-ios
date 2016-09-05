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

#import "NSPointerArray+GLBNS.h"

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

@end

/*--------------------------------------------------*/
