/*--------------------------------------------------*/

#import "GLBTextStyle.h"

/*--------------------------------------------------*/

#import "NSDictionary+GLBNS.h"

/*--------------------------------------------------*/

@interface GLBTextStyle ()

@property(nonatomic, nullable, strong) NSMutableParagraphStyle* mutParagraphStyle;

@end

/*--------------------------------------------------*/

@implementation GLBTextStyle

#pragma mark - Synthesize

#if defined(GLB_TARGET_IOS)
@synthesize shadow = _shadow;
#endif
@synthesize mutParagraphStyle = _mutParagraphStyle;

#pragma mark - Init / Free

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _ligature = 1;
}

- (void)dealloc {
}

#pragma mark - Property

#if defined(GLB_TARGET_IOS)

- (void)setShadow:(NSShadow*)shadow {
    if(_shadow != shadow) {
        _shadow = shadow;
    }
}

- (NSShadow*)shadow {
    if(_shadow == nil) {
        _shadow = [NSShadow new];
    }
    return _shadow;
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    self.shadow.shadowOffset = shadowOffset;
}

- (CGSize)shadowOffset {
    return self.shadow.shadowOffset;
}

- (void)setShadowBlurRadius:(CGFloat)shadowBlurRadius {
    self.shadow.shadowBlurRadius = shadowBlurRadius;
}

- (CGFloat)shadowBlurRadius {
    return self.shadow.shadowBlurRadius;
}

- (void)setShadowColor:(UIColor*)shadowColor {
    self.shadow.shadowColor = shadowColor;
}

- (UIColor*)shadowColor {
    return self.shadow.shadowColor;
}

#endif

- (void)setParagraphStyle:(NSParagraphStyle*)paragraphStyle{
    if(_mutParagraphStyle != paragraphStyle) {
        if(paragraphStyle != nil) {
            NSMutableParagraphStyle* ps = self.mutParagraphStyle;
            
            ps.lineSpacing = paragraphStyle.lineSpacing;
            ps.paragraphSpacing = paragraphStyle.paragraphSpacing;
            ps.alignment = paragraphStyle.alignment;
            ps.firstLineHeadIndent = paragraphStyle.firstLineHeadIndent;
            ps.headIndent = paragraphStyle.headIndent;
            ps.tailIndent = paragraphStyle.tailIndent;
            ps.lineBreakMode = paragraphStyle.lineBreakMode;
            ps.minimumLineHeight = paragraphStyle.minimumLineHeight;
            ps.maximumLineHeight = paragraphStyle.maximumLineHeight;
            ps.baseWritingDirection = paragraphStyle.baseWritingDirection;
            ps.lineHeightMultiple = paragraphStyle.lineHeightMultiple;
            ps.paragraphSpacingBefore = paragraphStyle.paragraphSpacingBefore;
            ps.hyphenationFactor = paragraphStyle.hyphenationFactor;
        } else {
            _mutParagraphStyle = nil;
        }
    }
}

- (NSParagraphStyle*)paragraphStyle {
    return self.mutParagraphStyle;
}

- (void)setLineSpacing:(CGFloat)lineSpacing {
    self.mutParagraphStyle.lineSpacing = lineSpacing;
}

- (CGFloat)lineSpacing {
    return self.mutParagraphStyle.lineSpacing;
}

- (void)setParagraphSpacing:(CGFloat)paragraphSpacing {
    self.mutParagraphStyle.paragraphSpacing = paragraphSpacing;
}

- (CGFloat)paragraphSpacing {
    return self.mutParagraphStyle.paragraphSpacing;
}

- (void)setAlignment:(NSTextAlignment)alignment {
    self.mutParagraphStyle.alignment = alignment;
}

- (NSTextAlignment)alignment {
    return self.mutParagraphStyle.alignment;
}

- (void)setFirstLineHeadIndent:(CGFloat)firstLineHeadIndent {
    self.mutParagraphStyle.firstLineHeadIndent = firstLineHeadIndent;
}

- (CGFloat)firstLineHeadIndent {
    return self.mutParagraphStyle.firstLineHeadIndent;
}

- (void)setHeadIndent:(CGFloat)headIndent {
    self.mutParagraphStyle.headIndent = headIndent;
}

- (CGFloat)headIndent {
    return self.mutParagraphStyle.headIndent;
}

- (void)setTailIndent:(CGFloat)tailIndent {
    self.mutParagraphStyle.tailIndent = tailIndent;
}

- (CGFloat)tailIndent {
    return self.mutParagraphStyle.tailIndent;
}

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode {
    self.mutParagraphStyle.lineBreakMode = lineBreakMode;
}

- (NSLineBreakMode)lineBreakMode {
    return self.mutParagraphStyle.lineBreakMode;
}

- (void)setMinimumLineHeight:(CGFloat)minimumLineHeight {
    self.mutParagraphStyle.minimumLineHeight = minimumLineHeight;
}

- (CGFloat)minimumLineHeight {
    return self.mutParagraphStyle.minimumLineHeight;
}

- (void)setMaximumLineHeight:(CGFloat)maximumLineHeight {
    self.mutParagraphStyle.maximumLineHeight = maximumLineHeight;
}

- (CGFloat)maximumLineHeight {
    return self.mutParagraphStyle.maximumLineHeight;
}

