/*--------------------------------------------------*/
#ifndef GLB_TRANSFORM_3D
#define GLB_TRANSFORM_3D
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
