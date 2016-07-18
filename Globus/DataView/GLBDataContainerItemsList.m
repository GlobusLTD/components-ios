/*--------------------------------------------------*/

#import "GLBDataContainer+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import "NSArray+GLBNS.h"

/*--------------------------------------------------*/

@implementation GLBDataContainerItemsList

#pragma mark - Synthesize

@synthesize orientation = _orientation;
@synthesize mode = _mode;
@synthesize reverse = _reverse;
@synthesize margin = _margin;
@synthesize spacing = _spacing;
@synthesize defaultSize = _defaultSize;
@synthesize defaultOrder = _defaultOrder;
@synthesize header = _header;
@synthesize footer = _footer;
@synthesize items = _items;

#pragma mark - Init / Free

+ (instancetype)containerWithOrientation:(GLBDataContainerOrientation)orientation {
    return [[self alloc] initWithOrientation:orientation];
}

- (instancetype)initWithOrientation:(GLBDataContainerOrientation)orientation {
    self = [super init];
    if(self != nil) {
        _orientation = orientation;
    }
    return self;
}

- (void)setup {
    [super setup];
    
    _orientation = GLBDataContainerOrientationVertical;
    _margin = UIEdgeInsetsZero;
    _spacing = UIOffsetZero;
    _defaultSize = CGSizeZero;
    _items = NSMutableArray.array;
    _movingFrame = CGRectZero;
}

- (void)dealloc {
}

#pragma mark - Property

- (void)setOrientation:(GLBDataContainerOrientation)orientation {
    if(_orientation != orientation) {
        _orientation = orientation;
        if(_view != nil) {
            [_view setNeedValidateLayout];
        }
    }
}

- (void)setMode:(GLBDataContainerItemsListMode)mode {
    if(_mode != mode) {
        _mode = mode;
        [_view setNeedValidateLayout];
    }
}

- (void)setMargin:(UIEdgeInsets)margin {
    if(UIEdgeInsetsEqualToEdgeInsets(_margin, margin) == NO) {
        _margin = margin;
        if(_view != nil) {
            [_view setNeedValidateLayout];
        }
    }
}

- (void)setSpacing:(UIOffset)spacing {
    if(UIOffsetEqualToOffset(_spacing, spacing) == NO) {
        _spacing = spacing;
        if(_view != nil) {
            [_view setNeedValidateLayout];
        }
    }
}

- (void)setDefaultSize:(CGSize)defaultSize {
    if(CGSizeEqualToSize(_defaultSize, defaultSize) == NO) {
        _defaultSize = defaultSize;
        if(_view != nil) {
            [_view setNeedValidateLayout];
        }
    }
}

- (void)setDefaultWidth:(CGFloat)defaultWidth {
    self.defaultSize = CGSizeMake(defaultWidth, _defaultSize.height);
}

- (CGFloat)defaultWidth {
    return _defaultSize.width;
}

- (void)setDefaultHeight:(CGFloat)defaultHeight {
    self.defaultSize = CGSizeMake(_defaultSize.width, defaultHeight);
}

- (CGFloat)defaultHeight {
    return _defaultSize.height;
}

- (void)setHeader:(GLBDataItem*)header {
    if(_header != header) {
        if(_header != nil) {
            [self _deleteEntry:_header];
        }
        _header = header;
        if(_header != nil) {
            [self _prependEntry:_header];
        }
        if(_view != nil) {
            [_view setNeedValidateLayout];
        }
    }
}

- (void)setFooter:(GLBDataItem*)footer {
    if(_footer != footer) {
        if(_footer != nil) {
            [self _deleteEntry:_footer];
        }
        _footer = footer;
        if(_footer != nil) {
            [self _appendEntry:_footer];
        }
        if(_view != nil) {
            [_view setNeedValidateLayout];
        }
    }
}

#pragma mark - Public

- (GLBDataItem*)prependIdentifier:(NSString*)identifier byData:(id)data {
    return [self prependIdentifier:identifier byData:data order:_defaultOrder configure:nil];
}

- (GLBDataItem*)prependIdentifier:(NSString*)identifier byData:(id)data configure:(GLBDataContainerConfigureItemBlock)configure {
    return [self prependIdentifier:identifier byData:data order:_defaultOrder configure:configure];
}

- (GLBDataItem*)prependIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order {
    return [self prependIdentifier:identifier byData:data order:order configure:nil];
}

- (GLBDataItem*)prependIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order configure:(GLBDataContainerConfigureItemBlock)configure {
    GLBDataItem* item = [GLBDataItem itemWithIdentifier:identifier order:order data:data];
    if(configure != nil) {
        configure(item);
    }
    [self prependItem:item];
    return item;
}

