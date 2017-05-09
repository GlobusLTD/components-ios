/*--------------------------------------------------*/

#import "GLBListDataViewControllerContentContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBListDataViewControllerContentContainer () {
    NSDictionary< NSString*, Class >* _mapCells;
}

@end

/*--------------------------------------------------*/

@implementation GLBListDataViewControllerContentContainer

#pragma mark - Synthesize

@synthesize viewController = _viewController;

#pragma mark - Init / Free

+ (instancetype)container {
    return [self containerWithOrientation:GLBDataViewContainerOrientationVertical];
}

- (void)setup {
    [super setup];
    
    _mapCells = [self.class mapCells];
}

#pragma mark - GLBDataViewContainer

- (void)willChangeDataView {
    if(self.dataView != nil) {
        [_mapCells glb_each:^(NSString* identifier, Class cellClass) {
            [self.dataView unregisterIdentifier:identifier];
        }];
    }
    
    [super willChangeDataView];
}

- (void)didChangeDataView {
    [super didChangeDataView];
    
    if(self.dataView != nil) {
        [_mapCells glb_each:^(NSString* identifier, Class cellClass) {
            [self.dataView registerIdentifier:identifier withViewClass:cellClass];
        }];
    }
}

#pragma mark - Public

+ (NSDictionary< NSString*, Class >*)mapCells {
    return @{};
}

- (GLBDataViewItem*)prepareItemWithModel:(id)model {
    return nil;
}

#pragma mark - GLBListDataViewControllerContentContainerProtocol

- (void)setModels:(NSArray*)models {
    [self deleteAllItems];
    [self appendModels:models];
}

- (void)appendModels:(NSArray*)models {
    for(id model in models) {
        GLBDataViewItem* contentItem = [self prepareItemWithModel:model];
        if(contentItem != nil) {
            [self appendItem:contentItem];
        }
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
