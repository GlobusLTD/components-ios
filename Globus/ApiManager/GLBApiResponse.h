/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"
#import "NSObject+GLBDebug.h"

/*--------------------------------------------------*/

@class GLBApiRequest;

/*--------------------------------------------------*/

@interface GLBApiResponse : NSObject < GLBObjectDebugProtocol >

@property(nonatomic, nullable, readonly, strong) __kindof GLBApiRequest* request;
@property(nonatomic, nullable, readonly, strong) NSURLResponse* urlResponse;
@property(nonatomic, readonly) NSInteger statusCode;
@property(nonatomic, nullable, readonly, strong) NSString* mimetype;
@property(nonatomic, nullable, readonly, strong) NSString* textEncoding;
@property(nonatomic, nullable, readonly, strong) NSDictionary* headers;
@property(nonatomic, nullable, readonly, strong) NSData* data;
@property(nonatomic, nullable, strong) NSError* error;
@property(nonatomic, getter=isValid) BOOL valid;

+ (BOOL)allowsBackgroundThread;

- (void)parse;
- (BOOL)fromData:(nonnull NSData*)data mimetype:(nonnull NSString*)mimetype;
- (BOOL)fromJson:(nonnull id)json;
- (BOOL)fromEmpty;

@end

/*--------------------------------------------------*/
