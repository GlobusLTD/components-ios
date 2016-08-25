/*--------------------------------------------------*/

#import "GLBDataItem+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"
#import "NSArray+GLBNS.h"

/*--------------------------------------------------*/

@implementation GLBDataItem

#pragma mark - Synthesize

@synthesize view = _view;
@synthesize parent = _parent;
@synthesize identifier = _identifier;
@synthesize data = _data;
@synthesize size = _size;
@synthesize needResize = _needResize;
@synthesize originFrame = _originFrame;
@synthesize updateFrame = _updateFrame;
@synthesize displayFrame = _displayFrame;
@synthesize order = _order;
@synthesize hidden = _hidden;
@synthesize allowsAlign = _allowsAlign;
@synthesize allowsPressed = _allowsPressed;
@synthesize allowsLongPressed = _allowsLongPressed;
@synthesize allowsSelection = _allowsSelection;
@synthesize allowsHighlighting = _allowsHighlighting;
@synthesize allowsEditing = _allowsEditing;
@synthesize allowsMoving = _allowsMoving;
@synthesize persistent = _persistent;
@synthesize selected = _selected;
@synthesize highlighted = _highlighted;
@synthesize editing = _editing;
@synthesize moving = _moving;
@synthesize cell = _cell;

#pragma mark - Init / Free

+ (instancetype)itemWithDataItem:(GLBDataItem*)dataItem {
    return [[self alloc] initWithDataItem:dataItem];
}

+ (instancetype)itemWithIdentifier:(NSString*)identifier order:(NSUInteger)order data:(id)data {
    return [[self alloc] initWithIdentifier:identifier order:order data:data];
}

+ (NSArray*)itemsWithIdentifier:(NSString*)identifier order:(NSUInteger)order dataArray:(NSArray*)dataArray {
    NSMutableArray* items = [NSMutableArray arrayWithCapacity:dataArray.count];
    for(id data in dataArray) {
        [items addObject:[self itemWithIdentifier:identifier order:order data:data]];
    }
    return items;
}

- (instancetype)initWithDataItem:(GLBDataItem*)dataItem {
    self = [super init];
    if(self != nil) {
        _identifier = dataItem.identifier;
        _order = dataItem.order;
        _data = dataItem.data;
        _size = dataItem.size;
        _needResize = dataItem.needResize;
        _originFrame = dataItem.originFrame;
        _updateFrame = dataItem.updateFrame;
        _displayFrame = dataItem.displayFrame;
        _hidden = dataItem.hidden;
        _allowsAlign = dataItem.allowsAlign;
        _allowsPressed = dataItem.allowsPressed;
        _allowsLongPressed = dataItem.allowsLongPressed;
        _allowsSelection = dataItem.allowsSelection;
        _allowsHighlighting = dataItem.allowsHighlighting;
        _allowsEditing = dataItem.allowsEditing;
        _allowsMoving = dataItem.allowsMoving;
        _persistent = dataItem.persistent;
        _needResize = YES;
        
        [self setup];
    }
    return self;
}

- (instancetype)initWithIdentifier:(NSString*)identifier order:(NSUInteger)order data:(id)data {
    self = [super init];
    if(self != nil) {
        _identifier = identifier;
        _order = order;
        _data = data;
        _size = CGSizeZero;
        _needResize = YES;
        _originFrame = CGRectNull;
        _updateFrame = CGRectNull;
        _displayFrame = CGRectNull;
        _allowsPressed = YES;
        _allowsLongPressed = NO;
        _allowsSelection = YES;
        _allowsHighlighting = YES;
        _allowsEditing = YES;
        _allowsMoving = YES;
        
        [self setup];
    }
    return self;
}

- (void)setup {
}

- (void)dealloc {
}

#pragma mark - NSCopying

- (id)copy {
    return [self copyWithZone:NSDefaultMallocZone()];
}

- (id)copyWithZone:(NSZone*)zone {
    return [[self.class allocWithZone:zone] initWithDataItem:self];
}

#pragma mark - Debug

- (NSString*)description {
    return self.debugDescription;
}

- (NSString*)debugDescription {
    NSMutableArray* lines = [NSMutableArray array];
    [lines addObject:[NSString stringWithFormat:@"- %@ <%x>", _identifier, (unsigned int)self]];
    [lines addObject:[NSString stringWithFormat:@"-- Order: %d", (int)_order]];
    [lines addObject:[NSString stringWithFormat:@"-- OriginFrame: %@", NSStringFromCGRect(_originFrame)]];
    [lines addObject:[NSString stringWithFormat:@"-- UpdateFrame: %@", NSStringFromCGRect(_updateFrame)]];
    [lines addObject:[NSString stringWithFormat:@"-- DisplayFrame: %@", NSStringFromCGRect(_displayFrame)]];
    if(_hidden == YES) {
        [lines addObject:[NSString stringWithFormat:@"-- Hidden"]];
    }
    if(_persistent == YES) {
        [lines addObject:[NSString stringWithFormat:@"-- Persistent"]];
    }
    return [NSString stringWithFormat:@"\n%@", [lines componentsJoinedByString:@"\n"]];
}

