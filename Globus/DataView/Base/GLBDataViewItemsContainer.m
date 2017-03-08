/*--------------------------------------------------*/

#import "GLBDataViewItemsContainer+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBDataViewItemsContainer

#pragma mark - Synthesize

@synthesize defaultOrder = _defaultOrder;
@synthesize items = _items;

#pragma mark - Init / Free

- (void)setup {
    [super setup];
    
    _items = NSMutableArray.array;
}

#pragma mark - Public override

- (void)willChangeDataView {
    [super willChangeDataView];
}

- (void)didChangeDataView {
    [super didChangeDataView];

    for(GLBDataViewItem* item in _items) {
        item.dataView = _dataView;
    }
}

- (void)beginUpdateAnimated:(BOOL)animated {
    [super beginUpdateAnimated:animated];
    
    for(GLBDataViewItem* item in _items) {
        [item beginUpdateAnimated:animated];
    }
}

- (void)updateAnimated:(BOOL)animated {
    [super updateAnimated:animated];
    
    for(GLBDataViewItem* item in _items) {
        [item updateAnimated:animated];
    }
}

- (void)endUpdateAnimated:(BOOL)animated {
    for(GLBDataViewItem* item in _items) {
        [item endUpdateAnimated:animated];
    }
    
    [super endUpdateAnimated:animated];
}

- (CGRect)frameForAvailableFrame:(CGRect)frame {
    return [self frameItemsForAvailableFrame:frame];
}

- (void)layoutForAvailableFrame:(CGRect)frame {
    [self layoutItemsForFrame:frame];
}

- (void)willLayoutForBounds:(CGRect)bounds {
    [self willItemsLayoutForBounds:CGRectIntersection(bounds, _frame)];
}

- (void)didLayoutForBounds:(CGRect)bounds {
    [self didItemsLayoutForBounds:CGRectIntersection(bounds, _frame)];
}

- (void)setNeedResize {
    for(GLBDataViewItem* item in _items) {
        [item setNeedResize];
    }
}

- (void)setNeedUpdate {
    for(GLBDataViewItem* item in _items) {
        [item setNeedUpdate];
    }
}

- (NSArray*)allItems {
    return [_items copy];
}

- (GLBDataViewItem*)itemForPoint:(CGPoint)point {
    for(GLBDataViewItem* item in _items) {
        if((item.isHidden == YES) || (item.isMoving == YES)) {
            continue;
        }
        if(CGRectContainsPoint(item.frame, point) == YES) {
            return item;
        }
    }
    return nil;
}

- (GLBDataViewItem*)itemForData:(id)data {
    for(GLBDataViewItem* item in _items) {
        id itemData = item.data;
        if([itemData isEqual:data] == YES) {
            return item;
        }
    }
    return nil;
}

#pragma mark - Public

- (GLBDataViewItem*)prependIdentifier:(NSString*)identifier byData:(id)data {
    return [self prependIdentifier:identifier byData:data order:_defaultOrder configure:nil];
}

- (GLBDataViewItem*)prependIdentifier:(NSString*)identifier byData:(id)data configure:(GLBDataViewContainerConfigureItemBlock)configure {
    return [self prependIdentifier:identifier byData:data order:_defaultOrder configure:configure];
}

- (GLBDataViewItem*)prependIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order {
    return [self prependIdentifier:identifier byData:data order:order configure:nil];
}

- (GLBDataViewItem*)prependIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order configure:(GLBDataViewContainerConfigureItemBlock)configure {
    GLBDataViewItem* item = [GLBDataViewItem itemWithIdentifier:identifier order:order data:data];
    if(configure != nil) {
        configure(item);
    }
    [self prependItem:item];
    return item;
}

- (void)prependItem:(GLBDataViewItem*)item {
    [_items insertObject:item atIndex:0];
    _accessibilityItems = nil;
    item.container = self;
    if(_dataView != nil) {
        [_dataView didInsertItems:@[ item ]];
    }
}

- (void)prependItems:(NSArray*)items {
    [_items insertObjects:items atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, items.count)]];
    _accessibilityItems = nil;
    for(GLBDataViewItem* item in items) {
        item.container = self;
    }
    if(_dataView != nil) {
        [_dataView didInsertItems:items];
    }
}

