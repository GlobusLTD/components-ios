/*--------------------------------------------------*/

#import "GLBListDataViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBListDataViewController

#pragma mark - Property

- (GLBDataViewContainer< GLBListDataViewControllerContentContainerProtocol >*)contentContainer {
    return (GLBDataViewContainer< GLBListDataViewControllerContentContainerProtocol >*)(super.contentContainer);
}

#pragma mark - GLBViewController

- (void)update {
    [super update];
    
    if(_provider.canCache == YES) {
        [self showContentContainerWithModel:_provider.cacheModels first:YES];
    } else {
        [self showPreloadContainer];
    }
    [_provider load];
}

- (void)clear {
    [_provider cancel];
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
    
    self.dataView.alwaysBounceVertical = YES;
    
    [super configureDataView];
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

#pragma mark - Public

- (id< GLBListDataViewControllerContentContainerProtocol >)prepareContentContainer {
    return nil;
}

- (GLBSearchBar*)prepareSearchBar {
    return [GLBSearchBar new];
}

- (GLBDataRefreshView*)prepareTopRefreshView {
    return [GLBDataRefreshView new];
}

- (void)showContentContainerWithModel:(NSArray*)models first:(BOOL)first {
    [super showContentContainer:^{
        if(first == YES) {
            [self.contentContainer setModels:models];
        } else {
            [self.contentContainer appendModels:models];
        }
    }];
}

- (void)beginSearching {
}

- (void)endSearching {
}

- (void)reloadData {
    if(self.isViewLoaded == YES) {
        switch(self.state) {
            case GLBDataViewControllerStateNone:
                if(_provider.canCache == YES) {
                    [self showContentContainerWithModel:_provider.cacheModels first:YES];
                } else {
                    [self showPreloadContainer];
                }
                break;
            case GLBDataViewControllerStatePreload:
                [self showPreloadContainer];
                break;
            case GLBDataViewControllerStateContent:
                if((_provider.isSearching == YES) && (_provider.searchText.length > 0)) {
                    [self showContentContainerWithModel:_provider.searchModels first:YES];
                } else {
                    [self showContentContainerWithModel:_provider.models first:YES];
                }
                break;
            case GLBDataViewControllerStateEmpty:
                [self showEmptyContainer];
                break;
            case GLBDataViewControllerStateError:
                [self showErrorContainer:_provider.error];
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
        switch(self.state) {
            case GLBDataViewControllerStateContent: {
                CGPoint contentOffset = self.dataView.contentOffset;
                CGSize contentSize = self.dataView.contentSize;
                CGSize frameSize = self.dataView.glb_frameSize;
                if(contentSize.height > frameSize.height) {
                    CGFloat limit = contentSize.height - frameSize.height;
                    if((limit > GLB_EPSILON) && (contentOffset.y > limit)) {
                        [_provider load];
                    }
                } else if(contentSize.width > frameSize.width) {
                    CGFloat limit = contentSize.width - frameSize.width;
                    if((limit > GLB_EPSILON) && (contentOffset.x > limit)) {
                        [_provider load];
                    }
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
    [self showErrorContainer:error];
    if(self.dataView.topRefreshView.state != GLBDataRefreshViewStateIdle) {
        [self.dataView hideTopRefreshAnimated:YES complete:nil];
    }
}

- (void)finishLoadingForDataProvider:(id< GLBListDataProvider >)dataProvider models:(NSArray*)models first:(BOOL)first {
    [self hideLoading];
    [self showContentContainerWithModel:models first:first];
    if(self.dataView.topRefreshView.state != GLBDataRefreshViewStateIdle) {
        [self.dataView hideTopRefreshAnimated:YES complete:nil];
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
