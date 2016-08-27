/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@protocol GLBViewController < NSObject >

@required
- (__kindof UIViewController*)currentViewController;

@end

/*--------------------------------------------------*/

@interface UIViewController (GLB_UI)

- (__kindof UIViewController*)glb_currentViewController;

- (void)glb_loadViewIfNeed;
- (void)glb_unloadViewIfPossible;
- (void)glb_unloadView;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
