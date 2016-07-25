/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"

/*--------------------------------------------------*/

@class GLBApiProvider;
@class GLBApiRequest;

/*--------------------------------------------------*/

@interface GLBApiManager : NSObject

@property(nonatomic, readonly, nullable, copy) NSArray< GLBApiProvider* >* providers;

+ (instancetype _Nullable)shared;

- (void)setup NS_REQUIRES_SUPER;

- (void)registerProvider:(GLBApiProvider* _Nonnull)provider;
- (void)unregisterProvider:(GLBApiProvider* _Nonnull)provider;

- (void)cancelRequest:(GLBApiRequest* _Nonnull)request;
- (void)cancelAllRequestsByTarget:(_Nonnull id)target;
- (void)cancelAllRequests;

@end

/*--------------------------------------------------*/
