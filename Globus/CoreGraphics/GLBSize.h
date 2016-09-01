/*--------------------------------------------------*/
#ifndef GLB_SIZE_H
#define GLB_SIZE_H
/*--------------------------------------------------*/

#include "GLBCG.h"

/*--------------------------------------------------*/

CGSize GLBSizeNearestMore(CGSize size, CGFloat step);
CGSize GLBSizeAdd(CGSize size, CGFloat value);
CGSize GLBSizeSub(CGSize size, CGFloat value);
CGSize GLBSizeMul(CGSize size, CGFloat value);
CGSize GLBSizeDiv(CGSize size, CGFloat value);

CGSize GLBSizeLerp(CGSize from, CGSize to, CGFloat progress);

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
