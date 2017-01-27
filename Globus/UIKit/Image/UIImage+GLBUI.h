/*--------------------------------------------------*/

#include "GLBUI.h"

/*--------------------------------------------------*/

#include "GLBRect.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef NS_OPTIONS(NSUInteger, GLBUIImageAlignment) {
    GLBUIImageAlignmentStretch,
    GLBUIImageAlignmentAspectFill,
    GLBUIImageAlignmentAspectFit
};

/*--------------------------------------------------*/

@interface UIImage (GLB_UI)

+ (nullable instancetype)glb_imageNamed:(nonnull NSString*)name renderingMode:(UIImageRenderingMode)renderingMode;
+ (nullable instancetype)glb_imageNamed:(nonnull NSString*)name capInsets:(UIEdgeInsets)capInsets;
+ (nullable instancetype)glb_imageWithColor:(nonnull UIColor*)color size:(CGSize)size;
+ (nullable instancetype)glb_imageWithColor:(nonnull UIColor*)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;
+ (nullable instancetype)glb_imageWithData:(nonnull NSData*)data;

- (nullable instancetype)glb_unrotate;
- (nullable instancetype)glb_scaleToSize:(CGSize)size;
- (nullable instancetype)glb_rotateToAngleInRadians:(CGFloat)angleInRadians;

- (nullable instancetype)glb_grayscale;
- (nullable instancetype)glb_blackAndWhite;
- (nullable instancetype)glb_invertColors;

- (nullable instancetype)glb_blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(nullable UIColor*)tintColor;

- (void)glb_drawInRect:(CGRect)rect alignment:(GLBUIImageAlignment)alignment;
- (void)glb_drawInRect:(CGRect)rect alignment:(GLBUIImageAlignment)alignment blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;
- (void)glb_drawInRect:(CGRect)rect alignment:(GLBUIImageAlignment)alignment radius:(CGFloat)radius;
- (void)glb_drawInRect:(CGRect)rect alignment:(GLBUIImageAlignment)alignment radius:(CGFloat)radius blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;
- (void)glb_drawInRect:(CGRect)rect alignment:(GLBUIImageAlignment)alignment corners:(UIRectCorner)corners radius:(CGFloat)radius;
- (void)glb_drawInRect:(CGRect)rect alignment:(GLBUIImageAlignment)alignment corners:(UIRectCorner)corners radius:(CGFloat)radius blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
