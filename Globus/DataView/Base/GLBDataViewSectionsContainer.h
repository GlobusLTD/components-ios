/*--------------------------------------------------*/

#import "GLBDataContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewSectionsContainer : GLBDataContainer

@property(nonatomic, readonly, strong) NSArray* sections;

- (void)prependSection:(GLBDataContainer*)section;
- (void)appendSection:(GLBDataContainer*)section;
- (void)insertSection:(GLBDataContainer*)section atIndex:(NSUInteger)index;
- (void)replaceOriginSection:(GLBDataContainer*)originSection withSection:(GLBDataContainer*)section;
- (void)deleteSection:(GLBDataContainer*)section;
- (void)deleteAllSections;

- (void)scrollToSection:(GLBDataContainer*)section scrollPosition:(GLBDataViewPosition)scrollPosition animated:(BOOL)animated;

@end

/*--------------------------------------------------*/
/* Legacy                                           */
/*--------------------------------------------------*/

GLB_DEPRECATED
@interface GLBDataContainerSections : GLBDataViewSectionsContainer
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
