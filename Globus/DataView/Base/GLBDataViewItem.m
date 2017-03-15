/*--------------------------------------------------*/

#import "GLBDataViewItem+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBDataViewItem

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(init)

#pragma mark - Synthesize

@synthesize dataView = _dataView;
@synthesize container = _container;
@synthesize identifier = _identifier;
@synthesize data = _data;
@synthesize size = _size;
@synthesize needResize = _needResize;
@synthesize originFrame = _originFrame;
@synthesize updateFrame = _updateFrame;
@synthesize displayFrame = _displayFrame;
@synthesize alpha = _alpha;
@synthesize transform3D = _transform3D;
@synthesize order = _order;
@synthesize accessibilityOrder = _accessibilityOrder;
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
@synthesize accessibilityElement = _accessibilityElement;

#pragma mark - Init / Free

+ (instancetype)itemWithIdentifier:(NSString*)identifier order:(NSUInteger)order data:(id)data {
    return [[self alloc] initWithIdentifier:identifier order:order accessibilityOrder:order data:data];
}

+ (instancetype)itemWithIdentifier:(NSString*)identifier order:(NSUInteger)order accessibilityOrder:(NSUInteger)accessibilityOrder data:(id)data {
    return [[self alloc] initWithIdentifier:identifier order:order accessibilityOrder:accessibilityOrder data:data];
}

- (instancetype)initWithIdentifier:(NSString*)identifier order:(NSUInteger)order data:(id)data {
    return [self initWithIdentifier:identifier order:order accessibilityOrder:order data:data];
}

- (instancetype)initWithIdentifier:(NSString*)identifier order:(NSUInteger)order accessibilityOrder:(NSUInteger)accessibilityOrder data:(id)data {
    self = [super init];
    if(self != nil) {
        _identifier = identifier;
        _order = order;
        _accessibilityOrder = accessibilityOrder;
        _data = data;
        _size = CGSizeZero;
        _needResize = YES;
        _originFrame = CGRectNull;
        _updateFrame = CGRectNull;
        _displayFrame = CGRectNull;
        _alpha = 1;
        _transform3D = CATransform3DIdentity;
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
    self.isAccessibilityElement = YES;
}

- (void)dealloc {
}

#pragma mark - Debug

- (NSString*)description {
    return self.debugDescription;
}

- (NSString*)debugDescription {
    NSMutableArray* lines = [NSMutableArray array];
    [lines addObject:[NSString stringWithFormat:@"- %@ <%x>", _identifier, (unsigned int)self]];
    [lines addObject:[NSString stringWithFormat:@"-- Order: %d", (int)_order]];
    if(_order != _accessibilityOrder) {
        [lines addObject:[NSString stringWithFormat:@"-- AccessibilityOrder: %d", (int)_accessibilityOrder]];
    }
    [lines addObject:[NSString stringWithFormat:@"-- OriginFrame: %@", NSStringFromCGRect(_originFrame)]];
    if(CGRectEqualToRect(_originFrame, _updateFrame) == NO) {
        [lines addObject:[NSString stringWithFormat:@"-- UpdateFrame: %@", NSStringFromCGRect(_updateFrame)]];
    }
    if(CGRectIsNull(_displayFrame) == NO) {
        [lines addObject:[NSString stringWithFormat:@"-- DisplayFrame: %@", NSStringFromCGRect(_displayFrame)]];
    }
    if(_hidden == YES) {
        [lines addObject:[NSString stringWithFormat:@"-- Hidden"]];
    }
    if(_persistent == YES) {
        [lines addObject:[NSString stringWithFormat:@"-- Persistent"]];
    }
    return [NSString stringWithFormat:@"\n%@", [lines componentsJoinedByString:@"\n"]];
}

#pragma mark - Property

- (void)setDataView:(GLBDataView*)dataView {
    if(_dataView != dataView) {
        _dataView = dataView;
        if(_dataView != nil) {
            if(_accessibilityElement == nil) {
                _accessibilityElement = [GLBDataViewItemAccessibilityElement accessibilityElementWithDataView:_dataView item:self];
            } else {
                _accessibilityElement.dataView = _dataView;
            }
        } else {
            _accessibilityElement = nil;
        }
    }
}

- (void)setContainer:(GLBDataViewContainer*)container {
    if(_container != container) {
        _container = container;
        if(_container != nil) {
            self.dataView = container.dataView;
        } else {
            self.dataView = nil;
        }
    }
}

- (void)setCell:(GLBDataViewCell*)cell {
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
                _cell.alpha = _alpha;
                _cell.layer.transform = _transform3D;
                _cell.item = self;
            }];
        }
    }
}

- (CGRect)originFrame {
    [_dataView validateLayoutIfNeed];
    return _originFrame;
}

- (void)setUpdateFrame:(CGRect)updateFrame {
    if(CGRectEqualToRect(_updateFrame, updateFrame) == NO) {
        _updateFrame = updateFrame;
        if(CGRectIsNull(_originFrame) == YES) {
            _originFrame = _updateFrame;
        }
        if((CGRectIsNull(_updateFrame) == NO) && (CGRectIsNull(_displayFrame) == YES)) {
            if(_cell != nil) {
                _cell.frame = _updateFrame;
            }
        }
    }
}

