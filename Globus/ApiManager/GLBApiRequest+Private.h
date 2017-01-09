/*--------------------------------------------------*/

#import "GLBApiRequest.h"

/*--------------------------------------------------*/

@interface GLBApiRequest () {
    NSMutableDictionary* _urlParams;
    NSMutableDictionary* _headers;
    NSMutableDictionary* _bodyParams;
}

@property(nonatomic, nullable, strong) GLBApiProvider* provider;
@property(nonatomic, nullable, strong) NSURLSessionTask* task;
@property(nonatomic, nullable, readonly, strong) GLBApiResponse* response;

- (void)reset;

@end

/*--------------------------------------------------*/
