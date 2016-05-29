/*--------------------------------------------------*/

#import "GLBDataContainer.h"
#import "GLBDataItem+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import "GLBGrid.h"

/*--------------------------------------------------*/

@interface GLBDataContainer () {
@protected
    __weak GLBDataView* _view;
    __weak GLBDataContainer* _parent;
    BOOL _hidden;
    BOOL _allowAutoAlign;
    UIEdgeInsets _alignInsets;
    GLBDataContainerAlign _alignPosition;
    UIOffset _alignThreshold;
    CGRect _frame;
}

@property(nonatomic, weak) __kindof GLBDataView* view;
@property(nonatomic, weak) __kindof GLBDataContainer* parent;

- (void)_willChangeView;
- (void)_didChangeView;
- (void)_willChangeParent;
- (void)_didChangeParent;

- (void)_willBeginDragging;
- (void)_didScrollDragging:(BOOL)dragging decelerating:(BOOL)decelerating;
- (void)_willEndDraggingWithVelocity:(CGPoint)velocity contentOffset:(inout CGPoint*)contentOffset contentSize:(CGSize)contentSize visibleSize:(CGSize)visibleSize;
- (void)_didEndDraggingWillDecelerate:(BOOL)decelerate;
- (void)_willBeginDecelerating;
- (void)_didEndDecelerating;
- (void)_didEndScrollingAnimation;

- (void)_beginUpdateAnimated:(BOOL)animated;
- (void)_endUpdateAnimated:(BOOL)animated;

- (CGPoint)_alignPointWithContentOffset:(CGPoint)contentOffset contentSize:(CGSize)contentSize visibleSize:(CGSize)visibleSize;
- (CGPoint)_alignWithVelocity:(CGPoint)velocity contentOffset:(CGPoint)contentOffset contentSize:(CGSize)contentSize visibleSize:(CGSize)visibleSize;

- (CGRect)_validateLayoutForAvailableFrame:(CGRect)frame;
- (void)_willLayoutForBounds:(CGRect)bounds;
- (void)_didLayoutForBounds:(CGRect)bounds;

- (void)_beginMovingItem:(GLBDataItem*)item location:(CGPoint)location;
- (void)_movingItem:(GLBDataItem*)item location:(CGPoint)location delta:(CGPoint)delta allowsSorting:(BOOL)allowsSorting;
- (void)_endMovingItem:(GLBDataItem*)item location:(CGPoint)location;

@end

/*--------------------------------------------------*/

@interface GLBDataContainerSections () {
@protected
    NSMutableArray< __kindof GLBDataContainer* >* _sections;
}

- (CGRect)_validateSectionsForAvailableFrame:(CGRect)frame;
- (void)_willSectionsLayoutForBounds:(CGRect)bounds;
- (void)_didSectionsLayoutForBounds:(CGRect)bounds;

@end

/*--------------------------------------------------*/

@interface GLBDataContainerSectionsList () {
    GLBDataContainerOrientation _orientation;
    UIEdgeInsets _margin;
    UIOffset _spacing;
    BOOL _pagingEnabled;
    __kindof GLBDataContainer* _currentSection;
}

@end

/*--------------------------------------------------*/

@interface GLBDataContainerItems () {
@protected
    NSMutableArray< __kindof GLBDataItem* >* _entries;
}

- (void)_prependEntry:(GLBDataItem*)entry;
- (void)_prependEntries:(NSArray*)entries;
- (void)_appendEntry:(GLBDataItem*)entry;
- (void)_appendEntries:(NSArray*)entries;
- (void)_insertEntry:(GLBDataItem*)entry atIndex:(NSUInteger)index;
- (void)_insertEntries:(NSArray*)entries atIndex:(NSUInteger)index;
- (void)_insertEntry:(GLBDataItem*)entry aboveEntry:(GLBDataItem*)aboveEntry;
- (void)_insertEntries:(NSArray*)entries aboveEntry:(GLBDataItem*)aboveEntry;
- (void)_insertEntry:(GLBDataItem*)entry belowEntry:(GLBDataItem*)belowEntry;
- (void)_insertEntries:(NSArray*)entries belowEntry:(GLBDataItem*)belowEntry;
- (void)_replaceOriginEntry:(GLBDataItem*)originEntry withEntry:(GLBDataItem*)entry;
- (void)_replaceOriginEntries:(NSArray*)originEntries withEntries:(NSArray*)entries;
- (void)_deleteEntry:(GLBDataItem*)entry;
- (void)_deleteEntries:(NSArray*)entries;
- (void)_deleteAllEntries;

- (CGRect)_validateEntriesForAvailableFrame:(CGRect)frame;
- (void)_willEntriesLayoutForBounds:(CGRect)bounds;
- (void)_didEntriesLayoutForBounds:(CGRect)bounds;

@end

/*--------------------------------------------------*/

@interface GLBDataContainerItemsList () {
    GLBDataContainerOrientation _orientation;
    GLBDataContainerItemsListMode _mode;
    BOOL _reverse;
    UIEdgeInsets _margin;
    UIOffset _spacing;
    CGSize _defaultSize;
    NSUInteger _defaultOrder;
    __kindof GLBDataItem* _header;
    __kindof GLBDataItem* _footer;
    NSMutableArray< __kindof GLBDataItem* >* _items;
}

@end

/*--------------------------------------------------*/

@interface GLBDataContainerItemsFlow () {
    GLBDataContainerOrientation _orientation;
    UIEdgeInsets _margin;
    UIOffset _spacing;
    CGSize _defaultSize;
    NSUInteger _defaultOrder;
    NSMutableArray< __kindof GLBDataItem* >* _items;
}

@end

/*--------------------------------------------------*/

@interface GLBDataContainerCalendar () {
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
    __kindof GLBDataItemCalendarMonth* _monthItem;
    NSMutableArray< __kindof GLBDataItem* >* _weekdayItems;
    GLBMutableGrid* _dayItems;
}

@property(nonatomic, strong) NSCalendar* calendar;
@property(nonatomic, strong) NSDate* beginDate;
@property(nonatomic, strong) NSDate* endDate;
@property(nonatomic, strong) __kindof GLBDataItemCalendarMonth* monthItem;
@property(nonatomic, strong) NSMutableArray< __kindof GLBDataItem* >* weekdayItems;
@property(nonatomic, strong) GLBMutableGrid* dayItems;

@end

/*--------------------------------------------------*/

@interface GLBDataContainerCalendarDays () {
@protected
    NSCalendar* _calendar;
    GLBDataContainerOrientation _orientation;
    UIEdgeInsets _margin;
    UIOffset _spacing;
    CGSize _defaultSize;
}

@property(nonatomic, strong) NSCalendar* calendar;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
