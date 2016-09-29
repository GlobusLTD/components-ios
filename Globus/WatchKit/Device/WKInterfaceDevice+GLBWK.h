/*--------------------------------------------------*/

#include "GLBWK.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_WATCHOS)
/*--------------------------------------------------*/

@interface WKInterfaceDevice (GLB_WK)

+ (NSString* _Nullable)glb_systemVersionString;
+ (NSComparisonResult)glb_compareSystemVersion:(NSString* _Nonnull)requiredVersion;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
