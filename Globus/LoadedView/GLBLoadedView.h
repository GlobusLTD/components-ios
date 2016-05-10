/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBLoadedView : UIView

@property(nonatomic, strong) IBOutlet UIView* rootView;
@property(nonatomic) UIEdgeInsets rootEdgeInsets;

- (void)setup NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
