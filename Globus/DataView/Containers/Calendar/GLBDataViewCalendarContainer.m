/*--------------------------------------------------*/

#import "GLBDataViewCalendarContainer+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import "NSArray+GLBNS.h"
#import "NSDate+GLBNS.h"
#import "GLBCG.h"

/*--------------------------------------------------*/

@implementation GLBDataViewCalendarContainer

#pragma mark - Synthesize

@synthesize calendar = _calendar;
@synthesize canShowMonth = _canShowMonth;
@synthesize canSelectMonth = _canSelectMonth;
@synthesize monthMargin = _monthMargin;
@synthesize monthHeight = _monthHeight;
@synthesize monthSpacing = _monthSpacing;
@synthesize canShowWeekdays = _canShowWeekdays;
@synthesize canSelectWeekdays = _canSelectWeekdays;
@synthesize weekdaysMargin = _weekdaysMargin;
@synthesize weekdaysHeight = _weekdaysHeight;
@synthesize weekdaysSpacing = _weekdaysSpacing;
@synthesize canShowDays = _canShowDays;
@synthesize canSelectDays = _canSelectDays;
@synthesize canSelectPreviousDays = _canSelectPreviousDays;
@synthesize canSelectNextDays = _canSelectNextDays;
@synthesize canSelectEarlierDays = _canSelectEarlierDays;
@synthesize canSelectCurrentDay = _canSelectCurrentDay;
@synthesize canSelectAfterDays = _canSelectAfterDays;
@synthesize daysMargin = _daysMargin;
@synthesize daysHeight = _daysHeight;
@synthesize daysSpacing = _daysSpacing;
@synthesize beginDate = _beginDate;
@synthesize endDate = _endDate;
@synthesize displayBeginDate = _displayBeginDate;
@synthesize displayEndDate = _displayEndDate;
@synthesize monthItem = _monthItem;
@synthesize weekdayItems = _weekdayItems;
@synthesize dayItems = _dayItems;

#pragma mark - Init / Free

+ (instancetype)containerWithCalendar:(NSCalendar*)calendar {
    return [[self alloc] initWithCalendar:calendar];
}

- (instancetype)initWithCalendar:(NSCalendar*)calendar {
    self = [super init];
    if(self != nil) {
        _calendar = calendar;
        _canShowMonth = YES;
        _canSelectMonth = NO;
        _monthMargin = UIEdgeInsetsZero;
        _monthHeight = 64.0f;
        _monthSpacing = 0.0f;
        _canShowWeekdays = YES;
        _canSelectWeekdays = NO;
        _weekdaysMargin = UIEdgeInsetsZero;
        _weekdaysHeight = 21.0f;
        _weekdaysSpacing = UIOffsetZero;
        _canShowDays = YES;
        _canSelectDays = YES;
        _canSelectPreviousDays = NO;
        _canSelectNextDays = NO;
        _canSelectEarlierDays = YES;
        _canSelectCurrentDay = YES;
        _canSelectAfterDays = YES;
        _daysMargin = UIEdgeInsetsZero;
        _daysHeight = 44.0f;
        _daysSpacing = UIOffsetZero;
        _weekdayItems = NSMutableArray.array;
        _dayItems = GLBMutableGrid.grid;
    }
    return self;
}

#pragma mark - Property

- (void)setCanShowMonth:(BOOL)canShowMonth {
    if(_canShowMonth != canShowMonth) {
        _canShowMonth = canShowMonth;
        if(_dataView != nil) {
            [_dataView setNeedValidateLayout];
        }
    }
}

- (void)setCanSelectMonth:(BOOL)canSelectMonth {
    if(_canSelectMonth != canSelectMonth) {
        _canSelectMonth = canSelectMonth;
        if(_monthItem != nil) {
            _monthItem.allowsSelection = _canSelectMonth;
        }
    }
}

- (void)setMonthMargin:(UIEdgeInsets)monthMargin {
    if(UIEdgeInsetsEqualToEdgeInsets(_monthMargin, monthMargin) == NO) {
        _monthMargin = monthMargin;
        if(_dataView != nil) {
            [_dataView setNeedValidateLayout];
        }
    }
}

