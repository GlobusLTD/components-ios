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
@synthesize headerItem = _headerItem;
@synthesize footerItem = _footerItem;
@synthesize contentItems = _contentItems;

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
    _contentItems = NSMutableArray.array;
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

- (void)setHeaderItem:(GLBDataViewItem*)headerItem {
    if(_headerItem != headerItem) {
        if(_headerItem != nil) {
            [super deleteItem:_headerItem];
        }
        _headerItem = headerItem;
        if(_headerItem != nil) {
            [super appendItem:_headerItem];
        }
        if(_dataView != nil) {
            [_dataView setNeedValidateLayout];
        }
    }
}

- (void)setFooterItem:(GLBDataViewItem*)footerItem {
    if(_footerItem != footerItem) {
        if(_footerItem != nil) {
            [super deleteItem:_footerItem];
        }
        _footerItem = footerItem;
        if(_footerItem != nil) {
            [super appendItem:_footerItem];
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
    [_contentItems insertObject:item atIndex:0];
    if(_headerItem != nil) {
        [super insertItem:item atIndex:[_contentItems indexOfObject:_headerItem] + 1];
    } else {
        [super prependItem:item];
    }
}

- (void)prependItems:(NSArray*)items {
    [_contentItems insertObjects:items atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, items.count)]];
    if(_headerItem != nil) {
        [super insertItems:items atIndex:[_contentItems indexOfObject:_headerItem] + 1];
    } else {
        [super prependItems:items];
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
    [_contentItems addObject:item];
    if(_footerItem != nil) {
        [super insertItem:item atIndex:[_contentItems indexOfObject:_footerItem] - 1];
    } else {
        [super appendItem:item];
    }
}

- (void)appendItems:(NSArray*)items {
    [_contentItems addObjectsFromArray:items];
    if(_footerItem != nil) {
        [super insertItems:items atIndex:[_contentItems indexOfObject:_footerItem] - 1];
    } else {
        [super appendItems:items];
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
        [_contentItems insertObject:item atIndex:index];
        if(_headerItem != nil) {
            index = MAX(index, [_contentItems indexOfObject:_headerItem] + 1);
        }
        if(_footerItem != nil) {
            index = MIN(index, [_contentItems indexOfObject:_footerItem] - 1);
        }
        [super insertItem:item atIndex:index];
    }
}

- (void)insertItems:(NSArray*)items atIndex:(NSUInteger)index {
    if((index != NSNotFound) && (items.count > 0)) {
        [_contentItems insertObjects:items atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, items.count)]];
        if(_headerItem != nil) {
            index = MAX(index, [_contentItems indexOfObject:_headerItem] + 1);
        }
        if(_footerItem != nil) {
            index = MIN(index, [_contentItems indexOfObject:_footerItem] - 1);
        }
        [super insertItems:items atIndex:index];
    }
}

- (void)insertItem:(GLBDataViewItem*)item aboveItem:(GLBDataViewItem*)aboveItem {
    NSUInteger index = [_contentItems indexOfObject:aboveItem];
    if(index != NSNotFound) {
        [self insertItem:item atIndex:index];
    }
}

- (void)insertItems:(NSArray*)items aboveItem:(GLBDataViewItem*)aboveItem {
    NSUInteger index = [_contentItems indexOfObject:aboveItem];
    if(index != NSNotFound) {
        [self insertItems:items atIndex:index];
    }
}

- (void)insertItem:(GLBDataViewItem*)item belowItem:(GLBDataViewItem*)belowItem {
    NSUInteger index = [_contentItems indexOfObject:belowItem];
    if(index != NSNotFound) {
        [self insertItem:item atIndex:index + 1];
    }
}

- (void)insertItems:(NSArray*)items belowItem:(GLBDataViewItem*)belowItem {
    NSUInteger index = [_contentItems indexOfObject:belowItem];
    if(index != NSNotFound) {
        [self insertItems:items atIndex:index + 1];
    }
}

- (void)replaceOriginItem:(GLBDataViewItem*)originItem withItem:(GLBDataViewItem*)item {
    NSUInteger index = [_contentItems indexOfObject:originItem];
    if(index != NSNotFound) {
        _contentItems[index] = item;
        [super replaceOriginItem:originItem withItem:item];
    }
}

- (void)replaceOriginItems:(NSArray*)originItems withItems:(NSArray*)items {
    NSIndexSet* indexSet = [_contentItems indexesOfObjectsPassingTest:^BOOL(GLBDataViewItem* originItem, NSUInteger index __unused, BOOL* stop __unused) {
        return [originItems containsObject:originItem];
    }];
    if(indexSet.count == items.count) {
        [_contentItems replaceObjectsAtIndexes:indexSet withObjects:items];
        [super replaceOriginItems:originItems withItems:items];
    }
}

- (void)deleteItem:(GLBDataViewItem*)item {
    if([_contentItems containsObject:item] == YES) {
        [_contentItems removeObject:item];
        [super deleteItem:item];
    }
}

- (void)deleteItems:(NSArray*)items {
    if([_contentItems glb_containsObjectsInArray:items] == YES) {
        [_contentItems removeObjectsInArray:items];
        [super deleteItems:items];
    }
}

- (void)deleteAllItems {
    if(_contentItems.count > 0) {
        NSArray* items = [NSArray arrayWithArray:_contentItems];
        [super deleteItems:items];
        [_contentItems removeAllObjects];
    }
}

