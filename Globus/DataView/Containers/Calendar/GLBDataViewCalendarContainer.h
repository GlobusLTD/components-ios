/*--------------------------------------------------*/

#import "GLBDataViewItemsContainer.h"
#import "GLBDataViewCalendarItem.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef __kindof GLBDataViewCalendarMonthItem* _Nonnull (^GLBDataContainerCalendarMonthCreateBlock)(NSDate* _Nonnull beginDate, NSDate* _Nonnull endDate);
typedef __kindof GLBDataViewCalendarWeekdayItem* _Nonnull (^GLBDataContainerCalendarWeekdayCreateBlock)(NSDate* _Nonnull date, NSUInteger index);
typedef __kindof GLBDataViewCalendarDayItem* _Nonnull (^GLBDataContainerCalendarDayCreateBlock)(NSDate* _Nonnull date);

typedef void (^GLBDataContainerCalendarEachDayItemsBlock)(GLBDataViewCalendarDayItem* _Nonnull dayItem);

/*--------------------------------------------------*/

@interface GLBDataViewCalendarContainer : GLBDataViewItemsContainer

@property(nonatomic, nonnull, readonly, strong) NSCalendar* calendar;
@property(nonatomic, nonnull, readonly, strong) NSDate* beginDate;
@property(nonatomic, nonnull, readonly, strong) NSDate* endDate;
@property(nonatomic, nonnull, readonly, strong) NSDate* displayBeginDate;
@property(nonatomic, nonnull, readonly, strong) NSDate* displayEndDate;

@property(nonatomic) BOOL canShowMonth;
@property(nonatomic) BOOL canSelectMonth;
@property(nonatomic) UIEdgeInsets monthMargin;
@property(nonatomic) CGFloat monthHeight;
@property(nonatomic) CGFloat monthSpacing;

@property(nonatomic) BOOL canShowWeekdays;
@property(nonatomic) BOOL canSelectWeekdays;
@property(nonatomic) UIEdgeInsets weekdaysMargin;
@property(nonatomic) CGFloat weekdaysHeight;
@property(nonatomic) UIOffset weekdaysSpacing;

@property(nonatomic) BOOL canShowDays;
@property(nonatomic) BOOL canSelectDays;
@property(nonatomic) BOOL canSelectPreviousDays;
@property(nonatomic) BOOL canSelectNextDays;
@property(nonatomic) BOOL canSelectEarlierDays;
@property(nonatomic) BOOL canSelectCurrentDay;
@property(nonatomic) BOOL canSelectAfterDays;
@property(nonatomic) UIEdgeInsets daysMargin;
@property(nonatomic) CGFloat daysHeight;
@property(nonatomic) UIOffset daysSpacing;

+ (nonnull instancetype)containerWithCalendar:(nonnull NSCalendar*)calendar NS_SWIFT_UNAVAILABLE("Use init(calendar:)");

- (nonnull instancetype)initWithCalendar:(nonnull NSCalendar*)calendar;

- (nullable __kindof GLBDataViewCalendarWeekdayItem*)weekdayItemForDate:(nonnull NSDate*)date;
- (nullable __kindof GLBDataViewCalendarDayItem*)dayItemForDate:(nonnull NSDate*)date;

- (void)prepareBeginDate:(nonnull NSDate*)beginDate endDate:(nonnull NSDate*)endDate;
- (void)prepareBeginDate:(nonnull NSDate*)beginDate endDate:(nonnull NSDate*)endDate dayBlock:(nullable GLBDataContainerCalendarDayCreateBlock)dayBlock;
- (void)prepareBeginDate:(nonnull NSDate*)beginDate endDate:(nonnull NSDate*)endDate monthBlock:(nullable GLBDataContainerCalendarMonthCreateBlock)monthBlock weekdayBlock:(nullable GLBDataContainerCalendarWeekdayCreateBlock)weekdayBlock dayBlock:(nullable GLBDataContainerCalendarDayCreateBlock)dayBlock;
- (void)replaceDate:(nonnull NSDate*)date data:(nullable id)data;
- (void)cleanup;

- (void)eachDayItemsWithWeekdayItem:(nonnull GLBDataViewCalendarWeekdayItem*)weekdayItem block:(nonnull GLBDataContainerCalendarEachDayItemsBlock)block;
- (void)eachWeekdayByDayItem:(nonnull GLBDataViewCalendarDayItem*)dayItem block:(nonnull GLBDataContainerCalendarEachDayItemsBlock)block;
- (void)eachWeekByDayItem:(nonnull GLBDataViewCalendarDayItem*)dayItem block:(nonnull GLBDataContainerCalendarEachDayItemsBlock)block;

@end

/*--------------------------------------------------*/

@interface GLBDataViewCalendarContainer (Unavailable)

- (void)prependItem:(nonnull GLBDataViewItem*)item NS_UNAVAILABLE;
- (void)prependItems:(nonnull NSArray*)items NS_UNAVAILABLE;
- (void)appendItem:(nonnull GLBDataViewItem*)item NS_UNAVAILABLE;
- (void)appendItems:(nonnull NSArray*)items NS_UNAVAILABLE;
- (void)insertItem:(nonnull GLBDataViewItem*)item atIndex:(NSUInteger)index NS_UNAVAILABLE;
- (void)insertItems:(nonnull NSArray*)items atIndex:(NSUInteger)index NS_UNAVAILABLE;
- (void)insertItem:(nonnull GLBDataViewItem*)item aboveItem:(nonnull GLBDataViewItem*)aboveItem NS_UNAVAILABLE;
- (void)insertItems:(nonnull NSArray*)items aboveItem:(nonnull GLBDataViewItem*)aboveItem NS_UNAVAILABLE;
- (void)insertItem:(nonnull GLBDataViewItem*)item belowItem:(nonnull GLBDataViewItem*)belowItem NS_UNAVAILABLE;
- (void)insertItems:(nonnull NSArray*)items belowItem:(nonnull GLBDataViewItem*)belowItem NS_UNAVAILABLE;
- (void)replaceOriginItem:(nonnull GLBDataViewItem*)originItem withItem:(nonnull GLBDataViewItem*)item NS_UNAVAILABLE;
- (void)replaceOriginItems:(nonnull NSArray*)originItems withItems:(nonnull NSArray*)items NS_UNAVAILABLE;
- (void)deleteItem:(nonnull GLBDataViewItem*)item NS_UNAVAILABLE;
- (void)deleteItems:(nonnull NSArray*)items NS_UNAVAILABLE;
- (void)deleteAllItems NS_UNAVAILABLE;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
