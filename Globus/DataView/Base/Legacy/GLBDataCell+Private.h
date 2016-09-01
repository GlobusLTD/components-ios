/*--------------------------------------------------*/

#import "GLBDataCell.h"
#import "GLBDataViewCell+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataCell ()

- (CGSize)sizeForItem:(id)item availableSize:(CGSize)size GLB_DEPRECATED;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/

#if __has_include("GLBDataCellSwipe+Private.h")
#import "GLBDataCellSwipe+Private.h"
#endif

/*--------------------------------------------------*/
