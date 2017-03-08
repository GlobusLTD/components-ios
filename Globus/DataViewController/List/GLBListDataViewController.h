/*--------------------------------------------------*/

#import "GLBDataViewController.h"

/*--------------------------------------------------*/

#import "GLBDataViewSectionsContainer.h"

/*--------------------------------------------------*/

#import "GLBListDataProvider.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBListDataViewControllerState) {
    GLBListDataViewControllerStateNone,
    GLBListDataViewControllerStateContent,
    GLBListDataViewControllerStatePreload,
    GLBListDataViewControllerStateEmpty,
    GLBListDataViewControllerStateError
};

/*--------------------------------------------------*/

@interface GLBListDataViewController : GLBDataViewController< GLBListDataProviderDelegate >

@property(nonatomic, nonnull, strong) id< GLBListDataProvider > provider;

@property(nonatomic, readonly) GLBListDataViewControllerState state;

- (void)configureDataView NS_REQUIRES_SUPER;

- (nullable __kindof GLBDataViewSectionsContainer*)prepareRootContainer;
- (nullable __kindof GLBDataViewSectionsContainer*)prepareContentContainer;
- (nullable __kindof GLBDataViewContainer*)preparePreloadContainer;
- (nullable __kindof GLBDataViewContainer*)prepareEmptyContainer;
- (nullable __kindof GLBDataViewContainer*)prepareErrorContainerWithError:(nullable id)error;

- (nullable __kindof GLBSearchBar*)prepareSearchBar;
- (nullable __kindof GLBDataRefreshView*)prepareTopRefreshView;

- (nullable __kindof GLBDataViewContainer*)prepareSectionContainerWithModel:(nonnull id< GLBListDataProviderModel >)model;

- (nullable __kindof GLBDataViewItem*)prepareHeaderItemWithModel:(nonnull id)model;
- (void)sectionContainer:(nonnull __kindof GLBDataViewContainer*)sectionContainer setHeaderItem:(nonnull __kindof GLBDataViewItem*)headerItem;

- (nullable __kindof GLBDataViewItem*)prepareFooterItemWithModel:(nonnull id)model;
- (void)sectionContainer:(nonnull __kindof GLBDataViewContainer*)sectionContainer setFooterItem:(nonnull __kindof GLBDataViewItem*)footerItem;

- (nullable __kindof GLBDataViewItem*)prepareItemWithModel:(nonnull id)model;
- (void)sectionContainer:(nonnull __kindof GLBDataViewContainer*)sectionContainer appendItem:(nonnull __kindof GLBDataViewItem*)item;

- (void)beginSearching;
- (void)endSearching;

- (void)reloadData;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
