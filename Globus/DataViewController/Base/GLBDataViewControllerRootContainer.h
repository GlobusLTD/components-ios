/*--------------------------------------------------*/

#import "GLBDataViewController.h"
#import "GLBDataViewSectionsListContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewControllerRootContainer : GLBDataViewSectionsListContainer < GLBDataViewControllerRootContainerProtocol >

+ (nonnull instancetype)container NS_SWIFT_UNAVAILABLE("Use init()");

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
