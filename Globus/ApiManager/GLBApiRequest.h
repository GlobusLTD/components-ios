/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"
#import "NSObject+GLBDebug.h"

/*--------------------------------------------------*/

@class GLBApiProvider;
@class GLBApiRequestUploadItem;
@class GLBApiResponse;

/*--------------------------------------------------*/

@interface GLBApiRequest : NSObject < GLBObjectDebugProtocol >

@property(nonatomic, nullable, readonly, strong) __kindof GLBApiProvider* provider;

@property(nonatomic, nullable, copy) NSString* url;
@property(nonatomic, nullable, copy) NSDictionary* urlParams;
@property(nonatomic) BOOL encodeUrlParams;
@property(nonatomic) BOOL includeArraySymbolsUrlParams;
@property(nonatomic, nullable, copy) NSString* method;
@property(nonatomic, nullable, copy) NSDictionary* headers;
@property(nonatomic, nullable, copy) NSData* bodyData;
@property(nonatomic, nullable, copy) NSDictionary* bodyParams;
@property(nonatomic, nullable, copy) NSString* bodyBoundary;
@property(nonatomic) BOOL encodeBodyParams;
@property(nonatomic, nullable, copy) NSArray< __kindof GLBApiRequestUploadItem* >* uploadItems;
@property(nonatomic) NSTimeInterval timeout;
@property(nonatomic) NSTimeInterval retries;
@property(nonatomic) NSTimeInterval delay;
@property(nonatomic) NSURLRequestCachePolicy cachePolicy;
@property(nonatomic) BOOL logging;

@property(nonatomic, nullable, readonly, strong) NSProgress* uploadProgress;
@property(nonatomic, nullable, readonly, strong) NSProgress* downloadProgress;

@property(nonatomic, nullable, readonly, strong) NSURLRequest* urlRequest;

- (void)setUrlParam:(nonnull NSString*)urlParam value:(nullable NSString*)value;
- (void)setHeader:(nonnull NSString*)header value:(nullable NSString*)value;
- (void)setBodyParam:(nonnull NSString*)bodyParam value:(nullable NSString*)value;

- (void)resume;
- (void)suspend;
- (void)cancel;

+ (nonnull Class)responseClass;

@end

/*--------------------------------------------------*/

@interface GLBApiRequestUploadItem : NSObject

@property(nonatomic, nonnull, readonly, copy) NSString* name;
@property(nonatomic, nonnull, readonly, copy) NSString* filename;
@property(nonatomic, nonnull, readonly, copy) NSString* mimetype;
@property(nonatomic, nullable, readonly, copy) NSString* localFilePath;
@property(nonatomic, nullable, readonly, strong) NSData* data;

- (nullable instancetype)initWithName:(nonnull NSString*)name
                              filename:(nonnull NSString*)filename
                              mimetype:(nonnull NSString*)mimetype
                                  data:(nonnull NSData*)data;

- (nullable instancetype)initWithName:(nonnull NSString*)name
                              filename:(nonnull NSString*)filename
                              mimetype:(nonnull NSString*)mimetype
                         localFilePath:(nonnull NSString*)localFilePath;

@end

/*--------------------------------------------------*/
