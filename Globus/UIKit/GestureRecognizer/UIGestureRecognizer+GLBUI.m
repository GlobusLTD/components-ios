/*--------------------------------------------------*/

#import "UIGestureRecognizer+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation UIGestureRecognizer (GLB_UI)

+ (void)glb_cancelInView:(UIView*)view recursive:(BOOL)recursive {
    for(UIGestureRecognizer* gesture in view.gestureRecognizers) {
        [gesture glb_cancel];
    }
    if(recursive == YES) {
        for(UIView* subview in view.subviews) {
            [self glb_cancelInView:subview recursive:recursive];
        }
    }
}

- (void)glb_cancel {
    if(self.enabled == YES) {
        self.enabled = NO;
        self.enabled = YES;
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
