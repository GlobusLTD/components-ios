//
//  Globus
//

#import "CalendarMonthDataViewCell.h"

@interface CalendarMonthDataViewCell ()

@property(nonatomic, weak) IBOutlet UILabel* displayLabel;

@end

@implementation CalendarMonthDataViewCell

- (void)setup {
    [super setup];
    
    _displayLabel.textColor = UIColor.darkGrayColor;
}

- (void)willShow {
    GLBDataViewCalendarMonthItem* item = self.item;
    NSDateFormatter* dateFormatter = [NSDateFormatter glb_dateFormatterWithFormat:@"MMMM"];
    _displayLabel.text = [dateFormatter stringFromDate:item.beginDate];
}

@end
