//
//  Globus
//

#import "SimpleDataViewController.h"
#import "SimpleDataViewCell.h"
#import "SimpleDataProvider.h"

@interface SimpleDataViewController ()
@end

static NSString* SimpleCellIdentifier = @"Simple";

@implementation SimpleDataViewController

#pragma mark - Init / Free

- (void)setup {
    [super setup];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"SimpleDataView";
    
    self.provider = [SimpleDataProvider dataProvider];
    self.spinnerView = [GLBArcSpinnerView new];
    self.spinnerView.color = UIColor.blueColor;
}

#pragma mark - GLBViewController

- (NSArray< UIBarButtonItem* >*)prepareNavigationLeftBarButtons {
    return @[
        [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MenuButton"] style:UIBarButtonItemStylePlain target:self action:@selector(pressedMenu:)]
    ];
}

#pragma mark - GLBSimpleDataViewController

- (GLBDataViewContainer< GLBSimpleDataViewControllerContentContainerProtocol >*)prepareContentContainer {
    return [SimpleDataViewControllerContentContainer container];
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

@end

@implementation SimpleDataViewControllerContentContainer

+ (NSDictionary< NSString*, Class >*)mapCells {
    return @{
        SimpleCellIdentifier: SimpleDataViewCell.class
    };
}

- (void)prepareWithModel:(id)model {
    [self appendIdentifier:SimpleCellIdentifier byData:model];
}

- (void)cleanupWithModel:(id)model {
    [self deleteAllItems];
}

@end
