/*--------------------------------------------------*/

#import "GLBDataViewSectionsContainer+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBDataViewSectionsContainer

#pragma mark - Synthesize

@synthesize sections = _sections;

#pragma mark - Init / Free

- (void)setup {
    [super setup];
    
    _sections = NSMutableArray.array;
}

#pragma mark - Public override

- (void)willChangeDataView {
    [super willChangeDataView];
}

- (void)didChangeDataView {
    [super didChangeDataView];
    
    for(GLBDataViewContainer* section in _sections) {
        section.dataView = _dataView;
    }
}

- (void)beginUpdateAnimated:(BOOL)animated {
    [super beginUpdateAnimated:animated];
    
    for(GLBDataViewContainer* section in _sections) {
        [section beginUpdateAnimated:animated];
    }
}

- (void)_updateAnimated:(BOOL)animated {
    [super updateAnimated:animated];
    
    for(GLBDataViewContainer* section in _sections) {
        [section updateAnimated:animated];
    }
}

- (void)endUpdateAnimated:(BOOL)animated {
    for(GLBDataViewContainer* section in _sections) {
        [section endUpdateAnimated:animated];
    }
    
    [super endUpdateAnimated:animated];
}

- (CGRect)frameForAvailableFrame:(CGRect)frame {
    return [self frameSectionsForAvailableFrame:frame];
}

- (void)layoutForAvailableFrame:(CGRect)frame {
    [self layoutSectionsForFrame:frame];
}

- (void)willLayoutForBounds:(CGRect)bounds {
    CGRect intersect = CGRectIntersection(bounds, _frame);
    if(CGRectIsEmpty(intersect) == NO) {
        [self willSectionsLayoutForBounds:intersect];
    }
}

- (void)didLayoutForBounds:(CGRect)bounds {
    CGRect intersect = CGRectIntersection(bounds, _frame);
    if(CGRectIsEmpty(intersect) == NO) {
        [self didSectionsLayoutForBounds:intersect];
    }
}

- (void)beginMovingItem:(GLBDataViewItem*)item location:(CGPoint)location {
    for(GLBDataViewContainer* section in _sections) {
        [section beginMovingItem:item location:location];
    }
}

- (void)movingItem:(GLBDataViewItem*)item location:(CGPoint)location delta:(CGPoint)delta allowsSorting:(BOOL)allowsSorting {
    for(GLBDataViewContainer* section in _sections) {
        [section movingItem:item location:location delta:delta allowsSorting:allowsSorting];
    }
}

- (void)endMovingItem:(GLBDataViewItem*)item location:(CGPoint)location {
    for(GLBDataViewContainer* section in _sections) {
        [section endMovingItem:item location:location];
    }
}

- (void)beginTransition {
    for(GLBDataViewContainer* section in _sections) {
        [section beginTransition];
    }
}

- (void)transitionResize {
    for(GLBDataViewContainer* section in _sections) {
        [section transitionResize];
    }
}

- (void)endTransition {
    for(GLBDataViewContainer* section in _sections) {
        [section endTransition];
    }
}

#pragma mark - Public override

- (void)setNeedResize {
    for(GLBDataViewItem* section in _sections) {
        [section setNeedResize];
    }
}

- (void)setNeedUpdate {
    for(GLBDataViewItem* section in _sections) {
        [section setNeedUpdate];
    }
}

- (NSArray*)allItems {
    NSMutableArray* result = NSMutableArray.array;
    for(GLBDataViewContainer* section in _sections) {
        [result addObjectsFromArray:section.allItems];
    }
    return result;
}

- (GLBDataViewItem*)itemForPoint:(CGPoint)point {
    for(GLBDataViewContainer* section in _sections) {
        GLBDataViewItem* item = [section itemForPoint:point];
        if(item != nil) {
            return item;
        }
    }
    return nil;
}

