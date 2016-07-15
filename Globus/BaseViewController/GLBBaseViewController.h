/*--------------------------------------------------*/

#import "UIViewController+GLBUI.h"
#import "GLBWindow.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBTransitionController;

/*--------------------------------------------------*/

@interface GLBBaseViewController : UIViewController< GLBWindowExtension >

@property(nonatomic, readonly, assign, getter=isAppeared) BOOL appeared;
@property(nonatomic, assign) BOOL clearWhenDisapper;

@property(nonatomic, getter=isStatusBarHidden) BOOL statusBarHidden;
@property(nonatomic) UIStatusBarStyle statusBarStyle;
@property(nonatomic) UIStatusBarAnimation statusBarAnimation;
@property(nonatomic, getter=isNavigationBarHidden) BOOL navigationBarHidden;
@property(nonatomic, getter=isToolbarHidden) BOOL toolbarHidden;
@property(nonatomic) BOOL hidesBarsWhenKeyboardAppears;
@property(nonatomic) BOOL hidesBarsOnSwipe;
@property(nonatomic) BOOL hidesBarsWhenVerticallyCompact;
@property(nonatomic) BOOL hidesBarsOnTap;
@property(nonatomic) BOOL hideKeyboardIfTouched;
@property(nonatomic, strong) GLBTransitionController* transitionModal;

- (void)setup NS_REQUIRES_SUPER;

- (void)setNavigationBarHidden:(BOOL)navigationBarHidden animated:(BOOL)animated;
- (void)setToolbarHidden:(BOOL)toolbarHidden animated:(BOOL)animated;

- (void)setNeedUpdate;
- (void)update NS_REQUIRES_SUPER;
- (void)clear NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
