/*--------------------------------------------------*/

#import "GLBDataViewItemsFlowContainer+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBDataViewItemsFlowContainer

#pragma mark - Synthesize

@synthesize orientation = _orientation;
@synthesize margin = _margin;
@synthesize spacing = _spacing;
@synthesize defaultSize = _defaultSize;
@synthesize defaultOrder = _defaultOrder;
@synthesize header = _header;
@synthesize footer = _footer;
@synthesize items = _items;

#pragma mark - Init / Free

+ (instancetype)containerWithOrientation:(GLBDataViewContainerOrientation)orientation {
    return [[self alloc] initWithOrientation:orientation];
}

- (instancetype)initWithOrientation:(GLBDataViewContainerOrientation)orientation {
    self = [super init];
    if(self != nil) {
        _orientation = orientation;
    }
    return self;
}

- (void)setup {
    [super setup];
    
    _orientation = GLBDataViewContainerOrientationVertical;
    _margin = UIEdgeInsetsZero;
    _spacing = UIOffsetZero;
    _defaultSize = CGSizeZero;
    _items = NSMutableArray.array;
}

#pragma mark - Property

- (void)setOrientation:(GLBDataViewContainerOrientation)orientation {
    if(_orientation != orientation) {
        _orientation = orientation;
        if(_dataView != nil) {
            [_dataView setNeedValidateLayout];
        }
    }
}

- (void)setMargin:(UIEdgeInsets)margin {
    if(UIEdgeInsetsEqualToEdgeInsets(_margin, margin) == NO) {
        _margin = margin;
        if(_dataView != nil) {
            [_dataView setNeedValidateLayout];
        }
    }
}

- (void)setSpacing:(UIOffset)spacing {
    if(UIOffsetEqualToOffset(_spacing, spacing) == NO) {
        _spacing = spacing;
        if(_dataView != nil) {
            [_dataView setNeedValidateLayout];
        }
    }
}

- (void)setDefaultSize:(CGSize)defaultSize {
    if(CGSizeEqualToSize(_defaultSize, defaultSize) == NO) {
        _defaultSize = defaultSize;
        if(_dataView != nil) {
            [_dataView setNeedValidateLayout];
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

- (void)setHeader:(GLBDataViewItem*)header {
    if(_header != header) {
        if(_header != nil) {
            [super deleteEntry:_header];
        }
        _header = header;
        if(_header != nil) {
            [super appendEntry:_header];
        }
        if(_dataView != nil) {
            [_dataView setNeedValidateLayout];
        }
    }
}

- (void)setFooter:(GLBDataViewItem*)footer {
    if(_footer != footer) {
        if(_footer != nil) {
            [super deleteEntry:_footer];
        }
        _footer = footer;
        if(_footer != nil) {
            [super appendEntry:_footer];
        }
        if(_dataView != nil) {
            [_dataView setNeedValidateLayout];
        }
    }
}

#pragma mark - Public override

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
    if(_header != nil) {
        [super insertEntry:item atIndex:[_entries indexOfObject:_header] + 1];
    } else {
        [super prependEntry:item];
    }
}

- (void)prependItems:(NSArray*)items {
    [_items insertObjects:items atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, items.count)]];
    if(_header != nil) {
        [super insertEntries:items atIndex:[_entries indexOfObject:_header] + 1];
    } else {
        [super prependEntries:items];
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
    if(_footer != nil) {
        [super insertEntry:item atIndex:[_entries indexOfObject:_footer] - 1];
    } else {
        [super appendEntry:item];
    }
}

- (void)appendItems:(NSArray*)items {
    [_items addObjectsFromArray:items];
    if(_footer != nil) {
        [super insertEntries:items atIndex:[_entries indexOfObject:_footer] - 1];
    } else {
        [super appendEntries:items];
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
    GLBDataViewItem* item = nil;
    if(index != NSNotFound) {
        item = [GLBDataViewItem itemWithIdentifier:identifier order:order data:data];
        if(configure != nil) {
            configure(item);
        }
        [self insertItem:item atIndex:index];
    }
    return item;
}

- (void)insertItem:(GLBDataViewItem*)item atIndex:(NSUInteger)index {
    if(index != NSNotFound) {
        [_items insertObject:item atIndex:index];
        if(_header != nil) {
            index = MAX(index, [_entries indexOfObject:_header] + 1);
        }
        if(_footer != nil) {
            index = MIN(index, [_entries indexOfObject:_footer] - 1);
        }
        [super insertEntry:item atIndex:index];
    }
}

- (void)insertItems:(NSArray*)items atIndex:(NSUInteger)index {
    if((index != NSNotFound) && (items.count > 0)) {
        [_items insertObjects:items atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, items.count)]];
        if(_header != nil) {
            index = MAX(index, [_entries indexOfObject:_header] + 1);
        }
        if(_footer != nil) {
            index = MIN(index, [_entries indexOfObject:_footer] - 1);
        }
        [super insertEntries:items atIndex:index];
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
        _items[index] = item;
        [super replaceOriginEntry:originItem withEntry:item];
    }
}

