/*--------------------------------------------------*/

#import "GLBDataViewController.h"
#import "GLBDataViewItemsListContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewControllerPreloadContainer : GLBDataViewItemsListContainer < GLBDataViewControllerPreloadContainerProtocol >

@property(nonatomic, readonly, nonnull, strong) Class cellClass;
@property(nonatomic) NSUInteger numberOfItems;

+ (nonnull instancetype)container NS_SWIFT_UNAVAILABLE("Use init()");
+ (nonnull instancetype)containerWithNumberOfItems:(NSUInteger)numberOfItems NS_SWIFT_UNAVAILABLE("Use init(numberOfItems:)");
+ (nonnull instancetype)containerWithCellClass:(nonnull Class)cellClass numberOfItems:(NSUInteger)numberOfItems NS_SWIFT_UNAVAILABLE("Use init(cellClass:numberOfItems:)");

- (nonnull instancetype)initWithNumberOfItems:(NSUInteger)numberOfItems;
- (nonnull instancetype)initWithCellClass:(nonnull Class)cellClass numberOfItems:(NSUInteger)numberOfItems;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
