/*--------------------------------------------------*/

#import "GLBDataCell+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

@implementation GLBDataCell

- (CGSize)sizeForItem:(id)item availableSize:(CGSize)size {
    return [super sizeForAvailableSize:size];
}

- (CGSize)sizeForAvailableSize:(CGSize)size {
    return [self sizeForItem:_item availableSize:size];
}

@end

#pragma clang diagnostic pop

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
