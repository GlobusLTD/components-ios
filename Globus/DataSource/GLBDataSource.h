/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/
#pragma mark - Public interface
/*--------------------------------------------------*/

@interface GLBDataSource : NSObject

@property(nonatomic, readonly, assign, getter=isUpdating) BOOL updating;
@property(nonatomic, readonly, strong) NSError* error;

- (void)setup NS_REQUIRES_SUPER;

- (void)load;
- (void)reset;
- (void)cancel;

@end

/*--------------------------------------------------*/


