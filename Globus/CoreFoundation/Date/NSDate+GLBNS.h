/****************************************************/
/*                                                  */
/* This file is part of the Globus Componetns iOS   */
/* Copyright 2014-2016 Globus-Ltd.                  */
/* http://www.globus-ltd.com                        */
/* Created by Alexander Trifonov                    */
/*                                                  */
/* For the full copyright and license information,  */
/* please view the LICENSE file that contained      */
/* MIT License and was distributed with             */
/* this source code.                                */
/*                                                  */
/****************************************************/

#import "NSObject+GLBNS.h"

/*--------------------------------------------------*/

extern const NSTimeInterval GLBDateMinute; ///How many seconds in one minute
extern const NSTimeInterval GLBDateHour;   ///How many minutes in one hour
extern const NSTimeInterval GLBDateDay;    ///How many hours in one day

/*--------------------------------------------------*/

/**
 * @brief Names of seasons of the year.
 * @discussion Names of seasons of the year.
 */
typedef NS_ENUM(NSUInteger, GLBDateSeason) {
    GLBDateSeasonWinter,
    GLBDateSeasonSpring,
    GLBDateSeasonSummer,
    GLBDateSeasonAutumn
};

/**
 * @brief Names of days of the week.
 * @discussion Names of days of the week.
 */
typedef NS_ENUM(NSUInteger, GLBDateWeekday) {
    GLBDateWeekdayMonday = 2,
    GLBDateWeekdayTuesday = 3,
    GLBDateWeekdayWednesday = 4,
    GLBDateWeekdayThursday = 5,
    GLBDateWeekdayFriday = 6,
    GLBDateWeekdaySaturday = 7,
    GLBDateWeekdaySunday = 1,
};

/*--------------------------------------------------*/

/**
 * @file NSDate+GLBNS.h
 * @class NSDate+GLBNS
 * @classdesign It is a category
 * @helps NSDate
 * @brief Many helpful methods for NSDate support.
 * @discussion NSDate support for easily create, manage and work.
 * @remark Very useful methods ;)
 * @version 0.1
 */

@interface NSDate (GLB_NS)

/**
 * @brief Create NSData object with date without time.
 * @discussion NSData object by setting day, month and year. A time will be 00:00:00.
 * @param year
 * @param month
 * @param day
 * @return NSData object
 * @code
 * NSDate* date = [NSDate glb_dateByYear:2001 month:01 day:01;
 * @endcode
 */
+ (NSDate* _Nullable)glb_dateByYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

/**
 * @brief Create NSData object with time without date.
 * @discussion NSData object by setting hour, minute and second. A date will be 01-01-0001.
 * @param hour
 * @param minute
 * @param second
 * @return NSData object
 * @code
 * NSDate* date = [NSDate glb_dateByHour:12 minute:01 second:00];
 * @endcode
 */
+ (NSDate* _Nullable)glb_dateByHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)seccond;

/**
 * @brief Create NSData object with date and time.
 * @discussion NSData object by setting day, month and year, hour, minute and second. A date will be cirtanly as you set.
 * @param year
 * @param month
 * @param day
 * @param hour
 * @param minute
 * @param second
 * @return NSData object
 * @code
 * NSDate* date = [NSDate glb_dateByYear:2001 month:01 day:01 hour:12 minute:01 second:00];
 * @endcode
 */
+ (NSDate* _Nullable)glb_dateByYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)seccond;

/**
 * @brief Time format string.
 * @discussion Time format string with time format 1:05 pm.
 * @return String
 * @code
 * NSString *timeFormat = [date glb_formatTime];
 * @endcode
 */
- (NSString* _Nullable)glb_formatTime;

/**
 * @brief Date long format string.
 * @discussion Date format string with date format Monday, July 27, 2009
 * @return String
 * @code
 * NSString *dateFormat = [date glb_formatTime];
 * @endcode
 */
- (NSString* _Nullable)glb_formatDate;

/**
 * @brief Date short format string.
 * @discussion Date format string with date format 7/27/09 or if now is less then 5 days is 7/27/09
 * @return String
 * @code
 * NSString *dateFormat = [date glb_formatShortTime];
 * @endcode
 */
- (NSString* _Nullable)glb_formatShortTime;

/**
 * @brief Date and time format string.
 * @discussion Date and time format string with date format Jul 27 1:05 pm or if now is less then 5 days is Mon 1:05 pm.
 * @return String
 * @code
 * NSString *dateFormat = [date glb_formatDateTime];
 * @endcode
 */
- (NSString* _Nullable)glb_formatDateTime;

