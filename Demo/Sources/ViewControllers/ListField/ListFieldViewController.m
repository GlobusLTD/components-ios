//
//  Globus
//

#import "ListFieldViewController.h"

@interface ListFieldViewController ()

@property(nonatomic, weak) IBOutlet GLBListField* listField;

@end

@implementation ListFieldViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GLBTextStyle* textStyle = [GLBTextStyle new];
    textStyle.font = [UIFont boldSystemFontOfSize:16.0f];
    textStyle.color = UIColor.darkGrayColor;
    _listField.textStyle = textStyle;
    
    GLBTextStyle* placeholderStyle = [GLBTextStyle new];
    placeholderStyle.font = [UIFont boldSystemFontOfSize:16.0f];
    placeholderStyle.color = UIColor.lightGrayColor;
    _listField.placeholderStyle = placeholderStyle;
    
    _listField.placeholder = @"Placeholder";
    _listField.items = @[
        [GLBListFieldItem itemWithTitle:@"Item #1" value:@(1)],
        [GLBListFieldItem itemWithTitle:@"Item #2" value:@(2)],
        [GLBListFieldItem itemWithTitle:@"Item #3" value:@(3)],
        [GLBListFieldItem itemWithTitle:@"Item #4" value:@(4)],
        [GLBListFieldItem itemWithTitle:@"Item #5" value:@(5)],
        [GLBListFieldItem itemWithTitle:@"Item #6" value:@(6)],
    ];
    _listField.selectedItem = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_listField becomeFirstResponder];
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

- (IBAction)changedSelectedItem:(id)sender {
    NSLog(@"ChangedSelectedItem: %@", _listField.selectedItem.value);
}

@end
