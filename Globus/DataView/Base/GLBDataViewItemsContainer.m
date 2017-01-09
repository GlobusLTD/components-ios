/*--------------------------------------------------*/

#import "GLBDataViewItemsContainer+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBDataViewItemsContainer

#pragma mark - Synthesize

@synthesize entries = _entries;

#pragma mark - Init / Free

- (void)setup {
    [super setup];
    
    _entries = NSMutableArray.array;
}

#pragma mark - Public override

- (void)_willChangeView {
}

- (void)_didChangeView {
    for(GLBDataViewItem* entry in _entries) {
        entry.dataView = _dataView;
    }
}

- (void)beginUpdateAnimated:(BOOL)animated {
    [super beginUpdateAnimated:animated];
    
    for(GLBDataViewItem* entry in _entries) {
        [entry beginUpdateAnimated:animated];
    }
}

- (void)updateAnimated:(BOOL)animated {
    [super updateAnimated:animated];
    
    for(GLBDataViewItem* entry in _entries) {
        [entry updateAnimated:animated];
    }
}

- (void)endUpdateAnimated:(BOOL)animated {
    for(GLBDataViewItem* entry in _entries) {
        [entry endUpdateAnimated:animated];
    }
    
    [super endUpdateAnimated:animated];
}

- (CGRect)frameForAvailableFrame:(CGRect)frame {
    return [self frameEntriesForAvailableFrame:frame];
}

- (void)layoutForAvailableFrame:(CGRect)frame {
    [self layoutEntriesForFrame:frame];
}

- (void)willLayoutForBounds:(CGRect)bounds {
    [self willEntriesLayoutForBounds:CGRectIntersection(bounds, _frame)];
}

- (void)didLayoutForBounds:(CGRect)bounds {
    [self didEntriesLayoutForBounds:CGRectIntersection(bounds, _frame)];
}

- (void)setNeedResize {
    for(GLBDataViewItem* entry in _entries) {
        [entry setNeedResize];
    }
}

- (void)setNeedUpdate {
    for(GLBDataViewItem* entry in _entries) {
        [entry setNeedUpdate];
    }
}

- (NSArray*)allItems {
    return [_entries copy];
}

- (GLBDataViewItem*)itemForPoint:(CGPoint)point {
    for(GLBDataViewItem* entry in _entries) {
        if((entry.isHidden == YES) || (entry.isMoving == YES)) {
            continue;
        }
        if(CGRectContainsPoint(entry.frame, point) == YES) {
            return entry;
        }
    }
    return nil;
}

- (GLBDataViewItem*)itemForData:(id)data {
    for(GLBDataViewItem* entry in _entries) {
        id entryData = entry.data;
        if([entryData isEqual:data] == YES) {
            return entry;
        }
    }
    return nil;
}

#pragma mark - Public

- (void)prependEntry:(GLBDataViewItem*)entry {
    [_entries insertObject:entry atIndex:0];
    _accessibilityEntries = nil;
    entry.container = self;
    if(_dataView != nil) {
        [_dataView didInsertItems:@[ entry ]];
    }
}

- (void)prependEntries:(NSArray*)entries {
    [_entries insertObjects:entries atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, entries.count)]];
    _accessibilityEntries = nil;
    for(GLBDataViewItem* entry in entries) {
        entry.container = self;
    }
    if(_dataView != nil) {
        [_dataView didInsertItems:entries];
    }
}

- (void)appendEntry:(GLBDataViewItem*)entry {
    [_entries addObject:entry];
    _accessibilityEntries = nil;
    entry.container = self;
    if(_dataView != nil) {
        [_dataView didInsertItems:@[ entry ]];
    }
}

- (void)appendEntries:(NSArray*)entries {
    [_entries addObjectsFromArray:entries];
    _accessibilityEntries = nil;
    for(GLBDataViewItem* entry in entries) {
        entry.container = self;
    }
    if(_dataView != nil) {
        [_dataView didInsertItems:entries];
    }
}

- (void)insertEntry:(GLBDataViewItem*)entry atIndex:(NSUInteger)index {
    if(index != NSNotFound) {
        [_entries insertObject:entry atIndex:index];
        _accessibilityEntries = nil;
        entry.container = self;
        if(_dataView != nil) {
            [_dataView didInsertItems:@[ entry ]];
        }
    }
}

