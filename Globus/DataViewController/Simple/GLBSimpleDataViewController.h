/*--------------------------------------------------*/

#import "GLBDataViewController.h"

/*--------------------------------------------------*/

#import "GLBDataViewSectionsContainer.h"

/*--------------------------------------------------*/

#import "GLBSimpleDataProvider.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBSimpleDataViewControllerState) {
    GLBSimpleDataViewControllerStateNone,
    GLBSimpleDataViewControllerStatePreload,
    GLBSimpleDataViewControllerStateContent,
    GLBSimpleDataViewControllerStateEmpty,
    GLBSimpleDataViewControllerStateError
};

/*--------------------------------------------------*/

@interface GLBSimpleDataViewController : GLBDataViewController< GLBSimpleDataProviderDelegate >

@property(nonatomic, nonnull, strong) id< GLBSimpleDataProvider > provider;

@property(nonatomic, readonly) GLBSimpleDataViewControllerState state;

- (void)configureDataView NS_REQUIRES_SUPER;

- (nullable __kindof GLBDataViewSectionsContainer*)prepareRootContainer;
- (nullable __kindof GLBDataViewContainer*)prepareContentContainerWithModel:(nullable id)model;
- (nullable __kindof GLBDataViewContainer*)preparePreloadContainer;
- (nullable __kindof GLBDataViewContainer*)prepareEmptyContainer;
- (nullable __kindof GLBDataViewContainer*)prepareErrorContainerWithError:(nullable id)error;

- (nullable __kindof GLBDataRefreshView*)prepareTopRefreshView;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