/**
 * @brief Time format string.
 * @discussion Time format string with words without numbers. If now is less then 1 second - "just a moment ago", if now is less then 1 minute ago - "X seconds ago", if now is less then 2 minute - "about a minute ago" , if now is less then 1 hour - "X minutes ago", if now is less then 1.5 hour -  "about an hour ago", if now is less then 1 day - "X hours ago".
 * @return String
 * @code
 * NSString *dateFormat = [date glb_formatRelativeTime];
 * @endcode
 */
- (NSString* _Nullable)glb_formatRelativeTime;

/**
 * @brief Time short format string.
 * @discussion Time short format string with number and one symbol. If now is less then 1 minute ago - " less than one minute ago", if now is less then 1 hour - "Xm" (50m), if now is less then 1.5 hour -  "Xh" (3h), if now is less then 7 days - "Xd" (30d).
 * @return String
 * @code
 * NSString *dateFormat = [date glb_formatShortRelativeTime];
 * @endcode
 */
- (NSString* _Nullable)glb_formatShortRelativeTime;

/**
 * @brief Create NSData object.
 * @discussion NSData object by unix timestamp and time zome.
 * @param timestamp
 * @param timeZone
 * @return NSData object
 * @code
 * NSDate* date = [NSDate glb_dateWithUnixTimestamp:timestamp timeZone:NSTimeZone.systemTimeZone];
 * @endcode
 */
+ (NSDate* _Nullable)glb_dateWithUnixTimestamp:(NSUInteger)timestamp timeZone:(NSTimeZone* _Nullable)timeZone;

/**
 * @brief Create NSData object.
 * @discussion NSData object by unix timestamp and current time zone.
 * @param timestamp
 * @return NSData object
 * @code
 * NSDate* date = [NSDate glb_dateWithUnixTimestamp:timestamp timeZone:NSTimeZone.systemTimeZone];
 * @endcode
 */
+ (NSDate* _Nullable)glb_dateWithUnixTimestamp:(NSUInteger)timestamp;

/**
 * @brief Create unix timestamp to time zone.
 * @discussion Unix timestamp to time zone.
 * @param timeZone
 * @return timeIntervalSince1970
 * @code
 * [date glb_unixTimestampToTimeZone:NSTimeZone.systemTimeZone];
 * @endcode
 */
- (NSUInteger)glb_unixTimestampToTimeZone:(NSTimeZone* _Nullable)timeZone;

/**
 * @brief Create unix timestamp.
 * @discussion Unix timestamp.
 * @return timeIntervalSince1970
 * @code
 * [date glb_unixTimestamp];
 * @endcode
 */
- (NSUInteger)glb_unixTimestamp;

/**
 * @brief Pick out certain unit of the date.
 * @discussion Pick out given unit of the given date.
 * @return NSDate
 * @code
 * [date glb_extractCalendarUnit:calendarUnit];
 * @endcode
 */
- (NSDate* _Nullable)glb_extractCalendarUnit:(NSCalendarUnit)calendarUnit;

/**
 * @brief Pick out the date and throw time.
 * @discussion Pick out the date and throw time. You will have dd-mm-yyyy and 00:00:00.
 * @return NSDate
 * @code
 * [date glb_withoutDate];
 * @endcode
 */
- (NSDate* _Nullable)glb_withoutDate;

/**
 * @brief Pick out the time and throw date.
 * @discussion Pick out the time and throw date. You will have 01-01-0001 and hh:mm:ss.
 * @return NSDate
 * @code
 * [date glb_withoutTime];
 * @endcode
 */
- (NSDate* _Nullable)glb_withoutTime;

/**
 * @brief First day of the year.
 * @discussion You will have january 1st of given date.
 * @return 01-01-year
 * @code
 * [date glb_beginningOfYear];
 * @endcode
 */
- (NSDate* _Nullable)glb_beginningOfYear;

/**
 * @brief Last day of the year.
 * @discussion You will have december 31st of given date.
 * @return 31-12-year
 * @code
 * [date glb_beginningOfYear];
 * @endcode
 */
- (NSDate* _Nullable)glb_endOfYear;

/**
 * @brief First day of the month.
 * @discussion You will have 1st day of month of given date.
 * @return 01-month
 * @code
 * [date glb_beginningOfMonth];
 * @endcode
 */
- (NSDate* _Nullable)glb_beginningOfMonth;

/**
 * @brief Last day of the month.
 * @discussion You will have last day of month of given date.
 * @return last day of the month
 * @code
 * [date glb_endOfMonth];
 * @endcode
 */
- (NSDate* _Nullable)glb_endOfMonth;

