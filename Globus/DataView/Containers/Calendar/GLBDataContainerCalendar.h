/*--------------------------------------------------*/

#import "GLBDataViewTypes.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBDataView;
@class GLBDataContainer;
@class GLBDataItem;
@class GLBDataCell;

/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBDataContainerOrientation) {
    GLBDataContainerOrientationVertical,
    GLBDataContainerOrientationHorizontal,
};

typedef NS_OPTIONS(NSUInteger, GLBDataContainerAlign) {
    GLBDataContainerAlignNone = GLBDataViewPositionNone,
    GLBDataContainerAlignTop = GLBDataViewPositionTop,
    GLBDataContainerAlignCenteredVertically = GLBDataViewPositionCenteredVertically,
    GLBDataContainerAlignBottom = GLBDataViewPositionBottom,
    GLBDataContainerAlignLeft = GLBDataViewPositionLeft,
    GLBDataContainerAlignCenteredHorizontally = GLBDataViewPositionCenteredHorizontally,
    GLBDataContainerAlignRight = GLBDataViewPositionRight,
    GLBDataContainerAlignCentered = GLBDataContainerAlignCenteredVertically | GLBDataContainerAlignCenteredHorizontally,
};

/*--------------------------------------------------*/

typedef void(^GLBDataContainerConfigureItemBlock)(__kindof GLBDataItem* item);

/*--------------------------------------------------*/

@interface GLBDataContainer : NSObject< GLBSearchBarDelegate >

@property(nonatomic, readonly, weak) __kindof GLBDataView* dataView;
@property(nonatomic, readonly, weak) __kindof GLBDataContainer* dataContainer;
@property(nonatomic, readonly, assign) CGRect frame;
@property(nonatomic, getter=isHidden) BOOL hidden;
@property(nonatomic, readonly, assign, getter=isHiddenInHierarchy) BOOL hiddenInHierarchy;
@property(nonatomic) BOOL allowAutoAlign;
@property(nonatomic) UIEdgeInsets alignInsets;
@property(nonatomic) GLBDataContainerAlign alignPosition;
@property(nonatomic) UIOffset alignThreshold;

- (void)setup NS_REQUIRES_SUPER;

- (void)setNeedResize;
- (void)setNeedReload;

- (NSArray*)allItems;

- (__kindof GLBDataItem*)itemForPoint:(CGPoint)point;
- (__kindof GLBDataItem*)itemForData:(id)data;
- (__kindof GLBDataCell*)cellForData:(id)data;

- (BOOL)containsActionForKey:(id)key;
- (BOOL)containsActionForIdentifier:(id)identifier forKey:(id)key;

- (void)performActionForKey:(id)key withArguments:(NSArray*)arguments;
- (void)performActionForIdentifier:(id)identifier forKey:(id)key withArguments:(NSArray*)arguments;

- (CGPoint)alignPoint;
- (void)align;

@end

/*--------------------------------------------------*/

@interface GLBDataContainerSections : GLBDataContainer

@property(nonatomic, readonly, strong) NSArray* sections;

- (void)prependSection:(GLBDataContainer*)section;
- (void)appendSection:(GLBDataContainer*)section;
- (void)insertSection:(GLBDataContainer*)section atIndex:(NSUInteger)index;
- (void)replaceOriginSection:(GLBDataContainer*)originSection withSection:(GLBDataContainer*)section;
- (void)deleteSection:(GLBDataContainer*)section;
- (void)deleteAllSections;

- (void)scrollToSection:(GLBDataContainer*)section scrollPosition:(GLBDataViewPosition)scrollPosition animated:(BOOL)animated;

@end

/*--------------------------------------------------*/

@interface GLBDataContainerSectionsList : GLBDataContainerSections

@property(nonatomic) GLBDataContainerOrientation orientation;
@property(nonatomic) UIEdgeInsets margin;
@property(nonatomic) UIOffset spacing;
@property(nonatomic) BOOL pagingEnabled;
@property(nonatomic) NSUInteger currentSectionIndex;
@property(nonatomic, strong) GLBDataContainer* currentSection;

