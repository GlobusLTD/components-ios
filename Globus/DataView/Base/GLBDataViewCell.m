/*--------------------------------------------------*/

#import "GLBDataViewCell+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBDataViewCell

#pragma mark - Synthesize

@synthesize dataView = _dataView;
@synthesize item = _item;
@synthesize selected = _selected;
@synthesize highlighted = _highlighted;
@synthesize editing = _editing;
@synthesize moving = _moving;
@synthesize pressGestureRecognizer = _pressGestureRecognizer;
@synthesize longPressGestureRecognizer = _longPressGestureRecognizer;
@synthesize rootView = _rootView;
@synthesize rootViewOffset = _rootViewOffset;
@synthesize rootViewSize = _rootViewSize;
@synthesize constraintRootViewCenterX = _constraintRootViewCenterX;
@synthesize constraintRootViewCenterY = _constraintRootViewCenterY;
@synthesize constraintRootViewWidth = _constraintRootViewWidth;
@synthesize constraintRootViewHeight = _constraintRootViewHeight;

#pragma mark - Calculating size

+ (CGSize)sizeForItem:(GLBDataViewItem*)item availableSize:(CGSize)size {
    GLBDataViewCell* cell = item.cell;
    GLBDataViewCell* dequeueCell = nil;
    if(cell == nil) {
        dequeueCell = [item.dataView dequeueCellWithItem:item];
    }
    CGSize result = CGSizeZero;
    if(dequeueCell != nil) {
        [UIView performWithoutAnimation:^{
            dequeueCell.glb_frameSize = size;
            dequeueCell.item = item;
        }];
        result = [dequeueCell sizeForAvailableSize:size];
        [item.dataView enqueueCell:dequeueCell];
        dequeueCell.item = nil;
    } else if(cell != nil) {
        result = [cell sizeForAvailableSize:size];
    }
    return result;
}

- (CGSize)sizeForAvailableSize:(CGSize)size {
    UILayoutPriority fittingHorizontalPriority = self.fittingHorizontalPriority;
    UILayoutPriority fittingVerticalPriority = self.fittingVerticalPriority;
    if([UIDevice glb_compareSystemVersion:@"8.0"] != NSOrderedAscending) {
        return [self systemLayoutSizeFittingSize:size
                   withHorizontalFittingPriority:fittingHorizontalPriority
                         verticalFittingPriority:fittingVerticalPriority];
    }
    NSLayoutConstraint* constraint = nil;
    if(fittingHorizontalPriority > fittingVerticalPriority) {
        constraint = [NSLayoutConstraint constraintWithItem:self.rootView
                                                  attribute:NSLayoutAttributeWidth
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:nil
                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                 multiplier:1
                                                   constant:size.width];
        size.height = UILayoutFittingCompressedSize.height;
    } else {
        constraint = [NSLayoutConstraint constraintWithItem:self.rootView
                                                  attribute:NSLayoutAttributeHeight
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:nil
                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                 multiplier:1
                                                   constant:size.height];
        size.width = UILayoutFittingCompressedSize.width;
    }
    [self.rootView addConstraint:constraint];
    CGSize result = [self systemLayoutSizeFittingSize:size];
    [self.rootView removeConstraint:constraint];
    return result;
}

- (UILayoutPriority)fittingHorizontalPriority {
    return UILayoutPriorityRequired;
}

- (UILayoutPriority)fittingVerticalPriority {
    return UILayoutPriorityFittingSizeLevel;
}

#pragma mark - Init / Free

- (instancetype)init {
    return [self initWithNib:self.class.glb_nib];
}

- (instancetype)initWithNib:(UINib*)nib {
    self = [super init];
    if(self != nil) {
        if(nib != nil) {
            [nib instantiateWithOwner:self options:nil];
        }
        [self setup];
    }
    return self;
}

- (void)setup {
    self.translatesAutoresizingMaskIntoConstraints = YES;
    self.autoresizingMask = UIViewAutoresizingNone;
    self.clipsToBounds = YES;
    self.hidden = YES;
    
    self.pressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(_handlerPressGestureRecognizer)];
    self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(_handlerLongPressGestureRecognizer)];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

