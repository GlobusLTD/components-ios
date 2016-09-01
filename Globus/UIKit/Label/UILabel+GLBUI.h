/*--------------------------------------------------*/

#import "NSString+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface UILabel (GLB_UI)

- (CGSize)glb_size;
- (CGSize)glb_sizeForWidth:(CGFloat)width;
- (CGSize)glb_sizeForSize:(CGSize)size;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