- (void)replaceOriginItems:(NSArray*)originItems withItems:(NSArray*)items {
    NSIndexSet* indexSet = [_items indexesOfObjectsPassingTest:^BOOL(GLBDataViewItem* originItem, NSUInteger index __unused, BOOL* stop __unused) {
        return [originItems containsObject:originItem];
    }];
    if(indexSet.count == items.count) {
        [_items replaceObjectsAtIndexes:indexSet withObjects:items];
        [super replaceOriginEntries:originItems withEntries:items];
    }
}

- (void)deleteItem:(GLBDataViewItem*)item {
    if([_items containsObject:item] == YES) {
        [_items removeObject:item];
        [super deleteEntry:item];
    }
}

- (void)deleteItems:(NSArray*)items {
    if([_items glb_containsObjectsInArray:items] == YES) {
        [_items removeObjectsInArray:items];
        [super deleteEntries:items];
    }
}

- (void)deleteAllItems {
    if(_items.count > 0) {
        NSArray* items = [NSArray arrayWithArray:_items];
        [super deleteEntries:items];
        [_items removeAllObjects];
    }
}

- (CGRect)frameEntriesForAvailableFrame:(CGRect)frame {
    CGSize restriction = CGSizeMake(frame.size.width - (_margin.left + _margin.right), frame.size.height - (_margin.top + _margin.bottom));
    CGSize cumulative = CGSizeZero, cumulativeRow = CGSizeZero;
    NSUInteger countOfRow = 0;
    
    switch(_orientation) {
        case GLBDataViewContainerOrientationVertical: {
            CGFloat availableWidth = (_defaultSize.width > 0) ? _defaultSize.width : restriction.width;
            CGFloat availableHeight = (_defaultSize.height > 0) ? _defaultSize.height : restriction.height;
            CGSize availableSize = CGSizeMake(availableWidth, availableHeight);
            for(GLBDataViewItem* entry in _entries) {
                if(entry.hidden == YES) {
                    continue;
                }
                CGSize entrySize = [entry sizeForAvailableSize:availableSize];
                if((countOfRow > 0) && (cumulativeRow.width + entrySize.width > restriction.width)) {
                    cumulative.width = MAX(restriction.width, cumulativeRow.width);
                    cumulative.height += cumulativeRow.height + _spacing.vertical;
                    cumulativeRow = CGSizeZero;
                    countOfRow = 0;
                }
                cumulativeRow.width += entrySize.width + _spacing.horizontal;
                cumulativeRow.height = MAX(entrySize.height, cumulativeRow.height);
                countOfRow++;
            }
            if(countOfRow > 0) {
                cumulative.width = MAX(restriction.width, cumulativeRow.width);
                cumulative.height += cumulativeRow.height + _spacing.vertical;
            }
            cumulative.width -= _spacing.horizontal;
            cumulative.height -= _spacing.vertical;
            break;
        }
        case GLBDataViewContainerOrientationHorizontal: {
            CGFloat availableWidth = (_defaultSize.width > 0) ? _defaultSize.width : restriction.width;
            CGFloat availableHeight = (_defaultSize.height > 0) ? _defaultSize.height : restriction.height;
            CGSize availableSize = CGSizeMake(availableWidth, availableHeight);
            for(GLBDataViewItem* entry in _entries) {
                if(entry.hidden == YES) {
                    continue;
                }
                CGSize entrySize = [entry sizeForAvailableSize:availableSize];
                if((countOfRow > 0) && (cumulativeRow.height + entrySize.height > restriction.height)) {
                    cumulative.width += cumulativeRow.width + _spacing.horizontal;
                    cumulative.height = MAX(restriction.height, cumulativeRow.height);
                    cumulativeRow = CGSizeZero;
                    countOfRow = 0;
                }
                cumulativeRow.width = MAX(entrySize.width, cumulativeRow.width);
                cumulativeRow.height += entrySize.height + _spacing.vertical;
                countOfRow++;
            }
            if(countOfRow > 0) {
                cumulative.width += cumulativeRow.width + _spacing.horizontal;
                cumulative.height = MAX(restriction.height, cumulativeRow.height);
            }
            cumulative.width -= _spacing.horizontal;
            cumulative.height -= _spacing.vertical;
            break;
        }
    }
    return CGRectMake(frame.origin.x, frame.origin.y, _margin.left + cumulative.width + _margin.right, _margin.top + cumulative.height + _margin.bottom);
}

