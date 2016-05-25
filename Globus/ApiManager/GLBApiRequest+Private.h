/*--------------------------------------------------*/

#import "GLBApiRequest.h"

/*--------------------------------------------------*/

@interface GLBApiRequest ()

@property(nonatomic, nullable, strong) GLBApiProvider* provider;
@property(nonatomic, nullable, strong) NSURLSessionTask* task;
@property(nonatomic, readonly, nullable, strong) GLBApiResponse* response;

- (void)reset;

@end

/*--------------------------------------------------*/