- (void)insertEntries:(NSArray*)entries atIndex:(NSUInteger)index {
    if(index != NSNotFound) {
        [_entries insertObjects:entries atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, entries.count)]];
        _accessibilityEntries = nil;
        for(GLBDataViewItem* entry in entries) {
            entry.container = self;
        }
        if(_dataView != nil) {
            [_dataView didInsertItems:entries];
        }
    }
}

- (void)insertEntry:(GLBDataViewItem*)entry aboveEntry:(GLBDataViewItem*)aboveEntry {
    NSUInteger index = [_entries indexOfObject:aboveEntry];
    if(index == NSNotFound) {
        index = 0;
    }
    [self insertEntry:entry atIndex:index];
}

- (void)insertEntries:(NSArray*)entries aboveEntry:(GLBDataViewItem*)aboveEntry {
    NSUInteger index = [_entries indexOfObject:aboveEntry];
    if(index == NSNotFound) {
        index = 0;
    }
    [self insertEntries:entries atIndex:index];
}

- (void)insertEntry:(GLBDataViewItem*)entry belowEntry:(GLBDataViewItem*)belowEntry {
    NSUInteger index = [_entries indexOfObject:belowEntry];
    if(index == NSNotFound) {
        index = (_entries.count > 0) ? _entries.count - 1 : 0;
    }
    [self insertEntry:entry atIndex:index + 1];
}

- (void)insertEntries:(NSArray*)entries belowEntry:(GLBDataViewItem*)belowEntry {
    NSUInteger index = [_entries indexOfObject:belowEntry];
    if(index == NSNotFound) {
        index = (_entries.count > 0) ? _entries.count - 1 : 0;
    }
    [self insertEntries:entries atIndex:index + 1];
}

- (void)replaceOriginEntry:(GLBDataViewItem*)originEntry withEntry:(GLBDataViewItem*)entry {
    NSUInteger index = [_entries indexOfObject:originEntry];
    if(index != NSNotFound) {
        entry.container = self;
        _entries[index] = entry;
        _accessibilityEntries = nil;
        if(_dataView != nil) {
            [_dataView didReplaceOriginItems:@[ originEntry ] withItems:@[ entry ]];
        }
    }
}

- (void)replaceOriginEntries:(NSArray*)originEntries withEntries:(NSArray*)entries {
    NSIndexSet* indexSet = [_entries indexesOfObjectsPassingTest:^BOOL(GLBDataViewItem* originEntry, NSUInteger index __unused, BOOL* stop __unused) {
        return [originEntries containsObject:originEntry];
    }];
    if(indexSet.count > 0) {
        for(GLBDataViewItem* entry in entries) {
            entry.container = self;
        }
        [_entries replaceObjectsAtIndexes:indexSet withObjects:entries];
        _accessibilityEntries = nil;
        if(_dataView != nil) {
            [_dataView didReplaceOriginItems:originEntries withItems:entries];
        }
    }
}

- (void)deleteEntry:(GLBDataViewItem*)entry {
    [_entries removeObject:entry];
    _accessibilityEntries = nil;
    if(_dataView != nil) {
        [_dataView didDeleteItems:@[ entry ]];
    }
}

- (void)deleteEntries:(NSArray*)entries {
    [_entries removeObjectsInArray:entries];
    _accessibilityEntries = nil;
    if(_dataView != nil) {
        [_dataView didDeleteItems:entries];
    }
}

- (void)deleteAllEntries {
    [self deleteEntries:[_entries copy]];
}

