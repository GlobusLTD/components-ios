/*--------------------------------------------------*/

#import "NSDate+GLBNS.h"
#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSDate (GLB_NS)

+ (NSDate*)glb_dateByYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSDateComponents* components = [NSDateComponents new];
    components.year = year;
    components.month = month;
    components.day = day;
    return [NSCalendar.currentCalendar dateFromComponents:components];
}

+ (NSDate*)glb_dateByHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)seccond {
    NSDateComponents* components = [NSDateComponents new];
    components.hour = hour;
    components.minute = minute;
    components.second = seccond;
    return [NSCalendar.currentCalendar dateFromComponents:components];
}

+ (NSDate*)glb_dateByYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)seccond {
    NSDateComponents* components = [NSDateComponents new];
    components.year = year;
    components.month = month;
    components.day = day;
    components.hour = hour;
    components.minute = minute;
    components.second = seccond;
    return [NSCalendar.currentCalendar dateFromComponents:components];
}

- (NSString*)glb_formatTime {
    static NSDateFormatter* formatter = nil;
    if(formatter == nil) {
        formatter = [NSDateFormatter new];
        formatter.dateFormat = NSLocalizedStringFromTable(@"h:mm a", @"GLB", @"Date format: 1:05 pm");
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:NSLocalizedStringFromTable(@"en_EN", @"GLB", @"Current locale")];
        formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    }
    return [formatter stringFromDate:self];
}

- (NSString*)glb_formatDate {
    static NSDateFormatter* formatter = nil;
    if(formatter == nil) {
        formatter = [NSDateFormatter new];
        formatter.dateFormat = NSLocalizedStringFromTable(@"EEEE, LLLL d, YYYY", @"GLB", @"Date format: Monday, July 27, 2009");
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:NSLocalizedStringFromTable(@"en_EN", @"GLB", @"Current locale")];
        formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    }
    return [formatter stringFromDate:self];
}

- (NSString*)glb_formatShortTime {
    NSTimeInterval diff = ABS(self.timeIntervalSinceNow);
    if(diff < GLBDateDay) {
        return [self glb_formatTime];
    } else if(diff < GLBDateDay * 5) {
        static NSDateFormatter* formatter = nil;
        if(formatter == nil) {
            formatter = [NSDateFormatter new];
            formatter.dateFormat = NSLocalizedStringFromTable(@"EEEE", @"GLB", @"Date format: Monday");
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:NSLocalizedStringFromTable(@"en_EN", @"GLB", @"Current locale")];
            formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        }
        return [formatter stringFromDate:self];
    } else {
        static NSDateFormatter* formatter = nil;
        if(formatter == nil) {
            formatter = [NSDateFormatter new];
            formatter.dateFormat = NSLocalizedStringFromTable(@"M/d/yy", @"GLB", @"Date format: 7/27/09");
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:NSLocalizedStringFromTable(@"en_EN", @"GLB", @"Current locale")];
            formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        }
        return [formatter stringFromDate:self];
    }
}

- (NSString*)glb_formatDateTime {
    NSTimeInterval diff = ABS(self.timeIntervalSinceNow);
    if(diff < GLBDateDay) {
        return [self glb_formatTime];
    } else if(diff < GLBDateDay * 5) {
        static NSDateFormatter* formatter = nil;
        if(formatter == nil) {
            formatter = [NSDateFormatter new];
            formatter.dateFormat = NSLocalizedStringFromTable(@"EEE h:mm a", @"GLB", @"Date format: Mon 1:05 pm");
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:NSLocalizedStringFromTable(@"en_EN", @"GLB", @"Current locale")];
            formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        }
        return [formatter stringFromDate:self];
    } else {
        static NSDateFormatter* formatter = nil;
        if(formatter == nil) {
            formatter = [NSDateFormatter new];
            formatter.dateFormat = NSLocalizedStringFromTable(@"MMM d h:mm a", @"GLB", @"Date format: Jul 27 1:05 pm");
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:NSLocalizedStringFromTable(@"en_EN", @"GLB", @"Current locale")];
            formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        }
        return [formatter stringFromDate:self];
    }
}

