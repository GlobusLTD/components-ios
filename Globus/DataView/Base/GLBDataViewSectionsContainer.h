/*--------------------------------------------------*/

#import "GLBDataViewContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewSectionsContainer : GLBDataViewContainer

@property(nonatomic, nonnull, readonly, strong) NSArray* sections;

- (void)prependSection:(nonnull GLBDataViewContainer*)section;
- (void)appendSection:(nonnull GLBDataViewContainer*)section;
- (void)insertSection:(nonnull GLBDataViewContainer*)section atIndex:(NSUInteger)index;
- (void)replaceOriginSection:(nonnull GLBDataViewContainer*)originSection withSection:(nonnull GLBDataViewContainer*)section;
- (void)deleteSection:(nonnull GLBDataViewContainer*)section;
- (void)deleteAllSections;

- (void)scrollToSection:(nonnull GLBDataViewContainer*)section scrollPosition:(GLBDataViewPosition)scrollPosition animated:(BOOL)animated;

- (CGRect)frameSectionsForAvailableFrame:(CGRect)frame;
- (void)layoutSectionsForFrame:(CGRect)frame;

- (void)willSectionsLayoutForBounds:(CGRect)bounds;
- (void)didSectionsLayoutForBounds:(CGRect)bounds;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