+ (instancetype)containerWithOrientation:(GLBDataContainerOrientation)orientation;

- (instancetype)initWithOrientation:(GLBDataContainerOrientation)orientation;

- (void)setCurrentSectionIndex:(NSUInteger)currentSectionIndex animated:(BOOL)animated;
- (void)setCurrentSection:(GLBDataContainer*)currentSection animated:(BOOL)animated;

@end

/*--------------------------------------------------*/

extern NSString* GLBDataContainerCurrentSectionChanged;

/*--------------------------------------------------*/

@interface GLBDataContainerItems : GLBDataContainer

@property(nonatomic, readonly, strong) NSArray* entries;

@end

/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBDataContainerItemsListMode) {
    GLBDataContainerItemsListModeBegin,
    GLBDataContainerItemsListModeCenter,
    GLBDataContainerItemsListModeEnd
};

/*--------------------------------------------------*/

@interface GLBDataContainerItemsList : GLBDataContainerItems

@property(nonatomic) GLBDataContainerOrientation orientation;
@property(nonatomic) GLBDataContainerItemsListMode mode;
@property(nonatomic) BOOL reverse;
@property(nonatomic) UIEdgeInsets margin;
@property(nonatomic) UIOffset spacing;
@property(nonatomic) CGSize defaultSize;
@property(nonatomic) CGFloat defaultWidth;
@property(nonatomic) CGFloat defaultHeight;
@property(nonatomic) NSUInteger defaultOrder;
@property(nonatomic, strong) __kindof GLBDataItem* header;
@property(nonatomic, strong) __kindof GLBDataItem* footer;
@property(nonatomic, readonly, strong) NSArray< __kindof GLBDataItem* >* items;

+ (instancetype)containerWithOrientation:(GLBDataContainerOrientation)orientation;

- (instancetype)initWithOrientation:(GLBDataContainerOrientation)orientation;

- (__kindof GLBDataItem*)prependIdentifier:(NSString*)identifier byData:(id)data;
- (__kindof GLBDataItem*)prependIdentifier:(NSString*)identifier byData:(id)data configure:(GLBDataContainerConfigureItemBlock)configure;
- (__kindof GLBDataItem*)prependIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order;
- (__kindof GLBDataItem*)prependIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order configure:(GLBDataContainerConfigureItemBlock)configure;
- (void)prependItem:(GLBDataItem*)item;
- (void)prependItems:(NSArray*)items;

- (__kindof GLBDataItem*)appendIdentifier:(NSString*)identifier byData:(id)data;
- (__kindof GLBDataItem*)appendIdentifier:(NSString*)identifier byData:(id)data configure:(GLBDataContainerConfigureItemBlock)configure;
- (__kindof GLBDataItem*)appendIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order;
- (__kindof GLBDataItem*)appendIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order configure:(GLBDataContainerConfigureItemBlock)configure;
- (void)appendItem:(GLBDataItem*)item;
- (void)appendItems:(NSArray*)items;