- (GLBDataViewItem*)appendIdentifier:(NSString*)identifier byData:(id)data {
    return [self appendIdentifier:identifier byData:data order:_defaultOrder configure:nil];
}

- (GLBDataViewItem*)appendIdentifier:(NSString*)identifier byData:(id)data configure:(GLBDataViewContainerConfigureItemBlock)configure {
    return [self appendIdentifier:identifier byData:data order:_defaultOrder configure:configure];
}

- (GLBDataViewItem*)appendIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order {
    return [self appendIdentifier:identifier byData:data order:order configure:nil];
}

- (GLBDataViewItem*)appendIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order configure:(GLBDataViewContainerConfigureItemBlock)configure {
    GLBDataViewItem* item = [GLBDataViewItem itemWithIdentifier:identifier order:order data:data];
    if(configure != nil) {
        configure(item);
    }
    [self appendItem:item];
    return item;
}

- (void)appendItem:(GLBDataViewItem*)item {
    [_items addObject:item];
    _accessibilityItems = nil;
    item.container = self;
    if(_dataView != nil) {
        [_dataView didInsertItems:@[ item ]];
    }
}

- (void)appendItems:(NSArray*)items {
    [_items addObjectsFromArray:items];
    _accessibilityItems = nil;
    for(GLBDataViewItem* item in items) {
        item.container = self;
    }
    if(_dataView != nil) {
        [_dataView didInsertItems:items];
    }
}

