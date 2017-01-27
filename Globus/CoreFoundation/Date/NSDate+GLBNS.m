/*--------------------------------------------------*/

#import "NSDate+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSDate (GLB_NS)

+ (NSDate*)glb_dateByYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    return [self glb_dateByYear:year month:month day:day usingCalendar:NSCalendar.currentCalendar];
}

+ (NSDate*)glb_dateByYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day usingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = [NSDateComponents new];
    components.year = year;
    components.month = month;
    components.day = day;
    return [calendar dateFromComponents:components];
}

+ (NSDate*)glb_dateByHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    return [self glb_dateByHour:hour minute:minute second:second usingCalendar:NSCalendar.currentCalendar];
}

+ (NSDate*)glb_dateByHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second usingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = [NSDateComponents new];
    components.hour = hour;
    components.minute = minute;
    components.second = second;
    return [calendar dateFromComponents:components];
}

+ (NSDate*)glb_dateByYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    return [self glb_dateByYear:year month:month day:day hour:hour minute:minute second:second usingCalendar:NSCalendar.currentCalendar];
}

+ (NSDate*)glb_dateByYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second usingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = [NSDateComponents new];
    components.year = year;
    components.month = month;
    components.day = day;
    components.hour = hour;
    components.minute = minute;
    components.second = second;
    return [calendar dateFromComponents:components];
}

- (NSString*)glb_formatTime {
    NSDateFormatter* formatter = [NSDateFormatter new];
    formatter.dateFormat = NSLocalizedStringFromTable(@"h:mm a", @"GLB", @"Date format: 1:05 pm");
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:NSLocalizedStringFromTable(@"en_EN", @"GLB", @"Current locale")];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    return [formatter stringFromDate:self];
}

- (NSString*)glb_formatDate {
    NSDateFormatter* formatter = [NSDateFormatter new];
    formatter.dateFormat = NSLocalizedStringFromTable(@"EEEE, LLLL d, YYYY", @"GLB", @"Date format: Monday, July 27, 2009");
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:NSLocalizedStringFromTable(@"en_EN", @"GLB", @"Current locale")];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    return [formatter stringFromDate:self];
}

- (NSString*)glb_formatShortTime {
    NSTimeInterval diff = ABS(self.timeIntervalSinceNow);
    if(diff < GLBDateDay) {
        return [self glb_formatTime];
    } else if(diff < GLBDateDay * 5) {
        NSDateFormatter* formatter = [NSDateFormatter new];
        formatter.dateFormat = NSLocalizedStringFromTable(@"EEEE", @"GLB", @"Date format: Monday");
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:NSLocalizedStringFromTable(@"en_EN", @"GLB", @"Current locale")];
        return [formatter stringFromDate:self];
    } else {
        NSDateFormatter* formatter = [NSDateFormatter new];
        formatter.dateFormat = NSLocalizedStringFromTable(@"M/d/yy", @"GLB", @"Date format: 7/27/09");
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:NSLocalizedStringFromTable(@"en_EN", @"GLB", @"Current locale")];
        return [formatter stringFromDate:self];
    }
}

- (NSString*)glb_formatDateTime {
    NSTimeInterval diff = ABS(self.timeIntervalSinceNow);
    if(diff < GLBDateDay) {
        return [self glb_formatTime];
    } else if(diff < GLBDateDay * 5) {
        NSDateFormatter* formatter = [NSDateFormatter new];
        formatter.dateFormat = NSLocalizedStringFromTable(@"EEE h:mm a", @"GLB", @"Date format: Mon 1:05 pm");
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:NSLocalizedStringFromTable(@"en_EN", @"GLB", @"Current locale")];
        return [formatter stringFromDate:self];
    } else {
        NSDateFormatter* formatter = [NSDateFormatter new];
        formatter.dateFormat = NSLocalizedStringFromTable(@"MMM d h:mm a", @"GLB", @"Date format: Jul 27 1:05 pm");
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:NSLocalizedStringFromTable(@"en_EN", @"GLB", @"Current locale")];
        return [formatter stringFromDate:self];
    }
}

