/*--------------------------------------------------*/

#import "GLBDataViewItemsListContainer+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBDataViewItemsListContainer

#pragma mark - Synthesize

@synthesize orientation = _orientation;
@synthesize mode = _mode;
@synthesize reverse = _reverse;
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
    _movingFrame = CGRectZero;
}

- (void)dealloc {
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

- (void)setMode:(GLBDataViewItemsListContainerMode)mode {
    if(_mode != mode) {
        _mode = mode;
        [_dataView setNeedValidateLayout];
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
            [super prependItem:_headerItem];
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
        [super insertItem:item atIndex:[_items indexOfObject:_headerItem] + 1];
    } else {
        [super prependItem:item];
    }
}

- (void)prependItems:(NSArray*)items {
    [_contentItems insertObjects:items atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, items.count)]];
    if(_headerItem != nil) {
        [super insertItems:items atIndex:[_items indexOfObject:_headerItem] + 1];
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
        [super insertItem:item atIndex:[_items indexOfObject:_footerItem] - 1];
    } else {
        [super appendItem:item];
    }
}

- (void)appendItems:(NSArray*)items {
    [_contentItems addObjectsFromArray:items];
    if(_footerItem != nil) {
        [super insertItems:items atIndex:[_items indexOfObject:_footerItem] - 1];
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
    [_contentItems insertObject:item atIndex:index];
    if(_headerItem != nil) {
        index = MAX(index, [_items indexOfObject:_headerItem] + 1);
    }
    if(_footerItem != nil) {
        index = MIN(index, [_items indexOfObject:_footerItem] - 1);
    }
    [super insertItem:item atIndex:index];
}

- (void)insertItems:(NSArray*)items atIndex:(NSUInteger)index {
    [_contentItems insertObjects:items atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, items.count)]];
    if(_headerItem != nil) {
        index = MAX(index, [_items indexOfObject:_headerItem] + 1);
    }
    if(_footerItem != nil) {
        index = MIN(index, [_items indexOfObject:_footerItem] - 1);
    }
    [super insertItems:items atIndex:index];
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
        [_contentItems removeAllObjects];
        [super deleteItems:items];
    }
}

- (CGRect)frameItemsForAvailableFrame:(CGRect)frame {
    CGSize restriction = CGSizeMake(frame.size.width - (_margin.left + _margin.right), frame.size.height - (_margin.top + _margin.bottom));
    CGSize cumulative = CGSizeZero;
    
    switch(_orientation) {
        case GLBDataViewContainerOrientationVertical: {
            CGFloat availableWidth = (_defaultSize.width > 0) ? _defaultSize.width : restriction.width;
            CGFloat availableHeight = (_defaultSize.height > 0) ? _defaultSize.height : restriction.height;
            CGSize availableSize = CGSizeMake(availableWidth, availableHeight);
            for(GLBDataViewItem* entry in _items) {
                if(entry.hidden == YES) {
                    continue;
                }
                CGSize entrySize = [entry sizeForAvailableSize:availableSize];
                cumulative.width = MAX(cumulative.width, entrySize.width);
                cumulative.height += entrySize.height + _spacing.vertical;
            }
            if(cumulative.height > FLT_EPSILON) {
                cumulative.height -= _spacing.vertical;
            }
            switch(_mode) {
                case GLBDataViewItemsListContainerModeBegin:
                    break;
                case GLBDataViewItemsListContainerModeCenter:
                    if(restriction.height > cumulative.height) {
                        cumulative.height = restriction.height;
                    }
                    break;
                case GLBDataViewItemsListContainerModeEnd:
                    if(restriction.height > cumulative.height) {
                        cumulative.height = restriction.height;
                    }
                    break;
            }
            break;
        }
        case GLBDataViewContainerOrientationHorizontal: {
            CGFloat availableWidth = (_defaultSize.width > 0) ? _defaultSize.width : restriction.width;
            CGFloat availableHeight = (_defaultSize.height > 0) ? _defaultSize.height : restriction.height;
            CGSize availableSize = CGSizeMake(availableWidth, availableHeight);
            for(GLBDataViewItem* entry in _items) {
                if(entry.hidden == YES) {
                    continue;
                }
                CGSize entrySize = [entry sizeForAvailableSize:availableSize];
                cumulative.width += entrySize.width + _spacing.horizontal;
                cumulative.height = MAX(cumulative.height, entrySize.height);
            }
            if(cumulative.width > FLT_EPSILON) {
                cumulative.width -= _spacing.horizontal;
            }
            switch(_mode) {
                case GLBDataViewItemsListContainerModeBegin:
                    break;
                case GLBDataViewItemsListContainerModeCenter:
                    if(restriction.width > cumulative.width) {
                        cumulative.width = restriction.width;
                    }
                    break;
                case GLBDataViewItemsListContainerModeEnd:
                    if(restriction.width > cumulative.width) {
                        cumulative.width = restriction.width;
                    }
                    break;
            }
            break;
        }
    }
    return CGRectMake(frame.origin.x, frame.origin.y, _margin.left + cumulative.width + _margin.right, _margin.top + cumulative.height + _margin.bottom);
}