- (GLBDataViewItem*)itemForData:(id)data {
    for(GLBDataViewContainer* section in _sections) {
        GLBDataViewItem* item = [section itemForData:data];
        if(item != nil) {
            return item;
        }
    }
    return nil;
}

- (CGPoint)alignWithVelocity:(CGPoint)velocity contentOffset:(CGPoint)contentOffset contentSize:(CGSize)contentSize visibleSize:(CGSize)visibleSize {
    if((_allowAutoAlign == YES) && (_hidden == NO)) {
        CGPoint alingPoint = [self alignPointWithContentOffset:contentOffset contentSize:contentSize visibleSize:visibleSize];
        if(CGRectContainsPoint(_frame, alingPoint) == YES) {
            for(GLBDataViewContainer* section in _sections) {
                if(section.allowAutoAlign == YES) {
                    CGPoint alingSectionCorner = CGPointZero;
                    if((_alignPosition & GLBDataViewContainerAlignLeft) != 0) {
                        alingSectionCorner.x = CGRectGetMinX(section.frame);
                    } else if((_alignPosition & GLBDataViewContainerAlignCenteredHorizontally) != 0) {
                        alingSectionCorner.x = CGRectGetMidX(section.frame);
                    } else if((_alignPosition & GLBDataViewContainerAlignRight) != 0) {
                        alingSectionCorner.x = CGRectGetMaxX(section.frame);
                    } else {
                        alingSectionCorner.x = alingPoint.x;
                    }
                    if((_alignPosition & GLBDataViewContainerAlignTop) != 0) {
                        alingSectionCorner.y = CGRectGetMinY(section.frame);
                    } else if((_alignPosition & GLBDataViewContainerAlignCenteredVertically) != 0) {
                        alingSectionCorner.y = CGRectGetMidY(section.frame);
                    } else if((_alignPosition & GLBDataViewContainerAlignBottom) != 0) {
                        alingSectionCorner.y = CGRectGetMaxY(section.frame);
                    } else {
                        alingSectionCorner.y = alingPoint.y;
                    }
                    CGFloat dx = alingPoint.x - alingSectionCorner.x;
                    CGFloat dy = alingPoint.y - alingSectionCorner.y;
                    if((ABS(alingSectionCorner.x - contentOffset.x) > FLT_EPSILON) && (ABS(dx) <= _alignThreshold.horizontal)) {
                        contentOffset.x -= dx;
                        alingPoint.x -= dx;
                    }
                    if((ABS(alingSectionCorner.y - contentOffset.y) > FLT_EPSILON) && (ABS(dy) <= _alignThreshold.vertical)) {
                        contentOffset.y -= dy;
                        alingPoint.y -= dy;
                    }
                }
            }
            contentOffset.x = MAX(0.0f, MIN(contentOffset.x, contentSize.width - visibleSize.width));
            contentOffset.y = MAX(0.0f, MIN(contentOffset.y, contentSize.height - visibleSize.height));
        }
    }
    if(CGRectContainsPoint(_frame, contentOffset) == YES) {
        for(GLBDataViewContainer* section in _sections) {
            if(section.hidden == YES) {
                continue;
            }
            contentOffset = [section alignWithVelocity:velocity contentOffset:contentOffset contentSize:contentSize visibleSize:visibleSize];
        }
    }
    return contentOffset;
}

#pragma mark - Public

- (void)prependSection:(GLBDataViewContainer*)section {
    section.container = self;
    [_sections insertObject:section atIndex:0];
    if(_dataView != nil) {
        [_dataView didInsertItems:section.allItems];
    }
}

- (void)appendSection:(GLBDataViewContainer*)section {
    section.container = self;
    [_sections addObject:section];
    if(_dataView != nil) {
        [_dataView didInsertItems:section.allItems];
    }
}

