/*--------------------------------------------------*/

#import "GLBLoadedView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import "UINib+GLBUI.h"

/*--------------------------------------------------*/

@interface GLBLoadedView ()

@property(nonatomic, strong) NSLayoutConstraint* constraintRootViewTop;
@property(nonatomic, strong) NSLayoutConstraint* constraintRootViewBottom;
@property(nonatomic, strong) NSLayoutConstraint* constraintRootViewLeft;
@property(nonatomic, strong) NSLayoutConstraint* constraintRootViewRight;


@end

/*--------------------------------------------------*/

@implementation GLBLoadedView

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
    self.clipsToBounds = YES;
    
    UINib* nib = [UINib glb_nibWithClass:self.class bundle:nil];
    if(nib != nil) {
        [nib instantiateWithOwner:self options:nil];
    }
}

#pragma mark - UIView

- (void)updateConstraints {
    if(_rootView != nil) {
        if(_constraintRootViewTop == nil) {
            _constraintRootViewTop = [_rootView glb_addConstraintAttribute:NSLayoutAttributeTop
                                                                  relation:NSLayoutRelationEqual
                                                                 attribute:NSLayoutAttributeTop
                                                                  constant:_rootEdgeInsets.top];
        }
        if(_constraintRootViewBottom == nil) {
            _constraintRootViewBottom = [_rootView glb_addConstraintAttribute:NSLayoutAttributeBottom
                                                                     relation:NSLayoutRelationEqual
                                                                    attribute:NSLayoutAttributeBottom
                                                                     constant:_rootEdgeInsets.bottom];
        }
        if(_constraintRootViewLeft == nil) {
            _constraintRootViewLeft = [_rootView glb_addConstraintAttribute:NSLayoutAttributeLeft
                                                                   relation:NSLayoutRelationEqual
                                                                  attribute:NSLayoutAttributeLeft
                                                                   constant:_rootEdgeInsets.left];
        }
        if(_constraintRootViewRight == nil) {
            _constraintRootViewRight = [_rootView glb_addConstraintAttribute:NSLayoutAttributeRight
                                                                    relation:NSLayoutRelationEqual
                                                                   attribute:NSLayoutAttributeRight
                                                                    constant:_rootEdgeInsets.right];
        }
    } else {
        if(_constraintRootViewTop != nil) {
            [self removeConstraint:_constraintRootViewTop];
            _constraintRootViewTop = nil;
        }
        if(_constraintRootViewBottom != nil) {
            [self removeConstraint:_constraintRootViewBottom];
            _constraintRootViewBottom = nil;
        }
        if(_constraintRootViewLeft != nil) {
            [self removeConstraint:_constraintRootViewLeft];
            _constraintRootViewLeft = nil;
        }
        if(_constraintRootViewRight != nil) {
            [self removeConstraint:_constraintRootViewRight];
            _constraintRootViewRight = nil;
        }
    }
    [super updateConstraints];
}

#pragma mark - Property

- (void)setRootView:(UIView*)rootView {
    if(_rootView != rootView) {
        if(_rootView != nil) {
            [_rootView removeFromSuperview];
        }
        _rootView = rootView;
        if(_rootView != nil) {
            _rootView.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:_rootView];
        }
        [self setNeedsUpdateConstraints];
    }
}

- (void)setRootEdgeInsets:(UIEdgeInsets)rootEdgeInsets {
    if(UIEdgeInsetsEqualToEdgeInsets(_rootEdgeInsets, rootEdgeInsets) == NO) {
        _rootEdgeInsets = rootEdgeInsets;
        if(_constraintRootViewTop != nil) {
            _constraintRootViewTop.constant = _rootEdgeInsets.top;
        }
        if(_constraintRootViewBottom != nil) {
            _constraintRootViewBottom.constant = _rootEdgeInsets.bottom;
        }
        if(_constraintRootViewLeft != nil) {
            _constraintRootViewLeft.constant = _rootEdgeInsets.left;
        }
        if(_constraintRootViewRight != nil) {
            _constraintRootViewRight.constant = _rootEdgeInsets.right;
        }
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
