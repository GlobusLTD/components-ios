/*--------------------------------------------------*/

#import "GLBDataContainerSections+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

@implementation GLBDataContainerSections

- (CGRect)_validateLayoutForAvailableFrame:(CGRect)frame {
    _frame = [self _validateSectionsForAvailableFrame:frame];
    return _frame;
}

- (CGRect)_validateSectionsForAvailableFrame:(CGRect)frame {
    return CGRectNull;
}

@end

#pragma clang diagnostic pop

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
