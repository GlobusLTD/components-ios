/*--------------------------------------------------*/

#import "GLBDataContainer+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBDataContainerCalendarDays

#pragma mark - Synthesize

@synthesize calendar = _calendar;
@synthesize orientation = _orientation;
@synthesize margin = _margin;
@synthesize spacing = _spacing;
@synthesize defaultSize = _defaultSize;

#pragma mark - Init / Free

+ (instancetype)containerWithCalendar:(NSCalendar*)calendar orientation:(GLBDataContainerOrientation)orientation {
    return [[self alloc] initWithCalendar:calendar orientation:orientation];
}

- (instancetype)initWithCalendar:(NSCalendar*)calendar orientation:(GLBDataContainerOrientation)orientation {
    self = [super init];
    if(self != nil) {
        if(calendar != nil) {
            _calendar = calendar;
        }
        _orientation = orientation;
    }
    return self;
}

- (void)setup {
    [super setup];
    
    _calendar = NSCalendar.currentCalendar;
    _orientation = GLBDataContainerOrientationVertical;
    _margin = UIEdgeInsetsZero;
    _spacing = UIOffsetZero;
    _defaultSize = CGSizeMake(44.0f, 44.0f);
}

#pragma mark - Property

- (void)setOrientation:(GLBDataContainerOrientation)orientation {
    if(_orientation != orientation) {
        _orientation = orientation;
        if(_view != nil) {
            [_view setNeedValidateLayout];
        }
    }
}

- (void)setMargin:(UIEdgeInsets)margin {
    if(UIEdgeInsetsEqualToEdgeInsets(_margin, margin) == NO) {
        _margin = margin;
        if(_view != nil) {
            [_view setNeedValidateLayout];
        }
    }
}

- (void)setSpacing:(UIOffset)spacing {
    if(UIOffsetEqualToOffset(_spacing, spacing) == NO) {
        _spacing = spacing;
        if(_view != nil) {
            [_view setNeedValidateLayout];
        }
    }
}

- (NSArray*)days {
    return _entries;
}

#pragma mark - Public

- (GLBDataItemCalendarDay*)dayItemForDate:(NSDate*)date {
    for(GLBDataItemCalendarDay* calendarDay in _entries) {
        if([date isEqualToDate:calendarDay.date] == YES) {
            return calendarDay;
        }
    }
    return nil;
}

- (GLBDataItemCalendarDay*)nearestDayItemForDate:(NSDate*)date {
    GLBDataItemCalendarDay* prevCalendarDay = nil;
    for(GLBDataItemCalendarDay* calendarDay in _entries) {
        switch([date compare:calendarDay.date]) {
            case NSOrderedDescending: prevCalendarDay = calendarDay; break;
            case NSOrderedSame: return calendarDay;
            case NSOrderedAscending: if(prevCalendarDay != nil) { return prevCalendarDay; } break;
        }
    }
    return nil;
}

- (void)prepareBeginDate:(NSDate*)beginDate endDate:(NSDate*)endDate interval:(NSTimeInterval)interval data:(id)data {
    NSTimeInterval timeInterval = beginDate.timeIntervalSince1970;
    NSTimeInterval endTimeInterval = endDate.timeIntervalSince1970;
    while(endTimeInterval - timeInterval > 0.0f) {
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        GLBDataItemCalendarDay* calendarDay = [self dayItemForDate:date];
        if(calendarDay == nil) {
            [self appendDate:date data:data];
        }
        timeInterval += interval;
    }
    [_entries sortUsingComparator:^NSComparisonResult(GLBDataItemCalendarDay* calendarDay1, GLBDataItemCalendarDay* calendarDay2) {
        return [calendarDay1.date compare:calendarDay2.date];
    }];
}

- (void)prependToDate:(NSDate*)date interval:(NSTimeInterval)interval data:(id)data {
    [self prepareBeginDate:date endDate:(_entries.count > 0) ? [_entries.firstObject date] : [NSDate date] interval:interval data:data];
}

- (void)prependDate:(NSDate*)date data:(id)data {
    [self _prependEntry:[GLBDataItemCalendarDay itemWithCalendar:_calendar date:date data:data]];
}

- (void)appendToDate:(NSDate*)date interval:(NSTimeInterval)interval data:(id)data {
    [self prepareBeginDate:(_entries.count > 0) ? [_entries.lastObject date] : [NSDate date] endDate:date interval:interval data:data];
}

- (void)appendDate:(NSDate*)date data:(id)data {
    [self _appendEntry:[GLBDataItemCalendarDay itemWithCalendar:_calendar date:date data:data]];
}

