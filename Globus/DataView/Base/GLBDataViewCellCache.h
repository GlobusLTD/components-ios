/*--------------------------------------------------*/

#import "GLBDataViewTypes.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBDataViewItem;
@class GLBDataViewCell;

/*--------------------------------------------------*/

@interface GLBDataViewCellCache : NSObject

+ (nonnull instancetype)shared;

- (void)setup NS_REQUIRES_SUPER;

- (nullable __kindof GLBDataViewCell*)dequeueCellClass:(nonnull Class)cellClass;
- (void)enqueueCell:(nonnull GLBDataViewCell*)cell;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
