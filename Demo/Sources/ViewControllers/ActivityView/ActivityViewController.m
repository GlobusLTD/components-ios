//
//  Globus
//

#import "ActivityViewController.h"

@interface ActivityViewController ()

@property(nonatomic, weak) IBOutlet GLBListField* listField;
@property(nonatomic, weak) IBOutlet GLBButton* showButton;

@property(nonatomic, strong) GLBTimer* timer;

@end

@implementation ActivityViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _timer = [GLBTimer timerWithInterval:5.0f];
    _timer.actionFinished = [GLBAction actionWithTarget:self action:@selector(timerFinished)];
    
    _listField.items = @[
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
    
    self.activityView = [GLBActivityView new];
    self.activityView.spinnerView = GLBArcSpinnerView.new;
    self.activityView.textLabel.text = @"This is activity message";
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

- (IBAction)pressedShow:(id)sender {
    [_listField resignFirstResponder];
    [self.activityView show];
    [_timer start];
}

- (IBAction)changedSelectedItem:(id)sender {
    GLBListFieldItem* selected = _listField.selectedItem;
    if(selected != nil) {
        Class spinnerViewClass = selected.value;
        if(selected != nil) {
            self.activityView.spinnerView = spinnerViewClass.new;
        } else {
            self.activityView.spinnerView = nil;
        }
    } else {
        self.activityView.spinnerView = nil;
    }
}

#pragma mark - Timer

- (void)timerFinished {
    [self.activityView hideComplete:^{
        [_listField becomeFirstResponder];
    }];
}

@end
