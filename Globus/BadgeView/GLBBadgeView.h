/*--------------------------------------------------*/

#import "UIView+GLBUI.h"
#import "GLBLabel.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBBadgeView : UIView

@property(nonatomic, nonnull, readonly, strong) GLBLabel* textLabel;
@property(nonatomic) IBInspectable UIEdgeInsets textInsets;

@property(nonatomic) IBInspectable CGSize minimumSize;
@property(nonatomic) IBInspectable CGSize maximumSize;

- (void)setup NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
