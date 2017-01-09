/*--------------------------------------------------*/

#import "GLBDataViewContainer+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBDataViewContainer

#pragma mark - Synthesize

@synthesize dataView = _dataView;
@synthesize container = _container;
@synthesize hidden = _hidden;
@synthesize allowAutoAlign = _allowAutoAlign;
@synthesize alignInsets = _alignInsets;
@synthesize alignPosition = _alignPosition;
@synthesize alignThreshold = _alignThreshold;

#pragma mark - Init / Free

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _alignPosition = GLBDataViewContainerAlignNone;
    _alignThreshold = UIOffsetMake(20.0f, 20.0f);
}

- (void)dealloc {
}

#pragma mark - Property

- (void)setDataView:(GLBDataView*)dataView {
    if(_dataView != dataView) {
        [self willChangeDataView];
        _dataView = dataView;
        [self didChangeDataView];
    }
}

- (void)setContainer:(GLBDataViewContainer*)container {
    if(_container != container) {
        [self willChangeContainer];
        _container = container;
        [self didChangeContainer];
    }
}

- (CGRect)frame {
    [_dataView validateLayoutIfNeed];
    return _frame;
}

- (void)setHidden:(BOOL)hidden {
    if(_hidden != hidden) {
        _hidden = hidden;
        [_dataView setNeedValidateLayout];
    }
}

- (BOOL)isHiddenInHierarchy {
    if(_hidden == YES) {
        return YES;
    }
    return _container.hiddenInHierarchy;
}

#pragma mark - Public

- (NSArray*)allItems {
    return @[];
}

- (void)setNeedResize {
}

- (void)setNeedUpdate {
}

- (void)setNeedReload {
    [self setNeedUpdate];
}

- (void)willChangeDataView {
}

- (void)didChangeDataView {
}

- (void)willChangeContainer {
}

- (void)didChangeContainer {
    if(_container != nil) {
        self.dataView = _container.dataView;
    }
}

- (GLBDataViewItem*)itemForPoint:(CGPoint __unused)point {
    return nil;
}

- (GLBDataViewItem*)itemForData:(id __unused)data {
    return nil;
}

- (GLBDataViewCell*)cellForData:(id)data {
    GLBDataViewItem* item = [self itemForData:data];
    if(item != nil) {
        return item.cell;
    }
    return nil;
}

- (BOOL)containsActionForKey:(id)key {
    return [_dataView containsActionForKey:key];
}

- (BOOL)containsActionForIdentifier:(id)identifier forKey:(id)key {
    return [_dataView containsActionForIdentifier:identifier forKey:key];
}

- (void)performActionForKey:(id)key withArguments:(NSArray*)arguments {
    [_dataView performActionForKey:key withArguments:[@[ self ] glb_unionWithArray:arguments]];
}

- (void)performActionForIdentifier:(id)identifier forKey:(id)key withArguments:(NSArray*)arguments {
    [_dataView performActionForIdentifier:identifier forKey:key withArguments:[@[ self ] glb_unionWithArray:arguments]];
}

- (void)willBeginDragging {
}

- (void)didScrollDragging:(BOOL)dragging decelerating:(BOOL)decelerating {
}

- (void)willEndDraggingWithVelocity:(CGPoint)velocity contentOffset:(inout CGPoint*)contentOffset contentSize:(CGSize)contentSize visibleSize:(CGSize)visibleSize {
    if(_allowAutoAlign == YES) {
        *contentOffset = [self alignWithVelocity:velocity contentOffset:*contentOffset contentSize:contentSize visibleSize:visibleSize];
    }
}

- (void)didEndDraggingWillDecelerate:(BOOL __unused)decelerate {
}

- (void)willBeginDecelerating {
}

- (void)didEndDecelerating {
}

- (void)didEndScrollingAnimation {
}

- (void)beginUpdateAnimated:(BOOL __unused)animated {
}

- (void)updateAnimated:(BOOL __unused)animated {
}

- (void)endUpdateAnimated:(BOOL __unused)animated {
    if(_allowAutoAlign == YES) {
        [self align];
    }
}

- (CGPoint)alignPoint {
    return [self alignPointWithContentOffset:_dataView.contentOffset contentSize:_dataView.contentSize visibleSize:_dataView.glb_boundsSize];
}

