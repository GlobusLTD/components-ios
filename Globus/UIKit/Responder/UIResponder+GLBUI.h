/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface UIResponder (GLB_UI)

+ (id)glb_currentFirstResponder;
+ (id)glb_currentFirstResponderInView:(UIView*)view;

+ (UIResponder*)glb_prevResponderFromView:(UIView*)view;
+ (UIResponder*)glb_nextResponderFromView:(UIView*)view;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
