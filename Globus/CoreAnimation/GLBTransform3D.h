/*--------------------------------------------------*/
#ifndef GLB_TRANSFORM_3D_H
#define GLB_TRANSFORM_3D_H
/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import <QuartzCore/QuartzCore.h>

/*--------------------------------------------------*/

CATransform3D GLBTransform3DRotationWithPerspective(CGFloat perspective, CGFloat angle, CGFloat x, CGFloat y, CGFloat z);

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