- (CGPoint)_alignPointWithContentOffset:(CGPoint)contentOffset contentSize:(CGSize)contentSize visibleSize:(CGSize)visibleSize {
    CGPoint alignPoint = CGPointZero;
    CGRect visibleRect = CGRectMake(_alignInsets.left, _alignInsets.top, visibleSize.width - (_alignInsets.left + _alignInsets.right), visibleSize.height - (_alignInsets.top + _alignInsets.bottom));
    if((_alignPosition & GLBDataViewContainerAlignLeft) != 0) {
        alignPoint.x = contentOffset.x + visibleRect.origin.x;
    } else if((_alignPosition & GLBDataViewContainerAlignCenteredHorizontally) != 0) {
        alignPoint.x = contentOffset.x + (visibleRect.origin.x + (visibleRect.size.width * 0.5f));
    } else if((_alignPosition & GLBDataViewContainerAlignRight) != 0) {
        alignPoint.x = contentOffset.x + (visibleRect.origin.x + visibleRect.size.width);
    } else {
        alignPoint.x = contentOffset.x;
    }
    if((_alignPosition & GLBDataViewContainerAlignTop) != 0) {
        alignPoint.y = contentOffset.y + visibleRect.origin.y;
    } else if((_alignPosition & GLBDataViewContainerAlignCenteredVertically) != 0) {
        alignPoint.y = contentOffset.y + (visibleRect.origin.y + (visibleRect.size.height * 0.5f));
    } else if((_alignPosition & GLBDataViewContainerAlignBottom) != 0) {
        alignPoint.y = contentOffset.y + (visibleRect.origin.y + visibleRect.size.height);
    } else {
        alignPoint.y = contentOffset.y;
    }
    return alignPoint;
}

- (CGPoint)alignWithVelocity:(CGPoint __unused)velocity contentOffset:(CGPoint)contentOffset contentSize:(CGSize __unused)contentSize visibleSize:(CGSize __unused)visibleSize {
    return contentOffset;
}

- (void)align {
    if((_dataView.dragging == NO) && (_dataView.decelerating == NO)) {
        [_dataView setContentOffset:[self alignWithVelocity:CGPointZero contentOffset:_dataView.contentOffset contentSize:_dataView.contentSize visibleSize:_dataView.glb_boundsSize] animated:YES];
    }
}

- (CGRect)validateLayoutForAvailableFrame:(CGRect)frame {
    _frame = [self frameForAvailableFrame:frame];
    [self layoutForAvailableFrame:frame];
    return _frame;
}

- (CGRect)frameForAvailableFrame:(CGRect)frame {
    return CGRectNull;
}

- (void)layoutForAvailableFrame:(CGRect)frame {
}

- (void)willLayoutForBounds:(CGRect __unused)bounds {
}

- (void)didLayoutForBounds:(CGRect __unused)bounds {
}

- (void)beginMovingItem:(GLBDataViewItem*)item location:(CGPoint)location {
}

- (void)movingItem:(GLBDataViewItem*)item location:(CGPoint)location delta:(CGPoint)delta allowsSorting:(BOOL)allowsSorting {
}

- (void)endMovingItem:(GLBDataViewItem*)item location:(CGPoint)location {
}

- (void)beginTransition {
}

- (void)transitionResize {
}

- (void)endTransition {
}

#pragma mark - GLBSearchBarDelegate

- (void)searchBarBeginSearch:(GLBSearchBar*)searchBar {
}

- (void)searchBarEndSearch:(GLBSearchBar*)searchBar {
}

- (void)searchBarBeginEditing:(GLBSearchBar*)searchBar {
}

- (void)searchBar:(GLBSearchBar*)searchBar textChanged:(NSString*)textChanged {
}

- (void)searchBarEndEditing:(GLBSearchBar*)searchBar {
}

- (void)searchBarPressedClear:(GLBSearchBar*)searchBar {
}

- (void)searchBarPressedReturn:(GLBSearchBar*)searchBar {
}

- (void)searchBarPressedCancel:(GLBSearchBar*)searchBar {
}

#pragma mark - UIAccessibility

- (BOOL)isAccessibilityElement {
    return NO;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
