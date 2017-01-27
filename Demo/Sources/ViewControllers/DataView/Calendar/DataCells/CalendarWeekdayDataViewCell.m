//
//  Globus
//

#import "CalendarWeekdayDataViewCell.h"

@interface CalendarWeekdayDataViewCell ()

@property(nonatomic, weak) IBOutlet UILabel* displayLabel;

@end

@implementation CalendarWeekdayDataViewCell

- (void)setup {
    [super setup];
    
    _displayLabel.textColor = UIColor.darkGrayColor;
}

- (void)willShow {
    GLBDataViewCalendarWeekdayItem* item = self.item;
    NSDateFormatter* dateFormatter = [NSDateFormatter glb_dateFormatterWithFormat:@"EE"];
    _displayLabel.text = [dateFormatter stringFromDate:item.date];
}

@end
