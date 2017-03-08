/*--------------------------------------------------*/

#import "GLBListDataViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBListDataViewController () {
@protected
    NSMutableDictionary< id< GLBListDataProviderModel >, GLBDataViewContainer* >* _sections;
}

@property(nonatomic, nonnull, readonly, strong) __kindof GLBDataViewSectionsContainer* rootContainer;
@property(nonatomic, nullable, readonly, strong) __kindof GLBDataViewContainer* contentContainer;

@end

/*--------------------------------------------------*/

@implementation GLBListDataViewController

#pragma mark - Synthesize

@synthesize rootContainer = _rootContainer;
@synthesize contentContainer = _contentContainer;

#pragma mark - Init / Free

- (void)setup {
    [super setup];
    
    _sections = [NSMutableDictionary dictionary];
}

#pragma mark - GLBViewController

- (void)update {
    [super update];
    
    if(_provider.canCache == YES) {
        [self __showContentContainer:_provider.cacheModels first:YES];
    } else {
        [self __showPreloadContainer];
    }
    [_provider load];
}

- (void)clear {
    [_provider cancel];
    
    _state = GLBListDataViewControllerStateNone;
    [_sections removeAllObjects];
    [self.dataView batchUpdate:^{
        [_rootContainer deleteAllSections];
    } complete:^{
        _contentContainer = nil;
    }];
    
    [super clear];
}

#pragma mark - GLBDataViewController

- (void)configureDataView {
    if(_provider.canSearch == YES) {
        GLBSearchBar* searchBar = [self prepareSearchBar];
        if(searchBar != nil) {
            self.dataView.searchBar = searchBar;
            
            [self.dataView registerActionWithTarget:self action:@selector(__actionBeginForSearchBar:) forKey:GLBDataViewSearchBegin];
            [self.dataView registerActionWithTarget:self action:@selector(__actionEndForSearchBar:) forKey:GLBDataViewSearchEnd];
            [self.dataView registerActionWithTarget:self action:@selector(__actionBeginEditingForSearchBar:) forKey:GLBDataViewSearchBeginEditing];
            [self.dataView registerActionWithTarget:self action:@selector(__actionSearchBar:text:) forKey:GLBDataViewSearchTextChanged];
            [self.dataView registerActionWithTarget:self action:@selector(__actionEndEditingForSearchBar:) forKey:GLBDataViewSearchEndEditing];
            [self.dataView registerActionWithTarget:self action:@selector(__actionPressedClearForSearchBar:) forKey:GLBDataViewSearchPressedClear];
            [self.dataView registerActionWithTarget:self action:@selector(__actionPressedReturnForSearchBar:) forKey:GLBDataViewSearchPressedReturn];
            [self.dataView registerActionWithTarget:self action:@selector(__actionPressedCancelForSearchBar:) forKey:GLBDataViewSearchPressedCancel];
        }
    }
    if(_provider.canReload == YES) {
        GLBDataRefreshView* refreshView = [self prepareTopRefreshView];
        if(refreshView != nil) {
            self.dataView.topRefreshView = refreshView;
            
            [self.dataView registerActionWithTarget:self action:@selector(__actionTriggeredRefresh) forKey:GLBDataViewTopRefreshTriggered];
        }
    }
    self.dataView.container = self.rootContainer;
}

- (void)cleanupDataView {
    [super cleanupDataView];
    
    self.dataView.searchBar = nil;
    self.dataView.topRefreshView = nil;
}

#pragma mark - Property

- (void)setProvider:(id< GLBListDataProvider >)provider {
    if(_provider != provider) {
        if(_provider != nil) {
            _provider.delegate = nil;
        }
        _provider = provider;
        if(_provider != nil) {
            _provider.delegate = self;
        }
        [self setNeedUpdate];
    }
}

- (GLBDataViewContainer*)rootContainer {
    if(_rootContainer == nil) {
        _rootContainer = [self prepareRootContainer];
    }
    return _rootContainer;
}

- (GLBDataViewContainer*)contentContainer {
    if(_contentContainer == nil) {
        _contentContainer = [self prepareContentContainer];
    }
    return _contentContainer;
}

#pragma mark - Public

- (GLBDataViewSectionsContainer*)prepareRootContainer {
    return nil;
}

- (GLBDataViewSectionsContainer*)prepareContentContainer {
    return nil;
}