- (void)setMonthHeight:(CGFloat)monthHeight {
    if(_monthHeight != monthHeight) {
        _monthHeight = monthHeight;
        if(_dataView != nil) {
            [_dataView setNeedValidateLayout];
        }
    }
}

- (void)setMonthSpacing:(CGFloat)monthSpacing {
    if(_monthSpacing != monthSpacing) {
        _monthSpacing = monthSpacing;
        if(_dataView != nil) {
            [_dataView setNeedValidateLayout];
        }
    }
}

- (void)setCanShowWeekdays:(BOOL)canShowWeekdays {
    if(_canShowWeekdays != canShowWeekdays) {
        _canShowWeekdays = canShowWeekdays;
        if(_dataView != nil) {
            [_dataView setNeedValidateLayout];
        }
    }
}

- (void)setCanSelectWeekdays:(BOOL)canSelectWeekdays {
    if(_canSelectWeekdays != canSelectWeekdays) {
        _canSelectWeekdays = canSelectWeekdays;
        [_weekdayItems glb_each:^(GLBDataViewCalendarWeekdayItem* weekdayItem) {
            weekdayItem.allowsSelection = _canSelectWeekdays;
        }];
    }
}

- (void)setWeekdaysMargin:(UIEdgeInsets)weekdaysMargin {
    if(UIEdgeInsetsEqualToEdgeInsets(_weekdaysMargin, weekdaysMargin) == NO) {
        _weekdaysMargin = weekdaysMargin;
        if(_dataView != nil) {
            [_dataView setNeedValidateLayout];
        }
    }
}

- (void)setWeekdaysHeight:(CGFloat)weekdaysHeight {
    if(_weekdaysHeight != weekdaysHeight) {
        _weekdaysHeight = weekdaysHeight;
        if(_dataView != nil) {
            [_dataView setNeedValidateLayout];
        }
    }
}

- (void)setWeekdaysSpacing:(UIOffset)weekdaysSpacing {
    if(UIOffsetEqualToOffset(_weekdaysSpacing, weekdaysSpacing) == NO) {
        _weekdaysSpacing = weekdaysSpacing;
        if(_dataView != nil) {
            [_dataView setNeedValidateLayout];
        }
    }
}

- (void)setCanShowDays:(BOOL)canShowDays {
    if(_canShowDays != canShowDays) {
        _canShowDays = canShowDays;
        if(_dataView != nil) {
            [_dataView setNeedValidateLayout];
        }
    }
}

- (void)setCanSelectDays:(BOOL)canSelectDays {
    if(_canSelectDays != canSelectDays) {
        _canSelectDays = canSelectDays;
        [_weekdayItems glb_each:^(GLBDataViewCalendarWeekdayItem* dayItem) {
            if(([dayItem.date glb_isAfterOrSame:_beginDate] == YES) && ([dayItem.date glb_isEarlierOrSame:_endDate] == YES)) {
                dayItem.allowsSelection = _canSelectDays;
            }
        }];
    }
}

- (void)setCanSelectPreviousDays:(BOOL)canSelectPreviousDays {
    if(_canSelectPreviousDays != canSelectPreviousDays) {
        _canSelectPreviousDays = canSelectPreviousDays;
        [_weekdayItems glb_each:^(GLBDataViewCalendarWeekdayItem* dayItem) {
            if([dayItem.date glb_isAfter:_endDate] == YES) {
                dayItem.allowsSelection = _canSelectNextDays;
            }
        }];
    }
}

- (void)setCanSelectNextDays:(BOOL)canSelectNextDays {
    if(_canSelectNextDays != canSelectNextDays) {
        _canSelectNextDays = canSelectNextDays;
        [_weekdayItems glb_each:^(GLBDataViewCalendarWeekdayItem* dayItem) {
            if([dayItem.date glb_isEarlier:_beginDate] == YES) {
                dayItem.allowsSelection = _canSelectPreviousDays;
            }
        }];
    }
}

