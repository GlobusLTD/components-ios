/*--------------------------------------------------*/

#import "GLBDataViewControllerRootContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBDataViewControllerRootContainer

#pragma mark - Synthesize

@synthesize viewController = _viewController;
@synthesize currentContainer = _currentContainer;

#pragma mark - Init / Free

+ (instancetype)container {
    return [self containerWithOrientation:GLBDataViewContainerOrientationVertical];
}

#pragma mark - GLBDataViewControllerRootContainerProtocol

- (void)showContentContainer:(GLBDataViewContainer< GLBDataViewControllerContentContainerProtocol >*)container {
    [self __showContainer:container];
}

- (void)showPreloadContainer:(GLBDataViewContainer< GLBDataViewControllerPreloadContainerProtocol >*)container {
    [self __showContainer:container];
}

- (void)showEmptyContainer:(GLBDataViewContainer< GLBDataViewControllerEmptyContainerProtocol >*)container {
    [self __showContainer:container];
}

- (void)showErrorContainer:(GLBDataViewContainer< GLBDataViewControllerErrorContainerProtocol >*)container {
    [self __showContainer:container];
}

- (void)hideCurrentContainer {
    [self __showContainer:nil];
}

#pragma mark - Private

- (void)__showContainer:(GLBDataViewContainer< GLBDataViewControllerContainerProtocol >*)container {
    if(_currentContainer != container) {
        if(_currentContainer != nil) {
            [self deleteSection:_currentContainer];
        }
        _currentContainer = container;
        if(_currentContainer != nil) {
            [self appendSection:_currentContainer];
        }
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
