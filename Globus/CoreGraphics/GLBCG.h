/*--------------------------------------------------*/
#ifndef GLB_CG
#define GLB_CG
/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"
#include <tgmath.h>

#import <CoreGraphics/CoreGraphics.h>

/*--------------------------------------------------*/

#define GLB_DEG_TO_RAD 0.0174532925f

/*--------------------------------------------------*/

NSInteger GLBIntegerRandom(NSInteger min, NSInteger max);
NSInteger GLBIntegerLerp(NSInteger from, NSInteger to, CGFloat progress);

CGFloat GLBFloatRandom(CGFloat min, CGFloat max);
CGFloat GLBFloatNearestMore(CGFloat value, CGFloat step);
CGFloat GLBFloatLerp(CGFloat from, CGFloat to, CGFloat progress);

/*--------------------------------------------------*/

#define GLB_COS(X) __tg_cos(__tg_promote1((X))(X))
#define GLB_SIN(X) __tg_sin(__tg_promote1((X))(X))
#define GLB_ATAN2(X, Y) __tg_atan2(__tg_promote2((X), (Y))(X), __tg_promote2((X), (Y))(Y))
#define GLB_POW(X, Y) __tg_pow(__tg_promote2((X), (Y))(X), __tg_promote2((X), (Y))(Y))
#define GLB_SQRT(X) __tg_sqrt(__tg_promote1((X))(X))
#define GLB_FABS(X) __tg_fabs(__tg_promote1((X))(X))
#define GLB_CEIL(X) __tg_ceil(__tg_promote1((X))(X))
#define GLB_FLOOR(X) __tg_floor(__tg_promote1((X))(X))

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
