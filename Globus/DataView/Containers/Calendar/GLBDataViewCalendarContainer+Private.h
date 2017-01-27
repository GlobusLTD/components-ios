/*--------------------------------------------------*/

#import "GLBDataViewCalendarContainer.h"
#import "GLBDataViewCalendarItem+Private.h"
#import "GLBDataViewItemsContainer+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import "GLBGrid.h"

/*--------------------------------------------------*/

@interface GLBDataViewCalendarContainer () {
@protected
    NSCalendar* _calendar;
    BOOL _canShowMonth;
    BOOL _canSelectMonth;
    UIEdgeInsets _monthMargin;
    CGFloat _monthHeight;
    CGFloat _monthSpacing;
    BOOL _canShowWeekdays;
    BOOL _canSelectWeekdays;
    UIEdgeInsets _weekdaysMargin;
    CGFloat _weekdaysHeight;
    UIOffset _weekdaysSpacing;
    BOOL _canShowDays;
    BOOL _canSelectDays;
    BOOL _canSelectPreviousDays;
    BOOL _canSelectNextDays;
    UIEdgeInsets _daysMargin;
    CGFloat _daysHeight;
    UIOffset _daysSpacing;
    NSDate* _beginDate;
    NSDate* _endDate;
    NSDate* _displayBeginDate;
    NSDate* _displayEndDate;
    __kindof GLBDataViewCalendarMonthItem* _monthItem;
    NSMutableArray< __kindof GLBDataViewCalendarWeekdayItem* >* _weekdayItems;
    GLBMutableGrid< __kindof GLBDataViewCalendarDayItem* >* _dayItems;
}

@property(nonatomic, nullable, strong) NSCalendar* calendar;
@property(nonatomic, nullable, strong) NSDate* beginDate;
@property(nonatomic, nullable, strong) NSDate* endDate;
@property(nonatomic, nullable, strong) __kindof GLBDataViewCalendarMonthItem* monthItem;
@property(nonatomic, nonnull, strong) NSMutableArray< __kindof GLBDataViewCalendarWeekdayItem* >* weekdayItems;
@property(nonatomic, nonnull, strong) GLBMutableGrid< __kindof GLBDataViewCalendarDayItem* >* dayItems;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
