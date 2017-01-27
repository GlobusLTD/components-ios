/*--------------------------------------------------*/

#import "GLBDataViewCalendarItem+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBDataViewCalendarItem

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(itemWithIdentifier:(NSString*)identifier order:(NSUInteger)order accessibilityOrder:(NSUInteger)accessibilityOrder data:(id)data)

#pragma mark - Synthesize

@synthesize calendar = _calendar;

#pragma mark - Init / Free

+ (instancetype)itemWithCalendar:(NSCalendar*)calendar
                      identifier:(NSString*)identifier
                           order:(NSUInteger)order
                            data:(id)data {
    return [[self alloc] initWithCalendar:calendar identifier:identifier order:order accessibilityOrder:order data:data];
}

+ (instancetype)itemWithCalendar:(NSCalendar*)calendar
                      identifier:(NSString*)identifier
                           order:(NSUInteger)order
              accessibilityOrder:(NSUInteger)accessibilityOrder
                            data:(id)data {
    return [[self alloc] initWithCalendar:calendar identifier:identifier order:order accessibilityOrder:accessibilityOrder data:data];
}

- (instancetype)initWithCalendar:(NSCalendar*)calendar
                      identifier:(NSString*)identifier
                           order:(NSUInteger)order
                            data:(id)data {
    return [self initWithCalendar:calendar identifier:identifier order:order accessibilityOrder:order data:data];
}

- (instancetype)initWithCalendar:(NSCalendar*)calendar
                      identifier:(NSString*)identifier
                           order:(NSUInteger)order
              accessibilityOrder:(NSUInteger)accessibilityOrder
                            data:(id)data {
    self = [super initWithIdentifier:identifier order:order accessibilityOrder:accessibilityOrder data:data];
    if(self != nil) {
        _calendar = calendar;
        _allowsMoving = NO;
    }
    return self;
}

@end

/*--------------------------------------------------*/

@implementation GLBDataViewCalendarMonthItem

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(itemWithСalendar:(NSCalendar*)calendar identifier:(NSString*)identifier order:(NSUInteger)order accessibilityOrder:(NSUInteger)accessibilityOrder data:(id)data)

#pragma mark - Synthesize

@synthesize beginDate = _beginDate;
@synthesize endDate = _endDate;
@synthesize displayBeginDate = _displayBeginDate;
@synthesize displayEndDate = _displayEndDate;

#pragma mark - Init / Free

+ (instancetype)itemWithCalendar:(NSCalendar*)calendar
                       beginDate:(NSDate*)beginDate
                         endDate:(NSDate*)endDate
                displayBeginDate:(NSDate*)displayBeginDate
                  displayEndDate:(NSDate*)displayEndDate
                            data:(id)data {
    return [[self alloc] initWithCalendar:calendar beginDate:beginDate endDate:endDate displayBeginDate:displayBeginDate displayEndDate:displayEndDate data:data];
}

- (instancetype)initWithCalendar:(NSCalendar*)calendar
                       beginDate:(NSDate*)beginDate
                         endDate:(NSDate*)endDate
                displayBeginDate:(NSDate*)displayBeginDate
                  displayEndDate:(NSDate*)displayEndDate
                            data:(id)data {
    self = [super initWithCalendar:calendar identifier:GLBDataViewCalendarMonthIdentifier order:3 accessibilityOrder:3 data:data];
    if(self != nil) {
        _beginDate = beginDate;
        _endDate = endDate;
        _displayBeginDate = displayBeginDate;
        _displayEndDate = displayEndDate;
    }
    return self;
}

@end

/*--------------------------------------------------*/

@implementation GLBDataViewCalendarWeekdayItem

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(itemWithСalendar:(NSCalendar*)calendar identifier:(NSString*)identifier order:(NSUInteger)order accessibilityOrder:(NSUInteger)accessibilityOrder data:(id)data)

#pragma mark - Synthesize

@synthesize monthItem = _monthItem;
@synthesize date = _date;

#pragma mark - Init / Free

+ (instancetype)itemWithCalendar:(NSCalendar*)calendar date:(NSDate*)date data:(id)data {
    return [[self alloc] initWithCalendar:calendar date:date data:data];
}

+ (instancetype)itemWithMonthItem:(GLBDataViewCalendarMonthItem*)monthItem date:(NSDate*)date data:(id)data {
    return [[self alloc] initWithMonthItem:monthItem date:date data:data];
}

- (instancetype)initWithCalendar:(NSCalendar*)calendar date:(NSDate*)date data:(id)data {
    self = [super initWithCalendar:calendar identifier:GLBDataViewCalendarWeekdayIdentifier order:2 accessibilityOrder:2 data:data];
    if(self != nil) {
        _date = date;
    }
    return self;
}

- (instancetype)initWithMonthItem:(GLBDataViewCalendarMonthItem*)monthItem date:(NSDate*)date data:(id)data {
    self = [super initWithCalendar:monthItem.calendar identifier:GLBDataViewCalendarWeekdayIdentifier order:2 accessibilityOrder:2 data:data];
    if(self != nil) {
        _monthItem = monthItem;
        _date = date;
    }
    return self;
}

@end

/*--------------------------------------------------*/

@implementation GLBDataViewCalendarDayItem

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(itemWithСalendar:(NSCalendar*)calendar identifier:(NSString*)identifier order:(NSUInteger)order accessibilityOrder:(NSUInteger)accessibilityOrder data:(id)data)

#pragma mark - Synthesize

@synthesize weekdayItem = _weekdayItem;
@synthesize date = _date;

#pragma mark - Init / Free

+ (instancetype)itemWithCalendar:(NSCalendar*)calendar
                            date:(NSDate*)date
                            data:(id)data {
    return [[self alloc] initWithCalendar:calendar date:date data:data];
}

+ (instancetype)itemWithWeekdayItem:(GLBDataViewCalendarWeekdayItem*)weekdayItem
                               date:(NSDate*)date
                               data:(id)data {
    return [[self alloc] initWithWeekdayItem:weekdayItem date:date data:data];
}

- (instancetype)initWithCalendar:(NSCalendar*)calendar
                            date:(NSDate*)date
                            data:(id)data {
    self = [super initWithCalendar:calendar identifier:GLBDataViewCalendarDayIdentifier order:1 accessibilityOrder:1 data:data];
    if(self != nil) {
        _date = date;
    }
    return self;
}

- (instancetype)initWithWeekdayItem:(GLBDataViewCalendarWeekdayItem*)weekdayItem
                               date:(NSDate*)date
                               data:(id)data {
    self = [super initWithCalendar:weekdayItem.calendar identifier:GLBDataViewCalendarDayIdentifier order:1 accessibilityOrder:1 data:data];
    if(self != nil) {
        _weekdayItem = weekdayItem;
        _date = date;
    }
    return self;
}

#pragma mark - Property

- (GLBDataViewCalendarMonthItem*)monthItem {
    return _weekdayItem.monthItem;
}

@end

/*--------------------------------------------------*/

NSString* GLBDataViewCalendarMonthIdentifier = @"GLBDataViewCalendarMonthIdentifier";
NSString* GLBDataViewCalendarWeekdayIdentifier = @"GLBDataViewCalendarWeekdayIdentifier";
NSString* GLBDataViewCalendarDayIdentifier = @"GLBDataViewCalendarDayIdentifier";

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
