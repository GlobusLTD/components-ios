/*--------------------------------------------------*/

#import "GLBDataViewControllerEmptyContainer.h"
#import "GLBDataViewControllerEmptyCell.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewControllerEmptyContainer () {
    GLBDataViewItem* _item;
}

@end

/*--------------------------------------------------*/

static NSString* DefaultIdentifier = @"Empty";

/*--------------------------------------------------*/

@implementation GLBDataViewControllerEmptyContainer

#pragma mark - Synthesize

@synthesize viewController = _viewController;

#pragma mark - Init / Free

+ (nonnull instancetype)container {
    return [self new];
}

+ (nonnull instancetype)containerWithCellClass:(Class)cellClass {
    return [[self alloc] initWithCellClass:cellClass];
}

- (nonnull instancetype)init {
    return [self initWithCellClass:GLBDataViewControllerEmptyCell.class];
}

- (nonnull instancetype)initWithCellClass:(Class)cellClass {
    self = [super init];
    if(self != nil) {
        _cellClass = cellClass;
        _item = [GLBDataViewItem itemWithIdentifier:DefaultIdentifier order:0 data:nil];
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

- (CGRect)frameItemsForAvailableFrame:(CGRect)frame {
    CGSize restriction = frame.size;
    CGSize cumulative = CGSizeZero;
    if(_item != nil) {
        cumulative = [_item sizeForAvailableSize:restriction];
    }
    return CGRectMake(frame.origin.x, frame.origin.y, cumulative.width, cumulative.height);
}

- (void)layoutItemsForFrame:(CGRect)frame {
    if(_item != nil) {
        CGSize size = [_item sizeForAvailableSize:frame.size];
        _item.updateFrame = CGRectMake(
            frame.origin.x,
            frame.origin.y,
            size.width,
            size.height
        );
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
