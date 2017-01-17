//
//  Globus
//

#import "SpinnerViewController.h"

@interface SpinnerViewController ()

@property(nonatomic, weak) IBOutlet GLBListField* listField;
@property(nonatomic, weak) IBOutlet UIView* wrapSpinnerView;
@property(nonatomic, strong) GLBSpinnerView* spinnerView;

@end

@implementation SpinnerViewController

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
    
    _listField.placeholder = @"Please select spinner style";
    _listField.items = @[
        [GLBListFieldItem itemWithTitle:@"None" value:nil],
        [GLBListFieldItem itemWithTitle:GLBArcSpinnerView.glb_className value:GLBArcSpinnerView.class],
        [GLBListFieldItem itemWithTitle:GLBArcAltSpinnerView.glb_className value:GLBArcAltSpinnerView.class],
        [GLBListFieldItem itemWithTitle:GLBBounceSpinnerView.glb_className value:GLBBounceSpinnerView.class],
        [GLBListFieldItem itemWithTitle:GLBChasingDotsSpinnerView.glb_className value:GLBChasingDotsSpinnerView.class],
        [GLBListFieldItem itemWithTitle:GLBCircleSpinnerView.glb_className value:GLBCircleSpinnerView.class],
        [GLBListFieldItem itemWithTitle:GLBCircleFlipSpinnerView.glb_className value:GLBCircleFlipSpinnerView.class],
        [GLBListFieldItem itemWithTitle:GLBFadingCircleSpinnerView.glb_className value:GLBFadingCircleSpinnerView.class],
        [GLBListFieldItem itemWithTitle:GLBFadingCircleAltSpinnerView.glb_className value:GLBFadingCircleAltSpinnerView.class],
        [GLBListFieldItem itemWithTitle:GLBNineCubeGridSpinnerView.glb_className value:GLBNineCubeGridSpinnerView.class],
        [GLBListFieldItem itemWithTitle:GLBPlaneSpinnerView.glb_className value:GLBPlaneSpinnerView.class],
        [GLBListFieldItem itemWithTitle:GLBPulseSpinnerView.glb_className value:GLBPulseSpinnerView.class],
        [GLBListFieldItem itemWithTitle:GLBThreeBounceSpinnerView.glb_className value:GLBThreeBounceSpinnerView.class],
        [GLBListFieldItem itemWithTitle:GLBWanderingCubesSpinnerView.glb_className value:GLBWanderingCubesSpinnerView.class],
        [GLBListFieldItem itemWithTitle:GLBWaveSpinnerView.glb_className value:GLBWaveSpinnerView.class],
        [GLBListFieldItem itemWithTitle:GLBWordPressSpinnerView.glb_className value:GLBWordPressSpinnerView.class],
    ];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_listField becomeFirstResponder];
}

#pragma mark - Property

- (void)setSpinnerView:(GLBSpinnerView*)spinnerView {
    if(_spinnerView != spinnerView) {
        if(_spinnerView != nil) {
            [_spinnerView stopAnimating];
            [_spinnerView removeFromSuperview];
        }
        _spinnerView = spinnerView;
        if(_spinnerView != nil) {
            _spinnerView.translatesAutoresizingMaskIntoConstraints = NO;
            [_spinnerView startAnimating];
            [_wrapSpinnerView addSubview:_spinnerView];
            [_spinnerView glb_addConstraintCenter];
        }
    }
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

- (IBAction)changedSelectedItem:(id)sender {
    GLBListFieldItem* selected = _listField.selectedItem;
    if(selected != nil) {
        Class spinnerViewClass = selected.value;
        if(selected != nil) {
            self.spinnerView = [spinnerViewClass new];
        } else {
            self.spinnerView = nil;
        }
    } else {
        self.spinnerView = nil;
    }
}

@end
