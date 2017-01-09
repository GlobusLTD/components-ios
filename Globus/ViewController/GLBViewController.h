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

@property(nonatomic, nullable, strong) GLBActivityView* activityView;

+ (instancetype _Nullable)instantiate NS_SWIFT_NAME(instantiate());
+ (instancetype _Nullable)instantiateWithOptions:(NSDictionary* _Nullable)options NS_SWIFT_NAME(instantiate(options:));

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