- (void)prependItem:(GLBDataItem*)item {
    [_items insertObject:item atIndex:0];
    if(_header != nil) {
        [self _insertEntry:item atIndex:[_entries indexOfObject:_header] + 1];
    } else {
        [self _prependEntry:item];
    }
}

- (void)prependItems:(NSArray*)items {
    [_items insertObjects:items atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, items.count)]];
    if(_header != nil) {
        [self _insertEntries:items atIndex:[_entries indexOfObject:_header] + 1];
    } else {
        [self _prependEntries:items];
    }
}

- (GLBDataItem*)appendIdentifier:(NSString*)identifier byData:(id)data {
    return [self appendIdentifier:identifier byData:data order:_defaultOrder configure:nil];
}

- (GLBDataItem*)appendIdentifier:(NSString*)identifier byData:(id)data configure:(GLBDataContainerConfigureItemBlock)configure {
    return [self appendIdentifier:identifier byData:data order:_defaultOrder configure:configure];
}

- (GLBDataItem*)appendIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order {
    return [self appendIdentifier:identifier byData:data order:order configure:nil];
}

- (GLBDataItem*)appendIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order configure:(GLBDataContainerConfigureItemBlock)configure {
    GLBDataItem* item = [GLBDataItem itemWithIdentifier:identifier order:order data:data];
    if(configure != nil) {
        configure(item);
    }
    [self appendItem:item];
    return item;
}

- (void)appendItem:(GLBDataItem*)item {
    [_items addObject:item];
    if(_footer != nil) {
        [self _insertEntry:item atIndex:[_entries indexOfObject:_footer] - 1];
    } else {
        [self _appendEntry:item];
    }
}

- (void)appendItems:(NSArray*)items {
    [_items addObjectsFromArray:items];
    if(_footer != nil) {
        [self _insertEntries:items atIndex:[_entries indexOfObject:_footer] - 1];
    } else {
        [self _appendEntries:items];
    }
}

