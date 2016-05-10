/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

typedef void(^GLBTimeoutBlock)();

/*--------------------------------------------------*/

@interface GLBTimeout : NSObject

+ (void)executeBlock:(GLBTimeoutBlock)block afterDelay:(NSTimeInterval)delay;

@end

/*--------------------------------------------------*/ 