- (void)setCanSelectEarlierDays:(BOOL)canSelectEarlierDays {
    if(_canSelectEarlierDays != canSelectEarlierDays) {
        _canSelectEarlierDays = canSelectEarlierDays;
        
        NSDate* now = NSDate.date.glb_withoutTime;
        [_weekdayItems glb_each:^(GLBDataViewCalendarWeekdayItem* dayItem) {
            if([dayItem.date glb_isEarlier:now] == YES) {
                dayItem.allowsSelection = _canSelectEarlierDays;
            }
        }];
    }
}

- (void)setCanSelectAfterDays:(BOOL)canSelectAfterDays {
    if(_canSelectAfterDays != canSelectAfterDays) {
        _canSelectAfterDays = canSelectAfterDays;
        
        NSDate* now = NSDate.date.glb_withoutTime;
        [_weekdayItems glb_each:^(GLBDataViewCalendarWeekdayItem* dayItem) {
            if([dayItem.date glb_isAfter:now] == YES) {
                dayItem.allowsSelection = _canSelectAfterDays;
            }
        }];
    }
}

- (void)setDaysMargin:(UIEdgeInsets)daysMargin {
    if(UIEdgeInsetsEqualToEdgeInsets(_daysMargin, daysMargin) == NO) {
        _daysMargin = daysMargin;
        if(_dataView != nil) {
            [_dataView setNeedValidateLayout];
        }
    }
}

- (void)setDaysHeight:(CGFloat)daysHeight {
    if(_daysHeight != daysHeight) {
        _daysHeight = daysHeight;
        if(_dataView != nil) {
            [_dataView setNeedValidateLayout];
        }
    }
}

- (void)setDaysSpacing:(UIOffset)daysSpacing {
    if(UIOffsetEqualToOffset(_daysSpacing, daysSpacing) == NO) {
        _daysSpacing = daysSpacing;
        if(_dataView != nil) {
            [_dataView setNeedValidateLayout];
        }
    }
}

#pragma mark - Public

- (GLBDataViewCalendarWeekdayItem*)weekdayItemForDate:(NSDate*)date {
    NSDateComponents* dateComponents = [_calendar components:NSCalendarUnitWeekday fromDate:date];
    for(GLBDataViewCalendarWeekdayItem* weekdayItem in _weekdayItems) {
        NSDateComponents* weekdayComponents = [_calendar components:NSCalendarUnitWeekday fromDate:weekdayItem.date];
        if(weekdayComponents.weekday == dateComponents.weekday) {
            return weekdayItem;
        }
    }
    return nil;
}

- (GLBDataViewCalendarDayItem*)dayItemForDate:(NSDate*)date {
    NSDate* beginDate = date.glb_beginningOfDay;
    __block GLBDataViewCalendarDayItem* result = nil;
    [_dayItems enumerateColumnsRowsUsingBlock:^(GLBDataViewCalendarDayItem* dayItem, NSUInteger column __unused, NSUInteger row __unused, BOOL* stopColumn, BOOL* stopRow) {
        if([dayItem.date isEqualToDate:beginDate] == YES) {
            result = dayItem;
            *stopColumn = YES;
            *stopRow = YES;
        }
    }];
    return result;
}

- (void)prepareBeginDate:(NSDate*)beginDate endDate:(NSDate*)endDate {
    [self prepareBeginDate:beginDate endDate:endDate monthBlock:^id(NSDate* monthBeginDate, NSDate* monthEndDate) {
        return [NSNull null];
    } weekdayBlock:^id(NSDate* date, NSUInteger index) {
        return [NSNull null];
    } dayBlock:^id(NSDate* date) {
        return [NSNull null];
    }];
}

- (void)prepareBeginDate:(NSDate*)beginDate endDate:(NSDate*)endDate dayBlock:(GLBDataContainerCalendarDayCreateBlock)dayBlock {
    [self prepareBeginDate:beginDate endDate:endDate monthBlock:^id(NSDate* monthBeginDate, NSDate* monthEndDate) {
        return [NSNull null];
    } weekdayBlock:^id(NSDate* date, NSUInteger index) {
        return [NSNull null];
    } dayBlock:dayBlock];
}

