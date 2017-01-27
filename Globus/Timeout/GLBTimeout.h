/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

typedef void(^GLBTimeoutBlock)();

/*--------------------------------------------------*/

@interface GLBTimeout : NSObject

+ (void)executeBlock:(nonnull GLBTimeoutBlock)block afterDelay:(NSTimeInterval)delay;

@end

/*--------------------------------------------------*/ 