- (NSString*)glb_formatRelativeTime {
    NSTimeInterval elapsed = ABS(self.timeIntervalSinceNow);
    if(elapsed <= 1.0f) {
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
    return [NSDate dateWithTimeIntervalSince1970:timestamp + offset];
}

+ (NSDate*)glb_dateWithUnixTimestamp:(NSUInteger)timestamp {
    return [self glb_dateWithUnixTimestamp:timestamp timeZone:nil];
}

- (NSUInteger)glb_unixTimestampToTimeZone:(NSTimeZone*)timeZone {
    NSInteger offset = 0;
    if(timeZone != nil) {
        offset = timeZone.secondsFromGMT - NSTimeZone.systemTimeZone.secondsFromGMT;
    }
    return (NSUInteger)self.timeIntervalSince1970 + offset;
}

- (NSUInteger)glb_unixTimestamp {
    return [self glb_unixTimestampToTimeZone:nil];
}

- (NSDate*)glb_extractCalendarUnit:(NSCalendarUnit)calendarUnit {
    return [NSCalendar.currentCalendar dateFromComponents:[NSCalendar.currentCalendar components:calendarUnit fromDate:self]];
}

- (NSDate*)glb_withoutDate {
    return [self glb_extractCalendarUnit:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond)];
}

- (NSDate*)glb_withoutTime {
    return [self glb_extractCalendarUnit:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)];
}

- (NSDate*)glb_beginningOfYear {
    NSDateComponents* components = [NSCalendar.currentCalendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.month = 1;
    components.day = 1;
    return [NSCalendar.currentCalendar dateFromComponents:components];
}

- (NSDate*)glb_endOfYear {
    static NSDateComponents* components = nil;
    if(components == nil) {
        components = NSDateComponents.new;
        components.year = 1;
    }
    return [[NSCalendar.currentCalendar dateByAddingComponents:components toDate:self.glb_beginningOfYear options:0] dateByAddingTimeInterval:-1];
}

- (NSDate*)glb_beginningOfMonth {
    NSDateComponents* components = [NSCalendar.currentCalendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.day = 1;
    return [NSCalendar.currentCalendar dateFromComponents:components];
}

- (NSDate*)glb_endOfMonth {
    static NSDateComponents* components = nil;
    if(components == nil) {
        components = NSDateComponents.new;
        components.month = 1;
    }
    return [[NSCalendar.currentCalendar dateByAddingComponents:components toDate:self.glb_beginningOfMonth options:0] dateByAddingTimeInterval:-1];
}

- (NSDate*)glb_beginningOfWeek {
    NSDateComponents* components = [NSCalendar.currentCalendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay) fromDate:self];
    NSInteger offset = components.weekday - (NSInteger)NSCalendar.currentCalendar.firstWeekday;
    if(offset < 0) {
        offset = offset + 7;
    }
    components.day = components.day - offset;
    return [NSCalendar.currentCalendar dateFromComponents:components];
}

- (NSDate*)glb_endOfWeek {
    static NSDateComponents* components = nil;
    if(components == nil) {
        components = NSDateComponents.new;
        components.weekOfMonth = 1;
    }
    return [[NSCalendar.currentCalendar dateByAddingComponents:components toDate:self.glb_beginningOfWeek options:0] dateByAddingTimeInterval:-1];
}

- (NSDate*)glb_beginningOfDay {
    return [NSCalendar.currentCalendar dateFromComponents:[NSCalendar.currentCalendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self]];
}

- (NSDate*)glb_endOfDay {
    static NSDateComponents* components = nil;
    if(components == nil) {
        components = NSDateComponents.new;
        components.day = 1;
    }
    return [[NSCalendar.currentCalendar dateByAddingComponents:components toDate:self.glb_beginningOfDay options:0] dateByAddingTimeInterval:-1];
}

- (NSDate*)glb_beginningOfHour {
    return [NSCalendar.currentCalendar dateFromComponents:[NSCalendar.currentCalendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour) fromDate:self]];
}

