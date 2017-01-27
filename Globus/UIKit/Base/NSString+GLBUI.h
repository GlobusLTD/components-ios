/*--------------------------------------------------*/

#include "GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface NSString (GLB_UI)

- (CGSize)glb_sizeWithFont:(nonnull UIFont*)font
             lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)glb_sizeWithFont:(nonnull UIFont*)font
                  forWidth:(CGFloat)width
             lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)glb_sizeWithFont:(nonnull UIFont*)font
                   forSize:(CGSize)size
             lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (void)glb_drawAtPoint:(CGPoint)point
                   font:(nonnull UIFont*)font
                  color:(nonnull UIColor*)color
             vAlignment:(GLBUIVerticalAlignment)vAlignment
             hAlignment:(GLBUIHorizontalAlignment)hAlignment
          lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (void)glb_drawInRect:(CGRect)rect
                  font:(nonnull UIFont*)font
                 color:(nonnull UIColor*)color
            vAlignment:(GLBUIVerticalAlignment)vAlignment
            hAlignment:(GLBUIHorizontalAlignment)hAlignment
         lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