- (void)insertSection:(GLBDataViewContainer*)section atIndex:(NSUInteger)index {
    if(index != NSNotFound) {
        section.container = self;
        [_sections insertObject:section atIndex:index];
        if(_dataView != nil) {
            [_dataView didInsertItems:section.allItems];
        }
    }
}

- (void)replaceOriginSection:(GLBDataViewContainer*)originSection withSection:(GLBDataViewContainer*)section {
    NSUInteger index = [_sections indexOfObject:originSection];
    if(index != NSNotFound) {
        section.container = self;
        _sections[index] = section;
        if(_dataView != nil) {
            [_dataView didReplaceOriginItems:originSection.allItems withItems:section.allItems];
        }
    }
}

- (void)deleteSection:(GLBDataViewContainer*)section {
    [_sections removeObject:section];
    if(_dataView != nil) {
        [_dataView didDeleteItems:section.allItems];
    }
}

- (void)deleteAllSections {
    if(_dataView != nil) {
        NSArray* allItems = self.allItems;
        [_sections removeAllObjects];
        [_dataView didDeleteItems:allItems];
    } else {
        [_sections removeAllObjects];
    }
}

- (void)scrollToSection:(GLBDataViewContainer*)section scrollPosition:(GLBDataViewPosition)scrollPosition animated:(BOOL)animated {
    [_dataView scrollToRect:section.frame scrollPosition:scrollPosition animated:animated];
}

- (CGRect)frameSectionsForAvailableFrame:(CGRect __unused)frame {
    return CGRectNull;
}

- (void)layoutSectionsForFrame:(CGRect)frame {
}

- (void)willSectionsLayoutForBounds:(CGRect)bounds {
    for(GLBDataViewContainer* section in _sections) {
        if(section.hidden == YES) {
            continue;
        }
        [section willLayoutForBounds:bounds];
    }
}

- (void)didSectionsLayoutForBounds:(CGRect)bounds {
    for(GLBDataViewContainer* section in _sections) {
        if(section.hidden == YES) {
            continue;
        }
        [section didLayoutForBounds:bounds];
    }
}

#pragma mark - GLBSearchBarDelegate

- (void)searchBarBeginSearch:(GLBSearchBar*)searchBar {
    for(GLBDataViewContainer* section in _sections) {
        [section searchBarBeginSearch:searchBar];
    }
}

- (void)searchBarEndSearch:(GLBSearchBar*)searchBar {
    for(GLBDataViewContainer* section in _sections) {
        [section searchBarEndSearch:searchBar];
    }
}

- (void)searchBarBeginEditing:(GLBSearchBar*)searchBar {
    for(GLBDataViewContainer* section in _sections) {
        [section searchBarBeginEditing:searchBar];
    }
}

- (void)searchBar:(GLBSearchBar*)searchBar textChanged:(NSString*)textChanged {
    for(GLBDataViewContainer* section in _sections) {
        [section searchBar:searchBar textChanged:textChanged];
    }
}

- (void)searchBarEndEditing:(GLBSearchBar*)searchBar {
    for(GLBDataViewContainer* section in _sections) {
        [section searchBarEndEditing:searchBar];
    }
}

- (void)searchBarPressedClear:(GLBSearchBar*)searchBar {
    for(GLBDataViewContainer* section in _sections) {
        [section searchBarPressedClear:searchBar];
    }
}

- (void)searchBarPressedReturn:(GLBSearchBar*)searchBar {
    for(GLBDataViewContainer* section in _sections) {
        [section searchBarPressedReturn:searchBar];
    }
}

- (void)searchBarPressedCancel:(GLBSearchBar*)searchBar {
    for(GLBDataViewContainer* section in _sections) {
        [section searchBarPressedCancel:searchBar];
    }
}

#pragma mark - UIAccessibilityContainer

- (NSArray*)accessibilityElements {
    NSMutableArray* result = [NSMutableArray array];
    for(GLBDataViewContainer* section in _sections) {
        NSArray* accessibilityElements = section.accessibilityElements;
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