- (CGRect)frameItemsForAvailableFrame:(CGRect)frame {
    CGSize restriction = CGSizeMake(frame.size.width - (_margin.left + _margin.right), frame.size.height - (_margin.top + _margin.bottom));
    CGSize cumulative = CGSizeZero, cumulativeRow = CGSizeZero;
    NSUInteger countOfRow = 0;
    
    switch(_orientation) {
        case GLBDataViewContainerOrientationVertical: {
            CGFloat availableWidth = (_defaultSize.width > 0) ? _defaultSize.width : restriction.width;
            CGFloat availableHeight = (_defaultSize.height > 0) ? _defaultSize.height : restriction.height;
            CGSize availableSize = CGSizeMake(availableWidth, availableHeight);
            for(GLBDataViewItem* entry in _contentItems) {
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
            for(GLBDataViewItem* entry in _contentItems) {
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

- (void)layoutItemsForFrame:(CGRect)frame {
    CGPoint offset = CGPointMake(frame.origin.x + _margin.left, frame.origin.y + _margin.top);
    CGSize restriction = CGSizeMake(frame.size.width - (_margin.left + _margin.right), frame.size.height - (_margin.top + _margin.bottom));
    CGSize cumulative = CGSizeZero, cumulativeRow = CGSizeZero;
    NSUInteger countOfRow = 0;
    
    switch(_orientation) {
        case GLBDataViewContainerOrientationVertical: {
            CGFloat availableWidth = (_defaultSize.width > 0) ? _defaultSize.width : restriction.width;
            CGFloat availableHeight = (_defaultSize.height > 0) ? _defaultSize.height : restriction.height;
            CGSize availableSize = CGSizeMake(availableWidth, availableHeight);
            for(GLBDataViewItem* entry in _contentItems) {
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
            for(GLBDataViewItem* entry in _contentItems) {
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

- (void)willItemsLayoutForBounds:(CGRect)bounds {
    BOOL headerItemValid = ((_headerItem != nil) && (_headerItem.hidden == NO));
    BOOL footerItemValid = ((_footerItem != nil) && (_footerItem.hidden == NO));
    switch(_orientation) {
        case GLBDataViewContainerOrientationVertical: {
            CGFloat boundsBefore = bounds.origin.y;
            CGFloat boundsAfter = bounds.origin.y + bounds.size.height;
            CGFloat entriesBefore = _frame.origin.y;
            CGFloat entriesAfter = _frame.origin.y + _frame.size.height;
            if(headerItemValid == YES) {
                CGRect headerItemFrame = _headerItem.updateFrame;
                headerItemFrame.origin.y = boundsBefore;
                if(footerItemValid == YES) {
                    CGRect footerItemFrame = _footerItem.updateFrame;
                    headerItemFrame.origin.y = MIN(headerItemFrame.origin.y, (boundsAfter - (_spacing.vertical + footerItemFrame.size.height)) - headerItemFrame.size.height);
                } else {
                    headerItemFrame.origin.y = MIN(headerItemFrame.origin.y, boundsAfter - headerItemFrame.size.height);
                }
                headerItemFrame.origin.y = MAX(entriesBefore, MIN(headerItemFrame.origin.y, entriesAfter - headerItemFrame.size.height));
                _headerItem.displayFrame = headerItemFrame;
            }
            if(footerItemValid == YES) {
                CGRect footerItemFrame = _footerItem.updateFrame;
                footerItemFrame.origin.y = boundsAfter - footerItemFrame.size.height;
                if(headerItemValid) {
                    CGRect headerItemFrame = _headerItem.updateFrame;
                    footerItemFrame.origin.y = MAX(footerItemFrame.origin.y, (boundsBefore + _spacing.vertical) + headerItemFrame.size.height);
                } else {
                    footerItemFrame.origin.y = MAX(footerItemFrame.origin.y, boundsBefore);
                }
                footerItemFrame.origin.y = MAX(entriesBefore, MIN(footerItemFrame.origin.y, entriesAfter - footerItemFrame.size.height));
                _footerItem.displayFrame = footerItemFrame;
            }
            break;
        }
        case GLBDataViewContainerOrientationHorizontal: {
            CGFloat boundsBefore = bounds.origin.x;
            CGFloat boundsAfter = bounds.origin.x + bounds.size.width;
            CGFloat entriesBefore = _frame.origin.x;
            CGFloat entriesAfter = _frame.origin.x + _frame.size.width;
            if(headerItemValid == YES) {
                CGRect headerItemFrame = _headerItem.updateFrame;
                headerItemFrame.origin.x = boundsBefore;
                if(footerItemValid == YES) {
                    CGRect footerItemFrame = _footerItem.updateFrame;
                    headerItemFrame.origin.x = MIN(headerItemFrame.origin.x, (boundsAfter - (_spacing.horizontal + footerItemFrame.size.width)) - headerItemFrame.size.width);
                } else {
                    headerItemFrame.origin.x = MIN(headerItemFrame.origin.x, boundsAfter - headerItemFrame.size.width);
                }
                headerItemFrame.origin.x = MAX(entriesBefore, MIN(headerItemFrame.origin.x, entriesAfter - headerItemFrame.size.width));
                _headerItem.displayFrame = headerItemFrame;
            }
            if(footerItemValid == YES) {
                CGRect footerItemFrame = _footerItem.updateFrame;
                footerItemFrame.origin.x = boundsAfter - footerItemFrame.size.width;
                if(headerItemValid == YES) {
                    CGRect headerItemFrame = _headerItem.updateFrame;
                    footerItemFrame.origin.x = MAX(footerItemFrame.origin.x, (boundsBefore + _spacing.horizontal) + headerItemFrame.size.width);
                } else {
                    footerItemFrame.origin.x = MAX(footerItemFrame.origin.x, boundsBefore);
                }
                footerItemFrame.origin.x = MAX(entriesBefore, MIN(footerItemFrame.origin.x, entriesAfter - footerItemFrame.size.width));
                _footerItem.displayFrame = footerItemFrame;
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
