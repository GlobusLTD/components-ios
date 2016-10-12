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

#pragma mark - Private propert private

- (void)_willChangeView {
}

- (void)_didChangeView {
    for(GLBDataViewContainer* section in _sections) {
        section.view = _view;
    }
}

#pragma mark - Private override

- (void)_beginUpdateAnimated:(BOOL)animated {
    [super _beginUpdateAnimated:animated];
    for(GLBDataViewContainer* section in _sections) {
        [section _beginUpdateAnimated:animated];
    }
}

- (void)_updateAnimated:(BOOL)animated {
    [super _updateAnimated:animated];
    for(GLBDataViewContainer* section in _sections) {
        [section _updateAnimated:animated];
    }
}

- (void)_endUpdateAnimated:(BOOL)animated {
    for(GLBDataViewContainer* section in _sections) {
        [section _endUpdateAnimated:animated];
    }
    [super _endUpdateAnimated:animated];
}

- (CGRect)_frameForAvailableFrame:(CGRect)frame {
    return [self _frameSectionsForAvailableFrame:frame];
}

- (void)_layoutForAvailableFrame:(CGRect)frame {
    [self _layoutSectionsForFrame:frame];
}

- (void)_willLayoutForBounds:(CGRect)bounds {
    CGRect intersect = CGRectIntersection(bounds, _frame);
    if(CGRectIsEmpty(intersect) == NO) {
        [self _willSectionsLayoutForBounds:intersect];
    }
}

- (void)_didLayoutForBounds:(CGRect)bounds {
    CGRect intersect = CGRectIntersection(bounds, _frame);
    if(CGRectIsEmpty(intersect) == NO) {
        [self _didSectionsLayoutForBounds:intersect];
    }
}

- (void)_beginMovingItem:(GLBDataViewItem*)item location:(CGPoint)location {
    for(GLBDataViewContainer* section in _sections) {
        [section _beginMovingItem:item location:location];
    }
}

- (void)_movingItem:(GLBDataViewItem*)item location:(CGPoint)location delta:(CGPoint)delta allowsSorting:(BOOL)allowsSorting {
    for(GLBDataViewContainer* section in _sections) {
        [section _movingItem:item location:location delta:delta allowsSorting:allowsSorting];
    }
}

- (void)_endMovingItem:(GLBDataViewItem*)item location:(CGPoint)location {
    for(GLBDataViewContainer* section in _sections) {
        [section _endMovingItem:item location:location];
    }
}

- (void)_beginTransition {
    for(GLBDataViewContainer* section in _sections) {
        [section _beginTransition];
    }
}

- (void)_transitionResize {
    for(GLBDataViewContainer* section in _sections) {
        [section _transitionResize];
    }
}

- (void)_endTransition {
    for(GLBDataViewContainer* section in _sections) {
        [section _endTransition];
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

#pragma mark - Public

- (void)prependSection:(GLBDataViewContainer*)section {
    section.parent = self;
    [_sections insertObject:section atIndex:0];
    if(_view != nil) {
        [_view _didInsertItems:section.allItems];
    }
}

- (void)appendSection:(GLBDataViewContainer*)section {
    section.parent = self;
    [_sections addObject:section];
    if(_view != nil) {
        [_view _didInsertItems:section.allItems];
    }
}

- (void)insertSection:(GLBDataViewContainer*)section atIndex:(NSUInteger)index {
    if(index != NSNotFound) {
        section.parent = self;
        [_sections insertObject:section atIndex:index];
        if(_view != nil) {
            [_view _didInsertItems:section.allItems];
        }
    }
}

- (void)replaceOriginSection:(GLBDataViewContainer*)originSection withSection:(GLBDataViewContainer*)section {
    NSUInteger index = [_sections indexOfObject:originSection];
    if(index != NSNotFound) {
        section.parent = self;
        _sections[index] = section;
        if(_view != nil) {
            [_view _didReplaceOriginItems:originSection.allItems withItems:section.allItems];
        }
    }
}

- (void)deleteSection:(GLBDataViewContainer*)section {
    [_sections removeObject:section];
    if(_view != nil) {
        [_view _didDeleteItems:section.allItems];
    }
}

- (void)deleteAllSections {
    if(_view != nil) {
        NSArray* allItems = self.allItems;
        [_sections removeAllObjects];
        [_view _didDeleteItems:allItems];
    } else {
        [_sections removeAllObjects];
    }
}

- (void)scrollToSection:(GLBDataViewContainer*)section scrollPosition:(GLBDataViewPosition)scrollPosition animated:(BOOL)animated {
    [_view scrollToRect:section.frame scrollPosition:scrollPosition animated:animated];
}

#pragma mark - Private override

- (CGPoint)_alignWithVelocity:(CGPoint)velocity contentOffset:(CGPoint)contentOffset contentSize:(CGSize)contentSize visibleSize:(CGSize)visibleSize {
    if((_allowAutoAlign == YES) && (_hidden == NO)) {
        CGPoint alingPoint = [self _alignPointWithContentOffset:contentOffset contentSize:contentSize visibleSize:visibleSize];
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
            contentOffset = [section _alignWithVelocity:velocity contentOffset:contentOffset contentSize:contentSize visibleSize:visibleSize];
        }
    }
    return contentOffset;
}

- (CGRect)_validateSectionsForAvailableFrame:(CGRect __unused)frame {
    return CGRectNull;
}

- (CGRect)_frameSectionsForAvailableFrame:(CGRect __unused)frame {
    return CGRectNull;
}

- (void)_layoutSectionsForFrame:(CGRect)frame {
}

- (void)_willSectionsLayoutForBounds:(CGRect)bounds {
    for(GLBDataViewContainer* section in _sections) {
        if(section.hidden == YES) {
            continue;
        }
        [section _willLayoutForBounds:bounds];
    }
}

- (void)_didSectionsLayoutForBounds:(CGRect)bounds {
    for(GLBDataViewContainer* section in _sections) {
        if(section.hidden == YES) {
            continue;
        }
        [section _didLayoutForBounds:bounds];
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

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
