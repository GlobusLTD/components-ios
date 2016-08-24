/*--------------------------------------------------*/

#import "GLBDataCell+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import "NSArray+GLBNS.h"
#import "UIGestureRecognizer+GLBUI.h"
#import "UIDevice+GLBUI.h"
#import "UINib+GLBUI.h"

/*--------------------------------------------------*/

@implementation GLBDataCell

#pragma mark - Synthesize

@synthesize identifier = _identifier;
@synthesize view = _view;
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

+ (CGSize)sizeForItem:(GLBDataItem*)item availableSize:(CGSize)size {
    GLBDataCell* cell = [item.view _dequeueCellWithItem:item];
    if(cell != nil) {
        cell.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
        cell.item = item;
        [cell setNeedsLayout];
        size = [cell sizeForItem:item availableSize:size];
        [item.view _enqueueCell:cell forIdentifier:item.identifier];
        cell.item = nil;
    }
    return size;
}

- (CGSize)sizeForItem:(id)item availableSize:(CGSize)size {
    if(UIDevice.glb_systemVersion >= 8.0f) {
        return [self systemLayoutSizeFittingSize:CGSizeMake(size.width, size.height) withHorizontalFittingPriority:[self fittingHorizontalPriority] verticalFittingPriority:[self fittingVerticalPriority]];
    }
    return [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
}

- (UILayoutPriority)fittingHorizontalPriority {
    return UILayoutPriorityRequired;
}

- (UILayoutPriority)fittingVerticalPriority {
    return UILayoutPriorityFittingSizeLevel;
}

#pragma mark - Init / Free

- (instancetype)initWithIdentifier:(NSString*)identifier {
    return [self initWithIdentifier:identifier nib:[UINib glb_nibWithClass:self.class bundle:nil]];
}

- (instancetype)initWithIdentifier:(NSString*)identifier nib:(UINib*)nib {
    self = [super init];
    if(self != nil) {
        _identifier = identifier;
        if(nib != nil) {
            [nib instantiateWithOwner:self options:nil];
        }
        [self setup];
    }
    return self;
}

- (void)setup {
    self.clipsToBounds = YES;
    self.hidden = YES;
    
    self.pressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(_handlerPressGestureRecognizer)];
    self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(_handlerLongPressGestureRecognizer)];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

#pragma mark - UIView

- (void)updateConstraints {
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
    [super updateConstraints];
}

#pragma mark - Property

- (void)setItem:(GLBDataItem*)item {
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
            [self willShow];
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
        [self setNeedsUpdateConstraints];
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

- (void)reload {
}

- (void)didHide {
}

- (BOOL)containsActionForKey:(id)key {
    return [_view containsActionForKey:key];
}

- (BOOL)containsActionForIdentifier:(id)identifier forKey:(id)key {
    return [_view containsActionForIdentifier:identifier forKey:key];
}

- (void)performActionForKey:(id)key withArguments:(NSArray*)arguments {
    [_view performActionForIdentifier:_identifier forKey:key withArguments:[@[ self ] glb_unionWithArray:arguments]];
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

- (void)beginTransition {
}

- (void)endTransition {
}

#pragma mark - Private

- (void)_willBeginDragging {
    [UIGestureRecognizer glb_cancelInView:_rootView recursive:YES];
}

- (void)_pressed {
    [_view _pressedItem:_item animated:YES];
    [self performActionForKey:GLBDataCellPressed withArguments:@[ _item ]];
}

- (void)_longPressed {
    [self performActionForKey:GLBDataCellLongPressed withArguments:@[ _item ]];
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
                    [self _pressed];
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
        [self _longPressed];
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
    if((_view.isDragging == YES) || (_view.isDecelerating == YES)) {
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

@end

/*--------------------------------------------------*/

NSString* GLBDataCellPressed = @"GLBDataCellPressed";
NSString* GLBDataCellLongPressed = @"GLBDataCellLongPressed";

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
