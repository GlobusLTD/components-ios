/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"

/*--------------------------------------------------*/

@interface GLBModelContext : NSObject

@property(nonatomic, nullable, strong) dispatch_queue_t queue;

+ (_Nullable instancetype)shared;

- (void)setup NS_REQUIRES_SUPER;

- (void)sync:(_Nonnull GLBSimpleBlock)work;
- (void)async:(_Nonnull GLBSimpleBlock)work complete:(_Nonnull GLBSimpleBlock)complete;
- (void)asyncQueue:(_Nullable dispatch_queue_t)queue work:(_Nonnull GLBSimpleBlock)work complete:(_Nonnull GLBSimpleBlock)complete;

@end

/*--------------------------------------------------*/
