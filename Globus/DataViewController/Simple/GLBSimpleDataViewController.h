/*--------------------------------------------------*/

#import "GLBDataViewController.h"

/*--------------------------------------------------*/

#import "GLBSimpleDataProvider.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@protocol GLBSimpleDataViewControllerContentContainerProtocol;

/*--------------------------------------------------*/

@interface GLBSimpleDataViewController : GLBDataViewController< GLBSimpleDataProviderDelegate >

@property(nonatomic, nonnull, strong) id< GLBSimpleDataProvider > provider;
@property(nonatomic, readonly, nullable, strong) __kindof GLBDataViewContainer< GLBSimpleDataViewControllerContentContainerProtocol >* contentContainer;

- (void)configureDataView NS_REQUIRES_SUPER;

- (nullable __kindof GLBDataViewContainer< GLBSimpleDataViewControllerContentContainerProtocol >*)prepareContentContainer;

- (nullable __kindof GLBDataRefreshView*)prepareTopRefreshView;

- (void)showContentContainer:(nonnull GLBSimpleBlock)update NS_UNAVAILABLE;
- (void)showContentContainerWithModel:(nullable id)model;

@end

/*--------------------------------------------------*/

@protocol GLBSimpleDataViewControllerContentContainerProtocol < GLBDataViewControllerContentContainerProtocol >

@property(nonatomic, nullable, strong) id model;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
