/*--------------------------------------------------*/
#ifndef GLB_CG
#define GLB_CG
/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

NSInteger GLBIntegerRandom(NSInteger min, NSInteger max);
NSInteger GLBIntegerLerp(NSInteger from, NSInteger to, CGFloat progress);

CGFloat GLBFloatRandom(CGFloat min, CGFloat max);
CGFloat GLBFloatNearestMore(CGFloat value, CGFloat step);
CGFloat GLBFloatLerp(CGFloat from, CGFloat to, CGFloat progress);

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
