/*--------------------------------------------------*/

#import "UILabel+GLBUI.h"
#import "NSString+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation UILabel (GLB_UI)

- (CGSize)glb_size {
    return [self glb_sizeForSize:CGSizeMake(NSIntegerMax, NSIntegerMax)];
}

- (CGSize)glb_sizeForWidth:(CGFloat)width {
    return [self glb_sizeForSize:CGSizeMake(width, NSIntegerMax)];
}

- (CGSize)glb_sizeForSize:(CGSize)size {
    return [self.text glb_sizeWithFont:self.font
                               forSize:size
                         lineBreakMode:self.lineBreakMode];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
