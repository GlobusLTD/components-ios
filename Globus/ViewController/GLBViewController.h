/*--------------------------------------------------*/

#import "UINib+GLBUI.h"

/*--------------------------------------------------*/

#import "GLBBaseViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBActivityView;

/*--------------------------------------------------*/

@interface GLBViewController : GLBBaseViewController < GLBNibExtension >

@property(nonatomic, getter=isAutomaticallyHideKeyboard) BOOL automaticallyHideKeyboard;
@property(nonatomic) UIInterfaceOrientationMask supportedOrientationMask;

@property(nonatomic, strong) GLBActivityView* activityView;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
