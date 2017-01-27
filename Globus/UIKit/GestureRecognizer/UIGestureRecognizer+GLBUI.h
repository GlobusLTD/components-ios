/*--------------------------------------------------*/

#include "GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface UIGestureRecognizer (GLB_UI)

+ (void)glb_cancelInView:(nonnull UIView*)view recursive:(BOOL)recursive;

- (void)glb_cancel;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
