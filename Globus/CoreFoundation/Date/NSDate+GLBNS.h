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

+ (NSDate* _Nullable)glb_dateByYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+ (NSDate* _Nullable)glb_dateByYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day usingCalendar:(NSCalendar* _Nonnull)calendar;
+ (NSDate* _Nullable)glb_dateByHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;
+ (NSDate* _Nullable)glb_dateByHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second usingCalendar:(NSCalendar* _Nonnull)calendar;
+ (NSDate* _Nullable)glb_dateByYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;
+ (NSDate* _Nullable)glb_dateByYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second usingCalendar:(NSCalendar* _Nonnull)calendar;

- (NSString* _Nullable)glb_formatTime;
- (NSString* _Nullable)glb_formatDate;
- (NSString* _Nullable)glb_formatShortTime;
- (NSString* _Nullable)glb_formatDateTime;
- (NSString* _Nullable)glb_formatRelativeTime;
- (NSString* _Nullable)glb_formatShortRelativeTime;

+ (NSDate* _Nullable)glb_dateWithUnixTimestamp:(NSUInteger)timestamp timeZone:(NSTimeZone* _Nullable)timeZone;
+ (NSDate* _Nullable)glb_dateWithUnixTimestamp:(NSUInteger)timestamp;
- (NSUInteger)glb_unixTimestampToTimeZone:(NSTimeZone* _Nullable)timeZone;
- (NSUInteger)glb_unixTimestamp;

- (NSDate* _Nullable)glb_extractCalendarUnit:(NSCalendarUnit)calendarUnit;
- (NSDate* _Nullable)glb_extractCalendarUnit:(NSCalendarUnit)calendarUnit usingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_withoutDate;
- (NSDate* _Nullable)glb_withoutDateUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_withoutTime;
- (NSDate* _Nullable)glb_withoutTimeUsingCalendar:(NSCalendar* _Nonnull)calendar;

- (NSDate* _Nullable)glb_beginningOfYear;
- (NSDate* _Nullable)glb_beginningOfYearUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_endOfYear;
- (NSDate* _Nullable)glb_endOfYearUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_beginningOfMonth;
- (NSDate* _Nullable)glb_beginningOfMonthUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_endOfMonth;
- (NSDate* _Nullable)glb_endOfMonthUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_beginningOfWeek;
- (NSDate* _Nullable)glb_beginningOfWeekUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_endOfWeek;
- (NSDate* _Nullable)glb_endOfWeekUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_beginningOfDay;
- (NSDate* _Nullable)glb_beginningOfDayUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_endOfDay;
- (NSDate* _Nullable)glb_endOfDayUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_beginningOfHour;
- (NSDate* _Nullable)glb_beginningOfHourUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_endOfHour;
- (NSDate* _Nullable)glb_endOfHourUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_beginningOfMinute;
- (NSDate* _Nullable)glb_beginningOfMinuteUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_endOfMinute;
- (NSDate* _Nullable)glb_endOfMinuteUsingCalendar:(NSCalendar* _Nonnull)calendar;

- (NSDate* _Nullable)glb_previousYear;
- (NSDate* _Nullable)glb_previousYearUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_nextYear;
- (NSDate* _Nullable)glb_nextYearUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_previousMonth;
- (NSDate* _Nullable)glb_previousMonthUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_nextMonth;
- (NSDate* _Nullable)glb_nextMonthUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_previousWeek;
- (NSDate* _Nullable)glb_previousWeekUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_nextWeek;
- (NSDate* _Nullable)glb_nextWeekUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_previousDay;
- (NSDate* _Nullable)glb_previousDayUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_nextDay;
- (NSDate* _Nullable)glb_nextDayUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_previousHour;
- (NSDate* _Nullable)glb_previousHourUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_nextHour;
- (NSDate* _Nullable)glb_nextHourUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_previousMinute;
- (NSDate* _Nullable)glb_previousMinuteUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_nextMinute;
- (NSDate* _Nullable)glb_nextMinuteUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_previousSecond;
- (NSDate* _Nullable)glb_previousSecondUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_nextSecond;
- (NSDate* _Nullable)glb_nextSecondUsingCalendar:(NSCalendar* _Nonnull)calendar;

- (NSInteger)glb_yearsToDate:(NSDate* _Nonnull)date;
- (NSInteger)glb_yearsToDate:(NSDate* _Nonnull)date usingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSInteger)glb_monthsToDate:(NSDate* _Nonnull)date;
- (NSInteger)glb_monthsToDate:(NSDate* _Nonnull)date usingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSInteger)glb_daysToDate:(NSDate* _Nonnull)date;
- (NSInteger)glb_daysToDate:(NSDate* _Nonnull)date usingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSInteger)glb_weeksToDate:(NSDate* _Nonnull)date;
- (NSInteger)glb_weeksToDate:(NSDate* _Nonnull)date usingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSInteger)glb_hoursToDate:(NSDate* _Nonnull)date;
- (NSInteger)glb_hoursToDate:(NSDate* _Nonnull)date usingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSInteger)glb_minutesToDate:(NSDate* _Nonnull)date;
- (NSInteger)glb_minutesToDate:(NSDate* _Nonnull)date usingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSInteger)glb_secondsToDate:(NSDate* _Nonnull)date;
- (NSInteger)glb_secondsToDate:(NSDate* _Nonnull)date usingCalendar:(NSCalendar* _Nonnull)calendar;

- (NSDate* _Nullable)glb_addYears:(NSInteger)years;
- (NSDate* _Nullable)glb_addYears:(NSInteger)years usingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_addMonths:(NSInteger)months;
- (NSDate* _Nullable)glb_addMonths:(NSInteger)months usingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_addWeeks:(NSInteger)weeks;
- (NSDate* _Nullable)glb_addWeeks:(NSInteger)weeks usingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_addDays:(NSInteger)days;
- (NSDate* _Nullable)glb_addDays:(NSInteger)days usingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_addHours:(NSInteger)hours;
- (NSDate* _Nullable)glb_addHours:(NSInteger)hours usingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_addMinutes:(NSInteger)minutes;
- (NSDate* _Nullable)glb_addMinutes:(NSInteger)minutes usingCalendar:(NSCalendar* _Nonnull)calendar;
- (NSDate* _Nullable)glb_addSeconds:(NSInteger)seconds;
- (NSDate* _Nullable)glb_addSeconds:(NSInteger)seconds usingCalendar:(NSCalendar* _Nonnull)calendar;

- (BOOL)glb_isYesterday;
- (BOOL)glb_isYesterdayUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (BOOL)glb_isToday;
- (BOOL)glb_isTodayUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (BOOL)glb_isTomorrow;
- (BOOL)glb_isTomorrowUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (BOOL)glb_insideFrom:(NSDate* _Nonnull)from to:(NSDate* _Nonnull)to;
- (BOOL)glb_isEarlier:(NSDate* _Nonnull)anotherDate;
- (BOOL)glb_isEarlierOrSame:(NSDate* _Nonnull)anotherDate;
- (BOOL)glb_isSame:(NSDate* _Nonnull)anotherDate;
- (BOOL)glb_isAfter:(NSDate* _Nonnull)anotherDate;
- (BOOL)glb_isAfterOrSame:(NSDate* _Nonnull)anotherDate;

- (GLBDateSeason)glb_season;
- (GLBDateSeason)glb_seasonUsingCalendar:(NSCalendar* _Nonnull)calendar;
- (GLBDateWeekday)glb_weekday;
- (GLBDateWeekday)glb_weekdayUsingCalendar:(NSCalendar* _Nonnull)calendar;

@end

/*--------------------------------------------------*/
