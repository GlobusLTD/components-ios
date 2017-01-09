/*--------------------------------------------------*/

#import "GLBDataViewTypes.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBDataViewItem;
@class GLBDataViewCell;

/*--------------------------------------------------*/

@interface GLBDataViewCellCache : NSObject

+ (instancetype _Nullable)shared;

- (void)setup NS_REQUIRES_SUPER;

- (__kindof GLBDataViewCell* _Nullable)dequeueCellClass:(Class _Nonnull)cellClass;
- (void)enqueueCell:(GLBDataViewCell* _Nonnull)cell;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
