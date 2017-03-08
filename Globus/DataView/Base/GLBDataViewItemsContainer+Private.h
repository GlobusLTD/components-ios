/*--------------------------------------------------*/

#import "GLBDataViewItemsContainer.h"
#import "GLBDataViewContainer+Private.h"
#import "GLBDataViewItem+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewItemsContainer () {
@protected
    NSUInteger _defaultOrder;
    NSMutableArray< __kindof GLBDataViewItem* >* _items;
    NSArray* _accessibilityItems;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
