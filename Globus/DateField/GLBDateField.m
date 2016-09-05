/*--------------------------------------------------*/

#import "GLBDateField.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDateField ()

@property(nonatomic, strong) UIDatePicker* pickerView;

- (void)setDate:(NSDate*)date animated:(BOOL)animated emitted:(BOOL)emitted;

@end

/*--------------------------------------------------*/

@implementation GLBDateField

#pragma mark - Init / Free

- (void)setup {
    [super setup];
    
    _locale = NSLocale.currentLocale;
    _calendar = NSCalendar.currentCalendar;
    _date = NSDate.date;
}

#pragma mark - Public

- (void)didBeginEditing {
    [super didBeginEditing];
    
    if(self.pickerView == nil) {
        self.pickerView = [UIDatePicker new];
        if(self.pickerView != nil) {
            self.pickerView.datePickerMode = self.datePickerMode;
            [self.pickerView addTarget:self action:@selector(changedDate) forControlEvents:UIControlEventValueChanged];
        }
        self.inputView = self.pickerView;
    }
    if(self.pickerView != nil) {
        self.pickerView.locale = self.locale;
        self.pickerView.calendar = self.calendar;
        self.pickerView.timeZone = self.timeZone;
        self.pickerView.minimumDate = self.minimumDate;
        self.pickerView.maximumDate = self.maximumDate;
        if(self.date != nil) {
            self.pickerView.date = self.date;
        }
    }
}

- (void)didEndEditing {
    [super didEndEditing];
    
    [self setDate:self.pickerView.date animated:YES emitted:YES];
}

#pragma mark - Property

- (void)setDatePickerMode:(UIDatePickerMode)datePickerMode {
    if(_datePickerMode != datePickerMode) {
        _datePickerMode = datePickerMode;
        
        if(self.pickerView != nil) {
            self.pickerView.datePickerMode = datePickerMode;
        }
    }
}

- (void)setDateFormatter:(NSDateFormatter*)dateFormatter {
    if(_dateFormatter != dateFormatter) {
        _dateFormatter = dateFormatter;
        
        if(self.date != nil) {
            if(dateFormatter != nil) {
                self.text = [dateFormatter stringFromDate:self.date];
            } else {
                self.text = self.date.description;
            }
        } else {
            self.text = @"";
        }
    }
}

- (void)setLocale:(NSLocale*)locale {
    if([_locale isEqual:locale] == NO) {
        _locale = locale;
        
        if(self.isEditing == YES) {
            if(self.date != nil) {
                self.pickerView.locale = locale;
            }
        }
    }
}

- (void)setCalendar:(NSCalendar*)calendar {
    if([_calendar isEqual:calendar] == NO) {
        _calendar = [calendar copy];
        
        if(self.isEditing == YES) {
            if(self.date != nil) {
                self.pickerView.calendar = calendar;
            }
        }
    }
}

- (void)setTimeZone:(NSTimeZone*)timeZone {
    if([_timeZone isEqual:timeZone] == NO) {
        _timeZone = timeZone;
        
        if(self.isEditing == YES) {
            if(self.date != nil) {
                self.pickerView.timeZone = timeZone;
            }
        }
    }
}

- (void)setMinimumDate:(NSDate*)minimumDate {
    if([_minimumDate isEqualToDate:minimumDate] == NO) {
        _minimumDate = minimumDate;

        if(self.isEditing == YES) {
            if(self.date != nil) {
                self.pickerView.minimumDate = minimumDate;
            }
        }
    }
}

- (void)setMaximumDate:(NSDate*)maximumDate {
    if([_maximumDate isEqualToDate:maximumDate] == NO) {
        _maximumDate = maximumDate;
        
        if(self.isEditing == YES) {
            if(self.date != nil) {
                self.pickerView.maximumDate = maximumDate;
            }
        }
    }
}

- (void)setDate:(NSDate*)date {
    [self setDate:date animated:NO];
}

- (void)setDate:(NSDate*)date animated:(BOOL)animated {
    [self setDate:date animated:animated emitted:NO];
}

#pragma mark - Private

- (void)setDate:(NSDate*)date animated:(BOOL)animated emitted:(BOOL)emitted {
    if([_date isEqualToDate:date] == NO) {
        _date = date;
        
        if(date != nil) {
            if(self.dateFormatter != nil) {
                self.text = [self.dateFormatter stringFromDate:date];
            } else {
                self.text = date.description;
            }
        } else {
            self.text = @"";
        }
        if(self.isEditing == YES) {
            if(date != nil) {
                [self.pickerView setDate:date animated:animated];
            }
        }
        if(emitted == YES) {
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

- (void)changedDate {
    [self setDate:self.pickerView.date animated:YES emitted:YES];
}

#pragma mark - GLBInputField

- (void)validate {
    if((self.form != nil) && (self.validator != nil)) {
        [self.form performValidator:self.validator value:self.date];
    }
}

- (NSArray*)messages {
    if((self.form != nil) && (self.validator != nil)) {
        return [self.validator messages:self.date];
    }
    return @[];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
