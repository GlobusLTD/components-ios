/*--------------------------------------------------*/

#import "GLBDataViewContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewSectionsContainer : GLBDataViewContainer

@property(nonatomic, readonly, strong) NSArray* sections;

- (void)prependSection:(GLBDataViewContainer*)section;
- (void)appendSection:(GLBDataViewContainer*)section;
- (void)insertSection:(GLBDataViewContainer*)section atIndex:(NSUInteger)index;
- (void)replaceOriginSection:(GLBDataViewContainer*)originSection withSection:(GLBDataViewContainer*)section;
- (void)deleteSection:(GLBDataViewContainer*)section;
- (void)deleteAllSections;

- (void)scrollToSection:(GLBDataViewContainer*)section scrollPosition:(GLBDataViewPosition)scrollPosition animated:(BOOL)animated;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