- (void)layoutItemsForFrame:(CGRect)frame {
    __block CGPoint offset = CGPointMake(frame.origin.x + _margin.left, frame.origin.y + _margin.top);
    CGSize restriction = CGSizeMake(frame.size.width - (_margin.left + _margin.right), frame.size.height - (_margin.top + _margin.bottom));
    CGSize cumulative = CGSizeZero;
    switch(_orientation) {
        case GLBDataViewContainerOrientationVertical: {
            CGFloat availableWidth = (_defaultSize.width > 0) ? _defaultSize.width : restriction.width;
            CGFloat availableHeight = (_defaultSize.height > 0) ? _defaultSize.height : restriction.height;
            CGSize availableSize = CGSizeMake(availableWidth, availableHeight);
            for(GLBDataViewItem* entry in _items) {
                if(entry.hidden == YES) {
                    continue;
                }
                CGSize entrySize = [entry sizeForAvailableSize:availableSize];
                cumulative.width = MAX(cumulative.width, entrySize.width);
                cumulative.height += entrySize.height + _spacing.vertical;
            }
            if(cumulative.height > FLT_EPSILON) {
                cumulative.height -= _spacing.vertical;
            }
            NSEnumerationOptions enumOption = (_reverse == YES) ? NSEnumerationReverse : 0;
            switch(_mode) {
                case GLBDataViewItemsListContainerModeBegin:
                    break;
                case GLBDataViewItemsListContainerModeCenter:
                    if(restriction.height > cumulative.height) {
                        offset.y += (restriction.height * 0.5f) - (cumulative.height * 0.5f);
                        cumulative.height = restriction.height;
                    }
                    break;
                case GLBDataViewItemsListContainerModeEnd:
                    if(restriction.height > cumulative.height) {
                        offset.y += cumulative.height - restriction.height;
                        cumulative.height = restriction.height;
                    }
                    break;
            }
            [_items glb_each:^(GLBDataViewItem* entry) {
                if(entry.hidden == NO) {
                    CGSize entrySize = [entry sizeForAvailableSize:availableSize];
                    if(entry.isMoving == NO) {
                        entry.updateFrame = CGRectMake(offset.x, offset.y, entrySize.width, entrySize.height);
                    }
                    offset.y += entrySize.height + _spacing.vertical;
                }
            } options:enumOption];
            break;
        }
        case GLBDataViewContainerOrientationHorizontal: {
            CGFloat availableWidth = (_defaultSize.width > 0) ? _defaultSize.width : restriction.width;
            CGFloat availableHeight = (_defaultSize.height > 0) ? _defaultSize.height : restriction.height;
            CGSize availableSize = CGSizeMake(availableWidth, availableHeight);
            for(GLBDataViewItem* entry in _items) {
                if(entry.hidden == YES) {
                    continue;
                }
                CGSize entrySize = [entry sizeForAvailableSize:availableSize];
                cumulative.width += entrySize.width + _spacing.horizontal;
                cumulative.height = MAX(cumulative.height, entrySize.height);
            }
            if(cumulative.width > FLT_EPSILON) {
                cumulative.width -= _spacing.horizontal;
            }
            NSEnumerationOptions enumOption = (_reverse == YES) ? NSEnumerationReverse : 0;
            switch(_mode) {
                case GLBDataViewItemsListContainerModeBegin:
                    break;
                case GLBDataViewItemsListContainerModeCenter:
                    if(restriction.width > cumulative.width) {
                        offset.x += (restriction.width * 0.5f) - (cumulative.width * 0.5f);
                        cumulative.width = restriction.width;
                    }
                    break;
                case GLBDataViewItemsListContainerModeEnd:
                    if(restriction.width > cumulative.width) {
                        offset.x += cumulative.width - restriction.width;
                        cumulative.width = restriction.width;
                    }
                    break;
            }
            [_items glb_each:^(GLBDataViewItem* entry) {
                if(entry.hidden == NO) {
                    CGSize entrySize = [entry sizeForAvailableSize:availableSize];
                    if(entry.isMoving == NO) {
                        entry.updateFrame = CGRectMake(offset.x, offset.y, entrySize.width, entrySize.height);
                    }
                    offset.x += entrySize.width + _spacing.horizontal;
                }
            } options:enumOption];
            break;
        }
    }
}

