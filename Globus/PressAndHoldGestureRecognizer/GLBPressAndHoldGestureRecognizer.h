/*--------------------------------------------------*/

#include "GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBPressAndHoldGestureRecognizer : UILongPressGestureRecognizer

@property(nonatomic) NSTimeInterval reportInterval;
@property(nonatomic) CGFloat allowableMovementWhenRecognized;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
