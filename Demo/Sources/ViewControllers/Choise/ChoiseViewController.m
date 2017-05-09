//
//  Globus
//

#import "ChoiseViewController.h"
#import "ChoiseCellTableViewCell.h"
#import "ChoiseViewModel.h"

#import "MainViewController.h"
#import "LabelViewController.h"
#import "ButtonViewController.h"
#import "ButtonImageViewController.h"
#import "ButtonBadgeViewController.h"
#import "ImageViewController.h"
#import "ImagePickerCropViewController.h"
#import "TextFieldViewController.h"
#import "DateFieldViewController.h"
#import "ListFieldViewController.h"
#import "PhoneFieldViewController.h"
#import "TextViewController.h"
#import "SpinnerViewController.h"
#import "ActivityViewController.h"
#import "ScrollViewController.h"
#import "TransitionRootViewController.h"
#import "PageControlViewController.h"
#import "NotificationsViewController.h"
#import "DialogRootViewController.h"
#import "ListDataViewController.h"
#import "SimpleDataViewController.h"
#import "CalendarDataViewController.h"

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
        [ChoiseViewModel viewModelWithTitle:@"Main" viewController:MainViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"Label" viewController:LabelViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"Button" viewController:ButtonViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"Button & Image" viewController:ButtonImageViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"Button & Badge" viewController:ButtonBadgeViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"Image" viewController:ImageViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"Image picker & crop" viewController:ImagePickerCropViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"Text field" viewController:TextFieldViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"Date field" viewController:DateFieldViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"List field" viewController:ListFieldViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"Phone field" viewController:PhoneFieldViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"Text view" viewController:TextViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"Spinner view" viewController:SpinnerViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"Activity view" viewController:ActivityViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"ScrollView" viewController:ScrollViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"Transition" viewController:TransitionRootViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"PageControl" viewController:PageControlViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"Notifications" viewController:NotificationsViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"Dialog" viewController:DialogRootViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"ListDataView" viewController:ListDataViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"SimpleDataView" viewController:SimpleDataViewController.class],
        [ChoiseViewModel viewModelWithTitle:@"CalendarDataView" viewController:CalendarDataViewController.class],
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
    GLBSlideViewController* svc = self.glb_slideViewController;
    if([svc.centerViewController isKindOfClass:GLBNavigationViewController.class] == YES) {
        GLBNavigationViewController* nvc = svc.centerViewController;
        
        NSUInteger index = (NSUInteger)(indexPath.row);
        GLBViewController* vc = [_data[index] instantiateViewController];
        if(vc != nil) {
            [nvc setViewControllers:@[ vc ] animated:YES];
        }
        [svc hideLeftViewControllerAnimated:YES complete:nil];
    }
}

@end
