/*--------------------------------------------------*/

#import "GLBDataViewItemsFlowContainer.h"
#import "GLBDataViewItemsContainer+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewItemsFlowContainer () {
    GLBDataViewContainerOrientation _orientation;
    UIEdgeInsets _margin;
    UIOffset _spacing;
    CGSize _defaultSize;
    __kindof GLBDataViewItem* _headerItem;
    __kindof GLBDataViewItem* _footerItem;
    NSMutableArray< __kindof GLBDataViewItem* >* _contentItems;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
