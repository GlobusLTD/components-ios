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

@property(nonatomic) UIInterfaceOrientationMask supportedOrientationMask;

@property(nonatomic, nullable, strong) GLBActivityView* activityView;

+ (nullable instancetype)instantiate NS_SWIFT_NAME(instantiate());
+ (nullable instancetype)instantiateWithOptions:(nullable NSDictionary*)options NS_SWIFT_NAME(instantiate(options:));

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