- (void)prepareBeginDate:(NSDate*)beginDate endDate:(NSDate*)endDate monthBlock:(GLBDataContainerCalendarMonthCreateBlock)monthBlock weekdayBlock:(GLBDataContainerCalendarWeekdayCreateBlock)weekdayBlock dayBlock:(GLBDataContainerCalendarDayCreateBlock)dayBlock {
    if(([_beginDate isEqualToDate:beginDate] == NO) || ([_endDate isEqualToDate:endDate] == NO)) {
        [self cleanup];
        _beginDate = beginDate;
        _displayBeginDate = _beginDate.glb_beginningOfWeek;
        _endDate = endDate;
        _displayEndDate = endDate.glb_endOfWeek;
        if(_canShowMonth == YES) {
            _monthItem = [GLBDataViewCalendarMonthItem itemWithCalendar:_calendar beginDate:_beginDate endDate:_endDate displayBeginDate:_displayBeginDate displayEndDate:_displayEndDate data:monthBlock(_beginDate, _endDate)];
            _monthItem.allowsSelection = _canSelectMonth;
            [super appendEntry:_monthItem];
        }
        if(_canShowWeekdays == YES) {
            NSDate* weekdayDate = _beginDate.glb_beginningOfWeek;
            for(NSUInteger weekdayIndex = 0; weekdayIndex < 7; weekdayIndex++) {
                GLBDataViewCalendarWeekdayItem* weekdayItem;
                if(_canShowMonth == YES) {
                    weekdayItem = [GLBDataViewCalendarWeekdayItem itemWithMonthItem:_monthItem date:weekdayDate data:weekdayBlock(weekdayDate, weekdayIndex)];
                } else {
                    weekdayItem = [GLBDataViewCalendarWeekdayItem itemWithCalendar:_calendar date:weekdayDate data:weekdayBlock(weekdayDate, weekdayIndex)];
                }
                weekdayItem.allowsSelection = _canSelectWeekdays;
                [_weekdayItems addObject:weekdayItem];
                [super appendEntry:weekdayItem];
                weekdayDate = weekdayDate.glb_nextDay;
            }
        }
        if(_canShowDays == YES) {
            NSDate* now = NSDate.date.glb_withoutTime;
            NSDate* beginDayDate = [_displayBeginDate copy];
            NSDate* endDayDate = [_displayEndDate copy];
            NSInteger weekOfMonth = [beginDayDate glb_weeksToDate:endDayDate.glb_nextSecond];
            if(weekOfMonth > 0) {
                [_dayItems setNumberOfColumns:7 numberOfRows:weekOfMonth];
                for(NSUInteger weekIndex = 0; weekIndex < (NSUInteger)weekOfMonth; weekIndex++) {
                    for(NSUInteger weekdayIndex = 0; weekdayIndex < 7; weekdayIndex++) {
                        GLBDataViewCalendarDayItem* dayItem;
                        if(_canShowWeekdays == YES) {
                            dayItem = [GLBDataViewCalendarDayItem itemWithWeekdayItem:_weekdayItems[weekdayIndex] date:beginDayDate data:dayBlock(beginDayDate)];
                        } else {
                            dayItem = [GLBDataViewCalendarDayItem itemWithCalendar:_calendar date:beginDayDate data:dayBlock(beginDayDate)];
                        }
                        if([dayItem.date glb_isEarlier:_beginDate] == YES) {
                            dayItem.allowsSelection = (_canSelectDays == YES) ? _canSelectPreviousDays : _canSelectDays;
                        } else if([dayItem.date glb_isAfter:_endDate] == YES) {
                            dayItem.allowsSelection = (_canSelectDays == YES) ? _canSelectNextDays : _canSelectDays;
                        } else {
                            if([dayItem.date glb_isEarlier:now] == YES) {
                                dayItem.allowsSelection = (_canSelectDays == YES) ? _canSelectEarlierDays : _canSelectDays;
                            } else if([dayItem.date glb_isAfter:now] == YES) {
                                dayItem.allowsSelection = (_canSelectDays == YES) ? _canSelectAfterDays : _canSelectDays;
                            } else {
                                dayItem.allowsSelection = (_canSelectDays == YES) ? _canSelectCurrentDay : _canSelectDays;
                            }
                        }
                        [_dayItems setObject:dayItem atColumn:weekdayIndex atRow:weekIndex];
                        [super appendEntry:dayItem];
                        beginDayDate = beginDayDate.glb_nextDay;
                    }
                }
            }
        }
    }
}

