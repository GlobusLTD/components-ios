/*--------------------------------------------------*/

#import "GLBLayoutView.h"
#import "GLBKVO.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import "NSArray+GLBNS.h"

/*--------------------------------------------------*/

@interface GLBLayoutView () {
    NSMutableArray* _hiddenObservers;
    NSMutableArray* _topConstraints;
    NSMutableArray* _bottomConstraints;
    NSMutableArray* _leftConstraints;
    NSMutableArray* _rightConstraints;
    NSMutableArray* _spacingConstraints;
}
 
@end

/*--------------------------------------------------*/

@implementation GLBLayoutView

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
    _hiddenObservers = [NSMutableArray array];
    _topConstraints = [NSMutableArray array];
    _bottomConstraints = [NSMutableArray array];
    _leftConstraints = [NSMutableArray array];
    _rightConstraints = [NSMutableArray array];
    _spacingConstraints = [NSMutableArray array];
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
            [_topConstraints glb_each:^(NSLayoutConstraint* constraint) {
                constraint.constant = margins.top;
            }];
        }
        if(_margins.bottom != margins.bottom) {
            [_bottomConstraints glb_each:^(NSLayoutConstraint* constraint) {
                constraint.constant = margins.bottom;
            }];
        }
        if(_margins.left != margins.left) {
            [_leftConstraints glb_each:^(NSLayoutConstraint* constraint) {
                constraint.constant = margins.left;
            }];
        }
        if(_margins.right != margins.right) {
            [_rightConstraints glb_each:^(NSLayoutConstraint* constraint) {
                constraint.constant = margins.right;
            }];
        }
        _margins = margins;
    }
}

- (void)setSpacing:(CGFloat)spacing {
    if(_spacing != spacing) {
        _spacing = spacing;
        [_spacingConstraints glb_each:^(NSLayoutConstraint* constraint) {
            constraint.constant = _spacing;
        }];
    }
}

#pragma mark - Public override

- (void)didAddSubview:(UIView*)subview {
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    [_hiddenObservers addObject:[subview glb_observeKeyPath:@"hidden" withBlock:^(GLBKVO* kvo, id oldValue, id newValue) {
        [self setNeedsUpdateConstraints];
    }]];
    [super didAddSubview:subview];
    [self setNeedsUpdateConstraints];
}

