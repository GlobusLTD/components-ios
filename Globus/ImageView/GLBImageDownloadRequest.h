/*--------------------------------------------------*/

#import "GLBApiRequest.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBImageDownloadRequest : GLBApiRequest

+ (instancetype)requestWithUrl:(NSURL*)url;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/