- (void)replaceDate:(NSDate*)date data:(id)data {
    __block NSUInteger foundColumn = NSNotFound, foundRow = NSNotFound;
    [_dayItems enumerateColumnsRowsUsingBlock:^(GLBDataViewCalendarDayItem* day, NSUInteger column, NSUInteger row, BOOL* stopColumn, BOOL* stopRow) {
        if([day.date isEqualToDate:date] == YES) {
            foundColumn = column;
            foundRow = row;
            *stopColumn = YES;
            *stopRow = YES;
        }
    }];
    if((foundColumn != NSNotFound) && (foundRow != NSNotFound)) {
        GLBDataViewCalendarDayItem* oldDayItem = [_dayItems objectAtColumn:foundColumn atRow:foundRow];
        GLBDataViewCalendarDayItem* newDayItem;
        if(oldDayItem.weekdayItem != nil) {
            newDayItem = [GLBDataViewCalendarDayItem itemWithWeekdayItem:oldDayItem.weekdayItem date:date data:data];
        } else {
            newDayItem = [GLBDataViewCalendarDayItem itemWithCalendar:oldDayItem.calendar date:date data:data];
        }
        newDayItem.allowsSelection = oldDayItem.allowsSelection;
        [_dayItems setObject:newDayItem atColumn:foundColumn atRow:foundRow];
        [super replaceOriginEntry:oldDayItem withEntry:newDayItem];
    }
}

- (void)cleanup {
    if(_monthItem != nil) {
        [super deleteEntry:_monthItem];
        _monthItem = nil;
    }
    if(_weekdayItems.count > 0) {
        [super deleteEntries:_weekdayItems];
        [_weekdayItems removeAllObjects];
    }
    if(_dayItems.count > 0) {
        [super deleteEntries:_dayItems.objects];
        [_dayItems removeAllObjects];
    }
    _beginDate = nil;
    _endDate = nil;
}

- (void)eachDayItemsWithWeekdayItem:(GLBDataViewCalendarWeekdayItem*)weekdayItem block:(GLBDataContainerCalendarEachDayItemsBlock)block {
    NSUInteger weekdayIndex = [_weekdayItems indexOfObject:weekdayItem];
    if(weekdayIndex != NSNotFound) {
        [_dayItems each:^(GLBDataViewCalendarDayItem* dayItem, NSUInteger column __unused, NSUInteger row __unused) {
            block(dayItem);
        } byColumn:weekdayIndex];
    }
}

- (void)eachWeekdayByDayItem:(GLBDataViewCalendarDayItem*)dayItem block:(GLBDataContainerCalendarEachDayItemsBlock)block {
    NSUInteger dayIndex = NSNotFound;
    [_dayItems findObjectUsingBlock:^BOOL(GLBDataViewCalendarDayItem* item) {
        return dayItem == item;
    } inColumn:&dayIndex inRow:NULL];
    if(dayIndex != NSNotFound) {
        [_dayItems each:^(GLBDataViewCalendarDayItem* item, NSUInteger column, NSUInteger row) {
            block(item);
        } byColumn:dayIndex];
    }
}

- (void)eachWeekByDayItem:(GLBDataViewCalendarDayItem*)dayItem block:(GLBDataContainerCalendarEachDayItemsBlock)block {
    NSUInteger weekIndex = NSNotFound;
    [_dayItems findObjectUsingBlock:^BOOL(GLBDataViewCalendarDayItem* item) {
        return dayItem == item;
    } inColumn:NULL inRow:&weekIndex];
    if(weekIndex != NSNotFound) {
        [_dayItems each:^(GLBDataViewCalendarDayItem* item, NSUInteger column, NSUInteger row) {
            block(item);
        } byRow:weekIndex];
    }
}

