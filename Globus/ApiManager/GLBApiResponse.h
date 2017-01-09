/*--------------------------------------------------*/

#import "NSObject+GLBDebug.h"
#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

@class GLBApiRequest;

/*--------------------------------------------------*/

@interface GLBApiResponse : NSObject < GLBObjectDebugProtocol >

@property(nonatomic, nullable, readonly, strong) __kindof GLBApiRequest* request;
@property(nonatomic, nullable, readonly, strong) NSURLResponse* urlResponse;
@property(nonatomic, readonly, assign) NSInteger statusCode;
@property(nonatomic, nullable, readonly, strong) NSString* mimetype;
@property(nonatomic, nullable, readonly, strong) NSString* textEncoding;
@property(nonatomic, nullable, readonly, strong) NSDictionary* headers;
@property(nonatomic, nullable, readonly, strong) NSData* data;
@property(nonatomic, nullable, strong) NSError* error;
@property(nonatomic, getter=isValid) BOOL valid;

+ (BOOL)allowsBackgroundThread;

- (void)parse;
- (BOOL)fromData:(NSData* _Nonnull)data mimetype:(NSString* _Nonnull)mimetype;
- (BOOL)fromJson:(id _Nonnull)json;
- (BOOL)fromEmpty;

@end

/*--------------------------------------------------*/
