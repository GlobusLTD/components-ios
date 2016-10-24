/*--------------------------------------------------*/

#import "GLBTextStyle.h"

/*--------------------------------------------------*/

#import "UIResponder+GLBUI.h"
#import "UIView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBLabel : UILabel

@property(nonatomic, readonly, strong) UILongPressGestureRecognizer* pressGesture;

@property(nonatomic, copy) NSString* plainText;
@property(nonatomic, copy) GLBTextStyle* textStyle;

- (void)setup NS_REQUIRES_SUPER;

- (NSRange)addLink:(NSString*)link normalStyle:(GLBTextStyle*)normalStyle pressed:(GLBSimpleBlock)pressed;
- (NSRange)addLink:(NSString*)link normalStyle:(GLBTextStyle*)normalStyle highlightStyle:(GLBTextStyle*)highlightStyle pressed:(GLBSimpleBlock)pressed;
- (void)addLinkRange:(NSRange)range normalStyle:(GLBTextStyle*)normalStyle pressed:(GLBSimpleBlock)pressed;
- (void)addLinkRange:(NSRange)range normalStyle:(GLBTextStyle*)normalStyle highlightStyle:(GLBTextStyle*)highlightStyle pressed:(GLBSimpleBlock)pressed;
- (void)removeLinkRange:(NSRange)range;
- (void)removeLinkAllRanges;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