#pragma mark - Public override

- (CGRect)frameEntriesForAvailableFrame:(CGRect)frame {
    BOOL canShowMonth = _canShowMonth;
    UIEdgeInsets monthMargin = (canShowMonth == YES) ? _monthMargin : UIEdgeInsetsZero;
    CGFloat monthHeight = (canShowMonth == YES) ? _monthHeight - (monthMargin.top + monthMargin.bottom) : 0.0f;
    CGFloat monthSpacing = (canShowMonth == YES) ? _monthSpacing : 0.0f;
    BOOL canShowWeekdays = _canShowWeekdays;
    UIEdgeInsets weekdaysMargin = (canShowWeekdays == YES) ? _weekdaysMargin : UIEdgeInsetsZero;
    CGFloat weekdaysHeight = (canShowWeekdays == YES) ? _weekdaysHeight - (weekdaysMargin.top + weekdaysMargin.bottom) : 0.0f;
    UIOffset weekdaysSpacing = (canShowWeekdays == YES) ? _weekdaysSpacing : UIOffsetZero;
    BOOL canShowDays = _canShowDays;
    UIEdgeInsets daysMargin = (canShowDays == YES) ? _daysMargin : UIEdgeInsetsZero;
    CGFloat daysHeight = (canShowDays == YES) ? _daysHeight - (daysMargin.top + daysMargin.bottom) : 0.0f;
    UIOffset daysSpacing = (canShowDays == YES) ? _daysSpacing : UIOffsetZero;
    CGFloat monthWidth = frame.size.width - (monthMargin.left + monthMargin.right);
    __block CGSize cumulative = CGSizeMake(monthWidth, 0.0f);
    
    if(canShowMonth == YES) {
        cumulative.height += monthHeight;
    }
    if(canShowWeekdays == YES) {
        NSUInteger lastIndex = _weekdayItems.count - 1;
        cumulative.height += weekdaysMargin.top;
        [_weekdayItems glb_eachWithIndex:^(GLBDataViewCalendarWeekdayItem* weekdayItem, NSUInteger index) {
            if(index == lastIndex) {
                cumulative.height += weekdaysHeight + weekdaysSpacing.vertical;
            }
        }];
        cumulative.height += weekdaysMargin.bottom - weekdaysSpacing.vertical;
    }
    if(canShowDays == YES) {
        NSUInteger lastColumn = _dayItems.numberOfColumns - 1;
        cumulative.height += daysMargin.top;
        [_dayItems eachRowsColumns:^(GLBDataViewCalendarDayItem* dayItem, NSUInteger column, NSUInteger row __unused) {
            if(column == lastColumn) {
                cumulative.height += daysHeight + daysSpacing.vertical;
            }
        }];
        cumulative.height += daysMargin.bottom - daysSpacing.vertical;
    }
    if(canShowMonth == YES) {
        cumulative.height += monthMargin.bottom - monthSpacing;
    }
    return CGRectMake(frame.origin.x, frame.origin.y, monthMargin.left + cumulative.width + monthMargin.right, monthMargin.top + cumulative.height + monthMargin.bottom);
}

