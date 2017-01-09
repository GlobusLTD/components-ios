/*--------------------------------------------------*/

#import "GLBApiResponse.h"

/*--------------------------------------------------*/

@interface GLBApiResponse ()

@property(nonatomic, nullable, strong) NSURLResponse* urlResponse;
@property(nonatomic, nullable, readonly, strong) NSMutableData* mutableData;

+ (instancetype _Nonnull)responseWithRequest:(GLBApiRequest* _Nonnull)request;

- (instancetype _Nonnull)initWithRequest:(GLBApiRequest* _Nonnull)request;

@end

/*--------------------------------------------------*/
