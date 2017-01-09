/*--------------------------------------------------*/

#import "GLBDataViewSectionsContainer.h"
#import "GLBDataViewContainer+Private.h"
#import "GLBDataViewItem+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewSectionsContainer () {
@protected
    NSMutableArray< __kindof GLBDataViewContainer* >* _sections;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
