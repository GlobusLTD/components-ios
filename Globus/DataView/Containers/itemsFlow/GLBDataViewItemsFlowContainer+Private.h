/*--------------------------------------------------*/

#import "GLBDataViewItemsFlowContainer.h"
#import "GLBDataViewItemsContainer+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewItemsFlowContainer () {
    GLBDataContainerOrientation _orientation;
    UIEdgeInsets _margin;
    UIOffset _spacing;
    CGSize _defaultSize;
    NSUInteger _defaultOrder;
    NSMutableArray< __kindof GLBDataViewItem* >* _items;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