- (void)layoutEntriesForFrame:(CGRect)frame {
    BOOL canShowMonth = _canShowMonth;
    UIEdgeInsets monthMargin = (canShowMonth == YES) ? _monthMargin : UIEdgeInsetsZero;
    CGFloat monthHeight = (canShowMonth == YES) ? _monthHeight - (monthMargin.top + monthMargin.bottom) : 0.0f;
    BOOL canShowWeekdays = _canShowWeekdays;
    UIEdgeInsets weekdaysMargin = (canShowWeekdays == YES) ? _weekdaysMargin : UIEdgeInsetsZero;
    CGFloat weekdaysHeight = (canShowWeekdays == YES) ? _weekdaysHeight - (weekdaysMargin.top + weekdaysMargin.bottom) : 0.0f;
    UIOffset weekdaysSpacing = (canShowWeekdays == YES) ? _weekdaysSpacing : UIOffsetZero;
    BOOL canShowDays = _canShowDays;
    UIEdgeInsets daysMargin = (canShowDays == YES) ? _daysMargin : UIEdgeInsetsZero;
    CGFloat daysHeight = (canShowDays == YES) ? _daysHeight - (daysMargin.top + daysMargin.bottom) : 0.0f;
    UIOffset daysSpacing = (canShowDays == YES) ? _daysSpacing : UIOffsetZero;
    CGFloat monthWidth = frame.size.width - (monthMargin.left + monthMargin.right);
    CGFloat availableWeekdaysWidth = monthWidth - (weekdaysMargin.left + weekdaysMargin.right) - (weekdaysSpacing.horizontal * 6);
    CGFloat defaultWeekdaysWidth = GLB_FLOOR(availableWeekdaysWidth / 7);
    CGFloat lastWeekdaysWidth = availableWeekdaysWidth - (defaultWeekdaysWidth * 6);
    CGFloat availableDaysWidth = monthWidth - (daysMargin.left + daysMargin.right) - (daysSpacing.horizontal * 6);
    CGFloat defaultDaysWidth = GLB_FLOOR(availableDaysWidth / 7);
    CGFloat lastDaysWidth = availableDaysWidth - (defaultDaysWidth * 6);
    __block CGPoint offset = CGPointMake(frame.origin.x + monthMargin.left, frame.origin.y + monthMargin.top);
    __block CGSize cumulative = CGSizeMake(monthWidth, 0.0f);
    
    if(canShowMonth == YES) {
        _monthItem.updateFrame = CGRectMake(offset.x, offset.y, monthWidth, monthHeight);
        cumulative.height += monthHeight;
        offset.y += monthHeight;
    }
    if(canShowWeekdays == YES) {
        NSUInteger lastIndex = _weekdayItems.count - 1;
        __block CGFloat weekdayOffset = offset.x + weekdaysMargin.left;
        cumulative.height += weekdaysMargin.top;
        offset.y += weekdaysMargin.top;
        [_weekdayItems glb_eachWithIndex:^(GLBDataViewCalendarWeekdayItem* weekdayItem, NSUInteger index) {
            if(index != lastIndex) {
                weekdayItem.updateFrame = CGRectMake(weekdayOffset, offset.y, defaultWeekdaysWidth, weekdaysHeight);
                weekdayOffset += defaultWeekdaysWidth + weekdaysSpacing.horizontal;
            } else {
                weekdayItem.updateFrame = CGRectMake(weekdayOffset, offset.y, lastWeekdaysWidth, weekdaysHeight);
                cumulative.height += weekdaysHeight + weekdaysSpacing.vertical;
                offset.y += weekdaysHeight + weekdaysSpacing.vertical;
            }
        }];
        cumulative.height += weekdaysMargin.bottom - weekdaysSpacing.vertical;
        offset.y += weekdaysMargin.bottom - weekdaysSpacing.vertical;
    }
    if(canShowDays == YES) {
        NSUInteger lastColumn = _dayItems.numberOfColumns - 1;
        __block CGFloat dayOffset = offset.x + daysMargin.left;
        cumulative.height += daysMargin.top;
        offset.y += daysMargin.top;
        [_dayItems eachRowsColumns:^(GLBDataViewCalendarDayItem* dayItem, NSUInteger column, NSUInteger row __unused) {
            if(column != lastColumn) {
                dayItem.updateFrame = CGRectMake(dayOffset, offset.y, defaultDaysWidth, daysHeight);
                dayOffset += defaultDaysWidth + daysSpacing.horizontal;
            } else {
                dayItem.updateFrame = CGRectMake(dayOffset, offset.y, lastDaysWidth, daysHeight);
                cumulative.height += daysHeight + daysSpacing.vertical;
                offset.y += daysHeight + daysSpacing.vertical;
                dayOffset = offset.x + daysMargin.left;
            }
        }];
        cumulative.height += daysMargin.bottom - daysSpacing.vertical;
        offset.y += daysMargin.bottom - daysSpacing.vertical;
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
