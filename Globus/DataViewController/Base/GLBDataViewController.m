/*--------------------------------------------------*/

#import "GLBDataViewController.h"
#import "GLBDataViewControllerRootContainer.h"
#import "GLBDataViewControllerPreloadContainer.h"
#import "GLBDataViewControllerEmptyContainer.h"
#import "GLBDataViewControllerErrorContainer.h"
#import "NSBundle+GLBNS.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBDataViewController

#pragma mark - GLBViewController

- (void)clear {
    _state = GLBDataViewControllerStateNone;
    [self.dataView batchUpdate:^{
        [_rootContainer hideCurrentContainer];
    } complete:^{
        _contentContainer = nil;
        _preloadContainer = nil;
        _emptyContainer = nil;
        _errorContainer = nil;
    }];
    
    [super clear];
}

#pragma mark - GLBDataViewController

- (void)configureDataView {
    if(_rootContainer == nil) {
        _rootContainer = [self prepareRootContainer];
        _rootContainer.viewController = self;
    }
    self.dataView.container = _rootContainer;
}

#pragma mark - Public

+ (NSBundle*)defaultNibBundle {
    static NSBundle* defaultNibBundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSBundle* rootBundle = [NSBundle bundleForClass:self.class];
        defaultNibBundle = [NSBundle glb_bundleWithName:self.glb_className rootBundle:rootBundle];
    });
    return defaultNibBundle;
}

- (GLBDataViewContainer< GLBDataViewControllerRootContainerProtocol >*)prepareRootContainer {
    return [GLBDataViewControllerRootContainer container];
}

- (id< GLBDataViewControllerContentContainerProtocol >)prepareContentContainer {
    return nil;
}

- (id< GLBDataViewControllerPreloadContainerProtocol >)preparePreloadContainer {
    return [GLBDataViewControllerPreloadContainer container];
}

- (id< GLBDataViewControllerEmptyContainerProtocol >)prepareEmptyContainer {
    return [GLBDataViewControllerEmptyContainer container];
}

- (id< GLBDataViewControllerErrorContainerProtocol >)prepareErrorContainerWithError:(id)error {
    return [GLBDataViewControllerErrorContainer containerWithError:error];
}

#pragma mark - Public

- (void)showPreloadContainer {
    if(_preloadContainer == nil) {
        _preloadContainer = [self preparePreloadContainer];
        _preloadContainer.viewController = self;
    }
    if(_preloadContainer != nil) {
        _state = GLBDataViewControllerStatePreload;
        [self.dataView batchUpdate:^{
            [_rootContainer showPreloadContainer:_preloadContainer];
        } complete:^{
            _contentContainer = nil;
            _emptyContainer = nil;
            _errorContainer = nil;
        }];
    } else {
        [self showEmptyContainer];
    }
}

- (void)showContentContainer:(GLBSimpleBlock)update {
    if(_state == GLBDataViewControllerStateContent) {
        [self.dataView batchUpdate:update];
    } else {
        if(_contentContainer == nil) {
            _contentContainer = [self prepareContentContainer];
            _contentContainer.viewController = self;
        }
        if(_contentContainer != nil) {
            _state = GLBDataViewControllerStateContent;
            [self.dataView batchUpdate:^{
                [_rootContainer showContentContainer:_contentContainer];
                if(update != nil) {
                    update();
                }
            } complete:^{
                _preloadContainer = nil;
                _emptyContainer = nil;
                _errorContainer = nil;
            }];
        } else {
            [self showEmptyContainer];
        }
    }
}

- (void)showEmptyContainer {
    if(_emptyContainer == nil) {
        _emptyContainer = [self prepareEmptyContainer];
        _emptyContainer.viewController = self;
    }
    if(_emptyContainer != nil) {
        _state = GLBDataViewControllerStateEmpty;
        [self.dataView batchUpdate:^{
            [_rootContainer showEmptyContainer:_emptyContainer];
        } complete:^{
            _contentContainer = nil;
            _preloadContainer = nil;
            _errorContainer = nil;
        }];
    } else {
        _state = GLBDataViewControllerStateNone;
    }
}

- (void)showErrorContainer:(id)error {
    if(error != nil) {
        if(_errorContainer == nil) {
            _errorContainer = [self prepareErrorContainerWithError:error];
            _errorContainer.viewController = self;
        }
        if(_errorContainer != nil) {
            _state = GLBDataViewControllerStateError;
            [self.dataView batchUpdate:^{
                [_rootContainer showErrorContainer:_errorContainer];
            } complete:^{
                _contentContainer = nil;
                _preloadContainer = nil;
                _emptyContainer = nil;
            }];
        } else {
            _state = GLBDataViewControllerStateNone;
        }
    } else {
        [self showEmptyContainer];
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
