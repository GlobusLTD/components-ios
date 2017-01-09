/*--------------------------------------------------*/

#import "NSObject+GLBDebug.h"
#import "NSDictionary+GLBNS.h"
#import "NSArray+GLBNS.h"
#import "NSOrderedSet+GLBNS.h"
#import "NSSet+GLBNS.h"
#import "NSString+GLBNS.h"
#import "NSData+GLBNS.h"
#import "NSURL+GLBNS.h"

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

- (void)setUrlParam:(NSString* _Nonnull)urlParam value:(NSString* _Nullable)value;
- (void)setHeader:(NSString* _Nonnull)header value:(NSString* _Nullable)value;
- (void)setBodyParam:(NSString* _Nonnull)bodyParam value:(NSString* _Nullable)value;

- (void)resume;
- (void)suspend;
- (void)cancel;

+ (Class _Nonnull)responseClass;

@end

/*--------------------------------------------------*/

@interface GLBApiRequestUploadItem : NSObject

@property(nonatomic, nonnull, readonly, copy) NSString* name;
@property(nonatomic, nonnull, readonly, copy) NSString* filename;
@property(nonatomic, nonnull, readonly, copy) NSString* mimetype;
@property(nonatomic, nullable, readonly, copy) NSString* localFilePath;
@property(nonatomic, nullable, readonly, strong) NSData* data;

- (instancetype _Nullable)initWithName:(NSString* _Nonnull)name
                              filename:(NSString* _Nonnull)filename
                              mimetype:(NSString* _Nonnull)mimetype
                                  data:(NSData* _Nonnull)data;

- (instancetype _Nullable)initWithName:(NSString* _Nonnull)name
                              filename:(NSString* _Nonnull)filename
                              mimetype:(NSString* _Nonnull)mimetype
                         localFilePath:(NSString* _Nonnull)localFilePath;

@end

/*--------------------------------------------------*/