- (void)willItemsLayoutForBounds:(CGRect)bounds {
    switch(_orientation) {
        case GLBDataViewContainerOrientationVertical: {
            CGFloat boundsBefore = bounds.origin.y;
            CGFloat boundsAfter = bounds.origin.y + bounds.size.height;
            CGFloat entriesBefore = _frame.origin.y;
            CGFloat entriesAfter = _frame.origin.y + _frame.size.height;
            if((_headerItem != nil) && (_headerItem.hidden == NO)) {
                CGRect headerItemFrame = _headerItem.updateFrame;
                headerItemFrame.origin.y = boundsBefore;
                if((_footerItem != nil) && (_footerItem.hidden == NO)) {
                    CGRect footerFrame = _footerItem.updateFrame;
                    headerItemFrame.origin.y = MIN(headerItemFrame.origin.y, (boundsAfter - (_spacing.vertical + footerFrame.size.height)) - headerItemFrame.size.height);
                } else {
                    headerItemFrame.origin.y = MIN(headerItemFrame.origin.y, boundsAfter - headerItemFrame.size.height);
                }
                headerItemFrame.origin.y = MAX(entriesBefore, MIN(headerItemFrame.origin.y, entriesAfter - headerItemFrame.size.height));
                _headerItem.displayFrame = headerItemFrame;
            }
            if((_footerItem != nil) && (_footerItem.hidden == NO)) {
                CGRect footerFrame = _footerItem.updateFrame;
                footerFrame.origin.y = boundsAfter - footerFrame.size.height;
                if((_headerItem != nil) && (_headerItem.hidden == NO)) {
                    CGRect headerItemFrame = _headerItem.updateFrame;
                    footerFrame.origin.y = MAX(footerFrame.origin.y, (boundsBefore + _spacing.vertical) + headerItemFrame.size.height);
                } else {
                    footerFrame.origin.y = MAX(footerFrame.origin.y, boundsBefore);
                }
                footerFrame.origin.y = MAX(entriesBefore, MIN(footerFrame.origin.y, entriesAfter - footerFrame.size.height));
                _footerItem.displayFrame = footerFrame;
            }
            break;
        }
        case GLBDataViewContainerOrientationHorizontal: {
            CGFloat boundsBefore = bounds.origin.x;
            CGFloat boundsAfter = bounds.origin.x + bounds.size.width;
            CGFloat entriesBefore = _frame.origin.x;
            CGFloat entriesAfter = _frame.origin.x + _frame.size.width;
            if((_headerItem != nil) && (_headerItem.hidden == NO)) {
                CGRect headerItemFrame = _headerItem.updateFrame;
                headerItemFrame.origin.x = boundsBefore;
                if((_footerItem != nil) && (_footerItem.hidden == NO)) {
                    CGRect footerFrame = _footerItem.updateFrame;
                    headerItemFrame.origin.x = MIN(headerItemFrame.origin.x, (boundsAfter - (_spacing.horizontal + footerFrame.size.width)) - headerItemFrame.size.width);
                } else {
                    headerItemFrame.origin.x = MIN(headerItemFrame.origin.x, boundsAfter - headerItemFrame.size.width);
                }
                headerItemFrame.origin.x = MAX(entriesBefore, MIN(headerItemFrame.origin.x, entriesAfter - headerItemFrame.size.width));
                _headerItem.displayFrame = headerItemFrame;
            }
            if((_footerItem != nil) && (_footerItem.hidden == NO)) {
                CGRect footerFrame = _footerItem.updateFrame;
                footerFrame.origin.x = boundsAfter - footerFrame.size.width;
                if((_headerItem != nil) && (_headerItem.hidden == NO)) {
                    CGRect headerItemFrame = _headerItem.updateFrame;
                    footerFrame.origin.x = MAX(footerFrame.origin.x, (boundsBefore + _spacing.horizontal) + headerItemFrame.size.width);
                } else {
                    footerFrame.origin.x = MAX(footerFrame.origin.x, boundsBefore);
                }
                footerFrame.origin.x = MAX(entriesBefore, MIN(footerFrame.origin.x, entriesAfter - footerFrame.size.width));
                _footerItem.displayFrame = footerFrame;
            }
            break;
        }
    }
}

