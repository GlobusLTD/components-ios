/*--------------------------------------------------*/

#import "UIResponder+GLBUI.h"
#import "UIApplication+GLBUI.h"
#import "UIWindow+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBActivityView;

/*--------------------------------------------------*/

@interface GLBWindow : UIWindow

@property(nonatomic) BOOL hideKeyboardIfTouched;

@property(nonatomic, strong) GLBActivityView* activityView;

- (void)setup NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/

@protocol GLBWindowExtension < NSObject >

@required
@property(nonatomic, readonly, assign) BOOL hideKeyboardIfTouched;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