- (GLBDataItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data {
    return [self insertIdentifier:identifier atIndex:index byData:data order:_defaultOrder configure:nil];
}

- (GLBDataItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data configure:(GLBDataContainerConfigureItemBlock)configure {
    return [self insertIdentifier:identifier atIndex:index byData:data order:_defaultOrder configure:configure];
}

- (GLBDataItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data order:(NSUInteger)order {
    return [self insertIdentifier:identifier atIndex:index byData:data order:order configure:nil];
}

- (GLBDataItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data order:(NSUInteger)order configure:(GLBDataContainerConfigureItemBlock)configure {
    GLBDataItem* item = [GLBDataItem itemWithIdentifier:identifier order:order data:data];
    if(configure != nil) {
        configure(item);
    }
    [self insertItem:item atIndex:index];
    return item;
}

- (void)insertItem:(GLBDataItem*)item atIndex:(NSUInteger)index {
    [_items insertObject:item atIndex:index];
    if(_header != nil) {
        index = MAX(index, [_entries indexOfObject:_header] + 1);
    }
    if(_footer != nil) {
        index = MIN(index, [_entries indexOfObject:_footer] - 1);
    }
    [self _insertEntry:item atIndex:index];
}

- (void)insertItems:(NSArray*)items atIndex:(NSUInteger)index {
    [_items insertObjects:items atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, items.count)]];
    if(_header != nil) {
        index = MAX(index, [_entries indexOfObject:_header] + 1);
    }
    if(_footer != nil) {
        index = MIN(index, [_entries indexOfObject:_footer] - 1);
    }
    [self _insertEntries:items atIndex:index];
}

- (void)insertItem:(GLBDataItem*)item aboveItem:(GLBDataItem*)aboveItem {
    NSUInteger index = [_items indexOfObject:aboveItem];
    if(index != NSNotFound) {
        [self insertItem:item atIndex:index];
    }
}

- (void)insertItems:(NSArray*)items aboveItem:(GLBDataItem*)aboveItem {
    NSUInteger index = [_items indexOfObject:aboveItem];
    if(index != NSNotFound) {
        [self insertItems:items atIndex:index];
    }
}

- (void)insertItem:(GLBDataItem*)item belowItem:(GLBDataItem*)belowItem {
    NSUInteger index = [_items indexOfObject:belowItem];
    if(index != NSNotFound) {
        [self insertItem:item atIndex:index + 1];
    }
}

- (void)insertItems:(NSArray*)items belowItem:(GLBDataItem*)belowItem {
    NSUInteger index = [_items indexOfObject:belowItem];
    if(index != NSNotFound) {
        [self insertItems:items atIndex:index + 1];
    }
}

- (void)replaceOriginItem:(GLBDataItem*)originItem withItem:(GLBDataItem*)item {
    NSUInteger index = [_items indexOfObject:originItem];
    if(index != NSNotFound) {
        _items[index] = item;
        [self _replaceOriginEntry:originItem withEntry:item];
    }
}

- (void)replaceOriginItems:(NSArray*)originItems withItems:(NSArray*)items {
    NSIndexSet* indexSet = [_items indexesOfObjectsPassingTest:^BOOL(GLBDataItem* originItem, NSUInteger index __unused, BOOL* stop __unused) {
        return [originItems containsObject:originItem];
    }];
    if(indexSet.count == items.count) {
        [_items replaceObjectsAtIndexes:indexSet withObjects:items];
        [self _replaceOriginEntries:originItems withEntries:items];
    }
}

- (void)deleteItem:(GLBDataItem*)item {
    if([_items containsObject:item] == YES) {
        [_items removeObject:item];
        [self _deleteEntry:item];
    }
}

- (void)deleteItems:(NSArray*)items {
    if([_items glb_containsObjectsInArray:items] == YES) {
        [_items removeObjectsInArray:items];
        [self _deleteEntries:items];
    }
}

- (void)deleteAllItems {
    if(_items.count > 0) {
        NSArray* items = [NSArray arrayWithArray:_items];
        [_items removeAllObjects];
        [self _deleteEntries:items];
    }
}

#pragma mark - Private override

- (CGRect)_validateEntriesForAvailableFrame:(CGRect)frame {
    __block CGPoint offset = CGPointMake(frame.origin.x + _margin.left, frame.origin.y + _margin.top);
    CGSize restriction = CGSizeMake(frame.size.width - (_margin.left + _margin.right), frame.size.height - (_margin.top + _margin.bottom));
    CGSize cumulative = CGSizeZero;
    switch(_orientation) {
        case GLBDataContainerOrientationVertical: {
            CGFloat availableWidth = (_defaultSize.width > 0) ? _defaultSize.width : restriction.width;
            CGFloat availableHeight = (_defaultSize.height > 0) ? _defaultSize.height : restriction.height;
            CGSize availableSize = CGSizeMake(availableWidth, availableHeight);
            for(GLBDataItem* entry in _entries) {
                CGSize entrySize = [entry sizeForAvailableSize:availableSize];
                if((entrySize.width >= FLT_EPSILON) && (entrySize.height >= FLT_EPSILON) && (entry.hidden == NO)) {
                    cumulative.width = MAX(cumulative.width, entrySize.width);
                    cumulative.height += entrySize.height + _spacing.vertical;
                }
            }
            if(cumulative.height > FLT_EPSILON) {
                cumulative.height -= _spacing.vertical;
            }
            NSEnumerationOptions enumOption = (_reverse == YES) ? NSEnumerationReverse : 0;
            switch(_mode) {
                case GLBDataContainerItemsListModeBegin:
                    break;
                case GLBDataContainerItemsListModeCenter:
                    offset.y += (restriction.height * 0.5f) - (cumulative.height * 0.5f);
                    if(restriction.height > cumulative.height) {
                        cumulative.height = restriction.height;
                    }
                    break;
                case GLBDataContainerItemsListModeEnd:
                    offset.y += cumulative.height - restriction.height;
                    if(restriction.height > cumulative.height) {
                        cumulative.height = restriction.height;
                    }
                    break;
            }
            [_entries glb_each:^(GLBDataItem* entry) {
                CGSize entrySize = [entry sizeForAvailableSize:availableSize];
                BOOL entryHidden = entry.hiddenInHierarchy;
                if((entrySize.width >= FLT_EPSILON) && (entrySize.height >= FLT_EPSILON)) {
                    if(entry.isMoving == NO) {
                        CGFloat height = (entryHidden == NO) ? entrySize.height : 0.0f;
                        entry.updateFrame = CGRectMake(offset.x, offset.y, entrySize.width, height);
                    }
                    if(entryHidden == NO) {
                        offset.y += entrySize.height + _spacing.vertical;
                    }
                }
            } options:enumOption];
            break;
        }
        case GLBDataContainerOrientationHorizontal: {
            CGFloat availableWidth = (_defaultSize.width > 0) ? _defaultSize.width : restriction.width;
            CGFloat availableHeight = (_defaultSize.height > 0) ? _defaultSize.height : restriction.height;
            CGSize availableSize = CGSizeMake(availableWidth, availableHeight);
            for(GLBDataItem* entry in _entries) {
                CGSize entrySize = [entry sizeForAvailableSize:availableSize];
                if((entrySize.width >= FLT_EPSILON) && (entrySize.height >= FLT_EPSILON) && (entry.hidden == NO)) {
                    cumulative.width += entrySize.width + _spacing.horizontal;
                    cumulative.height = MAX(cumulative.height, entrySize.height);
                }
            }
            if(cumulative.width > FLT_EPSILON) {
                cumulative.width -= _spacing.horizontal;
            }
            NSEnumerationOptions enumOption = (_reverse == YES) ? NSEnumerationReverse : 0;
            switch(_mode) {
                case GLBDataContainerItemsListModeBegin:
                    break;
                case GLBDataContainerItemsListModeCenter:
                    offset.x += (restriction.width * 0.5f) - (cumulative.width * 0.5f);
                    if(restriction.width > cumulative.width) {
                        cumulative.width = restriction.width;
                    }
                    break;
                case GLBDataContainerItemsListModeEnd:
                    offset.x += cumulative.width - restriction.width;
                    if(restriction.width > cumulative.width) {
                        cumulative.width = restriction.width;
                    }
                    break;
            }
            [_entries glb_each:^(GLBDataItem* entry) {
                CGSize entrySize = [entry sizeForAvailableSize:availableSize];
                BOOL entryHidden = entry.hiddenInHierarchy;
                if((entrySize.width >= FLT_EPSILON) && (entrySize.height >= FLT_EPSILON)) {
                    if(entry.isMoving == NO) {
                        CGFloat width = (entryHidden == NO) ? entrySize.width : 0.0f;
                        entry.updateFrame = CGRectMake(offset.x, offset.y, width, entrySize.height);
                    }
                    if(entryHidden == NO) {
                        offset.x += entrySize.width + _spacing.horizontal;
                    }
                }
            } options:enumOption];
            break;
        }
    }
    return CGRectMake(frame.origin.x, frame.origin.y, _margin.left + cumulative.width + _margin.right, _margin.top + cumulative.height + _margin.bottom);
}

- (void)_willEntriesLayoutForBounds:(CGRect)bounds {
    switch(_orientation) {
        case GLBDataContainerOrientationVertical: {
            CGFloat boundsBefore = bounds.origin.y;
            CGFloat boundsAfter = bounds.origin.y + bounds.size.height;
            CGFloat entriesBefore = _frame.origin.y;
            CGFloat entriesAfter = _frame.origin.y + _frame.size.height;
            if((_header != nil) && (_header.hidden == NO)) {
                CGRect headerFrame = _header.updateFrame;
                headerFrame.origin.y = boundsBefore;
                if((_footer != nil) && (_footer.hidden == NO)) {
                    CGRect footerFrame = _footer.updateFrame;
                    headerFrame.origin.y = MIN(headerFrame.origin.y, (boundsAfter - (_spacing.vertical + footerFrame.size.height)) - headerFrame.size.height);
                } else {
                    headerFrame.origin.y = MIN(headerFrame.origin.y, boundsAfter - headerFrame.size.height);
                }
                headerFrame.origin.y = MAX(entriesBefore, MIN(headerFrame.origin.y, entriesAfter - headerFrame.size.height));
                _header.displayFrame = headerFrame;
            }
            if((_footer != nil) && (_footer.hidden == NO)) {
                CGRect footerFrame = _footer.updateFrame;
                footerFrame.origin.y = boundsAfter - footerFrame.size.height;
                if((_header != nil) && (_header.hidden == NO)) {
                    CGRect headerFrame = _header.updateFrame;
                    footerFrame.origin.y = MAX(footerFrame.origin.y, (boundsBefore + _spacing.vertical) + headerFrame.size.height);
                } else {
                    footerFrame.origin.y = MAX(footerFrame.origin.y, boundsBefore);
                }
                footerFrame.origin.y = MAX(entriesBefore, MIN(footerFrame.origin.y, entriesAfter - footerFrame.size.height));
                _footer.displayFrame = footerFrame;
            }
            break;
        }
        case GLBDataContainerOrientationHorizontal: {
            CGFloat boundsBefore = bounds.origin.x;
            CGFloat boundsAfter = bounds.origin.x + bounds.size.width;
            CGFloat entriesBefore = _frame.origin.x;
            CGFloat entriesAfter = _frame.origin.x + _frame.size.width;
            if((_header != nil) && (_header.hidden == NO)) {
                CGRect headerFrame = _header.updateFrame;
                headerFrame.origin.x = boundsBefore;
                if((_footer != nil) && (_footer.hidden == NO)) {
                    CGRect footerFrame = _footer.updateFrame;
                    headerFrame.origin.x = MIN(headerFrame.origin.x, (boundsAfter - (_spacing.horizontal + footerFrame.size.width)) - headerFrame.size.width);
                } else {
                    headerFrame.origin.x = MIN(headerFrame.origin.x, boundsAfter - headerFrame.size.width);
                }
                headerFrame.origin.x = MAX(entriesBefore, MIN(headerFrame.origin.x, entriesAfter - headerFrame.size.width));
                _header.displayFrame = headerFrame;
            }
            if((_footer != nil) && (_footer.hidden == NO)) {
                CGRect footerFrame = _footer.updateFrame;
                footerFrame.origin.x = boundsAfter - footerFrame.size.width;
                if((_header != nil) && (_header.hidden == NO)) {
                    CGRect headerFrame = _header.updateFrame;
                    footerFrame.origin.x = MAX(footerFrame.origin.x, (boundsBefore + _spacing.horizontal) + headerFrame.size.width);
                } else {
                    footerFrame.origin.x = MAX(footerFrame.origin.x, boundsBefore);
                }
                footerFrame.origin.x = MAX(entriesBefore, MIN(footerFrame.origin.x, entriesAfter - footerFrame.size.width));
                _footer.displayFrame = footerFrame;
            }
            break;
        }
    }
}

- (void)_beginMovingItem:(GLBDataItem*)item location:(CGPoint)location {
    if(_items.count >= 2) {
        GLBDataItem* firstMovingRange = [_items glb_find:^BOOL(GLBDataItem* existItem) {
            return existItem.allowsMoving;
        }];
        GLBDataItem* lastMovingRange = [_items glb_find:^BOOL(GLBDataItem* existItem) {
            return existItem.allowsMoving;
        } options:NSEnumerationReverse];
        if(firstMovingRange != lastMovingRange) {
            _movingFrame = CGRectUnion(firstMovingRange.updateFrame, lastMovingRange.updateFrame);
        }
    }
}

- (void)_movingItem:(GLBDataItem*)item location:(CGPoint)location delta:(CGPoint)delta allowsSorting:(BOOL)allowsSorting {
    CGRect frame = item.updateFrame;
    if(CGRectIsEmpty(_movingFrame) == NO) {
        NSUInteger srcIndex = [_items indexOfObject:item];
        NSUInteger dstIndex = srcIndex;
        switch(_orientation) {
            case GLBDataContainerOrientationVertical: {
                frame = CGRectOffset(frame, 0.0f, delta.y);
                CGFloat upperLimit = CGRectGetMinY(_movingFrame);
                CGFloat lowerLimit = CGRectGetMaxY(_movingFrame);
                if(frame.origin.y < upperLimit) {
                    frame.origin.y = upperLimit;
                } else if(frame.origin.y + frame.size.height > lowerLimit) {
                    frame.origin.y = lowerLimit - frame.size.height;
                }
                break;
            }
            case GLBDataContainerOrientationHorizontal: {
                frame = CGRectOffset(frame, delta.x, 0.0f);
                CGFloat upperLimit = CGRectGetMinX(_movingFrame);
                CGFloat lowerLimit = CGRectGetMaxX(_movingFrame);
                if(frame.origin.x < upperLimit) {
                    frame.origin.x = upperLimit;
                } else if(frame.origin.x + frame.size.width > lowerLimit) {
                    frame.origin.x = lowerLimit - frame.size.width;
                }
                break;
            }
        }
        GLBDataItem* dstItem = [self itemForPoint:CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame))];
        if(dstItem != nil) {
            dstIndex = [_items indexOfObject:dstItem];
        }
        if((srcIndex != dstIndex) && (allowsSorting == YES)) {
            NSUInteger entrySrcIndex = [_entries indexOfObject:_items[srcIndex]];
            NSUInteger entryDstIndex = [_entries indexOfObject:_items[dstIndex]];
            if((entrySrcIndex != NSNotFound) && (entrySrcIndex != entryDstIndex)) {
                [_entries glb_moveObjectAtIndex:entrySrcIndex toIndex:entryDstIndex];
            }
            [_items glb_moveObjectAtIndex:srcIndex toIndex:dstIndex];
            
            __weak typeof(self) weakSelf = self;
            [self.view batchDuration:0.1f update:^{
                [weakSelf.view setNeedValidateLayout];
            }];
        }
    }
    item.updateFrame = frame;
}

- (void)_endMovingItem:(GLBDataItem*)item location:(CGPoint)location {
    _movingFrame = CGRectZero;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