- (__kindof GLBDataItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data;
- (__kindof GLBDataItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data configure:(GLBDataContainerConfigureItemBlock)configure;
- (__kindof GLBDataItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data order:(NSUInteger)order;
- (__kindof GLBDataItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data order:(NSUInteger)order configure:(GLBDataContainerConfigureItemBlock)configure;
- (void)insertItem:(GLBDataItem*)item atIndex:(NSUInteger)index;
- (void)insertItems:(NSArray*)items atIndex:(NSUInteger)index;
- (void)insertItem:(GLBDataItem*)item aboveItem:(GLBDataItem*)aboveItem;
- (void)insertItems:(NSArray*)items aboveItem:(GLBDataItem*)aboveItem;
- (void)insertItem:(GLBDataItem*)item belowItem:(GLBDataItem*)belowItem;
- (void)insertItems:(NSArray*)items belowItem:(GLBDataItem*)belowItem;

- (void)replaceOriginItem:(GLBDataItem*)originItem withItem:(GLBDataItem*)item;
- (void)replaceOriginItems:(NSArray*)originItems withItems:(NSArray*)items;

- (void)deleteItem:(GLBDataItem*)item;
- (void)deleteItems:(NSArray*)items;
- (void)deleteAllItems;

@end

/*--------------------------------------------------*/

@interface GLBDataContainerItemsFlow : GLBDataContainerItems

@property(nonatomic) GLBDataContainerOrientation orientation;
@property(nonatomic) UIEdgeInsets margin;
@property(nonatomic) UIOffset spacing;
@property(nonatomic) CGSize defaultSize;
@property(nonatomic) CGFloat defaultWidth;
@property(nonatomic) CGFloat defaultHeight;
@property(nonatomic) NSUInteger defaultOrder;
@property(nonatomic, strong) __kindof GLBDataItem* header;
@property(nonatomic, strong) __kindof GLBDataItem* footer;
@property(nonatomic, readonly, strong) NSArray* items;

+ (instancetype)containerWithOrientation:(GLBDataContainerOrientation)orientation;

- (instancetype)initWithOrientation:(GLBDataContainerOrientation)orientation;

- (__kindof GLBDataItem*)prependIdentifier:(NSString*)identifier byData:(id)data;
- (__kindof GLBDataItem*)prependIdentifier:(NSString*)identifier byData:(id)data configure:(GLBDataContainerConfigureItemBlock)configure;
- (__kindof GLBDataItem*)prependIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order;
- (__kindof GLBDataItem*)prependIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order configure:(GLBDataContainerConfigureItemBlock)configure;
- (void)prependItem:(GLBDataItem*)item;
- (void)prependItems:(NSArray*)items;

- (__kindof GLBDataItem*)appendIdentifier:(NSString*)identifier byData:(id)data;
- (__kindof GLBDataItem*)appendIdentifier:(NSString*)identifier byData:(id)data configure:(GLBDataContainerConfigureItemBlock)configure;
- (__kindof GLBDataItem*)appendIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order;
- (__kindof GLBDataItem*)appendIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order configure:(GLBDataContainerConfigureItemBlock)configure;
- (void)appendItem:(GLBDataItem*)item;
- (void)appendItems:(NSArray*)items;

- (__kindof GLBDataItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data;
- (__kindof GLBDataItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data configure:(GLBDataContainerConfigureItemBlock)configure;
- (__kindof GLBDataItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data order:(NSUInteger)order;
- (__kindof GLBDataItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data order:(NSUInteger)order configure:(GLBDataContainerConfigureItemBlock)configure;
- (void)insertItem:(GLBDataItem*)item atIndex:(NSUInteger)index;
- (void)insertItems:(NSArray*)items atIndex:(NSUInteger)index;
- (void)insertItem:(GLBDataItem*)item aboveItem:(GLBDataItem*)aboveItem;
- (void)insertItems:(NSArray*)items aboveItem:(GLBDataItem*)aboveItem;
- (void)insertItem:(GLBDataItem*)item belowItem:(GLBDataItem*)belowItem;
- (void)insertItems:(NSArray*)items belowItem:(GLBDataItem*)belowItem;

- (void)replaceOriginItem:(GLBDataItem*)originItem withItem:(GLBDataItem*)item;
- (void)replaceOriginItems:(NSArray*)originItems withItems:(NSArray*)items;

- (void)deleteItem:(GLBDataItem*)item;
- (void)deleteItems:(NSArray*)items;
- (void)deleteAllItems;

@end

/*--------------------------------------------------*/

@class GLBDataItemCalendarMonth;
@class GLBDataItemCalendarWeekday;
@class GLBDataItemCalendarDay;

/*--------------------------------------------------*/

typedef id (^GLBDataContainerCalendarMonthCreateBlock)(NSDate* beginDate, NSDate* endDate);
typedef id (^GLBDataContainerCalendarWeekdayCreateBlock)(NSDate* date, NSUInteger index);
typedef id (^GLBDataContainerCalendarDayCreateBlock)(NSDate* date);

typedef void (^GLBDataContainerCalendarEachDayItemsBlock)(GLBDataItemCalendarDay* dayItem);

/*--------------------------------------------------*/

@interface GLBDataContainerCalendar : GLBDataContainerItems

@property(nonatomic, readonly, strong) NSCalendar* calendar;
@property(nonatomic, readonly, strong) NSDate* beginDate;
@property(nonatomic, readonly, strong) NSDate* endDate;
@property(nonatomic, readonly, strong) NSDate* displayBeginDate;
@property(nonatomic, readonly, strong) NSDate* displayEndDate;

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

+ (instancetype)containerWithCalendar:(NSCalendar*)calendar;

- (instancetype)initWithCalendar:(NSCalendar*)calendar;

- (__kindof GLBDataItemCalendarWeekday*)weekdayItemForDate:(NSDate*)date;
- (__kindof GLBDataItemCalendarDay*)dayItemForDate:(NSDate*)date;

- (void)prepareBeginDate:(NSDate*)beginDate endDate:(NSDate*)endDate;
- (void)prepareBeginDate:(NSDate*)beginDate endDate:(NSDate*)endDate dayBlock:(GLBDataContainerCalendarDayCreateBlock)dayBlock;
- (void)prepareBeginDate:(NSDate*)beginDate endDate:(NSDate*)endDate monthBlock:(GLBDataContainerCalendarMonthCreateBlock)monthBlock weekdayBlock:(GLBDataContainerCalendarWeekdayCreateBlock)weekdayBlock dayBlock:(GLBDataContainerCalendarDayCreateBlock)dayBlock;
- (void)replaceDate:(NSDate*)date data:(id)data;
- (void)cleanup;

- (void)eachDayItemsWithWeekdayItem:(GLBDataItemCalendarWeekday*)weekdayItem block:(GLBDataContainerCalendarEachDayItemsBlock)block;
- (void)eachWeekdayByDayItem:(GLBDataItemCalendarDay*)dayItem block:(GLBDataContainerCalendarEachDayItemsBlock)block;
- (void)eachWeekByDayItem:(GLBDataItemCalendarDay*)dayItem block:(GLBDataContainerCalendarEachDayItemsBlock)block;

@end

/*--------------------------------------------------*/

@interface GLBDataContainerCalendarDays : GLBDataContainerItems

@property(nonatomic, readonly, strong) NSCalendar* calendar;

@property(nonatomic) GLBDataContainerOrientation orientation;
@property(nonatomic) UIEdgeInsets margin;
@property(nonatomic) UIOffset spacing;
@property(nonatomic) CGSize defaultSize;
@property(nonatomic, readonly, strong) NSArray* days;

+ (instancetype)containerWithCalendar:(NSCalendar*)calendar orientation:(GLBDataContainerOrientation)orientation;

- (instancetype)initWithCalendar:(NSCalendar*)calendar orientation:(GLBDataContainerOrientation)orientation;

- (__kindof GLBDataItemCalendarDay*)dayItemForDate:(NSDate*)date;
- (__kindof GLBDataItemCalendarDay*)nearestDayItemForDate:(NSDate*)date;

- (void)prepareBeginDate:(NSDate*)beginDate endDate:(NSDate*)endDate interval:(NSTimeInterval)interval data:(id)data;
- (void)prependToDate:(NSDate*)date interval:(NSTimeInterval)interval data:(id)data;
- (void)prependDate:(NSDate*)date data:(id)data;
- (void)appendToDate:(NSDate*)date interval:(NSTimeInterval)interval data:(id)data;
- (void)appendDate:(NSDate*)date data:(id)data;
- (void)insertDate:(NSDate*)date data:(id)data atIndex:(NSUInteger)index;
- (void)replaceDate:(NSDate*)date data:(id)data;
- (void)deleteBeginDate:(NSDate*)beginDate endDate:(NSDate*)endDate;
- (void)deleteDate:(NSDate*)date;
- (void)deleteAllDates;

- (void)scrollToDate:(NSDate*)date scrollPosition:(GLBDataViewPosition)scrollPosition animated:(BOOL)animated;

@end

/*--------------------------------------------------*/

extern NSString* GLBDataContainerCalendarMonthIdentifier;
extern NSString* GLBDataContainerCalendarWeekdayIdentifier;
extern NSString* GLBDataContainerCalendarDayIdentifier;

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