- (NSString*)glb_formatRelativeTime {
    NSTimeInterval elapsed = ABS(self.timeIntervalSinceNow);
    if(elapsed <= 1.0) {
        return NSLocalizedStringFromTable(@"just a moment ago", @"GLB", @"");
    } else if(elapsed < GLBDateMinute) {
        int seconds = (int)(elapsed);
        return [NSString stringWithFormat:NSLocalizedStringFromTable(@"%d seconds ago", @"GLB", @""), seconds];
    } else if(elapsed < GLBDateMinute * 2) {
        return NSLocalizedStringFromTable(@"about a minute ago", @"GLB", @"");
    } else if(elapsed < GLBDateHour) {
        int mins = (int)(elapsed / GLBDateMinute);
        return [NSString stringWithFormat:NSLocalizedStringFromTable(@"%d minutes ago", @"GLB", @""), mins];
    } else if(elapsed < GLBDateHour * 1.5) {
        return NSLocalizedStringFromTable(@"about an hour ago", @"GLB", @"");
    } else if(elapsed < GLBDateDay) {
        int hours = (int)((elapsed + GLBDateHour * 0.5) / GLBDateHour);
        return [NSString stringWithFormat:NSLocalizedStringFromTable(@"%d hours ago", @"GLB", @""), hours];
    } else {
        return [self glb_formatDateTime];
    }
}

- (NSString*)glb_formatShortRelativeTime {
    NSTimeInterval elapsed = ABS(self.timeIntervalSinceNow);
    if(elapsed < GLBDateMinute) {
        return NSLocalizedStringFromTable(@"<1m", @"GLB", @"Date format: less than one minute ago");
    } else if(elapsed < GLBDateHour) {
        int mins = (int)(elapsed / GLBDateMinute);
        return [NSString stringWithFormat:NSLocalizedStringFromTable(@"%dm", @"GLB", @"Date format: 50m"), mins];
    } else if(elapsed < GLBDateDay) {
        int hours = (int)((elapsed + GLBDateHour / 2) / GLBDateHour);
        return [NSString stringWithFormat:NSLocalizedStringFromTable(@"%dh", @"GLB", @"Date format: 3h"), hours];
    } else if(elapsed < (GLBDateDay * 7)) {
        int day = (int)((elapsed + GLBDateDay / 2) / GLBDateDay);
        return [NSString stringWithFormat:NSLocalizedStringFromTable(@"%dd", @"GLB", @"Date format: 3d"), day];
    } else {
        return [self glb_formatShortTime];
    }
}

+ (NSDate*)glb_dateWithUnixTimestamp:(NSUInteger)timestamp timeZone:(NSTimeZone*)timeZone {
    NSInteger offset = 0;
    if(timeZone != nil) {
        offset = timeZone.secondsFromGMT - NSTimeZone.systemTimeZone.secondsFromGMT;
    }
    if(offset < 0) {
        timestamp -= (NSUInteger)(-offset);
    } else {
        timestamp += (NSUInteger)(offset);
    }
    return [NSDate dateWithTimeIntervalSince1970:timestamp];
}

+ (NSDate*)glb_dateWithUnixTimestamp:(NSUInteger)timestamp {
    return [self glb_dateWithUnixTimestamp:timestamp timeZone:nil];
}

- (NSUInteger)glb_unixTimestampToTimeZone:(NSTimeZone*)timeZone {
    NSInteger offset = 0;
    if(timeZone != nil) {
        offset = timeZone.secondsFromGMT - NSTimeZone.systemTimeZone.secondsFromGMT;
    }
    NSUInteger timestamp = (NSUInteger)self.timeIntervalSince1970;
    if(offset < 0) {
        timestamp -= (NSUInteger)(-offset);
    } else {
        timestamp += (NSUInteger)(offset);
    }
    return timestamp;
}

- (NSUInteger)glb_unixTimestamp {
    return [self glb_unixTimestampToTimeZone:nil];
}

