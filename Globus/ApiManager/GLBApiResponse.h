/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

@class GLBApiRequest;

/*--------------------------------------------------*/

@interface GLBApiResponse : NSObject

@property(nonatomic, readonly, strong, nullable) __kindof GLBApiRequest* request;
@property(nonatomic, readonly, strong, nullable) NSURLResponse* urlResponse;
@property(nonatomic, readonly, assign) NSInteger statusCode;
@property(nonatomic, readonly, strong, nullable) NSString* mimetype;
@property(nonatomic, readonly, strong, nullable) NSString* textEncoding;
@property(nonatomic, readonly, strong, nullable) NSDictionary* headers;
@property(nonatomic, readonly, strong, nullable) NSData* data;
@property(nonatomic, strong, nullable) NSError* error;
@property(nonatomic, getter=isValid) BOOL valid;

+ (BOOL)allowsBackgroundThread;

- (void)parse;
- (BOOL)fromData:(nonnull NSData*)data mimetype:(nonnull NSString*)mimetype;
- (BOOL)fromJson:(nonnull id)json;
- (BOOL)fromEmpty;

@end

/*--------------------------------------------------*/
