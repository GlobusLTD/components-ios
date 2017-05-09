/*--------------------------------------------------*/

#import "GLBDataViewController.h"
#import "GLBListDataProvider.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@protocol GLBListDataViewControllerContentContainerProtocol;
@protocol GLBListDataViewControllerSectionContainerProtocol;

/*--------------------------------------------------*/

@interface GLBListDataViewController : GLBDataViewController< GLBListDataProviderDelegate >

@property(nonatomic, nonnull, strong) id< GLBListDataProvider > provider;
@property(nonatomic, readonly, nullable, strong) __kindof GLBDataViewContainer< GLBListDataViewControllerContentContainerProtocol >* contentContainer;

- (nullable __kindof GLBDataViewContainer< GLBListDataViewControllerContentContainerProtocol >*)prepareContentContainer;

- (void)configureDataView NS_REQUIRES_SUPER;

- (nullable __kindof GLBSearchBar*)prepareSearchBar;
- (nullable __kindof GLBDataRefreshView*)prepareTopRefreshView;

- (void)showContentContainer:(nonnull GLBSimpleBlock)update NS_UNAVAILABLE;
- (void)showContentContainerWithModel:(nonnull NSArray*)models first:(BOOL)first;

- (void)beginSearching;
- (void)endSearching;

- (void)reloadData;

@end

/*--------------------------------------------------*/

@protocol GLBListDataViewControllerContentContainerProtocol < GLBDataViewControllerContentContainerProtocol >

- (void)setModels:(nonnull NSArray*)models;
- (void)appendModels:(nonnull NSArray*)models;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
