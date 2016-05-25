/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

@class GLBApiRequest;

/*--------------------------------------------------*/

@interface GLBApiResponse : NSObject

@property(nonatomic, readonly, nullable, strong) __kindof GLBApiRequest* request;
@property(nonatomic, readonly, nullable, strong) NSURLResponse* urlResponse;
@property(nonatomic, readonly, assign) NSInteger statusCode;
@property(nonatomic, readonly, nullable, strong) NSString* mimetype;
@property(nonatomic, readonly, nullable, strong) NSString* textEncoding;
@property(nonatomic, readonly, nullable, strong) NSDictionary* headers;
@property(nonatomic, readonly, nullable, strong) NSData* data;
@property(nonatomic, nullable, strong) NSError* error;
@property(nonatomic, getter=isValid) BOOL valid;

+ (BOOL)allowsBackgroundThread;

- (void)parse;
- (BOOL)fromData:(nonnull NSData*)data mimetype:(nonnull NSString*)mimetype;
- (BOOL)fromJson:(nonnull id)json;
- (BOOL)fromEmpty;

@end

/*--------------------------------------------------*/
