/*--------------------------------------------------*/

#import "GLBLayoutView.h"
#import "GLBKVO.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBLayoutView ()

@property(nonatomic, readonly, strong) NSMutableArray* hiddenObservers;
@property(nonatomic, readonly, strong) NSMutableArray* topConstraints;
@property(nonatomic, readonly, strong) NSMutableArray* bottomConstraints;
@property(nonatomic, readonly, strong) NSMutableArray* leftConstraints;
@property(nonatomic, readonly, strong) NSMutableArray* rightConstraints;
@property(nonatomic, readonly, strong) NSMutableArray* spacingConstraints;

@end

/*--------------------------------------------------*/

@implementation GLBLayoutView

#pragma mark - Init

@synthesize hiddenObservers = _hiddenObservers;
@synthesize topConstraints = _topConstraints;
@synthesize bottomConstraints = _bottomConstraints;
@synthesize leftConstraints = _leftConstraints;
@synthesize rightConstraints = _rightConstraints;
@synthesize spacingConstraints = _spacingConstraints;

#pragma mark - Init / Free

- (instancetype)initWithCoder:(NSCoder*)coder {
    self = [super initWithCoder:coder];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
}

#pragma mark - Property

- (void)setAxis:(UILayoutConstraintAxis)axis {
    if(_axis != axis) {
        _axis = axis;
        [self setNeedsUpdateConstraints];
    }
}

- (void)setAlignment:(GLBLayoutViewAlignment)alignment {
    if(_alignment != alignment) {
        _alignment = alignment;
        [self setNeedsUpdateConstraints];
    }
}

- (void)setMargins:(UIEdgeInsets)margins{
    if(UIEdgeInsetsEqualToEdgeInsets(_margins, margins) == NO) {
        if(_margins.top != margins.top) {
            [self.topConstraints glb_each:^(NSLayoutConstraint* constraint) {
                constraint.constant = margins.top;
            }];
        }
        if(_margins.bottom != margins.bottom) {
            [self.bottomConstraints glb_each:^(NSLayoutConstraint* constraint) {
                constraint.constant = margins.bottom;
            }];
        }
        if(_margins.left != margins.left) {
            [self.leftConstraints glb_each:^(NSLayoutConstraint* constraint) {
                constraint.constant = margins.left;
            }];
        }
        if(_margins.right != margins.right) {
            [self.rightConstraints glb_each:^(NSLayoutConstraint* constraint) {
                constraint.constant = margins.right;
            }];
        }
        _margins = margins;
    }
}

- (void)setSpacing:(CGFloat)spacing {
    if(_spacing != spacing) {
        _spacing = spacing;
        [self.spacingConstraints glb_each:^(NSLayoutConstraint* constraint) {
            constraint.constant = _spacing;
        }];
    }
}

- (NSMutableArray*)hiddenObservers {
    if(_hiddenObservers == nil) {
        _hiddenObservers = [NSMutableArray array];
    }
    return _hiddenObservers;
}

- (NSMutableArray*)topConstraints {
    if(_topConstraints == nil) {
        _topConstraints = [NSMutableArray array];
    }
    return _topConstraints;
}

- (NSMutableArray*)bottomConstraints {
    if(_bottomConstraints == nil) {
        _bottomConstraints = [NSMutableArray array];
    }
    return _bottomConstraints;
}

- (NSMutableArray*)leftConstraints {
    if(_leftConstraints == nil) {
        _leftConstraints = [NSMutableArray array];
    }
    return _leftConstraints;
}

- (NSMutableArray*)rightConstraints {
    if(_rightConstraints == nil) {
        _rightConstraints = [NSMutableArray array];
    }
    return _rightConstraints;
}

- (NSMutableArray*)spacingConstraints {
    if(_spacingConstraints == nil) {
        _spacingConstraints = [NSMutableArray array];
    }
    return _spacingConstraints;
}

#pragma mark - Public override

- (void)didAddSubview:(UIView*)subview {
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    [self.hiddenObservers addObject:[subview glb_observeKeyPath:@"hidden" withBlock:^(GLBKVO* kvo, id oldValue, id newValue) {
        [self setNeedsUpdateConstraints];
    }]];
    [super didAddSubview:subview];
    [self setNeedsUpdateConstraints];
}