- (NSDate*)glb_endOfHour {
    static NSDateComponents* components = nil;
    if(components == nil) {
        components = NSDateComponents.new;
        components.hour = 1;
    }
    return [[NSCalendar.currentCalendar dateByAddingComponents:components toDate:self.glb_beginningOfHour options:0] dateByAddingTimeInterval:-1];
}

- (NSDate*)glb_beginningOfMinute {
    return [NSCalendar.currentCalendar dateFromComponents:[NSCalendar.currentCalendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:self]];
}

- (NSDate*)glb_endOfMinute {
    static NSDateComponents* components = nil;
    if(components == nil) {
        components = NSDateComponents.new;
        components.minute = 1;
    }
    return [[NSCalendar.currentCalendar dateByAddingComponents:components toDate:self.glb_beginningOfMinute options:0] dateByAddingTimeInterval:-1];
}

- (NSDate*)glb_previousYear {
    static NSDateComponents* components = nil;
    if(components == nil) {
        components = [NSDateComponents new];
        components.year = -1;
    }
    return [NSCalendar.currentCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate*)glb_nextYear {
    static NSDateComponents* components = nil;
    if(components == nil) {
        components = [NSDateComponents new];
        components.year = 1;
    }
    return [NSCalendar.currentCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate*)glb_previousMonth {
    static NSDateComponents* components = nil;
    if(components == nil) {
        components = [NSDateComponents new];
        components.month = -1;
    }
    return [NSCalendar.currentCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate*)glb_nextMonth {
    static NSDateComponents* components = nil;
    if(components == nil) {
        components = [NSDateComponents new];
        components.month = 1;
    }
    return [NSCalendar.currentCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate*)glb_previousWeek {
    static NSDateComponents* components = nil;
    if(components == nil) {
        components = [NSDateComponents new];
        components.day = -7;
    }
    return [NSCalendar.currentCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate*)glb_nextWeek {
    static NSDateComponents* components = nil;
    if(components == nil) {
        components = [NSDateComponents new];
        components.day = 7;
    }
    return [NSCalendar.currentCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate*)glb_previousDay {
    static NSDateComponents* components = nil;
    if(components == nil) {
        components = [NSDateComponents new];
        components.day = -1;
    }
    return [NSCalendar.currentCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate*)glb_nextDay {
    static NSDateComponents* components = nil;
    if(components == nil) {
        components = [NSDateComponents new];
        components.day = 1;
    }
    return [NSCalendar.currentCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate*)glb_previousHour {
    static NSDateComponents* components = nil;
    if(components == nil) {
        components = [NSDateComponents new];
        components.hour = -1;
    }
    return [NSCalendar.currentCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate*)glb_nextHour {
    static NSDateComponents* components = nil;
    if(components == nil) {
        components = [NSDateComponents new];
        components.hour = 1;
    }
    return [NSCalendar.currentCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate*)glb_previousMinute {
    static NSDateComponents* components = nil;
    if(components == nil) {
        components = [NSDateComponents new];
        components.minute = -1;
    }
    return [NSCalendar.currentCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate*)glb_nextMinute {
    static NSDateComponents* components = nil;
    if(components == nil) {
        components = [NSDateComponents new];
        components.minute = 1;
    }
    return [NSCalendar.currentCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate*)glb_previousSecond {
    static NSDateComponents* components = nil;
    if(components == nil) {
        components = [NSDateComponents new];
        components.second = -1;
    }
    return [NSCalendar.currentCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate*)glb_nextSecond {
    static NSDateComponents* components = nil;
    if(components == nil) {
        components = [NSDateComponents new];
        components.second = 1;
    }
    return [NSCalendar.currentCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSInteger)glb_yearsToDate:(NSDate*)date {
    return [[NSCalendar.currentCalendar components:NSCalendarUnitYear fromDate:self toDate:date options:0] year];
}

- (NSInteger)glb_monthsToDate:(NSDate*)date {
    return [[NSCalendar.currentCalendar components:NSCalendarUnitMonth fromDate:self toDate:date options:0] month];
}

- (NSInteger)glb_daysToDate:(NSDate*)date {
    return [[NSCalendar.currentCalendar components:NSCalendarUnitDay fromDate:self toDate:date options:0] day];
}

- (NSInteger)glb_weeksToDate:(NSDate*)date {
    return [[NSCalendar.currentCalendar components:NSCalendarUnitWeekOfYear fromDate:self toDate:date options:0] weekOfYear];
}

- (NSInteger)glb_hoursToDate:(NSDate*)date {
    return [[NSCalendar.currentCalendar components:NSCalendarUnitHour fromDate:self toDate:date options:0] hour];
}

- (NSInteger)glb_minutesToDate:(NSDate*)date {
    return [[NSCalendar.currentCalendar components:NSCalendarUnitMinute fromDate:self toDate:date options:0] minute];
}

- (NSInteger)glb_secondsToDate:(NSDate*)date {
    return [[NSCalendar.currentCalendar components:NSCalendarUnitSecond fromDate:self toDate:date options:0] second];
}

- (NSDate*)glb_addYears:(NSInteger)years {
    static NSDateComponents* components = nil;
    if(components == nil) {
        components = [NSDateComponents new];
    }
    components.year = years;
    return [NSCalendar.currentCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate*)glb_addMonths:(NSInteger)months {
    static NSDateComponents* components = nil;
    if(components == nil) {
        components = [NSDateComponents new];
    }
    components.month = months;
    return [NSCalendar.currentCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate*)glb_addWeeks:(NSInteger)weeks {
    return [self dateByAddingTimeInterval:(GLBDateDay * 7) * weeks];
}

- (NSDate*)glb_addDays:(NSInteger)days {
    return [self dateByAddingTimeInterval:GLBDateDay * days];
}

- (NSDate*)glb_addHours:(NSInteger)hours {
    return [self dateByAddingTimeInterval:GLBDateHour * hours];
}

- (NSDate*)glb_addMinutes:(NSInteger)minutes {
    return [self dateByAddingTimeInterval:GLBDateMinute * minutes];
}

- (NSDate*)glb_addSeconds:(NSInteger)seconds {
    return [self dateByAddingTimeInterval:seconds];
}

- (BOOL)glb_isYesterday {
    NSDate* date = NSDate.date.glb_previousDay;
    return [self glb_insideFrom:date.glb_beginningOfDay to:date.glb_endOfDay];
}

- (BOOL)glb_isToday {
    NSDate* date = NSDate.date;
    return [self glb_insideFrom:date.glb_beginningOfDay to:date.glb_endOfDay];
}

- (BOOL)glb_isTomorrow {
    NSDate* date = NSDate.date.glb_nextDay;
    return [self glb_insideFrom:date.glb_beginningOfDay to:date.glb_endOfDay];
}

- (BOOL)glb_insideFrom:(NSDate*)from to:(NSDate*)to {
    return ([self glb_isAfterOrSame:from]) && ([self glb_isEarlierOrSame:to]);
}

- (BOOL)glb_isEarlier:(NSDate*)anotherDate {
    return ([self compare:anotherDate] == NSOrderedAscending);
}

- (BOOL)glb_isEarlierOrSame:(NSDate*)anotherDate {
    return ([self compare:anotherDate] != NSOrderedSame);
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
    NSDateComponents* components = [NSCalendar.currentCalendar components:NSCalendarUnitMonth fromDate:self];
    NSInteger month = [components month];
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
    NSDateComponents* components = [NSCalendar.currentCalendar components:NSCalendarUnitWeekday fromDate:self];
    return [components weekday];
}

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    static NSDateFormatter* dateFormatter = nil;
    if(dateFormatter == nil) {
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:SSS ZZ";
    }
    dateFormatter.locale = NSLocale.currentLocale;
    
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    [string appendFormat:@"%@", [dateFormatter stringFromDate:self]];
}

@end

/*--------------------------------------------------*/

const NSTimeInterval GLBDateMinute = 60.0f;
const NSTimeInterval GLBDateHour = 60.0f * GLBDateMinute;
const NSTimeInterval GLBDateDay = 24.0f * GLBDateHour;

/*--------------------------------------------------*/