- (CGRect)updateFrame {
    [_dataView validateLayoutIfNeed];
    return _updateFrame;
}

- (void)setDisplayFrame:(CGRect)displayFrame {
    if(CGRectEqualToRect(_displayFrame, displayFrame) == NO) {
        _displayFrame = displayFrame;
        if(_cell != nil) {
            if(CGRectIsNull(_displayFrame) == NO) {
                _cell.frame = _displayFrame;
            } else {
                _cell.frame = _updateFrame;
            }
        }
    }
}

- (CGRect)displayFrame {
    [_dataView validateLayoutIfNeed];
    if(CGRectIsNull(_displayFrame) == YES) {
        return _updateFrame;
    }
    return _displayFrame;
}

- (CGRect)frame {
    [_dataView validateLayoutIfNeed];
    if(CGRectIsNull(_displayFrame) == NO) {
        return _displayFrame;
    } else if(CGRectIsNull(_updateFrame) == NO) {
        return _updateFrame;
    }
    return _originFrame;
}

- (void)setAlpha:(CGFloat)alpha {
    if(_alpha != alpha) {
        _alpha = alpha;
        if(_cell != nil) {
            _cell.alpha = _alpha;
        }
    }
}

- (void)setTransform:(CGAffineTransform)transform {
    [self setTransform3D:CATransform3DMakeAffineTransform(transform)];
}

- (CGAffineTransform)transform {
    return CATransform3DGetAffineTransform(_transform3D);
}

