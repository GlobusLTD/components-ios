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

extern const NSTimeInterval GLBDateMinute;
extern const NSTimeInterval GLBDateHour;
extern const NSTimeInterval GLBDateDay;

/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBDateSeason) {
    GLBDateSeasonWinter,
    GLBDateSeasonSpring,
    GLBDateSeasonSummer,
    GLBDateSeasonAutumn
};

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
 * @file
 * @class
 * @classdesign
 * @helps
 * @brief
 * @discussion
 * @remark
 * @version 0.1
 */

@interface NSDate (GLB_NS)

+ (nullable NSDate*)glb_dateByYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+ (nullable NSDate*)glb_dateByYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day usingCalendar:(nonnull NSCalendar*)calendar;
+ (nullable NSDate*)glb_dateByHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;
+ (nullable NSDate*)glb_dateByHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second usingCalendar:(nonnull NSCalendar*)calendar;
+ (nullable NSDate*)glb_dateByYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;
+ (nullable NSDate*)glb_dateByYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second usingCalendar:(nonnull NSCalendar*)calendar;

- (nullable NSString*)glb_formatTime;
- (nullable NSString*)glb_formatDate;
- (nullable NSString*)glb_formatShortTime;
- (nullable NSString*)glb_formatDateTime;
- (nullable NSString*)glb_formatRelativeTime;
- (nullable NSString*)glb_formatShortRelativeTime;

+ (nullable NSDate*)glb_dateWithUnixTimestamp:(NSUInteger)timestamp timeZone:(nullable NSTimeZone*)timeZone;
+ (nullable NSDate*)glb_dateWithUnixTimestamp:(NSUInteger)timestamp;
- (NSUInteger)glb_unixTimestampToTimeZone:(nullable NSTimeZone*)timeZone;
- (NSUInteger)glb_unixTimestamp;

- (nullable NSDate*)glb_extractCalendarUnit:(NSCalendarUnit)calendarUnit;
- (nullable NSDate*)glb_extractCalendarUnit:(NSCalendarUnit)calendarUnit usingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_withoutDate;
- (nullable NSDate*)glb_withoutDateUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_withoutTime;
- (nullable NSDate*)glb_withoutTimeUsingCalendar:(nonnull NSCalendar*)calendar;

- (nullable NSDate*)glb_beginningOfYear;
- (nullable NSDate*)glb_beginningOfYearUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_endOfYear;
- (nullable NSDate*)glb_endOfYearUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_beginningOfMonth;
- (nullable NSDate*)glb_beginningOfMonthUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_endOfMonth;
- (nullable NSDate*)glb_endOfMonthUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_beginningOfWeek;
- (nullable NSDate*)glb_beginningOfWeekUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_endOfWeek;
- (nullable NSDate*)glb_endOfWeekUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_beginningOfDay;
- (nullable NSDate*)glb_beginningOfDayUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_endOfDay;
- (nullable NSDate*)glb_endOfDayUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_beginningOfHour;
- (nullable NSDate*)glb_beginningOfHourUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_endOfHour;
- (nullable NSDate*)glb_endOfHourUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_beginningOfMinute;
- (nullable NSDate*)glb_beginningOfMinuteUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_endOfMinute;
- (nullable NSDate*)glb_endOfMinuteUsingCalendar:(nonnull NSCalendar*)calendar;

- (nullable NSDate*)glb_previousYear;
- (nullable NSDate*)glb_previousYearUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_nextYear;
- (nullable NSDate*)glb_nextYearUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_previousMonth;
- (nullable NSDate*)glb_previousMonthUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_nextMonth;
- (nullable NSDate*)glb_nextMonthUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_previousWeek;
- (nullable NSDate*)glb_previousWeekUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_nextWeek;
- (nullable NSDate*)glb_nextWeekUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_previousDay;
- (nullable NSDate*)glb_previousDayUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_nextDay;
- (nullable NSDate*)glb_nextDayUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_previousHour;
- (nullable NSDate*)glb_previousHourUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_nextHour;
- (nullable NSDate*)glb_nextHourUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_previousMinute;
- (nullable NSDate*)glb_previousMinuteUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_nextMinute;
- (nullable NSDate*)glb_nextMinuteUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_previousSecond;
- (nullable NSDate*)glb_previousSecondUsingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_nextSecond;
- (nullable NSDate*)glb_nextSecondUsingCalendar:(nonnull NSCalendar*)calendar;