#pragma mark - Property

- (void)setItem:(GLBDataViewItem*)item {
    if(_item != item) {
        if(_item != nil) {
            [self didHide];
            if(_editing == YES) {
                [self endEditingAnimated:NO];
            }
            if(_highlighted == YES) {
                [self unhighlightedAnimated:NO];
            }
            if(_selected == YES) {
                [self deselectedAnimated:NO];
            }
            self.hidden = YES;
        }
        _item = item;
        if(_item != nil) {
            self.hidden = NO;
            if(item.selected == YES) {
                [self selectedAnimated:NO];
            }
            if(item.highlighted == YES) {
                [self highlightedAnimated:NO];
            }
            if(item.editing == YES) {
                [self beginEditingAnimated:NO];
            }
            [self setNeedsLayout];
            [self willShow];
            if((_dataView.isAnimating == YES) || (_dataView.isTransiting == YES)) {
                [self layoutIfNeeded];
            }
        }
    }
}

- (void)setPressGestureRecognizer:(UILongPressGestureRecognizer*)pressGestureRecognizer {
    if(_pressGestureRecognizer != pressGestureRecognizer) {
        if(_pressGestureRecognizer != nil) {
            [_rootView removeGestureRecognizer:_pressGestureRecognizer];
        }
        _pressGestureRecognizer = pressGestureRecognizer;
        if(_pressGestureRecognizer != nil) {
            _pressGestureRecognizer.delaysTouchesBegan = YES;
            _pressGestureRecognizer.minimumPressDuration = 0.01f;
            _pressGestureRecognizer.delegate = self;
            [_rootView addGestureRecognizer:_pressGestureRecognizer];
        }
    }
}

- (void)setLongPressGestureRecognizer:(UILongPressGestureRecognizer*)longPressGestureRecognizer {
    if(_longPressGestureRecognizer != longPressGestureRecognizer) {
        if(_longPressGestureRecognizer != nil) {
            [_rootView removeGestureRecognizer:_longPressGestureRecognizer];
        }
        _longPressGestureRecognizer = longPressGestureRecognizer;
        if(_longPressGestureRecognizer != nil) {
            _longPressGestureRecognizer.delaysTouchesBegan = YES;
            _longPressGestureRecognizer.delegate = self;
            [_rootView addGestureRecognizer:_longPressGestureRecognizer];
        }
    }
}

- (void)setRootView:(UIView*)rootView {
    if(_rootView != rootView) {
        if(_rootView != nil) {
            [_rootView removeFromSuperview];
        }
        _rootView = rootView;
        if(_rootView != nil) {
            _rootView.translatesAutoresizingMaskIntoConstraints = NO;
        }
        [self glb_setSubviews:self.orderedSubviews];
        [self refreshConstraints];
    }
}

- (void)setConstraintRootViewCenterX:(NSLayoutConstraint*)constraintRootViewCenterX {
    if(_constraintRootViewCenterX != constraintRootViewCenterX) {
        if(_constraintRootViewCenterX != nil) {
            [self removeConstraint:_constraintRootViewCenterX];
        }
        _constraintRootViewCenterX = constraintRootViewCenterX;
        if(_constraintRootViewCenterX != nil) {
            [self addConstraint:_constraintRootViewCenterX];
        }
    }
}

- (void)setConstraintRootViewCenterY:(NSLayoutConstraint*)constraintRootViewCenterY {
    if(_constraintRootViewCenterY != constraintRootViewCenterY) {
        if(_constraintRootViewCenterY != nil) {
            [self removeConstraint:_constraintRootViewCenterY];
        }
        _constraintRootViewCenterY = constraintRootViewCenterY;
        if(_constraintRootViewCenterY != nil) {
            [self addConstraint:_constraintRootViewCenterY];
        }
    }
}

- (void)setConstraintRootViewWidth:(NSLayoutConstraint*)constraintRootViewWidth {
    if(_constraintRootViewWidth != constraintRootViewWidth) {
        if(_constraintRootViewWidth != nil) {
            [self removeConstraint:_constraintRootViewWidth];
        }
        _constraintRootViewWidth = constraintRootViewWidth;
        if(_constraintRootViewWidth != nil) {
            [self addConstraint:_constraintRootViewWidth];
        }
    }
}

