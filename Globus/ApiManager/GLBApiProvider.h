/*--------------------------------------------------*/

#import "NSDictionary+GLBNS.h"
#import "NSArray+GLBNS.h"
#import "NSString+GLBNS.h"
#import "NSData+GLBNS.h"
#import "NSError+GLBNS.h"
#import "NSURL+GLBNS.h"

/*--------------------------------------------------*/

@class GLBApiManager;
@class GLBApiRequest;
@class GLBApiResponse;

/*--------------------------------------------------*/

typedef void (^GLBApiProviderProgressBlock)(NSProgress* _Nonnull progress);
typedef void (^GLBApiProviderCompleteBlock)(_Nonnull id request, _Nonnull id response);

/*--------------------------------------------------*/

@interface GLBApiProvider : NSObject

@property(nonatomic, nullable, weak) GLBApiManager* manager;

@property(nonatomic, nonnull, readonly, copy) NSString* name;
@property(nonatomic, nullable, copy) NSURL* url;
@property(nonatomic, nullable, copy) NSDictionary* urlParams;
@property(nonatomic, nullable, copy) NSDictionary* headers;
@property(nonatomic, nullable, copy) NSDictionary* bodyParams;

@property(nonatomic) NSTimeInterval timeoutIntervalForRequest;
@property(nonatomic) NSTimeInterval timeoutIntervalForResource;
@property(nonatomic) NSURLRequestNetworkServiceType networkServiceType;
@property(nonatomic) BOOL allowsCellularAccess;
@property(nonatomic) SSLProtocol minimumTLSProtocol;
@property(nonatomic) SSLProtocol maximumTLSProtocol;
@property(nonatomic) BOOL shouldPipelining;
@property(nonatomic) BOOL shouldCookies;
@property(nonatomic) NSHTTPCookieAcceptPolicy cookieAcceptPolicy;
@property(nonatomic) NSInteger maximumConnectionsPerHost;
@property(nonatomic) NSURLRequestCachePolicy cachePolicy;
@property(nonatomic, nullable, strong) NSURLCache* cache;

@property(nonatomic, nullable, copy) NSString* certificateFilename;
@property(nonatomic) BOOL allowInvalidCertificates;

@property(nonatomic) BOOL logging;

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithName:(nonnull NSString*)name;
- (nonnull instancetype)initWithName:(nonnull NSString*)name url:(nullable NSURL*)url;
- (nonnull instancetype)initWithName:(nonnull NSString*)name url:(nullable NSURL*)url headers:(nullable NSDictionary< NSString*, NSString* >*)headers NS_DESIGNATED_INITIALIZER;

- (void)setup NS_REQUIRES_SUPER;

- (void)setUrlParam:(nonnull NSString*)urlParam value:(nullable NSString*)value;
- (void)setHeader:(nonnull NSString*)header value:(nullable NSString*)value;
- (void)setBodyParam:(nonnull NSString*)bodyParam value:(nullable NSString*)value;

- (void)sendRequest:(nonnull GLBApiRequest*)request
           byTarget:(nonnull id)target
      completeBlock:(nullable GLBApiProviderCompleteBlock)completeBlock;

- (void)sendRequest:(nonnull GLBApiRequest*)request
           byTarget:(nonnull id)target
      downloadBlock:(nullable GLBApiProviderProgressBlock)downloadBlock
      completeBlock:(nullable GLBApiProviderCompleteBlock)completeBlock;

- (void)sendRequest:(nonnull GLBApiRequest*)request
           byTarget:(nonnull id)target
        uploadBlock:(nullable GLBApiProviderProgressBlock)uploadBlock
      completeBlock:(nullable GLBApiProviderCompleteBlock)completeBlock;

- (void)cancelRequest:(nonnull GLBApiRequest*)request;
- (void)cancelAllRequestsByTarget:(nonnull id)target;
- (void)cancelAllRequests;

@end

/*--------------------------------------------------*/