- (NSInteger)glb_yearsToDate:(nonnull NSDate*)date;
- (NSInteger)glb_yearsToDate:(nonnull NSDate*)date usingCalendar:(nonnull NSCalendar*)calendar;
- (NSInteger)glb_monthsToDate:(nonnull NSDate*)date;
- (NSInteger)glb_monthsToDate:(nonnull NSDate*)date usingCalendar:(nonnull NSCalendar*)calendar;
- (NSInteger)glb_daysToDate:(nonnull NSDate*)date;
- (NSInteger)glb_daysToDate:(nonnull NSDate*)date usingCalendar:(nonnull NSCalendar*)calendar;
- (NSInteger)glb_weeksToDate:(nonnull NSDate*)date;
- (NSInteger)glb_weeksToDate:(nonnull NSDate*)date usingCalendar:(nonnull NSCalendar*)calendar;
- (NSInteger)glb_hoursToDate:(nonnull NSDate*)date;
- (NSInteger)glb_hoursToDate:(nonnull NSDate*)date usingCalendar:(nonnull NSCalendar*)calendar;
- (NSInteger)glb_minutesToDate:(nonnull NSDate*)date;
- (NSInteger)glb_minutesToDate:(nonnull NSDate*)date usingCalendar:(nonnull NSCalendar*)calendar;
- (NSInteger)glb_secondsToDate:(nonnull NSDate*)date;
- (NSInteger)glb_secondsToDate:(nonnull NSDate*)date usingCalendar:(nonnull NSCalendar*)calendar;

- (nullable NSDate*)glb_addYears:(NSInteger)years;
- (nullable NSDate*)glb_addYears:(NSInteger)years usingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_addMonths:(NSInteger)months;
- (nullable NSDate*)glb_addMonths:(NSInteger)months usingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_addWeeks:(NSInteger)weeks;
- (nullable NSDate*)glb_addWeeks:(NSInteger)weeks usingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_addDays:(NSInteger)days;
- (nullable NSDate*)glb_addDays:(NSInteger)days usingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_addHours:(NSInteger)hours;
- (nullable NSDate*)glb_addHours:(NSInteger)hours usingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_addMinutes:(NSInteger)minutes;
- (nullable NSDate*)glb_addMinutes:(NSInteger)minutes usingCalendar:(nonnull NSCalendar*)calendar;
- (nullable NSDate*)glb_addSeconds:(NSInteger)seconds;
- (nullable NSDate*)glb_addSeconds:(NSInteger)seconds usingCalendar:(nonnull NSCalendar*)calendar;

- (BOOL)glb_isYesterday;
- (BOOL)glb_isYesterdayUsingCalendar:(nonnull NSCalendar*)calendar;
- (BOOL)glb_isToday;
- (BOOL)glb_isTodayUsingCalendar:(nonnull NSCalendar*)calendar;
- (BOOL)glb_isTomorrow;
- (BOOL)glb_isTomorrowUsingCalendar:(nonnull NSCalendar*)calendar;
- (BOOL)glb_insideFrom:(nonnull NSDate*)from to:(nonnull NSDate*)to;
- (BOOL)glb_isEarlier:(nonnull NSDate*)anotherDate;
- (BOOL)glb_isEarlierOrSame:(nonnull NSDate*)anotherDate;
- (BOOL)glb_isSame:(nonnull NSDate*)anotherDate;
- (BOOL)glb_isAfter:(nonnull NSDate*)anotherDate;
- (BOOL)glb_isAfterOrSame:(nonnull NSDate*)anotherDate;

- (GLBDateSeason)glb_season;
- (GLBDateSeason)glb_seasonUsingCalendar:(nonnull NSCalendar*)calendar;
- (GLBDateWeekday)glb_weekday;
- (GLBDateWeekday)glb_weekdayUsingCalendar:(nonnull NSCalendar*)calendar;

@end

/*--------------------------------------------------*/
