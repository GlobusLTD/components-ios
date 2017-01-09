//
//  Globus
//

#import "ChoiseViewController.h"
#import "ChoiseCellTableViewCell.h"
#import "ChoiseViewModel.h"

#import "LabelViewController.h"
#import "ButtonViewController.h"
#import "ButtonImageViewController.h"
#import "ButtonBadgeViewController.h"
#import "ImageViewController.h"

@interface ChoiseViewController () < UITableViewDataSource, UITableViewDelegate > {
    NSArray< ChoiseViewModel* >* _data;
}

@property(nonatomic, weak) IBOutlet UITableView* tableView;

@end

@implementation ChoiseViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _data = @[
        [ChoiseViewModel viewModelWithTitle:@"Label" viewController:LabelViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"Button" viewController:ButtonViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"Button & Image" viewController:ButtonImageViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"Button & Badge" viewController:ButtonBadgeViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"Image" viewController:ImageViewController.class],
    ];
    
    [_tableView glb_registerCell:ChoiseCellTableViewCell.class];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return (NSInteger)(_data.count);
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    return [tableView glb_dequeueReusableCell:ChoiseCellTableViewCell.class];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    NSUInteger index = (NSUInteger)(indexPath.row);
    if([cell isKindOfClass:ChoiseCellTableViewCell.class] == YES) {
        ChoiseCellTableViewCell* choiseCell = (ChoiseCellTableViewCell*)cell;
        [choiseCell configureWithChoiseViewModel:_data[index]];
    }
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    NSUInteger index = (NSUInteger)(indexPath.row);
    ChoiseViewModel* viewModel = _data[index];
    GLBViewController* vc = [viewModel instantiateViewController];
    if(vc != nil) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
