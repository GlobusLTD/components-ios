/*--------------------------------------------------*/

#include "GLBUI.h"

/*--------------------------------------------------*/

typedef void(^GLBStyleBlock)(id _Nonnull target);

/*--------------------------------------------------*/

@interface GLBStyle : NSObject

@property(nonatomic, nullable, readonly, strong) NSString* name;
@property(nonatomic, nullable, readonly, strong) GLBStyle* parent;

+ (nonnull instancetype)styleWithName:(nonnull NSString*)name NS_SWIFT_NAME(style(name:));
+ (nonnull instancetype)styleWithName:(nonnull NSString*)name block:(nonnull GLBStyleBlock)block NS_SWIFT_UNAVAILABLE("Use init(name:block:)");
+ (nonnull instancetype)styleWithName:(nonnull NSString*)name parent:(nullable GLBStyle*)parent block:(nonnull GLBStyleBlock)block NS_SWIFT_UNAVAILABLE("Use init(name:parent:block:)");

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithName:(nonnull NSString*)name block:(nonnull GLBStyleBlock)block;
- (nonnull instancetype)initWithName:(nonnull NSString*)name parent:(nullable GLBStyle*)parent block:(nonnull GLBStyleBlock)block NS_DESIGNATED_INITIALIZER;

- (void)setup NS_REQUIRES_SUPER;

+ (void)unregisterStyleWithName:(nonnull NSString*)name;

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
