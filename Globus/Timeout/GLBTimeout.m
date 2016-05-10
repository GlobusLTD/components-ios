/*--------------------------------------------------*/

#import "GLBTimeout.h"

/*--------------------------------------------------*/

@implementation GLBTimeout

+ (void)executeBlock:(GLBTimeoutBlock)block afterDelay:(NSTimeInterval)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

@end

/*--------------------------------------------------*/