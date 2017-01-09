/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBBadgeView : UIView

@property(nonatomic, nullable, copy) IBInspectable NSString* text;
@property(nonatomic) IBInspectable UIEdgeInsets textInsets;
@property(nonatomic, nullable, strong) IBInspectable UIColor* textColor;
@property(nonatomic, nullable, strong) IBInspectable UIFont* textFont;
@property(nonatomic, nullable, strong) IBInspectable UIColor* textShadowColor;
@property(nonatomic) IBInspectable CGFloat textShadowRadius;
@property(nonatomic) IBInspectable CGSize textShadowOffset;

@property(nonatomic) IBInspectable CGSize minimumSize;
@property(nonatomic) IBInspectable CGSize maximumSize;

- (void)setup NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
