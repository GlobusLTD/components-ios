/*--------------------------------------------------*/

#import "NSArray+GLBNS.h"

/*--------------------------------------------------*/

@class GLBApiProvider;
@class GLBApiRequest;

/*--------------------------------------------------*/

@interface GLBApiManager : NSObject

@property(nonatomic, nonnull, readonly, copy) NSArray< GLBApiProvider* >* providers;

+ (instancetype _Nonnull)shared;

- (void)setup NS_REQUIRES_SUPER;

- (void)registerProvider:(GLBApiProvider* _Nonnull)provider;
- (void)unregisterProvider:(GLBApiProvider* _Nonnull)provider;

- (void)cancelRequest:(GLBApiRequest* _Nonnull)request;
- (void)cancelAllRequestsByTarget:(id _Nonnull)target;
- (void)cancelAllRequests;

@end

/*--------------------------------------------------*/