- (void)layoutEntriesForFrame:(CGRect)frame {
    CGPoint offset = CGPointMake(frame.origin.x + _margin.left, frame.origin.y + _margin.top);
    CGSize restriction = CGSizeMake(frame.size.width - (_margin.left + _margin.right), frame.size.height - (_margin.top + _margin.bottom));
    CGSize cumulative = CGSizeZero, cumulativeRow = CGSizeZero;
    NSUInteger countOfRow = 0;
    
    switch(_orientation) {
        case GLBDataViewContainerOrientationVertical: {
            CGFloat availableWidth = (_defaultSize.width > 0) ? _defaultSize.width : restriction.width;
            CGFloat availableHeight = (_defaultSize.height > 0) ? _defaultSize.height : restriction.height;
            CGSize availableSize = CGSizeMake(availableWidth, availableHeight);
            for(GLBDataViewItem* entry in _entries) {
                if(entry.hidden == YES) {
                    continue;
                }
                CGSize entrySize = [entry sizeForAvailableSize:availableSize];
                if((countOfRow > 0) && (cumulativeRow.width + entrySize.width > restriction.width)) {
                    offset.x = frame.origin.x + _margin.left;
                    offset.y += cumulativeRow.height + _spacing.vertical;
                    cumulative.width = MAX(restriction.width, cumulativeRow.width);
                    cumulative.height += cumulativeRow.height + _spacing.vertical;
                    cumulativeRow = CGSizeZero;
                    countOfRow = 0;
                }
                if(entry.isMoving == NO) {
                    entry.updateFrame = CGRectMake(offset.x, offset.y, entrySize.width, entrySize.height);
                }
                offset.x += entrySize.width + _spacing.horizontal;
                cumulativeRow.width += entrySize.width + _spacing.horizontal;
                cumulativeRow.height = MAX(entrySize.height, cumulativeRow.height);
                countOfRow++;
            }
            if(countOfRow > 0) {
                cumulative.width = MAX(restriction.width, cumulativeRow.width);
                cumulative.height += cumulativeRow.height + _spacing.vertical;
            }
            cumulative.width -= _spacing.horizontal;
            cumulative.height -= _spacing.vertical;
            break;
        }
        case GLBDataViewContainerOrientationHorizontal: {
            CGFloat availableWidth = (_defaultSize.width > 0) ? _defaultSize.width : restriction.width;
            CGFloat availableHeight = (_defaultSize.height > 0) ? _defaultSize.height : restriction.height;
            CGSize availableSize = CGSizeMake(availableWidth, availableHeight);
            for(GLBDataViewItem* entry in _entries) {
                if(entry.hidden == YES) {
                    continue;
                }
                CGSize entrySize = [entry sizeForAvailableSize:availableSize];
                if((countOfRow > 0) && (cumulativeRow.height + entrySize.height > restriction.height)) {
                    offset.x += cumulativeRow.width + _spacing.horizontal;
                    offset.y = frame.origin.y + _margin.top;
                    cumulative.width += cumulativeRow.width + _spacing.horizontal;
                    cumulative.height = MAX(restriction.height, cumulativeRow.height);
                    cumulativeRow = CGSizeZero;
                    countOfRow = 0;
                }
                if(entry.isMoving == NO) {
                    entry.updateFrame = CGRectMake(offset.x, offset.y, entrySize.width, entrySize.height);
                }
                offset.y += entrySize.height + _spacing.vertical;
                cumulativeRow.width = MAX(entrySize.width, cumulativeRow.width);
                cumulativeRow.height += entrySize.height + _spacing.vertical;
                countOfRow++;
            }
            if(countOfRow > 0) {
                cumulative.width += cumulativeRow.width + _spacing.horizontal;
                cumulative.height = MAX(restriction.height, cumulativeRow.height);
            }
            cumulative.width -= _spacing.horizontal;
            cumulative.height -= _spacing.vertical;
            break;
        }
    }
}

