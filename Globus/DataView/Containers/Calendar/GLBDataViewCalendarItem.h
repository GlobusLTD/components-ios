/*--------------------------------------------------*/

#import "GLBDataViewItem.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewCalendarItem : GLBDataViewItem

@property(nonatomic, nullable, readonly, weak) NSCalendar* calendar;

+ (nonnull instancetype)itemWithIdentifier:(nonnull NSString*)identifier
                                     order:(NSUInteger)order
                        accessibilityOrder:(NSUInteger)accessibilityOrder
                                      data:(nullable id)data NS_UNAVAILABLE;

+ (nonnull instancetype)itemWithCalendar:(nonnull NSCalendar*)calendar
                              identifier:(nonnull NSString*)identifier
                                   order:(NSUInteger)order
                                    data:(nullable id)data NS_SWIFT_UNAVAILABLE("Use init(calendar:identifier:order:data:)");

+ (nonnull instancetype)itemWithCalendar:(nonnull NSCalendar*)calendar
                              identifier:(nonnull NSString*)identifier
                                   order:(NSUInteger)order
                      accessibilityOrder:(NSUInteger)accessibilityOrder
                                    data:(nullable id)data NS_SWIFT_UNAVAILABLE("Use init(calendar:identifier:order:accessibilityOrder:data:)");

- (nonnull instancetype)initWithIdentifier:(nonnull NSString*)identifier
                                     order:(NSUInteger)order
                        accessibilityOrder:(NSUInteger)accessibilityOrder
                                      data:(nullable id)data NS_UNAVAILABLE;

- (nonnull instancetype)initWithCalendar:(nonnull NSCalendar*)calendar
                              identifier:(nonnull NSString*)identifier
                                   order:(NSUInteger)order
                                    data:(nullable id)data;

- (nonnull instancetype)initWithCalendar:(nonnull NSCalendar*)calendar
                              identifier:(nonnull NSString*)identifier
                                   order:(NSUInteger)order
                      accessibilityOrder:(NSUInteger)accessibilityOrder
                                    data:(nullable id)data NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBDataViewCalendarMonthItem : GLBDataViewCalendarItem

@property(nonatomic, nonnull, readonly, strong) NSDate* beginDate;
@property(nonatomic, nonnull, readonly, strong) NSDate* endDate;
@property(nonatomic, nonnull, readonly, strong) NSDate* displayBeginDate;
@property(nonatomic, nonnull, readonly, strong) NSDate* displayEndDate;

+ (nonnull instancetype)itemWithCalendar:(nonnull NSCalendar*)calendar
                              identifier:(nonnull NSString*)identifier
                                   order:(NSUInteger)order
                                    data:(nullable id)data NS_UNAVAILABLE;

+ (nonnull instancetype)itemWithCalendar:(nonnull NSCalendar*)calendar
                              identifier:(nonnull NSString*)identifier
                                   order:(NSUInteger)order
                      accessibilityOrder:(NSUInteger)accessibilityOrder
                                    data:(nullable id)data NS_UNAVAILABLE;

+ (nonnull instancetype)itemWithCalendar:(nonnull NSCalendar*)calendar
                               beginDate:(nonnull NSDate*)beginDate
                                 endDate:(nonnull NSDate*)endDate
                        displayBeginDate:(nonnull NSDate*)displayBeginDate
                          displayEndDate:(nonnull NSDate*)displayEndDate
                                    data:(nullable id)data NS_SWIFT_UNAVAILABLE("Use init(calendar:beginDate:endDate:displayBeginDate:displayEndDate:data:)");

- (nonnull instancetype)initWithCalendar:(nonnull NSCalendar*)calendar
                              identifier:(nonnull NSString*)identifier
                                   order:(NSUInteger)order
                      accessibilityOrder:(NSUInteger)accessibilityOrder
                                    data:(nullable id)data NS_UNAVAILABLE;

- (nonnull instancetype)initWithCalendar:(nonnull NSCalendar*)calendar
                               beginDate:(nonnull NSDate*)beginDate
                                 endDate:(nonnull NSDate*)endDate
                        displayBeginDate:(nonnull NSDate*)displayBeginDate
                          displayEndDate:(nonnull NSDate*)displayEndDate
                                    data:(nullable id)data NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBDataViewCalendarWeekdayItem : GLBDataViewCalendarItem

