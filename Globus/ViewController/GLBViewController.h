/*--------------------------------------------------*/

#import "GLBBaseViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBActivityView;

/*--------------------------------------------------*/

@interface GLBViewController : GLBBaseViewController

@property(nonatomic, getter=isAutomaticallyHideKeyboard) BOOL automaticallyHideKeyboard;
@property(nonatomic) UIInterfaceOrientationMask supportedOrientationMask;

@property(nonatomic, strong) GLBActivityView* activityView;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
