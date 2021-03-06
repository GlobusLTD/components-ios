/*--------------------------------------------------*/

#import "GLBTextStyle.h"

/*--------------------------------------------------*/

#import "UIResponder+GLBUI.h"
#import "UIView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBLabel : UILabel

@property(nonatomic, nullable, readonly, strong) UILongPressGestureRecognizer* pressGesture;

@property(nonatomic, nullable, copy) GLBTextStyle* textStyle;

- (void)setup NS_REQUIRES_SUPER;

- (NSRange)addLink:(nonnull NSString*)link normalStyle:(nonnull GLBTextStyle*)normalStyle pressed:(nullable GLBSimpleBlock)pressed NS_SWIFT_NAME(addLink(string:normal:pressed:));
- (NSRange)addLink:(nonnull NSString*)link normalStyle:(nonnull GLBTextStyle*)normalStyle highlightStyle:(nullable GLBTextStyle*)highlightStyle pressed:(nullable GLBSimpleBlock)pressed NS_SWIFT_NAME(addLink(string:normal:highlight:pressed:));
- (void)addLinkRange:(NSRange)range normalStyle:(nonnull GLBTextStyle*)normalStyle pressed:(nullable GLBSimpleBlock)pressed NS_SWIFT_NAME(addLink(range:normal:pressed:));
- (void)addLinkRange:(NSRange)range normalStyle:(nonnull GLBTextStyle*)normalStyle highlightStyle:(nullable GLBTextStyle*)highlightStyle pressed:(nullable GLBSimpleBlock)pressed NS_SWIFT_NAME(addLink(range:normal:highlight:pressed:));
- (void)removeLinkRange:(NSRange)range;
- (void)removeLinkAllRanges;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
