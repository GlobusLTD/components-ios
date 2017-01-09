/*--------------------------------------------------*/

#import "GLBRect.h"

/*--------------------------------------------------*/

#import "GLBTransitionController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBSlideTransitionController : GLBTransitionController

@property(nonatomic) CGFloat ratio;

- (instancetype)initWithRatio:(CGFloat)ratio;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