- (void)beginMovingItem:(GLBDataViewItem*)item location:(CGPoint)location {
    if(_contentItems.count >= 2) {
        GLBDataViewItem* firstMovingRange = [_contentItems glb_find:^BOOL(GLBDataViewItem* existItem) {
            return (existItem.allowsMoving == YES) && (existItem.hidden == NO);
        }];
        GLBDataViewItem* lastMovingRange = [_contentItems glb_find:^BOOL(GLBDataViewItem* existItem) {
            return (existItem.allowsMoving == YES) && (existItem.hidden == NO);
        } options:NSEnumerationReverse];
        if(firstMovingRange != lastMovingRange) {
            _movingFrame = CGRectUnion(firstMovingRange.updateFrame, lastMovingRange.updateFrame);
        }
    }
}

- (void)movingItem:(GLBDataViewItem*)item location:(CGPoint)location delta:(CGPoint)delta allowsSorting:(BOOL)allowsSorting {
    CGRect frame = item.updateFrame;
    if(CGRectIsEmpty(_movingFrame) == NO) {
        NSUInteger srcIndex = [_contentItems indexOfObject:item];
        NSUInteger dstIndex = srcIndex;
        switch(_orientation) {
            case GLBDataViewContainerOrientationVertical: {
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
            case GLBDataViewContainerOrientationHorizontal: {
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
        GLBDataViewItem* dstItem = [self itemForPoint:CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame))];
        if(dstItem != nil) {
            dstIndex = [_contentItems indexOfObject:dstItem];
        }
        if((srcIndex != dstIndex) && (allowsSorting == YES)) {
            NSUInteger entrySrcIndex = [_items indexOfObject:_contentItems[srcIndex]];
            NSUInteger entryDstIndex = [_items indexOfObject:_contentItems[dstIndex]];
            if((entrySrcIndex != NSNotFound) && (entrySrcIndex != entryDstIndex)) {
                [_items glb_moveObjectAtIndex:entrySrcIndex toIndex:entryDstIndex];
            }
            [_contentItems glb_moveObjectAtIndex:srcIndex toIndex:dstIndex];
            
            __weak typeof(self) weakSelf = self;
            [self.dataView batchDuration:0.1f update:^{
                [weakSelf.dataView setNeedValidateLayout];
            }];
        }
    }
    item.updateFrame = frame;
}

- (void)endMovingItem:(GLBDataViewItem*)item location:(CGPoint)location {
    _movingFrame = CGRectZero;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
