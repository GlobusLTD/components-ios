/*--------------------------------------------------*/

#import "GLBDataContainerItems+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

@implementation GLBDataContainerItems

- (CGRect)_validateLayoutForAvailableFrame:(CGRect)frame {
    _frame = [self _validateEntriesForAvailableFrame:frame];
    return _frame;
}

- (CGRect)_validateEntriesForAvailableFrame:(CGRect)frame {
    return CGRectNull;
}

@end

#pragma clang diagnostic pop

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/