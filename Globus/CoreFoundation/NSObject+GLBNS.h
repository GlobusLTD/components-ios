/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

@protocol GLBObjectDebugProtocol <NSObject>

@required
- (void)glb_debugString:(NSMutableString* _Nonnull)string indent:(NSUInteger)indent root:(BOOL)root;

@end

/*--------------------------------------------------*/

@interface NSObject (GLB_NS) < GLBObjectDebugProtocol >

+ (NSString* _Nonnull)glb_className;
- (NSString* _Nonnull)glb_className;

- (NSString* _Nullable)glb_debug;
- (NSString* _Nullable)glb_debugIndent:(NSUInteger)indent root:(BOOL)root;

@end

/*--------------------------------------------------*/
