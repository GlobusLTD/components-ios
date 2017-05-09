/*--------------------------------------------------*/

#import "GLBDataViewController.h"
#import "GLBDataViewItemsContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewControllerEmptyContainer : GLBDataViewItemsContainer < GLBDataViewControllerEmptyContainerProtocol >

@property(nonatomic, readonly, nonnull, strong) Class cellClass;

+ (nonnull instancetype)container NS_SWIFT_UNAVAILABLE("Use init()");
+ (nonnull instancetype)containerWithCellClass:(nonnull Class)cellClass NS_SWIFT_UNAVAILABLE("Use init(cellClass:)");

- (nonnull instancetype)initWithCellClass:(nonnull Class)cellClass;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