#pragma mark - Property

- (void)setParent:(GLBDataContainer*)parent {
    if(_parent != parent) {
        _parent = parent;
        if(_parent != nil) {
            self.view = parent.view;
        } else {
            self.view = nil;
        }
    }
}

- (void)setCell:(GLBDataCell*)cell {
    if(_cell != cell) {
        if(_cell != nil) {
            [UIView performWithoutAnimation:^{
                _cell.item = nil;
            }];
        }
        _cell = cell;
        if(_cell != nil) {
            [UIView performWithoutAnimation:^{
                if(CGRectIsNull(_displayFrame) == NO) {
                    _cell.frame = _displayFrame;
                } else {
                    _cell.frame = _originFrame;
                }
                _cell.item = self;
            }];
        }
    }
}

- (CGRect)originFrame {
    [_view validateLayoutIfNeed];
    return _originFrame;
}

- (void)setUpdateFrame:(CGRect)updateFrame {
    if(CGRectEqualToRect(_updateFrame, updateFrame) == NO) {
        _updateFrame = updateFrame;
        if(CGRectIsNull(_originFrame) == YES) {
            _originFrame = _updateFrame;
        }
        if((_cell != nil) && ((CGRectIsNull(_updateFrame) == NO) && (CGRectIsNull(_displayFrame) == YES))) {
            _cell.frame = _updateFrame;
        }
    }
}

- (CGRect)updateFrame {
    [_view validateLayoutIfNeed];
    return _updateFrame;
}

- (void)setDisplayFrame:(CGRect)displayFrame {
    if(CGRectEqualToRect(_displayFrame, displayFrame) == NO) {
        _displayFrame = displayFrame;
        if((_cell != nil) && (CGRectIsNull(_displayFrame) == NO)) {
            _cell.frame = _displayFrame;
        }
    }
}

- (CGRect)displayFrame {
    [_view validateLayoutIfNeed];
    if(CGRectIsNull(_displayFrame) == YES) {
        return _updateFrame;
    }
    return _displayFrame;
}

- (CGRect)frame {
    [_view validateLayoutIfNeed];
    if(CGRectIsNull(_displayFrame) == NO) {
        return _displayFrame;
    } else if(CGRectIsNull(_updateFrame) == NO) {
        return _updateFrame;
    }
    return _originFrame;
}

- (void)setHidden:(BOOL)hidden {
    if(_hidden != hidden) {
        _hidden = hidden;
        [_view setNeedValidateLayout];
    }
}

- (BOOL)isHiddenInHierarchy {
    if(_hidden == YES) {
        return YES;
    }
    return _parent.hiddenInHierarchy;
}

#pragma mark - Public

- (BOOL)containsActionForKey:(id)key {
    return [_view containsActionForKey:key];
}

- (BOOL)containsActionForIdentifier:(id)identifier forKey:(id)key {
    return [_view containsActionForIdentifier:identifier forKey:key];
}

- (void)performActionForKey:(id)key withArguments:(NSArray*)arguments {
    [_view performActionForIdentifier:_identifier forKey:key withArguments:[@[ self ] glb_unionWithArray:arguments]];
}

- (void)beginUpdateAnimated:(BOOL __unused)animated {
}

- (void)endUpdateAnimated:(BOOL __unused)animated {
    _originFrame = _updateFrame;
    if(_cell != nil) {
        _cell.frame = self.frame;
    }
}

- (void)selectedAnimated:(BOOL)animated {
    if(_selected == NO) {
        _selected = YES;
        if(_cell != nil) {
            [_view selectItem:self animated:animated];
            [_cell selectedAnimated:animated];
        }
    }
}

- (void)deselectedAnimated:(BOOL)animated {
    if(_selected == YES) {
        _selected = NO;
        if(_cell != nil) {
            [_view deselectItem:self animated:animated];
            [_cell deselectedAnimated:animated];
        }
    }
}

- (void)highlightedAnimated:(BOOL)animated {
    if(_highlighted == NO) {
        _highlighted = YES;
        if(_cell != nil) {
            [_view highlightItem:self animated:animated];
            [_cell highlightedAnimated:animated];
        }
    }
}

- (void)unhighlightedAnimated:(BOOL)animated {
    if(_highlighted == YES) {
        _highlighted = NO;
        if(_cell != nil) {
            [_view unhighlightItem:self animated:animated];
            [_cell unhighlightedAnimated:animated];
        }
    }
}

