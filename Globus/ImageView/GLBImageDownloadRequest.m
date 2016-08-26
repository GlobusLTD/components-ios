/*--------------------------------------------------*/

#import "GLBImageDownloadRequest.h"
#import "GLBImageDownloadResponse.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBImageDownloadRequest

+ (instancetype)requestWithUrl:(NSURL*)url {
    GLBImageDownloadRequest* request = [self new];
    request.method = @"GET";
    request.url = [url absoluteString];
    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    return request;
}

+ (Class)responseClass {
    return GLBImageDownloadResponse.class;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