- (void)insertDate:(NSDate*)date data:(id)data atIndex:(NSUInteger)index {
    [self _insertEntry:[GLBDataItemCalendarDay itemWithCalendar:_calendar date:date data:data] atIndex:index];
}

- (void)replaceDate:(NSDate*)date data:(id)data {
    NSUInteger index = [_entries indexOfObjectPassingTest:^BOOL(GLBDataItemCalendarDay* calendarDay, NSUInteger index __unused, BOOL* stop __unused) {
        return [calendarDay.date isEqualToDate:date];
    }];
    if(index != NSNotFound) {
        [self _replaceOriginEntry:_entries[index] withEntry:[GLBDataItemCalendarDay itemWithCalendar:_calendar date:date data:data]];
    }
}

- (void)deleteBeginDate:(NSDate*)beginDate endDate:(NSDate*)endDate {
    NSTimeInterval beginTimeInterval = beginDate.timeIntervalSince1970;
    NSTimeInterval endTimeInterval = endDate.timeIntervalSince1970;
    NSIndexSet* indexSet = [_entries indexesOfObjectsPassingTest:^BOOL(GLBDataItemCalendarDay* calendarDay, NSUInteger index __unused, BOOL* stop __unused) {
        NSComparisonResult timeInterval = calendarDay.date.timeIntervalSince1970;
        if((timeInterval >= beginTimeInterval) || (timeInterval <= endTimeInterval)) {
            return YES;
        }
        return NO;
    }];
    if(indexSet.count > 0) {
        [self _deleteEntries:[_entries objectsAtIndexes:indexSet]];
    }
}

- (void)deleteDate:(NSDate*)date {
    NSUInteger index = [_entries indexOfObjectPassingTest:^BOOL(GLBDataItemCalendarDay* calendarDay, NSUInteger index __unused, BOOL* stop __unused) {
        return [calendarDay.date isEqualToDate:date];
    }];
    if(index != NSNotFound) {
        [self _deleteEntry:_entries[index]];
    }
}

- (void)deleteAllDates {
    [self _deleteAllEntries];
}

- (void)scrollToDate:(NSDate*)date scrollPosition:(GLBDataViewPosition)scrollPosition animated:(BOOL)animated {
    GLBDataItem* calendarDay = [self nearestDayItemForDate:date];
    if(calendarDay != nil) {
        [_view scrollToItem:calendarDay scrollPosition:scrollPosition animated:animated];
    }
}

#pragma mark - Private override

- (CGRect)_validateEntriesForAvailableFrame:(CGRect)frame {
    CGPoint offset = CGPointMake(frame.origin.x + _margin.left, frame.origin.y + _margin.top);
    CGSize restriction = CGSizeMake(frame.size.width - (_margin.left + _margin.right), frame.size.height - (_margin.top + _margin.bottom));
    CGSize cumulative = CGSizeZero;
    switch(_orientation) {
        case GLBDataContainerOrientationVertical: {
            cumulative.width = restriction.width;
            for(GLBDataItemCalendarDay* calendarDay in _entries) {
                CGSize entrySize = [calendarDay sizeForAvailableSize:CGSizeMake(restriction.width, (_defaultSize.height > 0) ? _defaultSize.height : FLT_MAX)];
                if((entrySize.width >= FLT_EPSILON) && (entrySize.height >= FLT_EPSILON)) {
                    calendarDay.updateFrame = CGRectMake(offset.x, offset.y + cumulative.height, restriction.width, entrySize.height);
                    cumulative.height += entrySize.height + _spacing.vertical;
                }
            }
            cumulative.height -= _spacing.vertical;
            break;
        }
        case GLBDataContainerOrientationHorizontal: {
            cumulative.height = restriction.height;
            for(GLBDataItemCalendarDay* calendarDay in _entries) {
                CGSize entrySize = [calendarDay sizeForAvailableSize:CGSizeMake((_defaultSize.width > 0) ? _defaultSize.width : FLT_MAX, restriction.height)];
                if((entrySize.width >= FLT_EPSILON) && (entrySize.height >= FLT_EPSILON)) {
                    calendarDay.updateFrame = CGRectMake(offset.x + cumulative.width, offset.y, entrySize.width, restriction.height);
                    cumulative.width += entrySize.width + _spacing.horizontal;
                }
            }
            cumulative.width -= _spacing.horizontal;
            break;
        }
    }
    return CGRectMake(frame.origin.x, frame.origin.y, _margin.left + cumulative.width + _margin.right, _margin.top + cumulative.height + _margin.bottom);
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
