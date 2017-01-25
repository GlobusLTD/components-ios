//
//  Globus
//

#import "DialogRootViewController.h"
#import "DialogContentViewController.h"

@interface DialogRootViewController ()

@property(nonatomic, weak) IBOutlet GLBListField* listField;
@property(nonatomic) DialogContentViewController* contentViewController;
@property(nonatomic) GLBDialogViewController* dialogViewController;

@end

@implementation DialogRootViewController

#pragma mark - Synthesize

@synthesize contentViewController = _contentViewController;
@synthesize dialogViewController = _dialogViewController;

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _listField.items = @[
        [GLBListFieldItem itemWithTitle:@"Default" value:nil],
        [GLBListFieldItem itemWithTitle:GLBDialogPushAnimationController.glb_className value:GLBDialogPushAnimationController.class],
    ];
}

#pragma mark - Property

- (DialogContentViewController*)contentViewController {
    if(_contentViewController == nil) {
        _contentViewController = [DialogContentViewController instantiate];
    }
    return _contentViewController;
}

- (GLBDialogViewController*)dialogViewController {
    if(_dialogViewController == nil) {
        _dialogViewController = [GLBDialogViewController dialogViewControllerWithContentViewController:self.contentViewController];
        _dialogViewController.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.8f];
        _dialogViewController.backgroundBlurred = NO;
        _dialogViewController.contentVerticalAlignment = GLBDialogViewControllerAlignmentVerticalCenter;
        _dialogViewController.contentHorizontalAlignment = GLBDialogViewControllerAlignmentHorizontalCenter;
        _dialogViewController.contentWidthBehaviour = GLBDialogViewControllerSizeBehaviourFill;
        _dialogViewController.contentHeightBehaviour = GLBDialogViewControllerSizeBehaviourFit;
        _dialogViewController.contentInset = UIEdgeInsetsMake(16.0f, 16.0f, 16.0f, 16.0f);
    }
    return _dialogViewController;
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

- (IBAction)changedSelectedItem:(id)sender {
    GLBListFieldItem* selected = _listField.selectedItem;
    if(selected != nil) {
        Class animationControllerClass = selected.value;
        if(selected != nil) {
            self.dialogViewController.animationController = [animationControllerClass new];
        } else {
            self.dialogViewController.animationController = nil;
        }
    } else {
        self.dialogViewController.animationController = nil;
    }
}

- (IBAction)pressedShow:(id)sender {
    [self.dialogViewController presentWithCompletion:nil];
}

@end
