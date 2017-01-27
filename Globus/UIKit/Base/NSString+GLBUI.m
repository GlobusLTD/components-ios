/*--------------------------------------------------*/

#import "NSString+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation NSString (GLB_UI)

- (CGSize)glb_sizeWithFont:(UIFont*)font
             lineBreakMode:(NSLineBreakMode)lineBreakMode {
    return [self glb_sizeWithFont:font
                          forSize:CGSizeMake(NSIntegerMax, NSIntegerMax)
                    lineBreakMode:lineBreakMode];
}

- (CGSize)glb_sizeWithFont:(UIFont*)font
                  forWidth:(CGFloat)width
             lineBreakMode:(NSLineBreakMode)lineBreakMode {
    return [self glb_sizeWithFont:font
                          forSize:CGSizeMake(width, NSIntegerMax)
                    lineBreakMode:lineBreakMode];
}

- (CGSize)glb_sizeWithFont:(UIFont*)font
                   forSize:(CGSize)size
             lineBreakMode:(NSLineBreakMode)lineBreakMode {
    NSMutableParagraphStyle* paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = lineBreakMode;
    NSDictionary* attributes = @{
        NSFontAttributeName : font,
        NSParagraphStyleAttributeName : paragraphStyle
    };
    CGRect textRect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attributes
                                         context:nil];
    if(textRect.size.height < font.lineHeight) {
        textRect.size.height = font.lineHeight;
    }
    return CGSizeMake(GLB_CEIL(textRect.size.width), GLB_CEIL(textRect.size.height));
}

- (void)glb_drawAtPoint:(CGPoint)point
                   font:(UIFont*)font
                  color:(UIColor*)color
             vAlignment:(GLBUIVerticalAlignment)vAlignment
             hAlignment:(GLBUIHorizontalAlignment)hAlignment
          lineBreakMode:(NSLineBreakMode)lineBreakMode {
    NSStringDrawingOptions options = (NSStringDrawingOptions)(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine);
    NSMutableParagraphStyle* paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = lineBreakMode;
    NSDictionary* attributes = @{
        NSFontAttributeName: font,
        NSForegroundColorAttributeName: color,
        NSParagraphStyleAttributeName: paragraphStyle
    };
    CGRect boundingRect = [self boundingRectWithSize:CGSizeMake(NSIntegerMax, NSIntegerMax)
                                             options:options
                                          attributes:attributes
                                             context:nil];
    CGRect rect = CGRectMake(point.x, point.y, boundingRect.size.width, boundingRect.size.height);
    switch(hAlignment) {
        case GLBUIHorizontalAlignmentCenter: rect.origin.x -= rect.size.width * 0.5f; break;
        case GLBUIHorizontalAlignmentRight: rect.origin.x -= rect.size.width; break;
        default: break;
    }
    switch(vAlignment) {
        case GLBUIVerticalAlignmentCenter: rect.origin.y -= rect.size.height * 0.5f; break;
        case GLBUIVerticalAlignmentBottom: rect.origin.y -= rect.size.height; break;
        default: break;
    }
    [self drawWithRect:CGRectMake(GLB_FLOOR(rect.origin.x), GLB_FLOOR(rect.origin.y), GLB_CEIL(rect.size.width), GLB_CEIL(rect.size.height))
               options:options
            attributes:attributes
               context:nil];
}

- (void)glb_drawInRect:(CGRect)rect
                  font:(UIFont*)font
                 color:(UIColor*)color
            vAlignment:(GLBUIVerticalAlignment)vAlignment
            hAlignment:(GLBUIHorizontalAlignment)hAlignment
         lineBreakMode:(NSLineBreakMode)lineBreakMode {
    NSStringDrawingOptions options = (NSStringDrawingOptions)(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine);
    NSMutableParagraphStyle* paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = lineBreakMode;
    NSDictionary* attributes = @{
        NSFontAttributeName: font,
        NSForegroundColorAttributeName: color,
        NSParagraphStyleAttributeName: paragraphStyle
    };
    CGRect boundingRect = [self boundingRectWithSize:rect.size options:options attributes:attributes context:nil];
    switch(hAlignment) {
        case GLBUIHorizontalAlignmentCenter: rect.origin.x -= (boundingRect.size.width * 0.5f) - (rect.size.width * 0.5f); break;
        case GLBUIHorizontalAlignmentRight: rect.origin.x -= boundingRect.size.width - rect.size.width; break;
        default: break;
    }
    switch(vAlignment) {
        case GLBUIVerticalAlignmentCenter: rect.origin.y -= (boundingRect.size.height * 0.5f) - (rect.size.height * 0.5f); break;
        case GLBUIVerticalAlignmentBottom: rect.origin.y -= boundingRect.size.height - rect.size.height; break;
        default: break;
    }
    [self drawWithRect:CGRectMake(GLB_FLOOR(rect.origin.x), GLB_FLOOR(rect.origin.y), GLB_CEIL(rect.size.width), GLB_CEIL(rect.size.height))
               options:options
            attributes:attributes
               context:nil];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
