/*--------------------------------------------------*/

#import "GLBApiRequest.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBImageDownloadRequest : GLBApiRequest

+ (nonnull instancetype)requestWithUrl:(nonnull NSURL*)url;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/

