/*--------------------------------------------------*/

#import "GLBDataViewSectionsContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewSectionsListContainer : GLBDataViewSectionsContainer

@property(nonatomic) GLBDataViewContainerOrientation orientation;
@property(nonatomic) UIEdgeInsets margin;
@property(nonatomic) UIOffset spacing;
@property(nonatomic) BOOL pagingEnabled;
@property(nonatomic) NSUInteger currentSectionIndex;
@property(nonatomic, strong) GLBDataViewContainer* currentSection;

+ (instancetype)containerWithOrientation:(GLBDataViewContainerOrientation)orientation NS_SWIFT_UNAVAILABLE("Use init(orientation:)");

- (instancetype)initWithOrientation:(GLBDataViewContainerOrientation)orientation;

- (void)setCurrentSectionIndex:(NSUInteger)currentSectionIndex animated:(BOOL)animated;
- (void)setCurrentSection:(GLBDataViewContainer*)currentSection animated:(BOOL)animated;

@end

/*--------------------------------------------------*/

extern NSString* GLBDataViewContainerCurrentSectionChanged;

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
