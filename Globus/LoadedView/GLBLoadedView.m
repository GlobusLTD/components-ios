/*--------------------------------------------------*/

#import "GLBLoadedView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBLoadedView () {
    NSLayoutConstraint* _constraintRootViewTop;
    NSLayoutConstraint* _constraintRootViewBottom;
    NSLayoutConstraint* _constraintRootViewLeft;
    NSLayoutConstraint* _constraintRootViewRight;
}

@end

/*--------------------------------------------------*/

@implementation GLBLoadedView

#pragma mark - Init / Free

+ (instancetype)instantiate {
    return [self instantiateWithOptions:nil];
}

+ (instancetype)instantiateWithOptions:(NSDictionary*)options {
    UINib* nib = self.glb_nib;
    if(nib != nil) {
        return [nib glb_instantiateWithClass:self.class owner:nil options:options];
    }
    return nil;
}

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
        [self __loadFromNib];
        [self setup];
    }
    return self;
}

- (void)setup {
    self.clipsToBounds = YES;
}

#pragma mark - UIView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if(_rootView == nil) {
        [self __loadFromNib];
    }
}

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
            _constraintRootViewTop = nil;
            _constraintRootViewBottom = nil;
            _constraintRootViewLeft = nil;
            _constraintRootViewRight = nil;
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

- (void)setRootEdgeInsetsTop:(CGFloat)rootEdgeInsetsTop {
    self.rootEdgeInsets = UIEdgeInsetsMake(rootEdgeInsetsTop, _rootEdgeInsets.left, _rootEdgeInsets.bottom, _rootEdgeInsets.right);
}

- (CGFloat)rootEdgeInsetsTop {
    return _rootEdgeInsets.top;
}

- (void)setRootEdgeInsetsBottom:(CGFloat)rootEdgeInsetsBottom {
    self.rootEdgeInsets = UIEdgeInsetsMake(_rootEdgeInsets.top, _rootEdgeInsets.left, rootEdgeInsetsBottom, _rootEdgeInsets.right);
}

- (CGFloat)rootEdgeInsetsBottom {
    return _rootEdgeInsets.bottom;
}

- (void)setRootEdgeInsetsLeft:(CGFloat)rootEdgeInsetsLeft {
    self.rootEdgeInsets = UIEdgeInsetsMake(_rootEdgeInsets.top, rootEdgeInsetsLeft, _rootEdgeInsets.bottom, _rootEdgeInsets.right);
}

- (CGFloat)rootEdgeInsetsLeft {
    return _rootEdgeInsets.left;
}

- (void)setRootEdgeInsetsRight:(CGFloat)rootEdgeInsetsRight {
    self.rootEdgeInsets = UIEdgeInsetsMake(_rootEdgeInsets.top, _rootEdgeInsets.left, _rootEdgeInsets.bottom, rootEdgeInsetsRight);
}

- (CGFloat)rootEdgeInsetsRight {
    return _rootEdgeInsets.right;
}

#pragma mark - GLBNibExtension

+ (NSString*)nibName {
    return self.glb_className;
}

+ (NSBundle*)nibBundle {
    return nil;
}

#pragma mark - Private

- (void)__loadFromNib {
    UINib* nib = self.class.glb_nib;
    if(nib != nil) {
        [nib instantiateWithOwner:self options:nil];
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
