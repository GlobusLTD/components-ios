/*--------------------------------------------------*/

#import "GLBSimpleDataViewController.h"
#import "GLBDataViewItemsListContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBSimpleDataViewControllerContentContainer : GLBDataViewItemsListContainer < GLBSimpleDataViewControllerContentContainerProtocol >

+ (nonnull instancetype)container NS_SWIFT_UNAVAILABLE("Use init()");

+ (nonnull NSDictionary< NSString*, Class >*)mapCells;

- (void)prepareWithModel:(nonnull id)model;
- (void)cleanupWithModel:(nonnull id)model;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
