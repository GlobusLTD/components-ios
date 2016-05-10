/*--------------------------------------------------*/

#import "UIWindow+GLBUI.h"
#import "GLBActivityView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/


@protocol GLBWindowExtension < NSObject >

@required
@property(nonatomic, readonly, assign) BOOL hideKeyboardIfTouched;

@end

/*--------------------------------------------------*/

@interface GLBWindow : UIWindow

@property(nonatomic) BOOL hideKeyboardIfTouched;

@property(nonatomic, readonly, strong) GLBActivityView* activity;
@property(nonatomic) GLBActivityViewStyle activityStyle;

- (void)setup NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
