/*--------------------------------------------------*/

#import "GLBDataViewController.h"
#import "GLBDataViewItemsContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewControllerErrorContainer : GLBDataViewItemsContainer < GLBDataViewControllerErrorContainerProtocol >

+ (nonnull instancetype)containerWithError:(nonnull id)error NS_SWIFT_UNAVAILABLE("Use init(error:)");

- (nonnull instancetype)initWithError:(nonnull id)error;

+ (nonnull NSDictionary< NSString*, Class >*)mapCells;

+ (nonnull NSString*)itemIdentifierWithError:(nonnull id)error;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
