/*--------------------------------------------------*/

#import "GLBDataViewControllerPreloadContainer.h"
#import "GLBDataViewControllerPreloadCell.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

static NSString* DefaultIdentifier = @"DefaultPreload";
static NSUInteger DefaultNumberOfItems = 20;

/*--------------------------------------------------*/

@implementation GLBDataViewControllerPreloadContainer

#pragma mark - Synthesize

@synthesize viewController = _viewController;

#pragma mark - Init / Free

+ (instancetype)container {
    return [[self alloc] init];
}

+ (instancetype)containerWithNumberOfItems:(NSUInteger)numberOfItems {
    return [[self alloc] initWithNumberOfItems:numberOfItems];
}

+ (instancetype)containerWithCellClass:(Class)cellClass numberOfItems:(NSUInteger)numberOfItems {
    return [[self alloc] initWithCellClass:cellClass numberOfItems:numberOfItems];
}

- (instancetype)init {
    return [self initWithNumberOfItems:DefaultNumberOfItems];
}

- (instancetype)initWithNumberOfItems:(NSUInteger)numberOfItems {
    return [self initWithCellClass:GLBDataViewControllerPreloadCell.class numberOfItems:numberOfItems];
}

- (instancetype)initWithCellClass:(Class)cellClass numberOfItems:(NSUInteger)numberOfItems {
    self = [super init];
    if(self != nil) {
        _cellClass = cellClass;
        _numberOfItems = numberOfItems;
        
        for(NSUInteger index = 0; index < _numberOfItems; index++) {
            [self appendIdentifier:DefaultIdentifier byData:nil];
        }
    }
    return self;
}

#pragma mark - GLBDataViewContainer

- (void)willChangeDataView {
    if(self.dataView != nil) {
        [self.dataView unregisterIdentifier:DefaultIdentifier];
    }
    
    [super willChangeDataView];
}

- (void)didChangeDataView {
    [super didChangeDataView];
    
    if((self.dataView != nil) && (_cellClass != nil)) {
        [self.dataView registerIdentifier:DefaultIdentifier withViewClass:_cellClass];
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
