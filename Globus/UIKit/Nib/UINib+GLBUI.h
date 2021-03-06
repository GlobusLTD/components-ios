/*--------------------------------------------------*/

#import "UIDevice+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface UINib (GLB_UI)

+ (UINib*)glb_nibWithName:(NSString*)name;
+ (UINib*)glb_nibWithClass:(Class)aClass;
+ (UINib*)glb_nibWithName:(NSString*)name bundle:(NSBundle*)bundle;
+ (UINib*)glb_nibWithClass:(Class)aClass bundle:(NSBundle*)bundle;

+ (void)glb_setCacheForName:(NSString*)name nib:(UINib*)nib;
+ (UINib*)glb_cacheNibForName:(NSString*)name;
+ (UINib*)glb_cacheNibForClass:(Class)aClass;
+ (void)glb_removeCacheForName:(NSString*)name;

- (id)glb_instantiateWithClass:(Class)aClass owner:(id)owner options:(NSDictionary*)options;

@end

/*--------------------------------------------------*/

@interface UIResponder (GLBNib)

+ (UINib*)glb_nib;

@end

/*--------------------------------------------------*/

@protocol GLBNibExtension < NSObject >

@required
+ (NSString*)nibName;
+ (NSBundle*)nibBundle;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