- (CGPoint)alignWithVelocity:(CGPoint __unused)velocity contentOffset:(CGPoint)contentOffset contentSize:(CGSize)contentSize visibleSize:(CGSize)visibleSize {
    if((_allowAutoAlign == YES) && (_hidden == NO)) {
        CGPoint alingPoint = [self alignPointWithContentOffset:contentOffset contentSize:contentSize visibleSize:visibleSize];
        if(CGRectContainsPoint(_frame, alingPoint) == YES) {
            for(GLBDataViewItem* item in _entries) {
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
    for(GLBDataViewItem* item in _entries) {
        [item beginTransition];
    }
}

- (void)transitionResize {
    for(GLBDataViewItem* item in _entries) {
        [item transitionResize];
    }
}

- (void)endTransition {
    for(GLBDataViewItem* item in _entries) {
        [item endTransition];
    }
}

- (CGRect)frameEntriesForAvailableFrame:(CGRect)frame {
    return CGRectNull;
}

- (void)layoutEntriesForFrame:(CGRect)frame {
}

- (void)willEntriesLayoutForBounds:(CGRect)bounds {
}

- (void)didEntriesLayoutForBounds:(CGRect)bounds {
    for(GLBDataViewItem* entry in _entries) {
        if(entry.hidden == YES) {
            continue;
        }
        [entry validateLayoutForBounds:bounds];
    }
}

- (NSArray*)updateAccessibilityEntries {
    NSArray< GLBDataViewItem* >* visibleEntries = [_entries filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(GLBDataViewItem* entry, NSDictionary* bindings) {
        return (entry.isHidden == NO);
    }]];
    return [visibleEntries sortedArrayUsingComparator:^NSComparisonResult(GLBDataViewItem* entry1, GLBDataViewItem* entry2) {
        if(entry1.accessibilityOrder < entry2.accessibilityOrder) {
            return NSOrderedAscending;
        } else if(entry1.accessibilityOrder > entry2.accessibilityOrder) {
            return NSOrderedDescending;
        }
        CGRect entryFrame1 = entry1.frame;
        CGRect entryFrame2 = entry2.frame;
        if(entryFrame1.origin.y < entryFrame2.origin.y) {
            return NSOrderedAscending;
        } else if(entryFrame1.origin.x < entryFrame2.origin.x) {
            return NSOrderedAscending;
        } else if(entryFrame1.origin.y > entryFrame2.origin.y) {
            return NSOrderedDescending;
        } else if(entryFrame1.origin.x > entryFrame2.origin.x) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
}

#pragma mark - GLBSearchBarDelegate

- (void)searchBarBeginSearch:(GLBSearchBar*)searchBar {
    for(GLBDataViewItem* entry in _entries) {
        [entry searchBarBeginSearch:searchBar];
    }
}

- (void)searchBarEndSearch:(GLBSearchBar*)searchBar {
    for(GLBDataViewItem* entry in _entries) {
        [entry searchBarEndSearch:searchBar];
    }
}

- (void)searchBarBeginEditing:(GLBSearchBar*)searchBar {
    for(GLBDataViewItem* entry in _entries) {
        [entry searchBarBeginEditing:searchBar];
    }
}

- (void)searchBar:(GLBSearchBar*)searchBar textChanged:(NSString*)textChanged {
    for(GLBDataViewItem* entry in _entries) {
        [entry searchBar:searchBar textChanged:textChanged];
    }
}

- (void)searchBarEndEditing:(GLBSearchBar*)searchBar {
    for(GLBDataViewItem* entry in _entries) {
        [entry searchBarEndEditing:searchBar];
    }
}

- (void)searchBarPressedClear:(GLBSearchBar*)searchBar {
    for(GLBDataViewItem* entry in _entries) {
        [entry searchBarPressedClear:searchBar];
    }
}

- (void)searchBarPressedReturn:(GLBSearchBar*)searchBar {
    for(GLBDataViewItem* entry in _entries) {
        [entry searchBarPressedReturn:searchBar];
    }
}

- (void)searchBarPressedCancel:(GLBSearchBar*)searchBar {
    for(GLBDataViewItem* entry in _entries) {
        [entry searchBarPressedCancel:searchBar];
    }
}

#pragma mark - UIAccessibilityContainer

- (NSArray*)accessibilityElements {
    if(_accessibilityEntries == nil) {
        _accessibilityEntries = [self updateAccessibilityEntries];
    }
    NSMutableArray* result = [NSMutableArray array];
    for(GLBDataViewItem* entry in _accessibilityEntries) {
        NSArray* accessibilityElements = entry.accessibilityElements;
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
