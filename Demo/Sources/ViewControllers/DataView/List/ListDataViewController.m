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

#pragma mark - GLBViewController

- (NSArray< UIBarButtonItem* >*)prepareNavigationLeftBarButtons {
    return @[
        [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MenuButton"] style:UIBarButtonItemStylePlain target:self action:@selector(pressedMenu:)]
    ];
}

#pragma mark - GLBListDataViewController

- (GLBDataViewContainer< GLBListDataViewControllerContentContainerProtocol >*)prepareContentContainer {
    return [ListDataViewControllerContentContainer container];
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

@end

@implementation ListDataViewControllerContentContainer

+ (NSDictionary< NSString*, Class >*)mapCells {
    return @{
        ListCellIdentifier: ListDataViewCell.class
    };
}

- (GLBDataViewItem*)prepareItemWithModel:(id)model {
    return [GLBDataViewItem itemWithIdentifier:ListCellIdentifier order:0 data:model];
}

@end