/**
 * @brief First day of the week.
 * @discussion You will have monday (sunday) of the week of given date.
 * @return Monday (sunday)
 * @code
 * [date glb_beginningOfWeek];
 * @endcode
 */
- (NSDate* _Nullable)glb_beginningOfWeek;

/**
 * @brief Last day of the week.
 * @discussion You will have sunday (saturday) of the week of given date.
 * @return last day of the week.
 * @code
 * [date glb_endOfWeek];
 * @endcode
 */
- (NSDate* _Nullable)glb_endOfWeek;

/**
 * @brief Beginning of the day.
 * @discussion Beginning of the day. You will have a given date with time 00:00:00.
 * @return dd-mm-yyyy and 00:00:00.
 * @code
 * [date glb_beginningOfDay];
 * @endcode
 */
- (NSDate* _Nullable)glb_beginningOfDay;

/**
 * @brief End of the day.
 * @discussion End of the day. You will have a given date with time 23:59:59.
 * @return dd-mm-yyyy and 23:59:59.
 * @code
 * [date glb_endOfDay];
 * @endcode
 */
- (NSDate* _Nullable)glb_endOfDay;

/**
 * @brief Beginning of the hour.
 * @discussion Beginning of the hour. You will have a given date with time hh:00:00.
 * @return dd-mm-yyyy and hh:00:00.
 * @code
 * [date glb_beginningOfHour];
 * @endcode
 */
- (NSDate* _Nullable)glb_beginningOfHour;

/**
 * @brief End of the hour.
 * @discussion End of the hour. You will have a given date with time hh:59:59.
 * @return dd-mm-yyyy and hh:59:59.
 * @code
 * [date glb_endOfHour];
 * @endcode
 */
- (NSDate* _Nullable)glb_endOfHour;

/**
 * @brief Beginning of the minute.
 * @discussion Beginning of the minute. You will have a given date with time hh:mm:00.
 * @return dd-mm-yyyy and hh:mm:00.
 * @code
 * [date glb_beginningOfMinute];
 * @endcode
 */
- (NSDate* _Nullable)glb_beginningOfMinute;

/**
 * @brief End of the minute.
 * @discussion End of the minute. You will have a given date with time hh:mm:59.
 * @return dd-mm-yyyy and hh:mm:59.
 * @code
 * [date glb_endOfMinute];
 * @endcode
 */
- (NSDate* _Nullable)glb_endOfMinute;

/**
 * @brief Previouse of the year.
 * @discussion You will have a new date with previous year of the given date.
 * @return date with year - 1.
 * @code
 * [date glb_previousYear];
 * @endcode
 */
- (NSDate* _Nullable)glb_previousYear;

/**
 * @brief Next of the year.
 * @discussion You will have a new date with next year of the given date.
 * @return date with year + 1.
 * @code
 * [date glb_nextYear];
 * @endcode
 */
- (NSDate* _Nullable)glb_nextYear;

/**
 * @brief Previouse of the month.
 * @discussion You will have a new date with previous month of the given date.
 * @return date with month - 1.
 * @code
 * [date glb_previousMonth];
 * @endcode
 */
- (NSDate* _Nullable)glb_previousMonth;

/**
 * @brief Next of the month.
 * @discussion You will have a new date with next month of the given date.
 * @return date with month + 1.
 * @code
 * [date glb_nextMonth];
 * @endcode
 */
- (NSDate* _Nullable)glb_nextMonth;

/**
 * @brief Previouse of the month.
 * @discussion You will have a new date with previous month of the given date.
 * @return date with month - 1.
 * @code
 * [date glb_previousMonth];
 * @endcode
 */
- (NSDate* _Nullable)glb_previousWeek;

/**
 * @brief Next of the week.
 * @discussion You will have a new date with next week of the given date.
 * @return date with week + 1.
 * @code
 * [date glb_nextWeek];
 * @endcode
 */
- (NSDate* _Nullable)glb_nextWeek;

/**
 * @brief Previouse of the day.
 * @discussion You will have a new date with previous day of the given date.
 * @return date with month - 1.
 * @code
 * [date glb_previousDay];
 * @endcode
 */
- (NSDate* _Nullable)glb_previousDay;

/**
 * @brief Next of the day.
 * @discussion You will have a new date with next day of the given date.
 * @return date with day + 1.
 * @code
 * [date glb_nextDay];
 * @endcode
 */
- (NSDate* _Nullable)glb_nextDay;

/**
 * @brief Previouse of the hour.
 * @discussion You will have a new date with previous hour of the given date.
 * @return date with hour - 1.
 * @code
 * [date glb_previousHour];
 * @endcode
 */