- (void)setConstraintRootViewHeight:(NSLayoutConstraint*)constraintRootViewHeight {
    if(_constraintRootViewHeight != constraintRootViewHeight) {
        if(_constraintRootViewHeight != nil) {
            [self removeConstraint:_constraintRootViewHeight];
        }
        _constraintRootViewHeight = constraintRootViewHeight;
        if(_constraintRootViewHeight != nil) {
            [self addConstraint:_constraintRootViewHeight];
        }
    }
}

- (void)setRootViewOffset:(UIOffset)rootViewOffset {
    if(UIOffsetEqualToOffset(_rootViewOffset, rootViewOffset) == NO) {
        _rootViewOffset = rootViewOffset;
        if(_constraintRootViewCenterX != nil) {
            _constraintRootViewCenterX.constant = _rootViewOffset.horizontal;
        }
        if(_constraintRootViewCenterY != nil) {
            _constraintRootViewCenterY.constant = _rootViewOffset.vertical;
        }
    }
}

- (void)setRootViewSize:(CGSize)rootViewSize {
    if(CGSizeEqualToSize(_rootViewSize, rootViewSize) == NO) {
        _rootViewSize = rootViewSize;
        if(_constraintRootViewWidth != nil) {
            _constraintRootViewWidth.constant = _rootViewSize.width;
        }
        if(_constraintRootViewHeight != nil) {
            _constraintRootViewHeight.constant = _rootViewSize.height;
        }
    }
}

- (NSArray*)orderedSubviews {
    if(_rootView != nil) {
        return @[ _rootView ];
    }
    return @[  ];
}

#pragma mark - Public

- (void)willShow {
}

- (void)update {
}

- (void)reload {
    [self update];
}

- (void)didHide {
}

- (void)refreshConstraints {
    if(_rootView != nil) {
        if(_constraintRootViewCenterX == nil) {
            self.constraintRootViewCenterX = [NSLayoutConstraint constraintWithItem:_rootView
                                                                          attribute:NSLayoutAttributeCenterX
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeCenterX
                                                                         multiplier:1.0f
                                                                           constant:_rootViewOffset.horizontal];
        }
        if(_constraintRootViewCenterY == nil) {
            self.constraintRootViewCenterY = [NSLayoutConstraint constraintWithItem:_rootView
                                                                          attribute:NSLayoutAttributeCenterY
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeCenterY
                                                                         multiplier:1.0f
                                                                           constant:_rootViewOffset.vertical];
        }
        if(_constraintRootViewWidth == nil) {
            self.constraintRootViewWidth = [NSLayoutConstraint constraintWithItem:_rootView
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self
                                                                        attribute:NSLayoutAttributeWidth
                                                                       multiplier:1.0f
                                                                         constant:_rootViewSize.width];
        }
        if(_constraintRootViewHeight == nil) {
            self.constraintRootViewHeight = [NSLayoutConstraint constraintWithItem:_rootView
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self
                                                                         attribute:NSLayoutAttributeHeight
                                                                        multiplier:1.0f
                                                                          constant:_rootViewSize.height];
        }
    } else {
        self.constraintRootViewCenterX = nil;
        self.constraintRootViewCenterY = nil;
        self.constraintRootViewWidth = nil;
        self.constraintRootViewHeight = nil;
    }
}

- (BOOL)containsActionForKey:(id)key {
    return [_dataView containsActionForKey:key];
}

- (BOOL)containsActionForIdentifier:(id)identifier forKey:(id)key {
    return [_dataView containsActionForIdentifier:identifier forKey:key];
}

- (void)performActionForKey:(id)key withArguments:(NSArray*)arguments {
    if(_item != nil) {
        [_dataView performActionForIdentifier:_item.identifier forKey:key withArguments:[@[ self ] glb_unionWithArray:arguments]];
    }
}

- (void)pressed {
    [_dataView pressedItem:_item animated:YES];
    [self performActionForKey:GLBDataViewCellPressed withArguments:@[ _item ]];
}

