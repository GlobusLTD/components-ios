//
//  Globus
//

#import "ListDataViewController.h"
#import "ListDataViewCell.h"
#import "ListDataViewModel.h"

@interface ListDataViewController () {
    GLBDataViewItemsListContainer* _dataViewContainer;
}

@end

static NSString* ListCellIdentifier = @"List";

@implementation ListDataViewController

#pragma mark - Init / Free

- (void)setup {
    [super setup];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"ListDataView";
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem glb_removeAllLeftBarButtonItemsAnimated:NO];
    [self.navigationItem glb_addLeftBarButtonNormalImage:[UIImage imageNamed:@"MenuButton"] target:self action:@selector(pressedMenu:) animated:NO];
}

#pragma mark - GLBViewController

- (void)update {
    [super update];
    
    [self.dataView batchUpdate:^{
        for(NSUInteger index = 0; index < 1000; index++) {
            NSString* title = [NSString stringWithFormat:@"Item #%d", (int)index];
            [_dataViewContainer appendIdentifier:ListCellIdentifier
                                          byData:[ListDataViewModel viewModelWithTitle:title]];
        }
    }];
}

- (void)clear {
    [self.dataView batchUpdate:^{
        [_dataViewContainer deleteAllItems];
    }];
    
    [super clear];
}

#pragma mark - GLBDataViewController

- (void)prepareDataView {
    _dataViewContainer = [GLBDataViewItemsListContainer containerWithOrientation:GLBDataViewContainerOrientationVertical];
    
    [self.dataView registerIdentifier:ListCellIdentifier withViewClass:ListDataViewCell.class];
    
    self.dataView.container = _dataViewContainer;
}

- (void)cleanupDataView {
    self.dataView.container = nil;
    [self.dataView unregisterAllIdentifiers];
    [self.dataView unregisterAllActions];
    _dataViewContainer = nil;
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

@end