- (NSDate* _Nullable)glb_previousHour;

/**
 * @brief Next of the hour.
 * @discussion You will have a new date with next hour of the given date.
 * @return date with hour + 1.
 * @code
 * [date glb_nextHour];
 * @endcode
 */
- (NSDate* _Nullable)glb_nextHour;

/**
 * @brief Previouse of the minute.
 * @discussion You will have a new date with previous minute of the given date.
 * @return date with minute - 1.
 * @code
 * [date glb_previousMinute];
 * @endcode
 */
- (NSDate* _Nullable)glb_previousMinute;

/**
 * @brief Next of the minute.
 * @discussion You will have a new date with next minute of the given date.
 * @return date with minute + 1.
 * @code
 * [date glb_nextMinute];
 * @endcode
 */
- (NSDate* _Nullable)glb_nextMinute;

/**
 * @brief Previouse of the second.
 * @discussion You will have a new date with previous second of the given date.
 * @return date with second - 1.
 * @code
 * [date glb_previousSecond];
 * @endcode
 */
- (NSDate* _Nullable)glb_previousSecond;

/**
 * @brief Next of the second.
 * @discussion You will have a new date with next second of the given date.
 * @return date with second + 1.
 * @code
 * [date glb_nextSecond];
 * @endcode
 */
- (NSDate* _Nullable)glb_nextSecond;

/**
 * @brief How many years.
 * @discussion How many years between two dates.
 * @param second date.
 * @return Number of years.
 * @code
 * [date1 glb_yearsToDate:date2];
 * @endcode
 */
- (NSInteger)glb_yearsToDate:(NSDate* _Nonnull)date;

/**
 * @brief How many months.
 * @discussion How many months between two dates.
 * @param second date.
 * @return Number of months.
 * @code
 * [date1 glb_monthsToDate:date2];
 * @endcode
 */
- (NSInteger)glb_monthsToDate:(NSDate* _Nonnull)date;

/**
 * @brief How many days.
 * @discussion How many days between two dates.
 * @param second date.
 * @return Number of days.
 * @code
 * [date1 glb_daysToDate:date2];
 * @endcode
 */
- (NSInteger)glb_daysToDate:(NSDate* _Nonnull)date;

/**
 * @brief How many weeks.
 * @discussion How many weeks between two dates.
 * @param second date.
 * @return Number of weeks.
 * @code
 * [date1 glb_weeksToDate:date2];
 * @endcode
 */
- (NSInteger)glb_weeksToDate:(NSDate* _Nonnull)date;

/**
 * @brief How many hours.
 * @discussion How many years between two hours.
 * @param second date.
 * @return Number of hours.
 * @code
 * [date1 glb_hoursToDate:date2];
 * @endcode
 */
- (NSInteger)glb_hoursToDate:(NSDate* _Nonnull)date;

/**
 * @brief How many minutes.
 * @discussion How many minutes between two dates.
 * @param second date.
 * @return Number of minutes.
 * @code
 * [date1 glb_minutesToDate:date2];
 * @endcode
 */
- (NSInteger)glb_minutesToDate:(NSDate* _Nonnull)date;

/**
 * @brief How many seconds.
 * @discussion How many seconds between two dates.
 * @param second date.
 * @return Number of seconds.
 * @code
 * [date1 glb_secondsToDate:date2];
 * @endcode
 */
- (NSInteger)glb_secondsToDate:(NSDate* _Nonnull)date;

/**
 * @brief Add certain amount of years to date.
 * @discussion Add certain amount of years to date.
 * @param Number of year.
 * @return Date with increased year.
 * @code
 * NSDate* date = [date glb_addYears:1];
 * @endcode
 */
- (NSDate* _Nullable)glb_addYears:(NSInteger)years;

/**
 * @brief Add certain amount of months to date.
 * @discussion Add certain amount of year to date.
 * @param Number of months.
 * @return Date with increased month.
 * @code
 * NSDate* date = [date glb_addMonths:1];
 * @endcode
 */
- (NSDate* _Nullable)glb_addMonths:(NSInteger)months;

/**
 * @brief Add certain amount of weeks to date.
 * @discussion Add certain amount of weeks to date.
 * @param Number of weeks.
 * @return Date with increased weeks.
 * @code
 * NSDate* date = [date glb_addWeeks:1];
 * @endcode
 */
- (NSDate* _Nullable)glb_addWeeks:(NSInteger)weeks;

/**
 * @brief Add certain amount of days to date.
 * @discussion Add certain amount of days to date.
 * @param Number of days.
 * @return Date with increased days.
 * @code
 * NSDate* date = [date glb_addDays:1];
 * @endcode
 */