- (void)longPressed {
    [self performActionForKey:GLBDataViewCellLongPressed withArguments:@[ _item ]];
}

- (void)selectedAnimated:(BOOL)animated {
    _selected = YES;
}

- (void)deselectedAnimated:(BOOL)animated {
    _selected = NO;
}

- (void)highlightedAnimated:(BOOL)animated {
    _highlighted = YES;
}

- (void)unhighlightedAnimated:(BOOL)animated {
    _highlighted = NO;
}

- (void)beginEditingAnimated:(BOOL)animated {
    _editing = YES;
}

- (void)endEditingAnimated:(BOOL)animated {
    _editing = NO;
}

- (void)beginMovingAnimated:(BOOL)animated {
    _moving = YES;
    _pressGestureRecognizer.enabled = NO;
    _longPressGestureRecognizer.enabled = NO;
}

- (void)endMovingAnimated:(BOOL)animated {
    _moving = NO;
    _pressGestureRecognizer.enabled = YES;
    _longPressGestureRecognizer.enabled = YES;
}

- (void)validateLayoutForBounds:(CGRect __unused)bounds {
}

- (void)invalidateLayoutForBounds:(CGRect __unused)bounds {
}

- (void)willBeginDragging {
    [UIGestureRecognizer glb_cancelInView:_rootView recursive:YES];
}

- (void)beginTransition {
}

- (void)transitionResize {
}

- (void)endTransition {
}

- (void)_handlerPressGestureRecognizer {
    switch(_pressGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            if(_item.allowsHighlighting == YES) {
                if(_highlighted == NO) {
                    [_item highlightedAnimated:YES];
                }
            }
            break;
        case UIGestureRecognizerStateChanged:
            if(_item.allowsHighlighting == YES) {
                CGPoint location = [_pressGestureRecognizer locationInView:_rootView];
                if(CGRectContainsPoint(_rootView.bounds, location) == YES) {
                    if(_highlighted == NO) {
                        [_item highlightedAnimated:YES];
                    }
                } else if(_highlighted == YES) {
                    [_item unhighlightedAnimated:YES];
                }
            }
            break;
        case UIGestureRecognizerStateEnded:
            if(_highlighted == YES) {
                [_item unhighlightedAnimated:YES];
            }
            if(_item.allowsPressed == YES) {
                CGPoint location = [_pressGestureRecognizer locationInView:_rootView];
                if(CGRectContainsPoint(_rootView.bounds, location) == YES) {
                    [self pressed];
                }
            }
            break;
        default:
            if(_highlighted == YES) {
                [_item unhighlightedAnimated:YES];
            }
            break;
    }
}

- (void)_handlerLongPressGestureRecognizer {
    if(_longPressGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [_longPressGestureRecognizer requireGestureRecognizerToFail:_pressGestureRecognizer];
        [self longPressed];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    if((gestureRecognizer == _pressGestureRecognizer) && (_item.allowsHighlighting == NO) && (_item.allowsPressed == NO)) {
        return NO;
    }
    if((gestureRecognizer == _longPressGestureRecognizer) && (_item.allowsLongPressed == NO)) {
        return NO;
    }
    if((_dataView.isDragging == YES) || (_dataView.isDecelerating == YES)) {
        return NO;
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    UIView* view = touch.view;
    while(view != _rootView) {
        if([view isKindOfClass:UIControl.class] == YES) {
            return NO;
        }
        view = view.superview;
    }
    return (touch.view == _rootView) || (touch.view.canBecomeFirstResponder == NO);
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

#pragma mark - GLBNibExtension

+ (NSString*)nibName {
    return self.glb_className;
}

+ (NSBundle*)nibBundle {
    return nil;
}

#pragma mark - UIAccessibilityContainer

- (NSArray*)accessibilityElements {
    return self.subviews;
}

@end

/*--------------------------------------------------*/
/* Constants                                        */
/*--------------------------------------------------*/

NSString* GLBDataViewCellPressed = @"GLBDataViewCellPressed";
NSString* GLBDataViewCellLongPressed = @"GLBDataViewCellLongPressed";

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
