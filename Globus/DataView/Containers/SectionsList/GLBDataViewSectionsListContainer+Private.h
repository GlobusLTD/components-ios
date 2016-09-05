/*--------------------------------------------------*/

#import "GLBDataViewSectionsListContainer.h"
#import "GLBDataViewSectionsContainer+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewSectionsListContainer () {
    GLBDataViewContainerOrientation _orientation;
    UIEdgeInsets _margin;
    UIOffset _spacing;
    BOOL _pagingEnabled;
    __kindof GLBDataViewContainer* _currentSection;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
