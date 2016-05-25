/*--------------------------------------------------*/

#import "GLBApiResponse.h"

/*--------------------------------------------------*/

@interface GLBApiResponse ()

@property(nonatomic, nullable, strong) NSURLResponse* urlResponse;
@property(nonatomic, readonly, nullable, strong) NSMutableData* mutableData;

+ (instancetype _Nullable)responseWithRequest:(GLBApiRequest* _Nonnull)request;

- (instancetype _Nullable)initWithRequest:(GLBApiRequest* _Nonnull)request;

@end

/*--------------------------------------------------*/
