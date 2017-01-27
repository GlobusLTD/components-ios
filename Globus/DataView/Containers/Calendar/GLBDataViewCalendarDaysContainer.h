/*--------------------------------------------------*/

#import "GLBDataViewItemsContainer.h"
#import "GLBDataViewCalendarItem.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewCalendarDaysContainer : GLBDataViewItemsContainer

@property(nonatomic, nonnull, readonly, strong) NSCalendar* calendar;

@property(nonatomic) GLBDataViewContainerOrientation orientation;
@property(nonatomic) UIEdgeInsets margin;
@property(nonatomic) UIOffset spacing;
@property(nonatomic) CGSize defaultSize;
@property(nonatomic, nonnull, readonly, strong) NSArray< GLBDataViewCalendarDayItem* >* days;

+ (nonnull instancetype)containerWithCalendar:(nonnull NSCalendar*)calendar orientation:(GLBDataViewContainerOrientation)orientation;

- (nonnull instancetype)initWithCalendar:(nonnull NSCalendar*)calendar orientation:(GLBDataViewContainerOrientation)orientation;

- (nullable __kindof GLBDataViewCalendarDayItem*)dayItemForDate:(nonnull NSDate*)date;
- (nullable __kindof GLBDataViewCalendarDayItem*)nearestDayItemForDate:(nonnull NSDate*)date;

- (void)prepareBeginDate:(nonnull NSDate*)beginDate endDate:(nonnull NSDate*)endDate interval:(NSTimeInterval)interval data:(nullable id)data;
- (void)prependToDate:(nonnull NSDate*)date interval:(NSTimeInterval)interval data:(nullable id)data;
- (void)prependDate:(nonnull NSDate*)date data:(nullable id)data;
- (void)appendToDate:(nonnull NSDate*)date interval:(NSTimeInterval)interval data:(nullable id)data;
- (void)appendDate:(nonnull NSDate*)date data:(nullable id)data;
- (void)insertDate:(nonnull NSDate*)date data:(nullable id)data atIndex:(NSUInteger)index;
- (void)replaceDate:(nonnull NSDate*)date data:(nullable id)data;
- (void)deleteBeginDate:(nonnull NSDate*)beginDate endDate:(nonnull NSDate*)endDate;
- (void)deleteDate:(nonnull NSDate*)date;
- (void)deleteAllDates;

- (void)scrollToDate:(nonnull NSDate*)date scrollPosition:(GLBDataViewPosition)scrollPosition animated:(BOOL)animated;

@end

/*--------------------------------------------------*/

@interface GLBDataViewCalendarDaysContainer (Unavailable)

- (void)prependEntry:(nonnull GLBDataViewItem*)entry NS_UNAVAILABLE;
- (void)prependEntries:(nonnull NSArray*)entries NS_UNAVAILABLE;
- (void)appendEntry:(nonnull GLBDataViewItem*)entry NS_UNAVAILABLE;
- (void)appendEntries:(nonnull NSArray*)entries NS_UNAVAILABLE;
- (void)insertEntry:(nonnull GLBDataViewItem*)entry atIndex:(NSUInteger)index NS_UNAVAILABLE;
- (void)insertEntries:(nonnull NSArray*)entries atIndex:(NSUInteger)index NS_UNAVAILABLE;
- (void)insertEntry:(nonnull GLBDataViewItem*)entry aboveEntry:(nonnull GLBDataViewItem*)aboveEntry NS_UNAVAILABLE;
- (void)insertEntries:(nonnull NSArray*)entries aboveEntry:(nonnull GLBDataViewItem*)aboveEntry NS_UNAVAILABLE;
- (void)insertEntry:(nonnull GLBDataViewItem*)entry belowEntry:(nonnull GLBDataViewItem*)belowEntry NS_UNAVAILABLE;
- (void)insertEntries:(nonnull NSArray*)entries belowEntry:(nonnull GLBDataViewItem*)belowEntry NS_UNAVAILABLE;
- (void)replaceOriginEntry:(nonnull GLBDataViewItem*)originEntry withEntry:(nonnull GLBDataViewItem*)entry NS_UNAVAILABLE;
- (void)replaceOriginEntries:(nonnull NSArray*)originEntries withEntries:(nonnull NSArray*)entries NS_UNAVAILABLE;
- (void)deleteEntry:(nonnull GLBDataViewItem*)entry NS_UNAVAILABLE;
- (void)deleteEntries:(nonnull NSArray*)entries NS_UNAVAILABLE;
- (void)deleteAllEntries NS_UNAVAILABLE;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
