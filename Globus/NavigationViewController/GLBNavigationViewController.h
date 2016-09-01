/*--------------------------------------------------*/

#import "UINavigationController+GLBUI.h"
#import "UIDevice+GLBUI.h"

/*--------------------------------------------------*/

#import "GLBTransitionController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBNavigationViewController : UINavigationController< GLBViewController >

@property(nonatomic, readonly, assign, getter=isAppeared) BOOL appeared;
@property(nonatomic, nullable, strong) __kindof GLBTransitionController* transitionModal;
@property(nonatomic, nullable, strong) __kindof GLBTransitionController* transitionNavigation;

- (void)setup NS_REQUIRES_SUPER;

- (void)setNeedUpdate;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
