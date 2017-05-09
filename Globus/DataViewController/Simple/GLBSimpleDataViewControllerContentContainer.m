/*--------------------------------------------------*/

#import "GLBSimpleDataViewControllerContentContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBSimpleDataViewControllerContentContainer () {
    NSDictionary< NSString*, Class >* _mapCells;
}

@end

/*--------------------------------------------------*/

@implementation GLBSimpleDataViewControllerContentContainer

#pragma mark - Synthesize

@synthesize viewController = _viewController;
@synthesize model = _model;

#pragma mark - Init / Free

+ (instancetype)container {
    return [self new];
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

- (void)prepareWithModel:(id)model {
}

- (void)cleanupWithModel:(id)model {
}

#pragma mark - GLBSimpleDataViewControllerContentContainerProtocol

- (void)setModel:(id)model {
    if(_model != model) {
        if(_model != nil) {
            [self cleanupWithModel:_model];
        }
        _model = model;
        if(_model != nil) {
            [self prepareWithModel:_model];
        }
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
