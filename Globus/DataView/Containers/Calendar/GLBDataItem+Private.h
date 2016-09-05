/*--------------------------------------------------*/

#import "GLBDataItem.h"
#import "GLBDataView+Private.h"
#import "GLBDataContainer+Private.h"
#import "GLBDataCell+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataItem () {
@protected
    __weak GLBDataView* _view;
    __weak GLBDataContainer* _parent;
    NSString* _identifier;
    NSUInteger _order;
    id _data;
    CGSize _size;
    BOOL _needResize;
    CGRect _originFrame;
    CGRect _updateFrame;
    CGRect _displayFrame;
    CGRect _frame;
    BOOL _hidden;
    BOOL _allowsAlign;
    BOOL _allowsPressed;
    BOOL _allowsLongPressed;
    BOOL _allowsSelection;
    BOOL _allowsHighlighting;
    BOOL _allowsEditing;
    BOOL _allowsMoving;
    BOOL _persistent;
    BOOL _selected;
    BOOL _highlighted;
    BOOL _editing;
    GLBDataCell* _cell;
}

@property(nonatomic, weak) GLBDataView* view;
@property(nonatomic, weak) GLBDataContainer* parent;
@property(nonatomic, strong) NSString* identifier;
@property(nonatomic) BOOL needResize;
@property(nonatomic, getter=isMoving) BOOL moving;
@property(nonatomic, strong) GLBDataCell* cell;

@end

/*--------------------------------------------------*/

@interface GLBDataItemCalendar  () {
@protected
    __weak NSCalendar* _calendar;
}

- (instancetype)initWithIdentifier:(NSString*)identifier order:(NSUInteger)order calendar:(NSCalendar*)calendar data:(id)data;

@end

/*--------------------------------------------------*/

@interface GLBDataItemCalendarMonth  () {
@protected
    NSDate* _beginDate;
    NSDate* _endDate;
    NSDate* _displayBeginDate;
    NSDate* _displayEndDate;
}

+ (instancetype)itemWithCalendar:(NSCalendar*)calendar beginDate:(NSDate*)beginDate endDate:(NSDate*)endDate displayBeginDate:(NSDate*)displayBeginDate displayEndDate:(NSDate*)displayEndDate data:(id)data;

- (instancetype)initWithCalendar:(NSCalendar*)calendar beginDate:(NSDate*)beginDate endDate:(NSDate*)endDate displayBeginDate:(NSDate*)displayBeginDate displayEndDate:(NSDate*)displayEndDate data:(id)data;

@end

/*--------------------------------------------------*/

@interface GLBDataItemCalendarWeekday () {
@protected
    __weak GLBDataItemCalendarMonth* _monthItem;
    NSDate* _date;
}

+ (instancetype)itemWithCalendar:(NSCalendar*)calendar date:(NSDate*)date data:(id)data;
+ (instancetype)itemWithMonthItem:(GLBDataItemCalendarMonth*)monthItem date:(NSDate*)date data:(id)data;

- (instancetype)initWithCalendar:(NSCalendar*)calendar date:(NSDate*)date data:(id)data;
- (instancetype)initWithMonthItem:(GLBDataItemCalendarMonth*)monthItem date:(NSDate*)date data:(id)data;

@end

/*--------------------------------------------------*/

@interface GLBDataItemCalendarDay () {
@protected
    __weak GLBDataItemCalendarMonth* _monthItem;
    __weak GLBDataItemCalendarWeekday* _weekdayItem;
    NSDate* _date;
}

+ (instancetype)itemWithCalendar:(NSCalendar*)calendar date:(NSDate*)date data:(id)data;
+ (instancetype)itemWithWeekdayItem:(GLBDataItemCalendarWeekday*)weekdayItem date:(NSDate*)date data:(id)data;

- (instancetype)initWithCalendar:(NSCalendar*)calendar date:(NSDate*)date data:(id)data;
- (instancetype)initWithWeekdayItem:(GLBDataItemCalendarWeekday*)weekdayItem date:(NSDate*)date data:(id)data;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