- (void)beginEditingAnimated:(BOOL)animated {
    if(_editing == NO) {
        _editing = YES;
        if(_cell != nil) {
            [_view beganEditItem:self animated:animated];
            [_cell beginEditingAnimated:animated];
        }
    }
}

- (void)endEditingAnimated:(BOOL)animated {
    if(_editing == YES) {
        _editing = NO;
        if(_cell != nil) {
            [_view endedEditItem:self animated:animated];
            [_cell endEditingAnimated:animated];
        }
    }
}

- (void)beginMovingAnimated:(BOOL)animated {
    if(_moving == NO) {
        _moving = YES;
        if(_cell != nil) {
            [_view beganMoveItem:self animated:animated];
            [_cell beginMovingAnimated:animated];
        }
    }
}

- (void)endMovingAnimated:(BOOL)animated {
    if(_moving == YES) {
        _moving = NO;
        if(_cell != nil) {
            [_view endedMoveItemAnimated:animated];
            [_cell endMovingAnimated:animated];
        }
    }
}

- (void)setNeedResize {
    if(_needResize == NO) {
        _needResize = YES;
        if((_view.isAnimating == NO) && (_view.isTransiting == NO)) {
            _originFrame = CGRectNull;
            _updateFrame = CGRectNull;
            _displayFrame = CGRectNull;
        }
        [_view setNeedValidateLayout];
    }
}

- (CGSize)sizeForAvailableSize:(CGSize)size {
    if(_needResize == YES) {
        _needResize = NO;
        
        Class cellClass = [_view cellClassWithItem:self];
        if(cellClass != nil) {
            _size = [cellClass sizeForItem:self availableSize:size];
        }
    }
    return _size;
}

- (void)setNeedReload {
    if(_cell != nil) {
        if(_view.isUpdating == YES) {
            _cell.frame = self.frame;
            [_cell reload];
        } else {
            [UIView performWithoutAnimation:^{
                _cell.frame = self.frame;
                [_cell reload];
                [_cell layoutIfNeeded];
            }];
        }
    }
}

- (void)appear {
    [_view _appearItem:self];
}

- (void)disappear {
    [_view _disappearItem:self];
}

- (void)validateLayoutForBounds:(CGRect)bounds {
    if(_cell == nil) {
        if((_persistent == YES) && (self.hiddenInHierarchy == NO)) {
            [self appear];
            [_cell validateLayoutForBounds:bounds];
        } else if((CGRectIntersectsRect(bounds, CGRectUnion(_originFrame, self.frame)) == YES) && (self.hiddenInHierarchy == NO)) {
            [self appear];
            [_cell validateLayoutForBounds:bounds];
        }
    } else {
        [_cell validateLayoutForBounds:bounds];
    }
}

- (void)invalidateLayoutForBounds:(CGRect)bounds {
    if(_cell != nil) {
        if(_persistent == YES) {
            [_cell invalidateLayoutForBounds:bounds];
        } else if(self.hiddenInHierarchy == YES) {
            [self disappear];
        } else if(CGRectIntersectsRect(bounds, self.frame) == NO) {
            [self disappear];
        } else {
            [_cell invalidateLayoutForBounds:bounds];
        }
    }
}

- (void)beginTransition {
    if(_cell != nil) {
        [_cell beginTransition];
    }
}

- (void)endTransition {
    if(_cell != nil) {
        [_cell endTransition];
    }
}

#pragma mark - GLBSearchBarDelegate

- (void)searchBarBeginSearch:(GLBSearchBar*)searchBar {
    [_cell searchBarBeginSearch:searchBar];
}

- (void)searchBarEndSearch:(GLBSearchBar*)searchBar {
    [_cell searchBarEndSearch:searchBar];
}

- (void)searchBarBeginEditing:(GLBSearchBar*)searchBar {
    [_cell searchBarBeginEditing:searchBar];
}

- (void)searchBar:(GLBSearchBar*)searchBar textChanged:(NSString*)textChanged {
    [_cell searchBar:searchBar textChanged:textChanged];
}

- (void)searchBarEndEditing:(GLBSearchBar*)searchBar {
    [_cell searchBarEndEditing:searchBar];
}

- (void)searchBarPressedClear:(GLBSearchBar*)searchBar {
    [_cell searchBarPressedClear:searchBar];
}

- (void)searchBarPressedReturn:(GLBSearchBar*)searchBar {
    [_cell searchBarPressedReturn:searchBar];
}

- (void)searchBarPressedCancel:(GLBSearchBar*)searchBar {
    [_cell searchBarPressedCancel:searchBar];
}

@end

/*--------------------------------------------------*/

@implementation GLBDataItemCalendar

#pragma mark - Synthesize

