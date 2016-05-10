/*--------------------------------------------------*/

#import "UIViewController+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface UIApplication (GLB_UI)

@property(nonatomic, readonly, nullable, copy) NSArray* glb_windows;
@property(nonatomic, readonly, strong, nullable) UIWindow* glb_statusBarWindow;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
