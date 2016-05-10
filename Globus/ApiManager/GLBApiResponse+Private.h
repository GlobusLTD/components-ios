/*--------------------------------------------------*/

#import "GLBApiResponse.h"

/*--------------------------------------------------*/

@interface GLBApiResponse ()

@property(nonatomic, strong, nullable) NSURLResponse* urlResponse;
@property(nonatomic, readonly, strong, nullable) NSMutableData* mutableData;

+ (instancetype _Nullable)responseWithRequest:(GLBApiRequest* _Nonnull)request;

- (instancetype _Nullable)initWithRequest:(GLBApiRequest* _Nonnull)request;

@end

/*--------------------------------------------------*/
