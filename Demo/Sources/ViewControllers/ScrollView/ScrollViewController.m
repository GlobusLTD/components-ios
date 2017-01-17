//
//  Globus
//

#import "ScrollViewController.h"

@interface ScrollViewController ()

@property(nonatomic, weak) IBOutlet GLBListField* listField;
@property(nonatomic, weak) IBOutlet GLBScrollView* scrollView;

@end

@implementation ScrollViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _listField.items = @[
        [GLBListFieldItem itemWithTitle:@"Stretch" value:@(GLBScrollViewDirectionStretch)],
        [GLBListFieldItem itemWithTitle:@"Horizontal" value:@(GLBScrollViewDirectionHorizontal)],
        [GLBListFieldItem itemWithTitle:@"Vertical" value:@(GLBScrollViewDirectionVertical)]
    ];
    _scrollView.direction = GLBScrollViewDirectionStretch;
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

- (IBAction)changedSelectedItem:(id)sender {
    _scrollView.direction = [_listField.selectedItem.value integerValue];
}

@end
