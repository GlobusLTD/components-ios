/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"

/*--------------------------------------------------*/

@interface GLBModelContext : NSObject

@property(nonatomic, nonnull, strong) dispatch_queue_t queue;

+ (nonnull instancetype)shared;

- (void)setup NS_REQUIRES_SUPER;

- (void)sync:(nonnull GLBSimpleBlock)work;
- (void)async:(nonnull GLBSimpleBlock)work complete:(nonnull GLBSimpleBlock)complete;
- (void)asyncQueue:(nullable dispatch_queue_t)queue work:(nonnull GLBSimpleBlock)work complete:(nonnull GLBSimpleBlock)complete;

@end

/*--------------------------------------------------*/