- (NSDate*)glb_extractCalendarUnit:(NSCalendarUnit)calendarUnit {
    return [self glb_extractCalendarUnit:calendarUnit usingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_extractCalendarUnit:(NSCalendarUnit)calendarUnit usingCalendar:(NSCalendar*)calendar {
    return [calendar dateFromComponents:[calendar components:calendarUnit fromDate:self]];
}

- (NSDate*)glb_withoutDate {
    return [self glb_extractCalendarUnit:(NSCalendarUnit)(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) usingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_withoutDateUsingCalendar:(NSCalendar*)calendar {
    return [self glb_extractCalendarUnit:(NSCalendarUnit)(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) usingCalendar:calendar];
}

- (NSDate*)glb_withoutTime {
    return [self glb_extractCalendarUnit:(NSCalendarUnit)(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) usingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_withoutTimeUsingCalendar:(NSCalendar*)calendar {
    return [self glb_extractCalendarUnit:(NSCalendarUnit)(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) usingCalendar:calendar];
}

- (NSDate*)glb_beginningOfYear {
    return [self glb_beginningOfYearUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_beginningOfYearUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = [calendar components:(NSCalendarUnit)(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.month = 1;
    components.day = 1;
    return [calendar dateFromComponents:components];
}

- (NSDate*)glb_endOfYear {
    return [self glb_endOfYearUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_endOfYearUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = NSDateComponents.new;
    components.year = 1;
    components.second = -1;
    NSDate* date = [self glb_beginningOfYearUsingCalendar:calendar];
    return [calendar dateByAddingComponents:components toDate:date options:(NSCalendarOptions)0];
}

- (NSDate*)glb_beginningOfMonth {
    return [self glb_beginningOfMonthUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_beginningOfMonthUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = [calendar components:(NSCalendarUnit)(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.day = 1;
    return [calendar dateFromComponents:components];
}

- (NSDate*)glb_endOfMonth {
    return [self glb_endOfMonthUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_endOfMonthUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = NSDateComponents.new;
    components.month = 1;
    components.second = -1;
    NSDate* date = [self glb_beginningOfMonthUsingCalendar:calendar];
    return [calendar dateByAddingComponents:components toDate:date options:(NSCalendarOptions)0];
}

- (NSDate*)glb_beginningOfWeek {
    return [self glb_beginningOfWeekUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_beginningOfWeekUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = [calendar components:(NSCalendarUnit)(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay) fromDate:self];
    NSInteger offset = components.weekday - (NSInteger)calendar.firstWeekday;
    if(offset < 0) {
        offset = offset + 7;
    }
    components.day = components.day - offset;
    return [calendar dateFromComponents:components];
}

- (NSDate*)glb_endOfWeek {
    return [self glb_endOfWeekUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_endOfWeekUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = NSDateComponents.new;
    components.weekOfMonth = 1;
    components.second = -1;
    NSDate* date = [self glb_beginningOfWeekUsingCalendar:calendar];
    return [calendar dateByAddingComponents:components toDate:date options:(NSCalendarOptions)0];
}

- (NSDate*)glb_beginningOfDay {
    return [self glb_beginningOfDayUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_beginningOfDayUsingCalendar:(NSCalendar*)calendar {
    return [calendar dateFromComponents:[calendar components:(NSCalendarUnit)(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self]];
}

- (NSDate*)glb_endOfDay {
    return [self glb_endOfDayUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_endOfDayUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = NSDateComponents.new;
    components.day = 1;
    components.second = -1;
    NSDate* date = [self glb_beginningOfDayUsingCalendar:calendar];
    return [calendar dateByAddingComponents:components toDate:date options:(NSCalendarOptions)0];
}

- (NSDate*)glb_beginningOfHour {
    return [self glb_beginningOfHourUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_beginningOfHourUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = [calendar components:(NSCalendarUnit)(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour) fromDate:self];
    return [calendar dateFromComponents:components];
}

- (NSDate*)glb_endOfHour {
    return [self glb_endOfHourUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_endOfHourUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = NSDateComponents.new;
    components.hour = 1;
    components.second = -1;
    NSDate* date = [self glb_beginningOfHourUsingCalendar:calendar];
    return [calendar dateByAddingComponents:components toDate:date options:(NSCalendarOptions)0];
}

- (NSDate*)glb_beginningOfMinute {
    return [self glb_beginningOfMinuteUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_beginningOfMinuteUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = [calendar components:(NSCalendarUnit)(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:self];
    return [calendar dateFromComponents:components];
}

- (NSDate*)glb_endOfMinute {
    return [self glb_endOfMinuteUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_endOfMinuteUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = NSDateComponents.new;
    components.minute = 1;
    components.second = -1;
    NSDate* date = [self glb_beginningOfMinuteUsingCalendar:calendar];
    return [calendar dateByAddingComponents:components toDate:date options:(NSCalendarOptions)0];
}

- (NSDate*)glb_previousYear {
    return [self glb_previousYearUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_previousYearUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = NSDateComponents.new;
    components.year = -1;
    return [calendar dateByAddingComponents:components toDate:self options:(NSCalendarOptions)0];
}

- (NSDate*)glb_nextYear {
    return [self glb_nextYearUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_nextYearUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = NSDateComponents.new;
    components.year = 1;
    return [calendar dateByAddingComponents:components toDate:self options:(NSCalendarOptions)0];
}

- (NSDate*)glb_previousMonth {
    return [self glb_previousMonthUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_previousMonthUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = NSDateComponents.new;
    components.month = -1;
    return [calendar dateByAddingComponents:components toDate:self options:(NSCalendarOptions)0];
}

- (NSDate*)glb_nextMonth {
    return [self glb_nextMonthUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_nextMonthUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = NSDateComponents.new;
    components.month = 1;
    return [calendar dateByAddingComponents:components toDate:self options:(NSCalendarOptions)0];
}

- (NSDate*)glb_previousWeek {
    return [self glb_previousWeekUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_previousWeekUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = NSDateComponents.new;
    components.day = -7;
    return [calendar dateByAddingComponents:components toDate:self options:(NSCalendarOptions)0];
}

- (NSDate*)glb_nextWeek {
    return [self glb_nextWeekUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_nextWeekUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = NSDateComponents.new;
    components.day = 7;
    return [calendar dateByAddingComponents:components toDate:self options:(NSCalendarOptions)0];
}

- (NSDate*)glb_previousDay {
    return [self glb_previousDayUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_previousDayUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = NSDateComponents.new;
    components.day = -1;
    return [calendar dateByAddingComponents:components toDate:self options:(NSCalendarOptions)0];
}

- (NSDate*)glb_nextDay {
    return [self glb_nextDayUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_nextDayUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = NSDateComponents.new;
    components.day = 1;
    return [calendar dateByAddingComponents:components toDate:self options:(NSCalendarOptions)0];
}

- (NSDate*)glb_previousHour {
    return [self glb_previousHourUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_previousHourUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = NSDateComponents.new;
    components.hour = -1;
    return [calendar dateByAddingComponents:components toDate:self options:(NSCalendarOptions)0];
}

- (NSDate*)glb_nextHour {
    return [self glb_nextHourUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_nextHourUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = NSDateComponents.new;
    components.hour = 1;
    return [calendar dateByAddingComponents:components toDate:self options:(NSCalendarOptions)0];
}

- (NSDate*)glb_previousMinute {
    return [self glb_previousMinuteUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_previousMinuteUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = NSDateComponents.new;
    components.minute = -1;
    return [calendar dateByAddingComponents:components toDate:self options:(NSCalendarOptions)0];
}

- (NSDate*)glb_nextMinute {
    return [self glb_nextMinuteUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_nextMinuteUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = NSDateComponents.new;
    components.minute = 1;
    return [calendar dateByAddingComponents:components toDate:self options:(NSCalendarOptions)0];
}

- (NSDate*)glb_previousSecond {
    return [self glb_previousSecondUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_previousSecondUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = NSDateComponents.new;
    components.second = -1;
    return [calendar dateByAddingComponents:components toDate:self options:(NSCalendarOptions)0];
}

- (NSDate*)glb_nextSecond {
    return [self glb_nextSecondUsingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_nextSecondUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = NSDateComponents.new;
    components.second = 1;
    return [calendar dateByAddingComponents:components toDate:self options:(NSCalendarOptions)0];
}

- (NSInteger)glb_yearsToDate:(NSDate*)date {
    return [self glb_yearsToDate:date usingCalendar:NSCalendar.currentCalendar];
}

- (NSInteger)glb_yearsToDate:(NSDate*)date usingCalendar:(NSCalendar*)calendar {
    return [[calendar components:NSCalendarUnitYear fromDate:self toDate:date options:(NSCalendarOptions)0] year];
}

- (NSInteger)glb_monthsToDate:(NSDate*)date {
    return [self glb_monthsToDate:date usingCalendar:NSCalendar.currentCalendar];
}

- (NSInteger)glb_monthsToDate:(NSDate*)date usingCalendar:(NSCalendar*)calendar {
    return [[calendar components:NSCalendarUnitMonth fromDate:self toDate:date options:(NSCalendarOptions)0] month];
}

- (NSInteger)glb_daysToDate:(NSDate*)date {
    return [self glb_daysToDate:date usingCalendar:NSCalendar.currentCalendar];
}

- (NSInteger)glb_daysToDate:(NSDate*)date usingCalendar:(NSCalendar*)calendar {
    return [[calendar components:NSCalendarUnitDay fromDate:self toDate:date options:(NSCalendarOptions)0] day];
}

- (NSInteger)glb_weeksToDate:(NSDate*)date {
    return [self glb_weeksToDate:date usingCalendar:NSCalendar.currentCalendar];
}

- (NSInteger)glb_weeksToDate:(NSDate*)date usingCalendar:(NSCalendar*)calendar {
    return [[calendar components:NSCalendarUnitWeekOfYear fromDate:self toDate:date options:(NSCalendarOptions)0] weekOfYear];
}

- (NSInteger)glb_hoursToDate:(NSDate*)date {
    return [self glb_hoursToDate:date usingCalendar:NSCalendar.currentCalendar];
}

- (NSInteger)glb_hoursToDate:(NSDate*)date usingCalendar:(NSCalendar*)calendar {
    return [[calendar components:NSCalendarUnitHour fromDate:self toDate:date options:(NSCalendarOptions)0] hour];
}

- (NSInteger)glb_minutesToDate:(NSDate*)date {
    return [self glb_minutesToDate:date usingCalendar:NSCalendar.currentCalendar];
}

- (NSInteger)glb_minutesToDate:(NSDate*)date usingCalendar:(NSCalendar*)calendar {
    return [[calendar components:NSCalendarUnitMinute fromDate:self toDate:date options:(NSCalendarOptions)0] minute];
}

- (NSInteger)glb_secondsToDate:(NSDate*)date {
    return [self glb_secondsToDate:date usingCalendar:NSCalendar.currentCalendar];
}

- (NSInteger)glb_secondsToDate:(NSDate*)date usingCalendar:(NSCalendar*)calendar {
    return [[calendar components:NSCalendarUnitSecond fromDate:self toDate:date options:(NSCalendarOptions)0] second];
}

- (NSDate*)glb_addYears:(NSInteger)years {
    return [self glb_addYears:years usingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_addYears:(NSInteger)years usingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = [NSDateComponents new];
    components.year = years;
    return [calendar dateByAddingComponents:components toDate:self options:(NSCalendarOptions)0];
}

- (NSDate*)glb_addMonths:(NSInteger)months {
    return [self glb_addMonths:months usingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_addMonths:(NSInteger)months usingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = [NSDateComponents new];
    components.month = months;
    return [calendar dateByAddingComponents:components toDate:self options:(NSCalendarOptions)0];
}

- (NSDate*)glb_addWeeks:(NSInteger)weeks {
    return [self glb_addWeeks:weeks usingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_addWeeks:(NSInteger)weeks usingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = [NSDateComponents new];
    components.day = 7 * weeks;
    return [calendar dateByAddingComponents:components toDate:self options:(NSCalendarOptions)0];
}

- (NSDate*)glb_addDays:(NSInteger)days {
    return [self glb_addDays:days usingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_addDays:(NSInteger)days usingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = [NSDateComponents new];
    components.day = days;
    return [calendar dateByAddingComponents:components toDate:self options:(NSCalendarOptions)0];
}

- (NSDate*)glb_addHours:(NSInteger)hours {
    return [self glb_addHours:hours usingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_addHours:(NSInteger)hours usingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = [NSDateComponents new];
    components.hour = hours;
    return [calendar dateByAddingComponents:components toDate:self options:(NSCalendarOptions)0];
}

- (NSDate*)glb_addMinutes:(NSInteger)minutes {
    return [self glb_addMinutes:minutes usingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_addMinutes:(NSInteger)minutes usingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = [NSDateComponents new];
    components.minute = minutes;
    return [calendar dateByAddingComponents:components toDate:self options:(NSCalendarOptions)0];
}

- (NSDate*)glb_addSeconds:(NSInteger)seconds {
    return [self glb_addSeconds:seconds usingCalendar:NSCalendar.currentCalendar];
}

- (NSDate*)glb_addSeconds:(NSInteger)seconds usingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = [NSDateComponents new];
    components.second = seconds;
    return [calendar dateByAddingComponents:components toDate:self options:(NSCalendarOptions)0];
}

- (BOOL)glb_isYesterday {
    return [self glb_isYesterdayUsingCalendar:NSCalendar.currentCalendar];
}

- (BOOL)glb_isYesterdayUsingCalendar:(NSCalendar*)calendar {
    NSDate* date = [NSDate.date glb_previousDayUsingCalendar:calendar];
    NSDate* beginningOfDay = [date glb_beginningOfDayUsingCalendar:calendar];
    NSDate* endOfDay = [date glb_endOfDayUsingCalendar:calendar];
    return [self glb_insideFrom:beginningOfDay to:endOfDay];
}

- (BOOL)glb_isToday {
    return [self glb_isTodayUsingCalendar:NSCalendar.currentCalendar];
}

- (BOOL)glb_isTodayUsingCalendar:(NSCalendar*)calendar {
    NSDate* date = NSDate.date;
    NSDate* beginningOfDay = [date glb_beginningOfDayUsingCalendar:calendar];
    NSDate* endOfDay = [date glb_endOfDayUsingCalendar:calendar];
    return [self glb_insideFrom:beginningOfDay to:endOfDay];
}

- (BOOL)glb_isTomorrow {
    return [self glb_isTomorrowUsingCalendar:NSCalendar.currentCalendar];
}

- (BOOL)glb_isTomorrowUsingCalendar:(NSCalendar*)calendar {
    NSDate* date = [NSDate.date glb_nextDayUsingCalendar:calendar];
    NSDate* beginningOfDay = [date glb_beginningOfDayUsingCalendar:calendar];
    NSDate* endOfDay = [date glb_endOfDayUsingCalendar:calendar];
    return [self glb_insideFrom:beginningOfDay to:endOfDay];
}

- (BOOL)glb_insideFrom:(NSDate*)from to:(NSDate*)to {
    return ([self glb_isAfterOrSame:from]) && ([self glb_isEarlierOrSame:to]);
}

- (BOOL)glb_isEarlier:(NSDate*)anotherDate {
    return ([self compare:anotherDate] == NSOrderedAscending);
}

- (BOOL)glb_isEarlierOrSame:(NSDate*)anotherDate {
    return ([self compare:anotherDate] != NSOrderedDescending);
}

- (BOOL)glb_isSame:(NSDate*)anotherDate {
    return ([self compare:anotherDate] == NSOrderedSame);
}

- (BOOL)glb_isAfter:(NSDate*)anotherDate {
    return ([self compare:anotherDate] == NSOrderedDescending);
}

- (BOOL)glb_isAfterOrSame:(NSDate*)anotherDate {
    return([self compare:anotherDate] != NSOrderedAscending);
}

- (GLBDateSeason)glb_season {
    return [self glb_seasonUsingCalendar:NSCalendar.currentCalendar];
}

- (GLBDateSeason)glb_seasonUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = [calendar components:NSCalendarUnitMonth fromDate:self];
    NSInteger month = components.month;
    if((month >= 3) && (month <= 5)) {
        return GLBDateSeasonSpring;
    } else if((month >= 6) && (month <= 8)) {
        return GLBDateSeasonSummer;
    } else if((month >= 9) && (month <= 11)) {
        return GLBDateSeasonAutumn;
    }
    return GLBDateSeasonWinter;
}

- (GLBDateWeekday)glb_weekday {
    return [self glb_weekdayUsingCalendar:NSCalendar.currentCalendar];
}

- (GLBDateWeekday)glb_weekdayUsingCalendar:(NSCalendar*)calendar {
    NSDateComponents* components = [calendar components:NSCalendarUnitWeekday fromDate:self];
    return (GLBDateWeekday)components.weekday;
}

@end

/*--------------------------------------------------*/

const NSTimeInterval GLBDateMinute = 60.0;
const NSTimeInterval GLBDateHour = 60.0 * GLBDateMinute;
const NSTimeInterval GLBDateDay = 24.0 * GLBDateHour;

/*--------------------------------------------------*/
