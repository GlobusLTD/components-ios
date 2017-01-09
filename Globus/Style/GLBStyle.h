/*--------------------------------------------------*/

#include "GLBUI.h"

/*--------------------------------------------------*/

typedef void(^GLBStyleBlock)(id _Nonnull target);

/*--------------------------------------------------*/

@interface GLBStyle : NSObject

@property(nonatomic, nullable, readonly, strong) NSString* name;
@property(nonatomic, nullable, readonly, strong) GLBStyle* parent;

+ (instancetype _Nonnull)styleWithName:(NSString* _Nonnull)name NS_SWIFT_NAME(style(name:));
+ (instancetype _Nonnull)styleWithName:(NSString* _Nonnull)name block:(GLBStyleBlock _Nonnull)block NS_SWIFT_UNAVAILABLE("Use init(name:block:)");
+ (instancetype _Nonnull)styleWithName:(NSString* _Nonnull)name parent:(GLBStyle* _Nullable)parent block:(GLBStyleBlock _Nonnull)block NS_SWIFT_UNAVAILABLE("Use init(name:parent:block:)");

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithName:(NSString* _Nonnull)name block:(GLBStyleBlock _Nonnull)block;
- (instancetype _Nonnull)initWithName:(NSString* _Nonnull)name parent:(GLBStyle* _Nullable)parent block:(GLBStyleBlock _Nonnull)block NS_DESIGNATED_INITIALIZER;

- (void)setup NS_REQUIRES_SUPER;

+ (void)unregisterStyleWithName:(NSString* _Nonnull)name;

@end

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface UIResponder (GLBStyle)

@property(nonatomic, nullable, strong) IBInspectable GLBStyle* glb_style;
@property(nonatomic, nullable, strong) IBInspectable NSString* glb_styleName;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
