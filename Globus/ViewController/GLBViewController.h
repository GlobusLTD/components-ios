/*--------------------------------------------------*/

#import "GLBBaseViewController.h"
#import "GLBActivityView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBViewController : GLBBaseViewController

@property(nonatomic, getter=isAutomaticallyHideKeyboard) BOOL automaticallyHideKeyboard;
@property(nonatomic) UIInterfaceOrientationMask supportedOrientationMask;

@property(nonatomic, readonly, strong) GLBActivityView* activity;
@property(nonatomic) GLBActivityViewStyle activityStyle;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
