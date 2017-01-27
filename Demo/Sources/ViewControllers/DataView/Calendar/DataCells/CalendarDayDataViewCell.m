//
//  Globus
//

#import "CalendarDayDataViewCell.h"

@interface CalendarDayDataViewCell ()

@property(nonatomic, weak) IBOutlet UILabel* displayLabel;

@end

@implementation CalendarDayDataViewCell

- (void)setup {
    [super setup];
    
    _displayLabel.textColor = UIColor.darkGrayColor;
}

- (void)willShow {
    GLBDataViewCalendarWeekdayItem* item = self.item;
    NSDateFormatter* dateFormatter = [NSDateFormatter glb_dateFormatterWithFormat:@"dd"];
    _displayLabel.text = [dateFormatter stringFromDate:item.date];
}

@end
