//
//  Globus
//

#import "CalendarDataViewController.h"
#import "CalendarMonthDataViewCell.h"
#import "CalendarWeekdayDataViewCell.h"
#import "CalendarDayDataViewCell.h"

@interface CalendarDataViewController () {
    GLBDataViewCalendarContainer* _dataViewContainer;
}

@end

@implementation CalendarDataViewController

#pragma mark - Init / Free

- (void)setup {
    [super setup];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"CalendarDataView";
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem glb_removeAllLeftBarButtonItemsAnimated:NO];
    [self.navigationItem glb_addLeftBarButtonNormalImage:[UIImage imageNamed:@"MenuButton"] target:self action:@selector(pressedMenu:) animated:NO];
}

#pragma mark - GLBViewController

- (void)update {
    [super update];
    
    [self.dataView batchUpdate:^{
        NSDate* now = NSDate.date;
        [_dataViewContainer prepareBeginDate:now.glb_beginningOfMonth endDate:now.glb_endOfMonth];
    }];
}

- (void)clear {
    [self.dataView batchUpdate:^{
        [_dataViewContainer cleanup];
    }];
    
    [super clear];
}

#pragma mark - GLBDataViewController

- (void)configureDataView {
    _dataViewContainer = [GLBDataViewCalendarContainer containerWithCalendar:NSCalendar.currentCalendar];
    
    [self.dataView registerIdentifier:GLBDataViewCalendarMonthIdentifier withViewClass:CalendarMonthDataViewCell.class];
    [self.dataView registerIdentifier:GLBDataViewCalendarWeekdayIdentifier withViewClass:CalendarWeekdayDataViewCell.class];
    [self.dataView registerIdentifier:GLBDataViewCalendarDayIdentifier withViewClass:CalendarDayDataViewCell.class];
    
    self.dataView.container = _dataViewContainer;
}

- (void)cleanupDataView {
    [super cleanupDataView];
    
    _dataViewContainer = nil;
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

@end
