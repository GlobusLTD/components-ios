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

- (CGRect)_validateSectionsForAvailableFrame:(CGRect)frame GLB_DEPRECATED;

- (CGRect)_frameSectionsForAvailableFrame:(CGRect)frame;
- (void)_layoutSectionsForFrame:(CGRect)frame;

- (void)_willSectionsLayoutForBounds:(CGRect)bounds;
- (void)_didSectionsLayoutForBounds:(CGRect)bounds;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
