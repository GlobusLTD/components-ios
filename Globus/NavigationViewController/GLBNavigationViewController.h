/*--------------------------------------------------*/

#import "UINavigationController+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBTransitionController;

/*--------------------------------------------------*/

@interface GLBNavigationViewController : UINavigationController< GLBViewController >

@property(nonatomic, readonly, assign, getter=isAppeared) BOOL appeared;
@property(nonatomic, nullable, strong) __kindof GLBTransitionController* transitionModal;
@property(nonatomic, nullable, strong) __kindof GLBTransitionController* transitionNavigation;
@property(nonatomic, nullable, strong) __kindof GLBTransitionController* transitionInteractive;

- (void)setup NS_REQUIRES_SUPER;

- (void)setNeedUpdate;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
