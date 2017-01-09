/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"

/*--------------------------------------------------*/

@interface GLBModelContext : NSObject

@property(nonatomic, nonnull, strong) dispatch_queue_t queue;

+ (instancetype _Nonnull)shared;

- (void)setup NS_REQUIRES_SUPER;

- (void)sync:(GLBSimpleBlock _Nonnull)work;
- (void)async:(GLBSimpleBlock _Nonnull)work complete:(GLBSimpleBlock _Nonnull)complete;
- (void)asyncQueue:(dispatch_queue_t _Nullable)queue work:(GLBSimpleBlock _Nonnull)work complete:(GLBSimpleBlock _Nonnull)complete;

@end

/*--------------------------------------------------*/