- (NSDate* _Nullable)glb_addDays:(NSInteger)days;

/**
 * @brief Add certain amount of hours to date.
 * @discussion Add certain amount of hours to date.
 * @param Number of hours.
 * @return Date with increased hours.
 * @code
 * NSDate* date = [date glb_addHours:1];
 * @endcode
 */
- (NSDate* _Nullable)glb_addHours:(NSInteger)hours;

/**
 * @brief Add certain amount of minutes to date.
 * @discussion Add certain amount of minutes to date.
 * @param Number of minutes.
 * @return Date with increased minutes.
 * @code
 * NSDate* date = [date glb_addMinutes:1];
 * @endcode
 */
- (NSDate* _Nullable)glb_addMinutes:(NSInteger)minutes;

/**
 * @brief Add certain amount of seconds to date.
 * @discussion Add certain amount of seconds to date.
 * @param Number of seconds.
 * @return Date with increased seconds.
 * @code
 * NSDate* date = [date glb_addSeconds:1];
 * @endcode
 */
- (NSDate* _Nullable)glb_addSeconds:(NSInteger)seconds;

/**
 * @brief Is certain date yesterday or not.
 * @discussion Is certain date yesterday or not.
 * @return YES or NO.
 * @code
 * BOOL yesterday = [date glb_isYesterday];
 * @endcode
 */
- (BOOL)glb_isYesterday;

/**
 * @brief Is certain date today or not.
 * @discussion Is certain date today or not.
 * @return YES or NO.
 * @code
 * BOOL today = [date glb_isToday];
 * @endcode
 */
- (BOOL)glb_isToday;

/**
 * @brief Is certain date tomorrow or not.
 * @discussion Is certain date tomorrow or not.
 * @return YES or NO.
 * @code
 * BOOL tomorrow = [date glb_isTomorrow];
 * @endcode
 */
- (BOOL)glb_isTomorrow;

/**
 * @brief Is certain date between two different dates or not.
 * @discussion Is certain date between two different dates or not.
 * @return YES or NO.
 * @code
 * BOOL in = [date glb_insideFrom:fromDate to:toDate];
 * @endcode
 */
- (BOOL)glb_insideFrom:(NSDate* _Nonnull)from to:(NSDate* _Nonnull)to;

/**
 * @brief Is certain date before(erlier) to another date or not.
 * @discussion Is certain date before(erlier) to another date or not.
 * @return YES or NO.
 * @code
 * BOOL yesterday = [date glb_isEarlier:anotherDate];
 * @endcode
 */
- (BOOL)glb_isEarlier:(NSDate* _Nonnull)anotherDate;

/**
 * @brief Is certain date before(erlier) or equal(same) to another date or not.
 * @discussion Is certain date before(erlier) or equal(same) to another date or not.
 * @return YES or NO.
 * @code
 * BOOL yesterday = [date glb_isEarlierOrSame:anotherDate];
 * @endcode
 */
- (BOOL)glb_isEarlierOrSame:(NSDate* _Nonnull)anotherDate;

/**
 * @brief Is certain date equal(same) to another date or not.
 * @discussion Is certain date equal(same) to another date or not.
 * @return YES or NO.
 * @code
 * BOOL yesterday = [date glb_isSame:anotherDate];
 * @endcode
 */
- (BOOL)glb_isSame:(NSDate* _Nonnull)anotherDate;

/**
 * @brief Is certain date after(more then) to another date or not.
 * @discussion Is certain date after(more then) to another date or not.
 * @return YES or NO.
 * @code
 * BOOL yesterday = [date glb_isAfter:anotherDate];
 * @endcode
 */
- (BOOL)glb_isAfter:(NSDate* _Nonnull)anotherDate;

/**
 * @brief Is certain date after(more then) or equal(same) to another date or not.
 * @discussion Is certain date after(more then) or equal(same) to another date or not.
 * @return YES or NO.
 * @code
 * BOOL yesterday = [date glb_isAfterOrSame:anotherDate];
 * @endcode
 */
- (BOOL)glb_isAfterOrSame:(NSDate* _Nonnull)anotherDate;

/**
 * @brief The season name.
 * @discussion You will have a season name.
 * @return GLBDateSeason.
 * @code
 * [date glb_season];
 * @endcode
 */
- (GLBDateSeason)glb_season;

/**
 * @brief The week day name.
 * @discussion You will have a week day name.
 * @return GLBDateWeekday.
 * @code
 * [date glb_weekday];
 * @endcode
 */
- (GLBDateWeekday)glb_weekday;

@end

/*--------------------------------------------------*/
