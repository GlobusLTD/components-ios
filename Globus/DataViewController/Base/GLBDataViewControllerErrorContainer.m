/*--------------------------------------------------*/

#import "GLBDataViewControllerErrorContainer.h"
#import "GLBDataViewControllerErrorCell.h"
#import "NSDictionary+GLBNS.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewControllerErrorContainer () {
    NSDictionary< NSString*, Class >* _mapCells;
    GLBDataViewItem* _item;
}

@end

/*--------------------------------------------------*/

static NSString* DefaultIdentifier = @"DefaultError";

/*--------------------------------------------------*/

@implementation GLBDataViewControllerErrorContainer

#pragma mark - Synthesize

@synthesize viewController = _viewController;
@synthesize error = _error;

#pragma mark - Init / Free

+ (instancetype)containerWithError:(id)error {
    return [[self alloc] initWithError:error];
}

- (instancetype)initWithError:(id)error {
    self = [super init];
    if(self != nil) {
        _error = error;
        _mapCells = [self.class mapCells];
        NSString* identifier = [self.class itemIdentifierWithError:error];
        if(identifier != nil) {
            _item = [GLBDataViewItem itemWithIdentifier:identifier order:0 data:error];
        }
    }
    return self;
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

#pragma mark - Public

+ (NSDictionary< NSString*, Class >*)mapCells {
    return @{
        DefaultIdentifier: GLBDataViewControllerErrorCell.class
    };
}

+ (NSString*)itemIdentifierWithError:(id)error {
    return DefaultIdentifier;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
