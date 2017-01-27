/*--------------------------------------------------*/

#include "GLBWK.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_WATCHOS)
/*--------------------------------------------------*/

@interface WKInterfaceDevice (GLB_WK)

+ (nullable NSString*)glb_systemVersionString;
+ (NSComparisonResult)glb_compareSystemVersion:(nonnull NSString*)requiredVersion;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
