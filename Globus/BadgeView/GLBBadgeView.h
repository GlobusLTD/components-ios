/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBBadgeView : UIView

@property(nonatomic, copy) IBInspectable NSString* text;
@property(nonatomic) IBInspectable UIEdgeInsets textInsets;
@property(nonatomic, strong) IBInspectable UIColor* textColor;
@property(nonatomic, strong) IBInspectable UIFont* textFont;
@property(nonatomic, strong) IBInspectable UIColor* textShadowColor;
@property(nonatomic) IBInspectable CGFloat textShadowRadius;
@property(nonatomic) IBInspectable CGSize textShadowOffset;

@property(nonatomic) IBInspectable CGSize minimumSize;
@property(nonatomic) IBInspectable CGSize maximumSize;

- (void)setup NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
