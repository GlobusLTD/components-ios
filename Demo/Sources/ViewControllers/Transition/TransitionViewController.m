//
//  Globus
//

#import "TransitionViewController.h"

@interface TransitionViewController ()

@property(nonatomic, weak) IBOutlet GLBListField* listField;

@end

@implementation TransitionViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _listField.items = @[
        [GLBListFieldItem itemWithTitle:@"Default" value:nil],
        [GLBListFieldItem itemWithTitle:GLBCrossFadeTransitionController.glb_className value:GLBCrossFadeTransitionController.class],
        [GLBListFieldItem itemWithTitle:GLBMaterialTransitionController.glb_className value:GLBMaterialTransitionController.class],
        [GLBListFieldItem itemWithTitle:GLBSlideTransitionController.glb_className value:GLBSlideTransitionController.class],
        [GLBListFieldItem itemWithTitle:GLBCardsTransitionController.glb_className value:GLBCardsTransitionController.class],
    ];
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

- (IBAction)changedSelectedItem:(id)sender {
    GLBListFieldItem* selected = _listField.selectedItem;
    if(selected != nil) {
        Class transitionControllerClass = selected.value;
        if(selected != nil) {
            _transition = [transitionControllerClass new];
            if([_transition isKindOfClass:GLBMaterialTransitionController.class] == YES) {
                GLBMaterialTransitionController* materialTransition = _transition;
                materialTransition.backgroundColor = UIColor.redColor;
            }
        } else {
            _transition = nil;
        }
    } else {
        _transition = nil;
    }
}

@end
