/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

typedef void(^GLBTimeoutBlock)();

/*--------------------------------------------------*/

@interface GLBTimeout : NSObject

+ (void)executeBlock:(GLBTimeoutBlock _Nonnull)block afterDelay:(NSTimeInterval)delay;

@end

/*--------------------------------------------------*/ 
