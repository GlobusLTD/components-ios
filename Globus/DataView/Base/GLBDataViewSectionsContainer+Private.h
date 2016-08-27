/*--------------------------------------------------*/

#import "GLBDataViewSectionsContainer.h"
#import "GLBDataViewItem+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewSectionsContainer () {
@protected
    NSMutableArray< __kindof GLBDataContainer* >* _sections;
}

- (CGRect)_frameSectionsForAvailableFrame:(CGRect)frame;
- (void)_layoutSectionsForFrame:(CGRect)frame;

- (void)_willSectionsLayoutForBounds:(CGRect)bounds;
- (void)_didSectionsLayoutForBounds:(CGRect)bounds;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
