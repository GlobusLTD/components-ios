/*--------------------------------------------------*/

#include "GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface UIApplication (GLB_UI)

@property(nonatomic, readonly, nullable, copy) NSArray* glb_windows;
@property(nonatomic, readonly, nullable, strong) UIWindow* glb_statusBarWindow;
@property(nonatomic, readonly, nullable, strong) UIWindow* glb_visibledWindow;

@end

/*--------------------------------------------------*/

@interface UIWindow (GLB_UIApplication)

@property(nonatomic) BOOL glb_userWindow;

@end

/*--------------------------------------------------*/

@interface UIViewController (GLB_UIApplication)
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
