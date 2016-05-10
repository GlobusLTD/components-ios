/*--------------------------------------------------*/

#include "GLBTransform3D.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

CATransform3D GLBTransform3DRotationWithPerspective(CGFloat perspective, CGFloat angle, CGFloat x, CGFloat y, CGFloat z) {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = perspective;
    return CATransform3DRotate(transform, angle, x, y, z);
}

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
