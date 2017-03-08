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
