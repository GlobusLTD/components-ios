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
