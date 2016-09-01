/*--------------------------------------------------*/

#import "NSArray+GLBNS.h"

/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBLayoutViewAlignment) {
    GLBLayoutViewAlignmentFill,
    GLBLayoutViewAlignmentCenter,
    GLBLayoutViewAlignmentLeading,
    GLBLayoutViewAlignmentTrailing,
};

/*--------------------------------------------------*/

@interface GLBLayoutView : UIView

@property(nonatomic) IBInspectable UILayoutConstraintAxis axis;
@property(nonatomic) IBInspectable GLBLayoutViewAlignment alignment;
@property(nonatomic) IBInspectable UIEdgeInsets margins;
@property(nonatomic) IBInspectable CGFloat spacing;

- (void)setup NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
