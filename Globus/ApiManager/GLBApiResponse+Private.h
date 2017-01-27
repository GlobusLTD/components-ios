/*--------------------------------------------------*/

#import "GLBApiResponse.h"

/*--------------------------------------------------*/

@interface GLBApiResponse ()

@property(nonatomic, nullable, strong) NSURLResponse* urlResponse;
@property(nonatomic, nullable, readonly, strong) NSMutableData* mutableData;

+ (nonnull instancetype)responseWithRequest:(nonnull GLBApiRequest*)request;

- (nonnull instancetype)initWithRequest:(nonnull GLBApiRequest*)request;

@end

/*--------------------------------------------------*/
