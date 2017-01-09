/*--------------------------------------------------*/

#import "GLBApiRequest.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBImageDownloadRequest : GLBApiRequest

+ (instancetype _Nonnull)requestWithUrl:(NSURL* _Nonnull)url;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/

