/*--------------------------------------------------*/

#import "NSAttributedString+GLBNS.h"
#import "GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_UNAVAILABLE_WATCHOS)
@class NSShadow;
#endif
/*--------------------------------------------------*/

@interface GLBTextStyle : NSObject

@property(nonatomic, nullable, strong) UIFont* font;
@property(nonatomic, nullable, strong) UIColor* color;
@property(nonatomic, nullable, strong) UIColor* backgroundColor;
@property(nonatomic, nullable, strong) UIColor* strikeColor;
@property(nonatomic) CGFloat strikeWidth;
@property(nonatomic) NSInteger strikeThrough;
@property(nonatomic, nullable, strong) UIColor* underlineColor;
@property(nonatomic) NSUnderlineStyle underlineStyle;
@property(nonatomic, nullable, strong) NSShadow* shadow GLB_UNAVAILABLE_WATCHOS;
@property(nonatomic) CGSize shadowOffset GLB_UNAVAILABLE_WATCHOS;
@property(nonatomic) CGFloat shadowBlurRadius GLB_UNAVAILABLE_WATCHOS;
@property(nonatomic, nullable, strong) UIColor* shadowColor GLB_UNAVAILABLE_WATCHOS;
@property(nonatomic) NSInteger ligature;
@property(nonatomic) CGFloat kerning;
@property(nonatomic) CGFloat baselineOffset;
@property(nonatomic) CGFloat obliqueness;
@property(nonatomic) CGFloat expansion;
@property(nonatomic, nullable, strong) NSParagraphStyle* paragraphStyle;
@property(nonatomic) CGFloat lineSpacing;
@property(nonatomic) CGFloat paragraphBetween;
@property(nonatomic) NSTextAlignment alignment;
@property(nonatomic) CGFloat firstLineHeadIndent;
@property(nonatomic) CGFloat headIndent;
@property(nonatomic) CGFloat tailIndent;
@property(nonatomic) NSLineBreakMode lineBreakMode;
@property(nonatomic) CGFloat minimumLineHeight;
@property(nonatomic) CGFloat maximumLineHeight;
@property(nonatomic) NSWritingDirection baseWritingDirection;
@property(nonatomic) CGFloat lineHeightMultiple;
@property(nonatomic) CGFloat paragraphSpacingBefore;
@property(nonatomic) CGFloat hyphenationFactor;

@property(nonatomic, nullable, strong) NSDictionary< NSString*, id >* attributes;

- (void)setup NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/
