/*--------------------------------------------------*/

#import "GLBUI.h"

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

+ (instancetype _Nullable)glb_imageNamed:(NSString* _Nonnull)name capInsets:(UIEdgeInsets)capInsets;
+ (instancetype _Nullable)glb_imageWithColor:(UIColor* _Nonnull)color size:(CGSize)size;
+ (instancetype _Nullable)glb_imageWithColor:(UIColor* _Nonnull)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;
+ (instancetype _Nullable)glb_imageWithData:(NSData* _Nonnull)data;

- (UIImage* _Nullable)glb_unrotate;
- (UIImage* _Nullable)glb_scaleToSize:(CGSize)size;
- (UIImage* _Nullable)glb_rotateToAngleInRadians:(CGFloat)angleInRadians;

- (UIImage* _Nullable)glb_grayscale;
- (UIImage* _Nullable)glb_blackAndWhite;
- (UIImage* _Nullable)glb_invertColors;

- (UIImage* _Nullable)glb_blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor* _Nullable)tintColor;

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