- (GLBDataViewContainer*)preparePreloadContainer {
    return nil;
}

- (GLBDataViewContainer*)prepareEmptyContainer {
    return nil;
}

- (GLBDataViewContainer*)prepareErrorContainerWithError:(id)error {
    return nil;
}

- (GLBSearchBar*)prepareSearchBar {
    return [GLBSearchBar new];
}

- (GLBDataRefreshView*)prepareTopRefreshView {
    return [GLBDataRefreshView new];
}

- (GLBDataViewContainer*)prepareSectionContainerWithModel:(id< GLBListDataProviderModel >)model {
    return nil;
}

- (GLBDataViewItem*)prepareHeaderItemWithModel:(id)model {
    return nil;
}

- (void)sectionContainer:(GLBDataViewContainer*)sectionContainer setHeaderItem:(GLBDataViewItem*)headerItem {
}

- (GLBDataViewItem*)prepareFooterItemWithModel:(id)model {
    return nil;
}

- (void)sectionContainer:(GLBDataViewContainer*)sectionContainer setFooterItem:(GLBDataViewItem*)footerItem {
}

- (GLBDataViewItem*)prepareItemWithModel:(id)model {
    return nil;
}

- (void)sectionContainer:(GLBDataViewContainer*)sectionContainer appendItem:(GLBDataViewItem*)item {
}

- (void)beginSearching {
}

- (void)endSearching {
}

- (void)reloadData {
    if(self.isViewLoaded == YES) {
        switch(_state) {
            case GLBListDataViewControllerStateNone:
                if(_provider.canCache == YES) {
                    [self __showContentContainer:_provider.cacheModels first:YES];
                } else {
                    [self __showPreloadContainer];
                }
                break;
            case GLBListDataViewControllerStatePreload:
                [self __showPreloadContainer];
                break;
            case GLBListDataViewControllerStateContent:
                if((_provider.isSearching == YES) && (_provider.searchText.length > 0)) {
                    [self __showContentContainer:_provider.searchModels first:YES];
                } else {
                    [self __showContentContainer:_provider.models first:YES];
                }
                break;
            case GLBListDataViewControllerStateEmpty:
                [self __showEmptyContainer];
                break;
            case GLBListDataViewControllerStateError:
                [self __showErrorContainer:_provider.error];
                break;
        }
    }
}

#pragma mark - Actions

- (void)__actionBeginForSearchBar:(GLBSearchBar*)searchBar {
    [_provider beginSearch];
    [self beginSearching];
}

- (void)__actionEndForSearchBar:(GLBSearchBar*)searchBar {
    [_provider endSearch];
    [self endSearching];
}

- (void)__actionBeginEditingForSearchBar:(GLBSearchBar*)searchBar {
}

- (void)__actionSearchBar:(GLBSearchBar*)searchBar text:(NSString*)text {
    _provider.searchText = text;
}

- (void)__actionEndEditingForSearchBar:(GLBSearchBar*)searchBar {
}

- (void)__actionPressedClearForSearchBar:(GLBSearchBar*)searchBar {
}

- (void)__actionPressedReturnForSearchBar:(GLBSearchBar*)searchBar {
}

- (void)__actionPressedCancelForSearchBar:(GLBSearchBar*)searchBar {
}

- (void)__actionTriggeredRefresh {
    [_provider reload];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    if(_provider.canLoadMore == YES) {
        switch(_state) {
            case GLBListDataViewControllerStateContent: {
                CGPoint contentOffset = self.dataView.contentOffset;
                CGSize contentSize = self.dataView.contentSize;
                CGSize frameSize = self.dataView.glb_frameSize;
                CGFloat position, limit;
                if(contentSize.height > frameSize.height) {
                    position = contentOffset.y;
                    limit = contentSize.height - frameSize.height;
                } else if(contentSize.width > frameSize.width) {
                    position = contentOffset.x;
                    limit = contentSize.width - frameSize.width;
                } else {
                    limit = 0.0f;
                }
                if((limit > GLB_EPSILON) && (position >= limit)) {
                    [_provider load];
                }
                break;
            }
            default:
                break;
        }
    }
}

#pragma mark - GLBListDataProviderDelegate

- (void)startLoadingForDataProvider:(id< GLBListDataProvider >)dataProvider {
    [self showLoading];
}

- (void)finishLoadingForDataProvider:(id< GLBListDataProvider >)dataProvider error:(id)error {
    [self hideLoading];
    [self __showErrorContainer:error];
}