- (GLBDataViewItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data {
    return [self insertIdentifier:identifier atIndex:index byData:data order:_defaultOrder configure:nil];
}

- (GLBDataViewItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data configure:(GLBDataViewContainerConfigureItemBlock)configure {
    return [self insertIdentifier:identifier atIndex:index byData:data order:_defaultOrder configure:configure];
}

- (GLBDataViewItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data order:(NSUInteger)order {
    return [self insertIdentifier:identifier atIndex:index byData:data order:order configure:nil];
}

- (GLBDataViewItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data order:(NSUInteger)order configure:(GLBDataViewContainerConfigureItemBlock)configure {
    GLBDataViewItem* item = [GLBDataViewItem itemWithIdentifier:identifier order:order data:data];
    if(configure != nil) {
        configure(item);
    }
    [self insertItem:item atIndex:index];
    return item;
}

- (void)insertItem:(GLBDataViewItem*)item atIndex:(NSUInteger)index {
    if(index != NSNotFound) {
        [_items insertObject:item atIndex:index];
        _accessibilityItems = nil;
        item.container = self;
        if(_dataView != nil) {
            [_dataView didInsertItems:@[ item ]];
        }
    }
}

- (void)insertItems:(NSArray*)items atIndex:(NSUInteger)index {
    if(index != NSNotFound) {
        [_items insertObjects:items atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, items.count)]];
        _accessibilityItems = nil;
        for(GLBDataViewItem* item in items) {
            item.container = self;
        }
        if(_dataView != nil) {
            [_dataView didInsertItems:items];
        }
    }
}

- (void)insertItem:(GLBDataViewItem*)item aboveItem:(GLBDataViewItem*)aboveItem {
    NSUInteger index = [_items indexOfObject:aboveItem];
    if(index != NSNotFound) {
        [self insertItem:item atIndex:index];
    }
}

- (void)insertItems:(NSArray*)items aboveItem:(GLBDataViewItem*)aboveItem {
    NSUInteger index = [_items indexOfObject:aboveItem];
    if(index != NSNotFound) {
        [self insertItems:items atIndex:index];
    }
}

- (void)insertItem:(GLBDataViewItem*)item belowItem:(GLBDataViewItem*)belowItem {
    NSUInteger index = [_items indexOfObject:belowItem];
    if(index != NSNotFound) {
        [self insertItem:item atIndex:index + 1];
    }
}

- (void)insertItems:(NSArray*)items belowItem:(GLBDataViewItem*)belowItem {
    NSUInteger index = [_items indexOfObject:belowItem];
    if(index != NSNotFound) {
        [self insertItems:items atIndex:index + 1];
    }
}

- (void)replaceOriginItem:(GLBDataViewItem*)originItem withItem:(GLBDataViewItem*)item {
    NSUInteger index = [_items indexOfObject:originItem];
    if(index != NSNotFound) {
        item.container = self;
        _items[index] = item;
        _accessibilityItems = nil;
        if(_dataView != nil) {
            [_dataView didReplaceOriginItems:@[ originItem ] withItems:@[ item ]];
        }
    }
}

- (void)replaceOriginItems:(NSArray*)originItems withItems:(NSArray*)items {
    NSIndexSet* indexSet = [_items indexesOfObjectsPassingTest:^BOOL(GLBDataViewItem* originEntry, NSUInteger index __unused, BOOL* stop __unused) {
        return [originItems containsObject:originEntry];
    }];
    if(indexSet.count > 0) {
        for(GLBDataViewItem* item in items) {
            item.container = self;
        }
        [_items replaceObjectsAtIndexes:indexSet withObjects:items];
        _accessibilityItems = nil;
        if(_dataView != nil) {
            [_dataView didReplaceOriginItems:originItems withItems:items];
        }
    }
}

- (void)deleteItem:(GLBDataViewItem*)item {
    [_items removeObject:item];
    _accessibilityItems = nil;
    if(_dataView != nil) {
        [_dataView didDeleteItems:@[ item ]];
    }
}

- (void)deleteItems:(NSArray*)items {
    [_items removeObjectsInArray:items];
    _accessibilityItems = nil;
    if(_dataView != nil) {
        [_dataView didDeleteItems:items];
    }
}

- (void)deleteAllItems {
    [self deleteItems:[_items copy]];
}

- (CGPoint)alignWithVelocity:(CGPoint __unused)velocity contentOffset:(CGPoint)contentOffset contentSize:(CGSize)contentSize visibleSize:(CGSize)visibleSize {
    if((_allowAutoAlign == YES) && (_hidden == NO)) {
        CGPoint alingPoint = [self alignPointWithContentOffset:contentOffset contentSize:contentSize visibleSize:visibleSize];
        if(CGRectContainsPoint(_frame, alingPoint) == YES) {
            for(GLBDataViewItem* item in _items) {
                if(item.hidden == YES) {
                    continue;
                }
                if(item.allowsAlign == YES) {
                    CGPoint alingItemCorner = CGPointZero;
                    if((_alignPosition & GLBDataViewContainerAlignLeft) != 0) {
                        alingItemCorner.x = CGRectGetMinX(item.updateFrame);
                    } else if((_alignPosition & GLBDataViewContainerAlignCenteredHorizontally) != 0) {
                        alingItemCorner.x = CGRectGetMidX(item.updateFrame);
                    } else if((_alignPosition & GLBDataViewContainerAlignRight) != 0) {
                        alingItemCorner.x = CGRectGetMaxX(item.updateFrame);
                    } else {
                        alingItemCorner.x = alingPoint.x;
                    }
                    if((_alignPosition & GLBDataViewContainerAlignTop) != 0) {
                        alingItemCorner.y = CGRectGetMinY(item.updateFrame);
                    } else if((_alignPosition & GLBDataViewContainerAlignCenteredVertically) != 0) {
                        alingItemCorner.y = CGRectGetMidY(item.updateFrame);
                    } else if((_alignPosition & GLBDataViewContainerAlignBottom) != 0) {
                        alingItemCorner.y = CGRectGetMaxY(item.updateFrame);
                    } else {
                        alingItemCorner.y = alingPoint.y;
                    }
                    CGFloat dx = alingPoint.x - alingItemCorner.x;
                    CGFloat dy = alingPoint.y - alingItemCorner.y;
                    if((ABS(alingItemCorner.x - contentOffset.x) > FLT_EPSILON) && (ABS(dx) <= _alignThreshold.horizontal)) {
                        contentOffset.x -= dx;
                        alingPoint.x -= dx;
                    }
                    if((ABS(alingItemCorner.y - contentOffset.y) > FLT_EPSILON) && (ABS(dy) <= _alignThreshold.vertical)) {
                        contentOffset.y -= dy;
                        alingPoint.y -= dy;
                    }
                }
            }
            contentOffset.x = MAX(0.0f, MIN(contentOffset.x, contentSize.width - visibleSize.width));
            contentOffset.y = MAX(0.0f, MIN(contentOffset.y, contentSize.height - visibleSize.height));
        }
    }
    return contentOffset;
}

- (void)beginTransition {
    for(GLBDataViewItem* item in _items) {
        [item beginTransition];
    }
}

- (void)transitionResize {
    for(GLBDataViewItem* item in _items) {
        [item transitionResize];
    }
}

- (void)endTransition {
    for(GLBDataViewItem* item in _items) {
        [item endTransition];
    }
}

- (CGRect)frameItemsForAvailableFrame:(CGRect)frame {
    return CGRectNull;
}

- (void)layoutItemsForFrame:(CGRect)frame {
}

- (void)willItemsLayoutForBounds:(CGRect)bounds {
}

- (void)didItemsLayoutForBounds:(CGRect)bounds {
    for(GLBDataViewItem* item in _items) {
        if(item.hidden == YES) {
            continue;
        }
        [item validateLayoutForBounds:bounds];
    }
}

- (NSArray*)updateAccessibilityItems {
    NSArray< GLBDataViewItem* >* visibleItems = [_items filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(GLBDataViewItem* item, NSDictionary* bindings) {
        return (item.isHidden == NO);
    }]];
    return [visibleItems sortedArrayUsingComparator:^NSComparisonResult(GLBDataViewItem* item1, GLBDataViewItem* item2) {
        if(item1.accessibilityOrder < item2.accessibilityOrder) {
            return NSOrderedAscending;
        } else if(item1.accessibilityOrder > item2.accessibilityOrder) {
            return NSOrderedDescending;
        }
        CGRect itemFrame1 = item1.frame;
        CGRect itemFrame2 = item2.frame;
        if(itemFrame1.origin.y < itemFrame2.origin.y) {
            return NSOrderedAscending;
        } else if(itemFrame1.origin.x < itemFrame2.origin.x) {
            return NSOrderedAscending;
        } else if(itemFrame1.origin.y > itemFrame2.origin.y) {
            return NSOrderedDescending;
        } else if(itemFrame1.origin.x > itemFrame2.origin.x) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
}

#pragma mark - GLBSearchBarDelegate

- (void)searchBarBeginSearch:(GLBSearchBar*)searchBar {
    for(GLBDataViewItem* item in _items) {
        [item searchBarBeginSearch:searchBar];
    }
}

- (void)searchBarEndSearch:(GLBSearchBar*)searchBar {
    for(GLBDataViewItem* item in _items) {
        [item searchBarEndSearch:searchBar];
    }
}

- (void)searchBarBeginEditing:(GLBSearchBar*)searchBar {
    for(GLBDataViewItem* item in _items) {
        [item searchBarBeginEditing:searchBar];
    }
}

- (void)searchBar:(GLBSearchBar*)searchBar textChanged:(NSString*)textChanged {
    for(GLBDataViewItem* item in _items) {
        [item searchBar:searchBar textChanged:textChanged];
    }
}

- (void)searchBarEndEditing:(GLBSearchBar*)searchBar {
    for(GLBDataViewItem* item in _items) {
        [item searchBarEndEditing:searchBar];
    }
}

- (void)searchBarPressedClear:(GLBSearchBar*)searchBar {
    for(GLBDataViewItem* item in _items) {
        [item searchBarPressedClear:searchBar];
    }
}

- (void)searchBarPressedReturn:(GLBSearchBar*)searchBar {
    for(GLBDataViewItem* item in _items) {
        [item searchBarPressedReturn:searchBar];
    }
}

- (void)searchBarPressedCancel:(GLBSearchBar*)searchBar {
    for(GLBDataViewItem* item in _items) {
        [item searchBarPressedCancel:searchBar];
    }
}

#pragma mark - UIAccessibilityContainer

- (NSArray*)accessibilityElements {
    if(_accessibilityItems == nil) {
        _accessibilityItems = [self updateAccessibilityItems];
    }
    NSMutableArray* result = [NSMutableArray array];
    for(GLBDataViewItem* item in _accessibilityItems) {
        NSArray* accessibilityElements = item.accessibilityElements;
        if(accessibilityElements != nil) {
            [result addObjectsFromArray:accessibilityElements];
        }
    }
    return result;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