- (void)setTransform3D:(CATransform3D)transform3D {
    if(CATransform3DEqualToTransform(_transform3D, transform3D) == NO) {
        _transform3D = transform3D;
        if(_cell != nil) {
            _cell.layer.transform = _transform3D;
        }
    }
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

- (BOOL)containsActionForKey:(id)key {
    return [_dataView containsActionForKey:key];
}

- (BOOL)containsActionForIdentifier:(id)identifier forKey:(id)key {
    return [_dataView containsActionForIdentifier:identifier forKey:key];
}

- (void)performActionForKey:(id)key withArguments:(NSArray*)arguments {
    [_dataView performActionForIdentifier:_identifier forKey:key withArguments:[@[ self ] glb_unionWithArray:arguments]];
}

- (void)beginUpdateAnimated:(BOOL __unused)animated {
}

- (void)updateAnimated:(BOOL __unused)animated {
    _originFrame = _updateFrame;
    if(_cell != nil) {
        _cell.frame = self.frame;
    }
}

- (void)endUpdateAnimated:(BOOL __unused)animated {
}

- (void)selectedAnimated:(BOOL)animated {
    if(_selected == NO) {
        _selected = YES;
        if(_cell != nil) {
            [_dataView selectItem:self animated:animated];
            [_cell selectedAnimated:animated];
        }
    }
}

- (void)deselectedAnimated:(BOOL)animated {
    if(_selected == YES) {
        _selected = NO;
        if(_cell != nil) {
            [_dataView deselectItem:self animated:animated];
            [_cell deselectedAnimated:animated];
        }
    }
}

- (void)highlightedAnimated:(BOOL)animated {
    if(_highlighted == NO) {
        _highlighted = YES;
        if(_cell != nil) {
            [_dataView highlightItem:self animated:animated];
            [_cell highlightedAnimated:animated];
        }
    }
}

- (void)unhighlightedAnimated:(BOOL)animated {
    if(_highlighted == YES) {
        _highlighted = NO;
        if(_cell != nil) {
            [_dataView unhighlightItem:self animated:animated];
            [_cell unhighlightedAnimated:animated];
        }
    }
}

- (void)beginEditingAnimated:(BOOL)animated {
    if(_editing == NO) {
        _editing = YES;
        if(_cell != nil) {
            [_dataView beganEditItem:self animated:animated];
            [_cell beginEditingAnimated:animated];
        }
    }
}

- (void)endEditingAnimated:(BOOL)animated {
    if(_editing == YES) {
        _editing = NO;
        if(_cell != nil) {
            [_dataView endedEditItem:self animated:animated];
            [_cell endEditingAnimated:animated];
        }
    }
}

- (void)beginMovingAnimated:(BOOL)animated {
    if(_moving == NO) {
        _moving = YES;
        if(_cell != nil) {
            [_dataView beganMoveItem:self animated:animated];
            [_cell beginMovingAnimated:animated];
        }
    }
}

- (void)endMovingAnimated:(BOOL)animated {
    if(_moving == YES) {
        _moving = NO;
        if(_cell != nil) {
            [_dataView endedMoveItemAnimated:animated];
            [_cell endMovingAnimated:animated];
        }
    }
}

- (void)setNeedResize {
    if(_needResize == NO) {
        _needResize = YES;
        if((_dataView.isAnimating == NO) && (_dataView.isTransiting == NO)) {
            _originFrame = CGRectNull;
            _updateFrame = CGRectNull;
        }
        [_dataView setNeedValidateLayout];
    }
}

- (CGSize)sizeForAvailableSize:(CGSize)size {
    if(_needResize == YES) {
        _needResize = NO;
        
        Class cellClass = [_dataView cellClassWithItem:self];
        if(cellClass != nil) {
            _size = [cellClass sizeForItem:self availableSize:size];
        }
    }
    return _size;
}

- (void)setNeedUpdate {
    if(_cell != nil) {
        if(_dataView.isUpdating == YES) {
            _cell.frame = self.frame;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            [_cell reload];
#pragma clang diagnostic pop
        } else {
            [UIView performWithoutAnimation:^{
                _cell.frame = self.frame;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                [_cell reload];
#pragma clang diagnostic pop
            }];
        }
    }
}

- (void)setNeedReload {
    [self setNeedUpdate];
}

- (void)validateLayoutForBounds:(CGRect)bounds {
    if(_cell == nil) {
        if(_persistent == YES) {
            [_dataView appearItem:self];
            [_cell validateLayoutForBounds:bounds];
        } else if((CGRectIntersectsRect(bounds, CGRectUnion(_originFrame, self.frame)) == YES)) {
            [_dataView appearItem:self];
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
            [_dataView disappearItem:self];
        } else if(CGRectIntersectsRect(bounds, self.frame) == NO) {
            [_dataView disappearItem:self];
        } else {
            [_cell invalidateLayoutForBounds:bounds];
        }
    }
}

- (void)beginTransition {
    [self setNeedResize];
    if(_cell != nil) {
        [_cell beginTransition];
    }
}

- (void)transitionResize {
    [self setNeedResize];
    if(_cell != nil) {
        [_cell transitionResize];
    }
}

- (void)endTransition {
    if(_cell != nil) {
        [_cell endTransition];
    }
}

#pragma mark - Private

- (NSArray*)_cellAccessibilityElements {
    if(_cell.isAccessibilityElement == YES) {
        return @[ _cell ];
    } else {
        return _cell.accessibilityElements;
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

#pragma mark - UIAccessibilityContainer

- (NSInteger)accessibilityElementCount {
    return (NSInteger)(self.accessibilityElements.count);
}

- (id)accessibilityElementAtIndex:(NSInteger)index {
    return [self.accessibilityElements objectAtIndex:(NSUInteger)(index)];
}

- (NSInteger)indexOfAccessibilityElement:(id)element {
    return (NSInteger)([self.accessibilityElements indexOfObject:element]);
}

- (NSArray*)accessibilityElements {
    if(_accessibilityElement != nil) {
        if(_accessibilityElement.isAccessibilityElement == YES) {
            if(_cell != nil) {
                return [self _cellAccessibilityElements];
            } else {
                return @[ _accessibilityElement ];
            }
        }
    }
    return nil;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBDataViewItemAccessibilityElement

+ (instancetype)accessibilityElementWithDataView:(GLBDataView*)dataView item:(GLBDataViewItem*)item {
    return [[self alloc] initWithDataView:dataView item:item];
}

- (instancetype)initWithDataView:(GLBDataView*)dataView item:(GLBDataViewItem*)item {
    self = [super initWithAccessibilityContainer:dataView];
    if(self != nil) {
        _dataView = dataView;
        _item = item;
    }
    return self;
}

#pragma mark - Property

- (void)setDataView:(GLBDataView*)dataView {
    _dataView = dataView;
    self.accessibilityContainer = dataView;
}

#pragma mark - UIAccessibilityElement

- (void)setIsAccessibilityElement:(BOOL)isAccessibilityElement {
    _item.isAccessibilityElement = isAccessibilityElement;
}

- (BOOL)isAccessibilityElement {
    return _item.isAccessibilityElement;
}

- (void)setAccessibilitLabel:(NSString*)accessibilityLabel {
    _item.accessibilityLabel = accessibilityLabel;
}

- (NSString*)accessibilityLabel {
    return _item.accessibilityLabel;
}

- (void)setAccessibilityHint:(NSString*)accessibilityHint {
    _item.accessibilityHint = accessibilityHint;
}

- (NSString*)accessibilityHint {
    return _item.accessibilityHint;
}

- (void)setAccessibilityValue:(NSString*)accessibilityValue {
    _item.accessibilityValue = accessibilityValue;
}

- (NSString*)accessibilityValue {
    return _item.accessibilityValue;
}

- (CGRect)accessibilityFrame {
    return [_dataView convertRect:_item.frame toView:nil];
}

- (void)setAccessibilityTraits:(UIAccessibilityTraits)accessibilityTraits {
    _item.accessibilityTraits = accessibilityTraits;
}

- (UIAccessibilityTraits)accessibilityTraits {
    return _item.accessibilityTraits;
}

#pragma mark - Property

- (void)accessibilityElementDidBecomeFocused {
    id notificationArg = nil;
    if(_item.cell != nil) {
        NSArray* cellAccessibilityElements = [_item _cellAccessibilityElements];
        if(cellAccessibilityElements != nil) {
            notificationArg = cellAccessibilityElements.firstObject;
        }
    } else {
        notificationArg = self;
    }
    UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, notificationArg);
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
