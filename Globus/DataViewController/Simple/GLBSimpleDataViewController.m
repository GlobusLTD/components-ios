/*--------------------------------------------------*/

#import "GLBSimpleDataViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBSimpleDataViewController ()

@property(nonatomic, nonnull, readonly, strong) __kindof GLBDataViewSectionsContainer* rootContainer;

@end

/*--------------------------------------------------*/

@implementation GLBSimpleDataViewController

#pragma mark - Synthesize

@synthesize rootContainer = _rootContainer;

#pragma mark - GLBViewController

- (void)update {
    [super update];
    
    if(_provider.canCache == YES) {
        [self __applyModel:[_provider cacheModel]];
    } else {
        GLBDataViewContainer* preloadContainer = [self preparePreloadContainer];
        if(preloadContainer != nil) {
            _state = GLBSimpleDataViewControllerStatePreload;
            [self.dataView batchUpdate:^{
                [_rootContainer deleteAllSections];
                [_rootContainer appendSection:preloadContainer];
            }];
        }
    }
    [_provider load];
}

- (void)clear {
    [_provider cancel];
    
    _state = GLBSimpleDataViewControllerStateNone;
    [self.dataView batchUpdate:^{
        [_rootContainer deleteAllSections];
    }];
    
    [super clear];
}

#pragma mark - GLBDataViewController

- (void)configureDataView {
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
    
    self.dataView.topRefreshView = nil;
}

#pragma mark - Property

- (void)setProvider:(id< GLBSimpleDataProvider >)provider {
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

#pragma mark - Public

- (GLBDataViewSectionsContainer*)prepareRootContainer {
    return nil;
}

- (GLBDataViewContainer*)prepareContentContainerWithModel:(id)model {
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

- (GLBDataRefreshView*)prepareTopRefreshView {
    return [GLBDataRefreshView new];
}

#pragma mark - Actions

- (void)__actionTriggeredRefresh {
    [_provider reload];
}

#pragma mark - GLBSimpleDataProviderDelegate

- (void)startLoadingForDataProvider:(id< GLBSimpleDataProvider >)dataProvider {
    [self showLoading];
}

- (void)finishLoadingForDataProvider:(id< GLBSimpleDataProvider >)dataProvider error:(id)error {
    [self hideLoading];
    [self __error:error];
}

- (void)finishLoadingForDataProvider:(id< GLBSimpleDataProvider >)dataProvider model:(id)model {
    [self hideLoading];
    [self __applyModel:model];
}

#pragma mark - Internal

- (void)__error:(id)error {
    GLBDataViewContainer* errorContainer = [self prepareErrorContainerWithError:error];
    if(errorContainer != nil) {
        _state = GLBSimpleDataViewControllerStateError;
        [self.dataView batchUpdate:^{
            [_rootContainer deleteAllSections];
            [_rootContainer appendSection:errorContainer];
        }];
    } else {
        _state = GLBSimpleDataViewControllerStateEmpty;
        GLBDataViewContainer* emptyContainer = [self prepareEmptyContainer];
        if(emptyContainer != nil) {
            [self.dataView batchUpdate:^{
                [_rootContainer deleteAllSections];
                [_rootContainer appendSection:emptyContainer];
            }];
        } else {
            [self.dataView batchUpdate:^{
                [_rootContainer deleteAllSections];
            }];
        }
    }
}

- (void)__applyModel:(id)model {
    if(model != nil) {
        _state = GLBSimpleDataViewControllerStateContent;
        GLBDataViewSectionsContainer* contentContainer = [self prepareContentContainerWithModel:model];
        if(contentContainer != nil) {
            [self.dataView batchUpdate:^{
                [_rootContainer deleteAllSections];
                [_rootContainer appendSection:contentContainer];
            }];
        } else {
            _state = GLBSimpleDataViewControllerStateEmpty;
        }
    } else {
        _state = GLBSimpleDataViewControllerStateEmpty;
    }
    if(_state == GLBSimpleDataViewControllerStateEmpty) {
        GLBDataViewContainer* emptyContainer = [self prepareEmptyContainer];
        if(emptyContainer != nil) {
            [self.dataView batchUpdate:^{
                [_rootContainer deleteAllSections];
                [_rootContainer appendSection:emptyContainer];
            }];
        } else {
            [self.dataView batchUpdate:^{
                [_rootContainer deleteAllSections];
            }];
        }
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