@property(nonatomic, nullable, readonly, weak) __kindof GLBDataViewCalendarMonthItem* monthItem;
@property(nonatomic, nonnull, readonly, strong) NSDate* date;

+ (nonnull instancetype)itemWithCalendar:(nonnull NSCalendar*)calendar
                              identifier:(nonnull NSString*)identifier
                                   order:(NSUInteger)order
                                    data:(nullable id)data NS_UNAVAILABLE;

+ (nonnull instancetype)itemWithCalendar:(nonnull NSCalendar*)calendar
                              identifier:(nonnull NSString*)identifier
                                   order:(NSUInteger)order
                      accessibilityOrder:(NSUInteger)accessibilityOrder
                                    data:(nullable id)data NS_UNAVAILABLE;

+ (nonnull instancetype)itemWithCalendar:(nonnull NSCalendar*)calendar
                                    date:(nonnull NSDate*)date
                                    data:(nullable id)data NS_SWIFT_UNAVAILABLE("Use init(calendar:date:data:)");

+ (nonnull instancetype)itemWithMonthItem:(nonnull GLBDataViewCalendarMonthItem*)monthItem
                                     date:(nonnull NSDate*)date
                                     data:(nullable id)data NS_SWIFT_UNAVAILABLE("Use init(monthItem:date:data:)");

- (nonnull instancetype)initWithCalendar:(nonnull NSCalendar*)calendar
                              identifier:(nonnull NSString*)identifier
                                   order:(NSUInteger)order
                      accessibilityOrder:(NSUInteger)accessibilityOrder
                                    data:(nullable id)data NS_UNAVAILABLE;

- (nonnull instancetype)initWithCalendar:(nonnull NSCalendar*)calendar
                                    date:(nonnull NSDate*)date
                                    data:(nullable id)data NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)initWithMonthItem:(nonnull GLBDataViewCalendarMonthItem*)monthItem
                                     date:(nonnull NSDate*)date
                                     data:(nullable id)data NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBDataViewCalendarDayItem : GLBDataViewCalendarItem

@property(nonatomic, nullable, readonly, weak) __kindof GLBDataViewCalendarMonthItem* monthItem;
@property(nonatomic, nullable, readonly, weak) __kindof GLBDataViewCalendarWeekdayItem* weekdayItem;
@property(nonatomic, nonnull, readonly, strong) NSDate* date;

+ (nonnull instancetype)itemWithCalendar:(nonnull NSCalendar*)calendar
                              identifier:(nonnull NSString*)identifier
                                   order:(NSUInteger)order
                                    data:(nullable id)data NS_UNAVAILABLE;

+ (nonnull instancetype)itemWithCalendar:(nonnull NSCalendar*)calendar
                              identifier:(nonnull NSString*)identifier
                                   order:(NSUInteger)order
                      accessibilityOrder:(NSUInteger)accessibilityOrder
                                    data:(nullable id)data NS_UNAVAILABLE;

+ (nonnull instancetype)itemWithCalendar:(nonnull NSCalendar*)calendar
                                    date:(nonnull NSDate*)date
                                    data:(nullable id)data NS_SWIFT_UNAVAILABLE("Use init(calendar:date:data:)");

+ (nonnull instancetype)itemWithWeekdayItem:(nonnull GLBDataViewCalendarWeekdayItem*)weekdayItem
                                       date:(nonnull NSDate*)date
                                       data:(nullable id)data NS_SWIFT_UNAVAILABLE("Use init(weekdayItem:date:data:)");

- (nonnull instancetype)initWithCalendar:(nonnull NSCalendar*)calendar
                              identifier:(nonnull NSString*)identifier
                                   order:(NSUInteger)order
                      accessibilityOrder:(NSUInteger)accessibilityOrder
                                    data:(nullable id)data NS_UNAVAILABLE;

- (nonnull instancetype)initWithCalendar:(nonnull NSCalendar*)calendar
                                    date:(nonnull NSDate*)date
                                    data:(nullable id)data NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)initWithWeekdayItem:(nonnull GLBDataViewCalendarWeekdayItem*)weekdayItem
                                       date:(nonnull NSDate*)date
                                       data:(nullable id)data NS_DESIGNATED_INITIALIZER;


@end

/*--------------------------------------------------*/

extern NSString* _Nonnull GLBDataViewCalendarMonthIdentifier;
extern NSString* _Nonnull GLBDataViewCalendarWeekdayIdentifier;
extern NSString* _Nonnull GLBDataViewCalendarDayIdentifier;

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