- (void)setBaseWritingDirection:(NSWritingDirection)baseWritingDirection {
    self.mutParagraphStyle.baseWritingDirection = baseWritingDirection;
}

- (NSWritingDirection)baseWritingDirection {
    return self.mutParagraphStyle.baseWritingDirection;
}

- (void)setLineHeightMultiple:(CGFloat)lineHeightMultiple {
    self.mutParagraphStyle.lineHeightMultiple = lineHeightMultiple;
}

- (CGFloat)lineHeightMultiple {
    return self.mutParagraphStyle.lineHeightMultiple;
}

- (void)setParagraphSpacingBefore:(CGFloat)paragraphSpacingBefore {
    self.mutParagraphStyle.paragraphSpacingBefore = paragraphSpacingBefore;
}

- (CGFloat)paragraphSpacingBefore {
    return self.mutParagraphStyle.paragraphSpacingBefore;
}

- (void)setHyphenationFactor:(CGFloat)hyphenationFactor {
    self.mutParagraphStyle.hyphenationFactor = (float)(hyphenationFactor);
}

- (CGFloat)hyphenationFactor {
    return self.mutParagraphStyle.hyphenationFactor;
}

- (void)setAttributes:(NSDictionary< NSString*, id >*)attributes {
    self.font = [attributes glb_objectForKey:NSFontAttributeName orDefault:nil];
    self.color = [attributes glb_objectForKey:NSForegroundColorAttributeName orDefault:nil];
    self.backgroundColor = [attributes glb_objectForKey:NSBackgroundColorAttributeName orDefault:nil];
    self.strikeColor = [attributes glb_objectForKey:NSStrokeColorAttributeName orDefault:nil];
    self.strikeWidth = [[attributes glb_numberForKey:NSStrokeWidthAttributeName orDefault:nil] floatValue];
    self.strikeThrough = [[attributes glb_numberForKey:NSStrikethroughStyleAttributeName orDefault:nil] integerValue];
    self.underlineColor = [attributes glb_objectForKey:NSUnderlineColorAttributeName orDefault:nil];
#if defined(GLB_TARGET_IOS)
    self.shadow = [attributes glb_objectForKey:NSShadowAttributeName orDefault:nil];
#endif
    self.ligature = [[attributes glb_numberForKey:NSLigatureAttributeName orDefault:@(1)] integerValue];
    self.kerning = [[attributes glb_numberForKey:NSKernAttributeName orDefault:nil] floatValue];
    self.baselineOffset = [[attributes glb_numberForKey:NSBaselineOffsetAttributeName orDefault:nil] floatValue];
    self.obliqueness = [[attributes glb_numberForKey:NSObliquenessAttributeName orDefault:nil] floatValue];
    self.expansion = [[attributes glb_numberForKey:NSExpansionAttributeName orDefault:nil] floatValue];
    self.paragraphStyle = [attributes glb_objectForKey:NSParagraphStyleAttributeName orDefault:nil];
}

- (NSDictionary< NSString*, id >*)attributes {
    NSMutableDictionary* attributes = [NSMutableDictionary new];
    if(_font != nil) {
        attributes[NSFontAttributeName] = _font;
    }
    if(_color != nil) {
        attributes[NSForegroundColorAttributeName] = _color;
    }
    if(_backgroundColor != nil) {
        attributes[NSBackgroundColorAttributeName] = _backgroundColor;
    }
    if(_strikeColor != nil) {
        attributes[NSStrokeColorAttributeName] = _strikeColor;
    }
    if(ABS(_strikeWidth) > FLT_EPSILON) {
        attributes[NSStrokeWidthAttributeName] = @(_strikeWidth);
    }
    if(ABS(_strikeThrough) > 0) {
        attributes[NSStrikethroughStyleAttributeName] = @(_strikeThrough);
    }
    if(_underlineColor != nil) {
        attributes[NSUnderlineColorAttributeName] = _underlineColor;
    }
    if(_underlineStyle != NSUnderlineStyleNone) {
        attributes[NSUnderlineStyleAttributeName] = @(_underlineStyle);
    }
#if defined(GLB_TARGET_IOS)
    if(_shadow != nil) {
        attributes[NSShadowAttributeName] = _shadow;
    }
#endif
    if(ABS(_ligature) > 1) {
        attributes[NSLigatureAttributeName] = @(_ligature);
    }
    if(ABS(_kerning) > FLT_EPSILON) {
        attributes[NSKernAttributeName] = @(_kerning);
    }
    if(ABS(_baselineOffset) > FLT_EPSILON) {
        attributes[NSBaselineOffsetAttributeName] = @(_baselineOffset);
    }
    if(ABS(_obliqueness) > FLT_EPSILON) {
        attributes[NSObliquenessAttributeName] = @(_obliqueness);
    }
    if(ABS(_expansion) > FLT_EPSILON) {
        attributes[NSExpansionAttributeName] = @(_expansion);
    }
    if(_mutParagraphStyle != nil) {
        attributes[NSParagraphStyleAttributeName] = _mutParagraphStyle;
    }
    return attributes;
}

#pragma mark - Property internal

- (NSMutableParagraphStyle*)mutParagraphStyle {
    if(_mutParagraphStyle == nil) {
        _mutParagraphStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    }
    return _mutParagraphStyle;
}

@end

/*--------------------------------------------------*/
