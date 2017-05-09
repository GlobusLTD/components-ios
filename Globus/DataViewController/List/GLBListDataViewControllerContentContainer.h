/*--------------------------------------------------*/

#import "GLBListDataViewController.h"
#import "GLBDataViewItemsListContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBListDataViewControllerContentContainer : GLBDataViewItemsListContainer < GLBListDataViewControllerContentContainerProtocol >

+ (nonnull instancetype)container NS_SWIFT_UNAVAILABLE("Use init()");

+ (nonnull NSDictionary< NSString*, Class >*)mapCells;

- (nullable __kindof GLBDataViewItem*)prepareItemWithModel:(nonnull id)model;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
