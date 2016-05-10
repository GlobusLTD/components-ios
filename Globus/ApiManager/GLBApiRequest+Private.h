/*--------------------------------------------------*/

#import "GLBApiRequest.h"

/*--------------------------------------------------*/

@interface GLBApiRequest ()

@property(nonatomic, strong, nullable) GLBApiProvider* provider;
@property(nonatomic, strong, nullable) NSURLSessionTask* task;
@property(nonatomic, strong, nullable) NSURLResponse* urlResponse;
@property(nonatomic, readonly, strong, nullable) GLBApiResponse* response;

- (void)reset;

@end

/*--------------------------------------------------*/
