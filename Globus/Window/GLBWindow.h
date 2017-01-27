/*--------------------------------------------------*/

#import "UIResponder+GLBUI.h"
#import "UIApplication+GLBUI.h"
#import "UIWindow+GLBUI.h"

/*--------------------------------------------------*/

#import "GLBTransitionController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBActivityView;

/*--------------------------------------------------*/

@interface GLBWindow : UIWindow

@property(nonatomic) BOOL hideKeyboardIfTouched;
@property(nonatomic, nullable, strong) GLBTransitionController* transition;
@property(nonatomic, nullable, strong) GLBActivityView* activityView;

- (void)setup NS_REQUIRES_SUPER;

- (void)changeRootViewController:(nonnull UIViewController*)rootViewController animated:(BOOL)animated NS_SWIFT_NAME(change(rootViewController:animated:));

@end

/*--------------------------------------------------*/

@protocol GLBWindowExtension < NSObject >

@required
@property(nonatomic, readonly, assign) BOOL hideKeyboardIfTouched;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
