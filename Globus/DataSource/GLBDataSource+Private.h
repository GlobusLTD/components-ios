/*--------------------------------------------------*/

#import "GLBDataSource.h"

/*--------------------------------------------------*/
#pragma mark - Private interface
/*--------------------------------------------------*/

@interface GLBDataSource () {
    BOOL _updating;
    NSError* _error;
}

- (void)_load NS_REQUIRES_SUPER;
- (void)_reset NS_REQUIRES_SUPER;
- (void)_cancel NS_REQUIRES_SUPER;

- (BOOL)_shouldUpdate NS_REQUIRES_SUPER;
- (void)_startUpdating NS_REQUIRES_SUPER;
- (void)_finishUpdating NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/


