/*--------------------------------------------------*/

#import "GLBDataViewSectionsContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewSectionsListContainer : GLBDataViewSectionsContainer

@property(nonatomic) GLBDataContainerOrientation orientation;
@property(nonatomic) UIEdgeInsets margin;
@property(nonatomic) UIOffset spacing;
@property(nonatomic) BOOL pagingEnabled;
@property(nonatomic) NSUInteger currentSectionIndex;
@property(nonatomic, strong) GLBDataContainer* currentSection;

+ (instancetype)containerWithOrientation:(GLBDataContainerOrientation)orientation;

- (instancetype)initWithOrientation:(GLBDataContainerOrientation)orientation;

- (void)setCurrentSectionIndex:(NSUInteger)currentSectionIndex animated:(BOOL)animated;
- (void)setCurrentSection:(GLBDataContainer*)currentSection animated:(BOOL)animated;

@end

/*--------------------------------------------------*/

extern NSString* GLBDataContainerCurrentSectionChanged;

/*--------------------------------------------------*/
/* Legacy                                           */
/*--------------------------------------------------*/

GLB_DEPRECATED
@interface GLBDataContainerSectionsList : GLBDataViewSectionsListContainer
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
