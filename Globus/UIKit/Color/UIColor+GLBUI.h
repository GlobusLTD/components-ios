/*--------------------------------------------------*/

#include "GLBUI.h"

/*--------------------------------------------------*/

@interface UIColor (GLB_UI)

+ (nullable UIColor*)glb_colorWithString:(nonnull NSString*)string;
+ (CGFloat)glb_colorComponentFromString:(nonnull NSString*)string start:(NSUInteger)start length:(NSUInteger)length;

- (nullable NSString*)glb_stringValue;

- (nullable UIColor*)glb_multiplyColor:(nonnull UIColor*)color percent:(CGFloat)percent;
- (nullable UIColor*)glb_multiplyBrightness:(CGFloat)brightness;

@end

/*--------------------------------------------------*/
