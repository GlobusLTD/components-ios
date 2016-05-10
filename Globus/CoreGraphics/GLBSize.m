/*--------------------------------------------------*/

#include "GLBSize.h"

/*--------------------------------------------------*/

CGSize GLBSizeNearestMore(CGSize size, CGFloat step) {
    return CGSizeMake(GLBFloatNearestMore(size.width, step),
                      GLBFloatNearestMore(size.height, step));
}

CGSize GLBSizeAdd(CGSize size, CGFloat value) {
    return CGSizeMake(size.width + value,
                      size.height + value);
}

CGSize GLBSizeSub(CGSize size, CGFloat value) {
    return CGSizeMake(size.width - value,
                      size.height - value);
}

CGSize GLBSizeMul(CGSize size, CGFloat value) {
    return CGSizeMake(size.width * value,
                      size.height * value);
}

CGSize GLBSizeDiv(CGSize size, CGFloat value) {
    return CGSizeMake(size.width / value,
                      size.height / value);
}

CGSize GLBSizeLerp(CGSize from, CGSize to, CGFloat progress) {
    return CGSizeMake(GLBFloatLerp(from.width, from.width, progress),
                      GLBFloatLerp(from.height, from.height, progress));
}

/*--------------------------------------------------*/