- (void)willRemoveSubview:(UIView*)subview {
    [self.hiddenObservers glb_each:^(GLBKVO* kvo) {
        if(kvo.subject == subview) {
            [kvo stopObservation];
            [self.hiddenObservers removeObject:kvo];
        }
    }];
    [super willRemoveSubview:subview];
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if(self.topConstraints.count > 0) {
        [self removeConstraints:self.topConstraints];
        [self.topConstraints removeAllObjects];
    }
    if(self.bottomConstraints.count > 0) {
        [self removeConstraints:self.bottomConstraints];
        [self.bottomConstraints removeAllObjects];
    }
    if(self.rightConstraints.count > 0) {
        [self removeConstraints:self.rightConstraints];
        [self.rightConstraints removeAllObjects];
    }
    if(self.leftConstraints.count > 0) {
        [self removeConstraints:self.leftConstraints];
        [self.leftConstraints removeAllObjects];
    }
    
    __block UIView* prevSubview = nil;
    [self.subviews glb_each:^(UIView* subview) {
        switch(_axis) {
            case UILayoutConstraintAxisHorizontal:
                if(prevSubview == nil) {
                    [self.leftConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeLeft relation:NSLayoutRelationEqual attribute:NSLayoutAttributeLeft constant:_margins.left]];
                } else {
                    [self.spacingConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeLeft relation:NSLayoutRelationEqual view:prevSubview attribute:NSLayoutAttributeRight constant:_spacing]];
                }
                switch(_alignment) {
                    case GLBLayoutViewAlignmentFill:
                        [self.topConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeTop relation:NSLayoutRelationEqual attribute:NSLayoutAttributeTop constant:_margins.top]];
                        [self.bottomConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual attribute:NSLayoutAttributeBottom constant:_margins.bottom]];
                        break;
                    case GLBLayoutViewAlignmentLeading:
                        [self.topConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeTop relation:NSLayoutRelationEqual attribute:NSLayoutAttributeTop constant:_margins.top]];
                        [self.bottomConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeBottom relation:NSLayoutRelationGreaterThanOrEqual attribute:NSLayoutAttributeBottom constant:_margins.bottom]];
                        break;
                    case GLBLayoutViewAlignmentCenter:
                        [subview glb_addConstraintAttribute:NSLayoutAttributeCenterY relation:NSLayoutRelationEqual attribute:NSLayoutAttributeCenterY constant:0.0];
                        [self.topConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeTop relation:NSLayoutRelationGreaterThanOrEqual attribute:NSLayoutAttributeTop constant:_margins.top]];
                        [self.bottomConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeBottom relation:NSLayoutRelationGreaterThanOrEqual attribute:NSLayoutAttributeBottom constant:_margins.bottom]];
                        break;
                    case GLBLayoutViewAlignmentTrailing:
                        [self.topConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeTop relation:NSLayoutRelationGreaterThanOrEqual attribute:NSLayoutAttributeTop constant:_margins.top]];
                        [self.bottomConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual attribute:NSLayoutAttributeBottom constant:_margins.bottom]];
                        break;
                }
                break;
            case UILayoutConstraintAxisVertical:
                if(prevSubview == nil) {
                    [self.topConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeTop relation:NSLayoutRelationEqual attribute:NSLayoutAttributeTop constant:_margins.top]];
                } else {
                    [self.spacingConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeTop relation:NSLayoutRelationEqual view:prevSubview attribute:NSLayoutAttributeBottom constant:_spacing]];
                }
                switch(_alignment) {
                    case GLBLayoutViewAlignmentFill:
                        [self.leftConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeLeft relation:NSLayoutRelationEqual attribute:NSLayoutAttributeLeft constant:_margins.left]];
                        [self.rightConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual attribute:NSLayoutAttributeRight constant:_margins.right]];
                        break;
                    case GLBLayoutViewAlignmentLeading:
                        [self.leftConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeLeft relation:NSLayoutRelationEqual attribute:NSLayoutAttributeLeft constant:_margins.left]];
                        [self.rightConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeRight relation:NSLayoutRelationGreaterThanOrEqual attribute:NSLayoutAttributeRight constant:_margins.right]];
                        break;
                    case GLBLayoutViewAlignmentCenter:
                        [subview glb_addConstraintAttribute:NSLayoutAttributeCenterX relation:NSLayoutRelationEqual attribute:NSLayoutAttributeCenterX constant:0.0];
                        [self.leftConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeLeft relation:NSLayoutRelationGreaterThanOrEqual attribute:NSLayoutAttributeLeft constant:_margins.left]];
                        [self.rightConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeRight relation:NSLayoutRelationGreaterThanOrEqual attribute:NSLayoutAttributeRight constant:_margins.right]];
                        break;
                    case GLBLayoutViewAlignmentTrailing:
                        [self.leftConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeLeft relation:NSLayoutRelationGreaterThanOrEqual attribute:NSLayoutAttributeLeft constant:_margins.left]];
                        [self.rightConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual attribute:NSLayoutAttributeRight constant:_margins.right]];
                        break;
                }
                break;
        }
        if(subview.isHidden == NO) {
            prevSubview = subview;
        }
    }];
    if(prevSubview != nil) {
        switch(_axis) {
            case UILayoutConstraintAxisHorizontal:
                [self.rightConstraints addObject:[prevSubview glb_addConstraintAttribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual attribute:NSLayoutAttributeRight constant:_margins.right]];
                break;
            case UILayoutConstraintAxisVertical:
                [self.bottomConstraints addObject:[prevSubview glb_addConstraintAttribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual attribute:NSLayoutAttributeBottom constant:_margins.bottom]];
                break;
        }
    }
    [super updateConstraints];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
