/*--------------------------------------------------*/

#import "GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface UIColor (GLB_UI)

+ (UIColor* _Nullable)glb_colorWithString:(NSString* _Nonnull)string;
+ (CGFloat)glb_colorComponentFromString:(NSString* _Nonnull)string start:(NSUInteger)start length:(NSUInteger)length;

- (UIColor* _Nullable)glb_multiplyColor:(UIColor* _Nonnull)color percent:(CGFloat)percent;
- (UIColor* _Nullable)glb_multiplyBrightness:(CGFloat)brightness;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
