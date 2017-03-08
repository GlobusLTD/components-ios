//
//  Globus
//

#import "ListDataViewController.h"
#import "ListDataViewCell.h"
#import "ListDataProvider.h"

@interface ListDataViewController ()
@end

static NSString* ListCellIdentifier = @"List";

@implementation ListDataViewController

#pragma mark - Init / Free

- (void)setup {
    [super setup];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"ListDataView";
    
    self.provider = [ListDataProvider dataProvider];
    self.spinnerView = [GLBArcSpinnerView new];
    self.spinnerView.color = UIColor.blueColor;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem glb_removeAllLeftBarButtonItemsAnimated:NO];
    [self.navigationItem glb_addLeftBarButtonNormalImage:[UIImage imageNamed:@"MenuButton"] target:self action:@selector(pressedMenu:) animated:NO];
}

#pragma mark - GLBListDataViewController

- (void)configureDataView {
    [super configureDataView];
    
    [self registerIdentifier:ListCellIdentifier withViewClass:ListDataViewCell.class];
}

- (GLBDataViewSectionsContainer*)prepareRootContainer {
    return [GLBDataViewSectionsListContainer containerWithOrientation:GLBDataViewContainerOrientationVertical];
}

- (GLBDataViewSectionsContainer*)prepareContentContainer {
    return [GLBDataViewSectionsListContainer containerWithOrientation:GLBDataViewContainerOrientationVertical];
}

- (GLBDataViewContainer*)preparePreloadContainer {
    return nil;
}

- (GLBDataViewContainer*)prepareEmptyContainer {
    return nil;
}

- (GLBDataViewContainer*)prepareErrorContainerWithError:(nullable id)error {
    return nil;
}

- (GLBDataViewContainer*)prepareSectionContainerWithModel:(id< GLBListDataProviderModel >)model {
    return [GLBDataViewItemsListContainer containerWithOrientation:GLBDataViewContainerOrientationVertical];
}

- (GLBDataViewItem*)prepareItemWithModel:(id)model {
    return [GLBDataViewItem itemWithIdentifier:ListCellIdentifier order:0 data:model];
}

- (void)sectionContainer:(GLBDataViewContainer*)sectionContainer appendItem:(GLBDataViewItem*)item {
    GLBDataViewItemsListContainer* itemsListContainer = (GLBDataViewItemsListContainer*)sectionContainer;
    [itemsListContainer appendItem:item];
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

@end
