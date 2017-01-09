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

- (instancetype _Nonnull)init NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithName:(NSString* _Nonnull)name;
- (instancetype _Nonnull)initWithName:(NSString* _Nonnull)name url:(NSURL* _Nullable)url;
- (instancetype _Nonnull)initWithName:(NSString* _Nonnull)name url:(NSURL* _Nullable)url headers:(NSDictionary< NSString*, NSString* >* _Nullable)headers NS_DESIGNATED_INITIALIZER;

- (void)setup NS_REQUIRES_SUPER;

- (void)setUrlParam:(NSString* _Nonnull)urlParam value:(NSString* _Nullable)value;
- (void)setHeader:(NSString* _Nonnull)header value:(NSString* _Nullable)value;
- (void)setBodyParam:(NSString* _Nonnull)bodyParam value:(NSString* _Nullable)value;

- (void)sendRequest:(GLBApiRequest* _Nonnull)request
           byTarget:(id _Nonnull)target
      completeBlock:(GLBApiProviderCompleteBlock _Nullable)completeBlock;

- (void)sendRequest:(GLBApiRequest* _Nonnull)request
           byTarget:(id _Nonnull)target
      downloadBlock:(GLBApiProviderProgressBlock _Nullable)downloadBlock
      completeBlock:(GLBApiProviderCompleteBlock _Nullable)completeBlock;

- (void)sendRequest:(GLBApiRequest* _Nonnull)request
           byTarget:(id _Nonnull)target
        uploadBlock:(GLBApiProviderProgressBlock _Nullable)uploadBlock
      completeBlock:(GLBApiProviderCompleteBlock _Nullable)completeBlock;

- (void)cancelRequest:(GLBApiRequest* _Nonnull)request;
- (void)cancelAllRequestsByTarget:(id _Nonnull)target;
- (void)cancelAllRequests;

@end

/*--------------------------------------------------*/
