/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

@class GLBApiProvider;
@class GLBApiRequest;

/*--------------------------------------------------*/

@interface GLBApiManager : NSObject

@property(nonatomic, nonnull, readonly, copy) NSArray< GLBApiProvider* >* providers;

+ (nonnull instancetype)shared;

- (void)registerProvider:(nonnull GLBApiProvider*)provider;
- (void)unregisterProvider:(nonnull GLBApiProvider*)provider;

- (void)cancelRequest:(nonnull GLBApiRequest*)request;
- (void)cancelAllRequestsByTarget:(nonnull id)target;
- (void)cancelAllRequests;

@end

/*--------------------------------------------------*/