- (void)willEntriesLayoutForBounds:(CGRect)bounds {
    BOOL headerValid = ((_header != nil) && (_header.hidden == NO));
    BOOL footerValid = ((_footer != nil) && (_footer.hidden == NO));
    switch(_orientation) {
        case GLBDataViewContainerOrientationVertical: {
            CGFloat boundsBefore = bounds.origin.y;
            CGFloat boundsAfter = bounds.origin.y + bounds.size.height;
            CGFloat entriesBefore = _frame.origin.y;
            CGFloat entriesAfter = _frame.origin.y + _frame.size.height;
            if(headerValid == YES) {
                CGRect headerFrame = _header.updateFrame;
                headerFrame.origin.y = boundsBefore;
                if(footerValid == YES) {
                    CGRect footerFrame = _footer.updateFrame;
                    headerFrame.origin.y = MIN(headerFrame.origin.y, (boundsAfter - (_spacing.vertical + footerFrame.size.height)) - headerFrame.size.height);
                } else {
                    headerFrame.origin.y = MIN(headerFrame.origin.y, boundsAfter - headerFrame.size.height);
                }
                headerFrame.origin.y = MAX(entriesBefore, MIN(headerFrame.origin.y, entriesAfter - headerFrame.size.height));
                _header.displayFrame = headerFrame;
            }
            if(footerValid == YES) {
                CGRect footerFrame = _footer.updateFrame;
                footerFrame.origin.y = boundsAfter - footerFrame.size.height;
                if(headerValid) {
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
        case GLBDataViewContainerOrientationHorizontal: {
            CGFloat boundsBefore = bounds.origin.x;
            CGFloat boundsAfter = bounds.origin.x + bounds.size.width;
            CGFloat entriesBefore = _frame.origin.x;
            CGFloat entriesAfter = _frame.origin.x + _frame.size.width;
            if(headerValid == YES) {
                CGRect headerFrame = _header.updateFrame;
                headerFrame.origin.x = boundsBefore;
                if(footerValid == YES) {
                    CGRect footerFrame = _footer.updateFrame;
                    headerFrame.origin.x = MIN(headerFrame.origin.x, (boundsAfter - (_spacing.horizontal + footerFrame.size.width)) - headerFrame.size.width);
                } else {
                    headerFrame.origin.x = MIN(headerFrame.origin.x, boundsAfter - headerFrame.size.width);
                }
                headerFrame.origin.x = MAX(entriesBefore, MIN(headerFrame.origin.x, entriesAfter - headerFrame.size.width));
                _header.displayFrame = headerFrame;
            }
            if(footerValid == YES) {
                CGRect footerFrame = _footer.updateFrame;
                footerFrame.origin.x = boundsAfter - footerFrame.size.width;
                if(headerValid == YES) {
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

- (void)beginMovingItem:(GLBDataViewItem*)item location:(CGPoint)location {
}

- (void)movingItem:(GLBDataViewItem*)item location:(CGPoint)location delta:(CGPoint)delta allowsSorting:(BOOL)allowsSorting {
}

- (void)endMovingItem:(GLBDataViewItem*)item location:(CGPoint)location {
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
