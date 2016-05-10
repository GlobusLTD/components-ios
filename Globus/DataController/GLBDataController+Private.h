/*--------------------------------------------------*/

#import "GLBDataController.h"

/*--------------------------------------------------*/
#pragma mark - Private interface
/*--------------------------------------------------*/

@interface GLBDataController () {
    __weak id< GLBDataControllerDelegate > _delegate;
    BOOL _updating;
    NSError* _error;
}

#pragma mark - Private instance methods

- (void)_load:(BOOL)force NS_REQUIRES_SUPER;
- (BOOL)_shouldUpdate:(BOOL)force NS_REQUIRES_SUPER;
- (void)_startUpdating:(BOOL)force notify:(BOOL)notify NS_REQUIRES_SUPER;
- (void)_finishUpdating:(BOOL)force notify:(BOOL)notify NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/


