/*--------------------------------------------------*/

#import "NSAttributedString+GLBNS.h"
#import "GLBUI.h"

/*--------------------------------------------------*/

@interface GLBTextStyle : NSObject

@property(nonatomic, strong, nullable) UIFont* font;
@property(nonatomic, strong, nullable) UIColor* color;
@property(nonatomic, strong, nullable) UIColor* backgroundColor;
@property(nonatomic, strong, nullable) UIColor* strikeColor;
@property(nonatomic) CGFloat strikeWidth;
@property(nonatomic) NSInteger strikeThrough;
@property(nonatomic, strong, nullable) UIColor* underlineColor;
@property(nonatomic) NSUnderlineStyle underlineStyle;
@property(nonatomic, strong, nullable) NSShadow* shadow;
@property(nonatomic, assign) CGSize shadowOffset;
@property(nonatomic, assign) CGFloat shadowBlurRadius;
@property(nonatomic, strong, nullable) UIColor* shadowColor;
@property(nonatomic) NSInteger ligature;
@property(nonatomic) CGFloat kerning;
@property(nonatomic) CGFloat baselineOffset;
@property(nonatomic) CGFloat obliqueness;
@property(nonatomic) CGFloat expansion;
@property(nonatomic, strong, nullable) NSParagraphStyle* paragraphStyle;
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

@property(nonatomic, strong, nullable) NSDictionary< NSString*, id >* attributes;

- (void)setup NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/
