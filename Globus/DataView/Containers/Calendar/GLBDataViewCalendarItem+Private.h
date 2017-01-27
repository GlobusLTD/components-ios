/*--------------------------------------------------*/

#import "GLBDataViewCalendarItem.h"
#import "GLBDataViewItem+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewCalendarItem  () {
@protected
    __weak NSCalendar* _calendar;
}

@end

/*--------------------------------------------------*/

@interface GLBDataViewCalendarMonthItem  () {
@protected
    NSDate* _beginDate;
    NSDate* _endDate;
    NSDate* _displayBeginDate;
    NSDate* _displayEndDate;
}

@end

/*--------------------------------------------------*/

@interface GLBDataViewCalendarWeekdayItem () {
@protected
    __weak GLBDataViewCalendarMonthItem* _monthItem;
    NSDate* _date;
}

@end

/*--------------------------------------------------*/

@interface GLBDataViewCalendarDayItem () {
@protected
    __weak GLBDataViewCalendarWeekdayItem* _weekdayItem;
    NSDate* _date;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
