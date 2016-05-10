/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

@interface NSError (GLB_NS)

- (BOOL)glb_isURLError;
- (BOOL)glb_URLErrorConnectedToInternet;
- (BOOL)glb_URLErrorCancelled;
- (BOOL)glb_URLErrorTimedOut;

@end

/*--------------------------------------------------*/
