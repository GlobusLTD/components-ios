/*--------------------------------------------------*/

#import "GLBDataViewItemsListContainer.h"
#import "GLBDataViewItemsContainer+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewItemsListContainer () {
    GLBDataContainerOrientation _orientation;
    GLBDataViewItemsListContainerMode _mode;
    BOOL _reverse;
    UIEdgeInsets _margin;
    UIOffset _spacing;
    CGSize _defaultSize;
    NSUInteger _defaultOrder;
    __kindof GLBDataViewItem* _header;
    __kindof GLBDataViewItem* _footer;
    NSMutableArray< __kindof GLBDataViewItem* >* _items;
    CGRect _movingFrame;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
