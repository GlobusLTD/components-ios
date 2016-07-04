/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"

/*--------------------------------------------------*/

@interface NSPointerArray (GLB_NS) < GLBObjectDebugProtocol >

- (NSUInteger)glb_indexForPointer:(nullable void *)pointer;

- (void)glb_removePointer:(nullable void *)pointer;

@end

/*--------------------------------------------------*/
