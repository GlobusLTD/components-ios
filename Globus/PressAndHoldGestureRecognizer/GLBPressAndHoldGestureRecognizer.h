/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import <UIKit/UIKit.h>

/*--------------------------------------------------*/

@interface GLBPressAndHoldGestureRecognizer : UILongPressGestureRecognizer

@property(nonatomic) NSTimeInterval reportInterval;
@property(nonatomic) CGFloat allowableMovementWhenRecognized;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
