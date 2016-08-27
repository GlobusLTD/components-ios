/*--------------------------------------------------*/

#include "GLBCG.h"

/*--------------------------------------------------*/

static BOOL GLBNeedRandomizeSeed = YES;

/*--------------------------------------------------*/

NSInteger GLBIntegerRandom(NSInteger min, NSInteger max) {
    if(GLBNeedRandomizeSeed == YES) {
        GLBNeedRandomizeSeed = NO;
        srand((unsigned)time(NULL));
    }
    return (NSInteger)(min + (NSInteger)arc4random_uniform((u_int32_t)(max - min + 1)));
}

NSInteger GLBIntegerLerp(NSInteger from, NSInteger to, CGFloat progress) {
    return (NSInteger)GLBFloatLerp(from, to, progress);
}

CGFloat GLBFloatRandom(CGFloat min, CGFloat max) {
    if(GLBNeedRandomizeSeed == YES) {
        GLBNeedRandomizeSeed = NO;
        srand((unsigned)time(NULL));
    }
    return ((arc4random() % RAND_MAX) / (CGFloat)RAND_MAX) * (max - min) + min;
}

CGFloat GLBFloatNearestMore(CGFloat value, CGFloat step) {
    CGFloat result = step;
    while(result < value) {
        result += step;
    }
    return result;
}

CGFloat GLBFloatLerp(CGFloat from, CGFloat to, CGFloat progress) {
    return ((1 - progress) * from) + (progress * to);
}

/*--------------------------------------------------*/
