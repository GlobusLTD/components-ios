/*--------------------------------------------------*/

#import "GLBDataViewItemsListContainer.h"
#import "GLBDataViewItemsContainer+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewItemsListContainer () {
    GLBDataViewContainerOrientation _orientation;
    GLBDataViewItemsListContainerMode _mode;
    BOOL _reverse;
    UIEdgeInsets _margin;
    UIOffset _spacing;
    CGSize _defaultSize;
    NSUInteger _defaultOrder;
    __kindof GLBDataViewItem* _headerItem;
    __kindof GLBDataViewItem* _footerItem;
    NSMutableArray< __kindof GLBDataViewItem* >* _contentItems;
    CGRect _movingFrame;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