- (void)finishLoadingForDataProvider:(id< GLBListDataProvider >)dataProvider models:(NSArray< GLBListDataProviderModel >*)models first:(BOOL)first {
    [self hideLoading];
    [self __showContentContainer:models first:first];
    if(self.dataView.topRefreshView.state != GLBDataRefreshViewStateIdle) {
        [self.dataView hideTopRefreshAnimated:YES complete:nil];
    }
}

#pragma mark - Internal

- (void)__showPreloadContainer {
    if(_sections.count > 0) {
        [_sections removeAllObjects];
    }
    GLBDataViewContainer* preloadContainer = [self preparePreloadContainer];
    if(preloadContainer != nil) {
        _state = GLBListDataViewControllerStatePreload;
        [self.dataView batchUpdate:^{
            [_rootContainer deleteAllSections];
            [_rootContainer appendSection:preloadContainer];
        }];
    } else {
        [self __showEmptyContainer];
    }
}

- (void)__showContentContainer:(NSArray< id< GLBListDataProviderModel > >*)models first:(BOOL)first {
    if(first == YES) {
        [_sections removeAllObjects];
    }
    if(_state == GLBListDataViewControllerStateContent) {
        [self.dataView batchUpdate:^{
            if(first == YES) {
                [_contentContainer deleteAllSections];
            }
            [self __appendModels:models];
        }];
    } else if(models.count > 0) {
        GLBDataViewSectionsContainer* contentContainer = self.contentContainer;
        if(contentContainer != nil) {
            _state = GLBListDataViewControllerStateContent;
            if(first == YES) {
                [contentContainer deleteAllSections];
            }
            [self.dataView batchUpdate:^{
                [_rootContainer deleteAllSections];
                [self __appendModels:models];
                [_rootContainer appendSection:contentContainer];
            }];
        } else {
            [self __showEmptyContainer];
        }
    } else {
        [self __showEmptyContainer];
    }
}

- (void)__showEmptyContainer {
    if(_sections.count > 0) {
        [_sections removeAllObjects];
    }
    _state = GLBListDataViewControllerStateEmpty;
    GLBDataViewContainer* emptyContainer = [self prepareEmptyContainer];
    [self.dataView batchUpdate:^{
        if(emptyContainer != nil) {
            [_rootContainer deleteAllSections];
            [_rootContainer appendSection:emptyContainer];
        } else {
            [_rootContainer deleteAllSections];
        }
    } complete:^{
        _contentContainer = nil;
    }];
}

- (void)__showErrorContainer:(id)error {
    if(_sections.count > 0) {
        [_sections removeAllObjects];
    }
    if(error != nil) {
        GLBDataViewContainer* errorContainer = [self prepareErrorContainerWithError:error];
        if(errorContainer != nil) {
            _state = GLBListDataViewControllerStateError;
            [self.dataView batchUpdate:^{
                [_rootContainer deleteAllSections];
                [_rootContainer appendSection:errorContainer];
            } complete:^{
                _contentContainer = nil;
            }];
        }
    } else {
        [self __showEmptyContainer];
    }
}

- (void)__appendModels:(NSArray< id< GLBListDataProviderModel > >*)models {
    for(id< GLBListDataProviderModel > model in models) {
        __kindof GLBDataViewContainer* sectionContainer = _sections[model];
        if(sectionContainer == nil) {
            sectionContainer = [self prepareSectionContainerWithModel:model];
            if(sectionContainer != nil) {
                id header = model.header;
                if(header != nil) {
                    GLBDataViewItem* headerItem = [self prepareHeaderItemWithModel:header];
                    if(headerItem != nil) {
                        [self sectionContainer:sectionContainer setHeaderItem:headerItem];
                    }
                }
                id footer = model.footer;
                if(footer != nil) {
                    GLBDataViewItem* footerItem = [self prepareFooterItemWithModel:footer];
                    if(footerItem != nil) {
                        [self sectionContainer:sectionContainer setFooterItem:footerItem];
                    }
                }
                [_contentContainer appendSection:sectionContainer];
            }
        }
        if(sectionContainer != nil) {
            for(id child in model.childs) {
                GLBDataViewItem* item = [self prepareItemWithModel:child];
                if(item != nil) {
                    [self sectionContainer:sectionContainer appendItem:item];
                }
            }
        }
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
