/*--------------------------------------------------*/

#import "GLBSimpleDataViewController.h"
#import "GLBSimpleDataViewControllerContentContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBSimpleDataViewController

#pragma mark - Property

- (GLBDataViewContainer< GLBSimpleDataViewControllerContentContainerProtocol >*)contentContainer {
    return (GLBDataViewContainer< GLBSimpleDataViewControllerContentContainerProtocol >*)(super.contentContainer);
}

#pragma mark - Synthesize

@synthesize rootContainer = _rootContainer;

#pragma mark - GLBViewController

- (void)update {
    [super update];
    
    if(_provider.canCache == YES) {
        [self showContentContainerWithModel:[_provider cacheModel]];
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

#pragma mark - Public

- (GLBDataViewContainer< GLBSimpleDataViewControllerContentContainerProtocol >*)prepareContentContainer {
    return [GLBSimpleDataViewControllerContentContainer container];
}

- (GLBDataRefreshView*)prepareTopRefreshView {
    return [GLBDataRefreshView new];
}

- (void)showContentContainerWithModel:(id)model {
    [super showContentContainer:^{
        self.contentContainer.model = model;
    }];
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
    [self showErrorContainer:error];
    if(self.dataView.topRefreshView.state != GLBDataRefreshViewStateIdle) {
        [self.dataView hideTopRefreshAnimated:YES complete:nil];
    }
}

- (void)finishLoadingForDataProvider:(id< GLBSimpleDataProvider >)dataProvider model:(id)model {
    [self hideLoading];
    [self showContentContainerWithModel:model];
    if(self.dataView.topRefreshView.state != GLBDataRefreshViewStateIdle) {
        [self.dataView hideTopRefreshAnimated:YES complete:nil];
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
