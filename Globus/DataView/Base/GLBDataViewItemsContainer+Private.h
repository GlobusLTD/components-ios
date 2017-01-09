/*--------------------------------------------------*/

#import "GLBDataViewItemsContainer.h"
#import "GLBDataViewContainer+Private.h"
#import "GLBDataViewItem+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewItemsContainer () {
@protected
    NSMutableArray< __kindof GLBDataViewItem* >* _entries;
    NSArray* _accessibilityEntries;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