@synthesize calendar = _calendar;

#pragma mark - Init / Free

- (instancetype)initWithIdentifier:(NSString*)identifier order:(NSUInteger)order calendar:(NSCalendar*)calendar data:(id)data {
    self = [super initWithIdentifier:identifier order:order data:data];
    if(self != nil) {
        _allowsMoving = NO;
        _calendar = calendar;
    }
    return self;
}

@end

/*--------------------------------------------------*/

@implementation GLBDataItemCalendarMonth

#pragma mark - Synthesize

@synthesize beginDate = _beginDate;
@synthesize endDate = _endDate;
@synthesize displayBeginDate = _displayBeginDate;
@synthesize displayEndDate = _displayEndDate;

#pragma mark - Init / Free

+ (instancetype)itemWithCalendar:(NSCalendar*)calendar beginDate:(NSDate*)beginDate endDate:(NSDate*)endDate displayBeginDate:(NSDate*)displayBeginDate displayEndDate:(NSDate*)displayEndDate data:(id)data {
    return [[self alloc] initWithCalendar:calendar beginDate:beginDate endDate:endDate displayBeginDate:displayBeginDate displayEndDate:displayEndDate data:data];
}

- (instancetype)initWithCalendar:(NSCalendar*)calendar beginDate:(NSDate*)beginDate endDate:(NSDate*)endDate displayBeginDate:(NSDate*)displayBeginDate displayEndDate:(NSDate*)displayEndDate data:(id)data {
    self = [super initWithIdentifier:GLBDataContainerCalendarMonthIdentifier order:3 calendar:calendar data:data];
    if(self != nil) {
        _allowsMoving = NO;
        _beginDate = beginDate;
        _endDate = endDate;
        _displayBeginDate = displayBeginDate;
        _displayEndDate = displayEndDate;
    }
    return self;
}

@end

/*--------------------------------------------------*/

@implementation GLBDataItemCalendarWeekday

#pragma mark - Synthesize

@synthesize monthItem = _monthItem;
@synthesize date = _date;

#pragma mark - Init / Free

+ (instancetype)itemWithCalendar:(NSCalendar*)calendar date:(NSDate*)date data:(id)data {
    return [[self alloc] initWithCalendar:calendar date:date data:data];
}

+ (instancetype)itemWithMonthItem:(GLBDataItemCalendarMonth*)monthItem date:(NSDate*)date data:(id)data {
    return [[self alloc] initWithMonthItem:monthItem date:date data:data];
}

- (instancetype)initWithCalendar:(NSCalendar*)calendar date:(NSDate*)date data:(id)data {
    self = [super initWithIdentifier:GLBDataContainerCalendarWeekdayIdentifier order:2 calendar:calendar data:data];
    if(self != nil) {
        _allowsMoving = NO;
        _date = date;
    }
    return self;
}

- (instancetype)initWithMonthItem:(GLBDataItemCalendarMonth*)monthItem date:(NSDate*)date data:(id)data {
    self = [super initWithIdentifier:GLBDataContainerCalendarWeekdayIdentifier order:2 calendar:monthItem.calendar data:data];
    if(self != nil) {
        _allowsMoving = NO;
        _monthItem = monthItem;
        _date = date;
    }
    return self;
}

@end

/*--------------------------------------------------*/

@implementation GLBDataItemCalendarDay

#pragma mark - Synthesize

@synthesize monthItem = _monthItem;
@synthesize weekdayItem = _weekdayItem;
@synthesize date = _date;

#pragma mark - Init / Free

+ (instancetype)itemWithCalendar:(NSCalendar*)calendar date:(NSDate*)date data:(id)data {
    return [[self alloc] initWithCalendar:calendar date:date data:data];
}

+ (instancetype)itemWithWeekdayItem:(GLBDataItemCalendarWeekday*)weekdayItem date:(NSDate*)date data:(id)data {
    return [[self alloc] initWithWeekdayItem:weekdayItem date:date data:data];
}

- (instancetype)initWithCalendar:(NSCalendar*)calendar date:(NSDate*)date data:(id)data {
    self = [super initWithIdentifier:GLBDataContainerCalendarDayIdentifier order:1 calendar:calendar data:data];
    if(self != nil) {
        _allowsMoving = NO;
        _date = date;
    }
    return self;
}

- (instancetype)initWithWeekdayItem:(GLBDataItemCalendarWeekday*)weekdayItem date:(NSDate*)date data:(id)data {
    self = [super initWithIdentifier:GLBDataContainerCalendarDayIdentifier order:1 calendar:weekdayItem.calendar data:data];
    if(self != nil) {
        _allowsMoving = NO;
        _monthItem = weekdayItem.monthItem;
        _weekdayItem = weekdayItem;
        _date = date;
    }
    return self;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
