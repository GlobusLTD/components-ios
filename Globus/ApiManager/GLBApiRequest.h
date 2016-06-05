/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"

/*--------------------------------------------------*/

@class GLBApiProvider;
@class GLBApiRequestUploadItem;
@class GLBApiResponse;

/*--------------------------------------------------*/

@interface GLBApiRequest : NSObject < GLBObjectDebugProtocol >

@property(nonatomic, readonly, nullable, strong) __kindof GLBApiProvider* provider;

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
@property(nonatomic, nullable, copy) NSArray* uploadItems;
@property(nonatomic) NSTimeInterval timeout;
@property(nonatomic) NSTimeInterval retries;
@property(nonatomic) NSTimeInterval delay;

@property(nonatomic, readonly, nullable, strong) NSProgress* uploadProgress;
@property(nonatomic, readonly, nullable, strong) NSProgress* downloadProgress;

@property(nonatomic, readonly, nullable, strong) NSURLRequest* urlRequest;

- (void)resume;
- (void)suspend;
- (void)cancel;

+ (_Nonnull Class)responseClass;

@end

/*--------------------------------------------------*/

@interface GLBApiRequestUploadItem : NSObject

@property(nonatomic, readonly, nonnull, copy) NSString* name;
@property(nonatomic, readonly, nonnull, copy) NSString* filename;
@property(nonatomic, readonly, nonnull, copy) NSString* mimetype;
@property(nonatomic, readonly, nullable, copy) NSString* localFilePath;
@property(nonatomic, readonly, nullable, strong) NSData* data;

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