- (void)willRemoveSubview:(UIView*)subview {
    [_hiddenObservers glb_each:^(GLBKVO* kvo) {
        if(kvo.subject == subview) {
            [kvo stopObservation];
            [_hiddenObservers removeObject:kvo];
        }
    }];
    [super willRemoveSubview:subview];
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if(_topConstraints.count > 0) {
        [self removeConstraints:_topConstraints];
        [_topConstraints removeAllObjects];
    }
    if(_bottomConstraints.count > 0) {
        [self removeConstraints:_bottomConstraints];
        [_bottomConstraints removeAllObjects];
    }
    if(_rightConstraints.count > 0) {
        [self removeConstraints:_rightConstraints];
        [_rightConstraints removeAllObjects];
    }
    if(_leftConstraints.count > 0) {
        [self removeConstraints:_leftConstraints];
        [_leftConstraints removeAllObjects];
    }
    
    __block UIView* prevSubview = nil;
    [self.subviews glb_each:^(UIView* subview) {
        switch(_axis) {
            case UILayoutConstraintAxisHorizontal:
                if(prevSubview == nil) {
                    [_leftConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeLeft relation:NSLayoutRelationEqual attribute:NSLayoutAttributeLeft constant:_margins.left]];
                } else {
                    [_spacingConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeLeft relation:NSLayoutRelationEqual view:prevSubview attribute:NSLayoutAttributeRight constant:_spacing]];
                }
                switch(_alignment) {
                    case GLBLayoutViewAlignmentFill:
                        [_topConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeTop relation:NSLayoutRelationEqual attribute:NSLayoutAttributeTop constant:_margins.top]];
                        [_bottomConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual attribute:NSLayoutAttributeBottom constant:_margins.bottom]];
                        break;
                    case GLBLayoutViewAlignmentLeading:
                        [_topConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeTop relation:NSLayoutRelationEqual attribute:NSLayoutAttributeTop constant:_margins.top]];
                        [_bottomConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeBottom relation:NSLayoutRelationGreaterThanOrEqual attribute:NSLayoutAttributeBottom constant:_margins.bottom]];
                        break;
                    case GLBLayoutViewAlignmentCenter:
                        [subview glb_addConstraintAttribute:NSLayoutAttributeCenterY relation:NSLayoutRelationEqual attribute:NSLayoutAttributeCenterY constant:0.0f];
                        [_topConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeTop relation:NSLayoutRelationGreaterThanOrEqual attribute:NSLayoutAttributeTop constant:_margins.top]];
                        [_bottomConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeBottom relation:NSLayoutRelationGreaterThanOrEqual attribute:NSLayoutAttributeBottom constant:_margins.bottom]];
                        break;
                    case GLBLayoutViewAlignmentTrailing:
                        [_topConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeTop relation:NSLayoutRelationGreaterThanOrEqual attribute:NSLayoutAttributeTop constant:_margins.top]];
                        [_bottomConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual attribute:NSLayoutAttributeBottom constant:_margins.bottom]];
                        break;
                }
                break;
            case UILayoutConstraintAxisVertical:
                if(prevSubview == nil) {
                    [_topConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeTop relation:NSLayoutRelationEqual attribute:NSLayoutAttributeTop constant:_margins.top]];
                } else {
                    [_spacingConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeTop relation:NSLayoutRelationEqual view:prevSubview attribute:NSLayoutAttributeBottom constant:_spacing]];
                }
                switch(_alignment) {
                    case GLBLayoutViewAlignmentFill:
                        [_leftConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeLeft relation:NSLayoutRelationEqual attribute:NSLayoutAttributeLeft constant:_margins.left]];
                        [_rightConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual attribute:NSLayoutAttributeRight constant:_margins.right]];
                        break;
                    case GLBLayoutViewAlignmentLeading:
                        [_leftConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeLeft relation:NSLayoutRelationEqual attribute:NSLayoutAttributeLeft constant:_margins.left]];
                        [_rightConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeRight relation:NSLayoutRelationGreaterThanOrEqual attribute:NSLayoutAttributeRight constant:_margins.right]];
                        break;
                    case GLBLayoutViewAlignmentCenter:
                        [subview glb_addConstraintAttribute:NSLayoutAttributeCenterX relation:NSLayoutRelationEqual attribute:NSLayoutAttributeCenterX constant:0.0f];
                        [_leftConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeLeft relation:NSLayoutRelationGreaterThanOrEqual attribute:NSLayoutAttributeLeft constant:_margins.left]];
                        [_rightConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeRight relation:NSLayoutRelationGreaterThanOrEqual attribute:NSLayoutAttributeRight constant:_margins.right]];
                        break;
                    case GLBLayoutViewAlignmentTrailing:
                        [_leftConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeLeft relation:NSLayoutRelationGreaterThanOrEqual attribute:NSLayoutAttributeLeft constant:_margins.left]];
                        [_rightConstraints addObject:[subview glb_addConstraintAttribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual attribute:NSLayoutAttributeRight constant:_margins.right]];
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
                [_rightConstraints addObject:[prevSubview glb_addConstraintAttribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual attribute:NSLayoutAttributeRight constant:_margins.right]];
                break;
            case UILayoutConstraintAxisVertical:
                [_bottomConstraints addObject:[prevSubview glb_addConstraintAttribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual attribute:NSLayoutAttributeBottom constant:_margins.bottom]];
                break;
        }
    }
    [super updateConstraints];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
