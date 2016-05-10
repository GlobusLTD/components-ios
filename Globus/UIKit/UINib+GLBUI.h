/*--------------------------------------------------*/

#import "GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface UINib (GLB_UI)

+ (UINib*)glb_nibWithName:(NSString*)bame bundle:(NSBundle*)bundle;
+ (UINib*)glb_nibWithClass:(Class)class bundle:(NSBundle*)bundle;

+ (void)glb_setCacheForName:(NSString*)name nib:(UINib*)nib;
+ (UINib*)glb_cacheNibForName:(NSString*)name;
+ (UINib*)glb_cacheNibForClass:(Class)class;
+ (void)glb_removeCacheForName:(NSString*)name;

- (id)glb_instantiateWithClass:(Class)class owner:(id)owner options:(NSDictionary*)options;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
