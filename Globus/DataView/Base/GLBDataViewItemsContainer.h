/*--------------------------------------------------*/

#import "GLBDataContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewItemsContainer : GLBDataContainer

@property(nonatomic, readonly, strong) NSArray* entries;

@end

/*--------------------------------------------------*/
/* Legacy                                           */
/*--------------------------------------------------*/

@interface GLBDataContainerItems : GLBDataViewItemsContainer
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
