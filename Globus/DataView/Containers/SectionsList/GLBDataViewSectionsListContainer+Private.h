/*--------------------------------------------------*/

#import "GLBDataViewSectionsListContainer.h"
#import "GLBDataViewSectionsContainer+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewSectionsListContainer () {
    GLBDataContainerOrientation _orientation;
    UIEdgeInsets _margin;
    UIOffset _spacing;
    BOOL _pagingEnabled;
    __kindof GLBDataContainer* _currentSection;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
