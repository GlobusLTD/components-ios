/*--------------------------------------------------*/

#include "GLBUI.h"

/*--------------------------------------------------*/

typedef void(^GLBStyleBlock)(id target);

/*--------------------------------------------------*/

@interface GLBStyle : NSObject

@property(nonatomic, readonly, strong) NSString* name;
@property(nonatomic, readonly, strong) GLBStyle* parent;

+ (instancetype)styleWithName:(NSString*)name;
+ (instancetype)styleWithName:(NSString*)name block:(GLBStyleBlock)block;
+ (instancetype)styleWithName:(NSString*)name parent:(GLBStyle*)parent block:(GLBStyleBlock)block;

- (instancetype)initWithName:(NSString*)name block:(GLBStyleBlock)block;
- (instancetype)initWithName:(NSString*)name parent:(GLBStyle*)parent block:(GLBStyleBlock)block;

- (void)setup NS_REQUIRES_SUPER;

+ (void)unregisterStyleWithName:(NSString*)name;

@end

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface UIResponder (GLBStyle)

@property(nonatomic, strong) IBInspectable GLBStyle* glb_style;
@property(nonatomic, strong) IBInspectable NSString* glb_styleName;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
