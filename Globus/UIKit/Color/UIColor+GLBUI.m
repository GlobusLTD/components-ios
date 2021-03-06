/*--------------------------------------------------*/

#import "UIColor+GLBUI.h"

/*--------------------------------------------------*/

@implementation UIColor (GLB_UI)

+ (UIColor*)glb_colorWithString:(NSString*)string {
    UIColor* result = nil;
    NSRange range = [string rangeOfString:@"#"];
    if((range.location != NSNotFound) && (range.length > 0)) {
        CGFloat red = 1, blue = 1, green = 1, alpha = 1;
        NSString* colorString = [[string stringByReplacingCharactersInRange:range withString:@""] uppercaseString];
        switch (colorString.length) {
            case 2: // #GG
                red = green = blue = [self glb_colorComponentFromString:colorString start:0 length:2];
                break;
            case 6: // #RRGGBB
                red = [self glb_colorComponentFromString:colorString start:0 length:2];
                green = [self glb_colorComponentFromString:colorString start:2 length:2];
                blue = [self glb_colorComponentFromString:colorString start:4 length:2];
                break;
            case 8: // #RRGGBBAA
                red = [self glb_colorComponentFromString:colorString start:0 length:2];
                green = [self glb_colorComponentFromString:colorString start:2 length:2];
                blue = [self glb_colorComponentFromString:colorString start:4 length:2];
                alpha = [self glb_colorComponentFromString:colorString start:6 length:2];
                break;
        }
        result = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    }
    return result;
}

+ (CGFloat)glb_colorComponentFromString:(NSString*)string start:(NSUInteger)start length:(NSUInteger)length {
    unsigned result = 0;
    NSString* part = [string substringWithRange:NSMakeRange(start, length)];
    if(part != nil) {
        NSScanner* scaner = [NSScanner scannerWithString:part];
        if(scaner != nil) {
            [scaner scanHexInt:&result];
        }
    }
    return (result / (CGFloat)(255));
}

- (NSString*)glb_stringValue {
    CGFloat r, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return [NSString stringWithFormat:@"#%02X%02X%02X%02X", (int)(255 * r), (int)(255 * g), (int)(255 * b), (int)(255 * a)];
}

- (UIColor*)glb_multiplyColor:(UIColor*)color percent:(CGFloat)percent {
    CGFloat alpha = MAX(0, MIN(percent, 1));
    CGFloat r1, g1, b1, a1;
    CGFloat r2, g2, b2, a2;
    [self getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    [color getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    return [UIColor colorWithRed:(r1 * (1 - alpha)) + (r2 * alpha)
                           green:(g1 * (1 - alpha)) + (g2 * alpha)
                            blue:(b1 * (1 - alpha)) + (b2 * alpha)
                           alpha:(a1 * (1 - alpha)) + (a2 * alpha)];
}

- (UIColor*)glb_multiplyBrightness:(CGFloat)brightness {
    CGFloat h, s, b, a;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    return [UIColor colorWithHue:h saturation:s brightness:b * brightness alpha:a];
}

@end

/*--------------------------------------------------*/
