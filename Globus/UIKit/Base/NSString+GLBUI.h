/*--------------------------------------------------*/

#import "GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface NSString (GLB_UI)

- (CGSize)glb_sizeWithFont:(UIFont* _Nonnull)font
             lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)glb_sizeWithFont:(UIFont* _Nonnull)font
                  forWidth:(CGFloat)width
             lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)glb_sizeWithFont:(UIFont* _Nonnull)font
                   forSize:(CGSize)size
             lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (void)glb_drawAtPoint:(CGPoint)point
                   font:(UIFont* _Nonnull)font
                  color:(UIColor* _Nonnull)color
             vAlignment:(GLBUIVerticalAlignment)vAlignment
             hAlignment:(GLBUIHorizontalAlignment)hAlignment
          lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (void)glb_drawInRect:(CGRect)rect
                  font:(UIFont* _Nonnull)font
                 color:(UIColor* _Nonnull)color
            vAlignment:(GLBUIVerticalAlignment)vAlignment
            hAlignment:(GLBUIHorizontalAlignment)hAlignment
         lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
