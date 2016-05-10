/*--------------------------------------------------*/

#import "GLBScrollView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBScrollView ()

@property(nonatomic, strong) NSLayoutConstraint* constraintRootViewL;
@property(nonatomic, strong) NSLayoutConstraint* constraintRootViewT;
@property(nonatomic, strong) NSLayoutConstraint* constraintRootViewR;
@property(nonatomic, strong) NSLayoutConstraint* constraintRootViewB;
@property(nonatomic, strong) NSLayoutConstraint* constraintRootViewW;
@property(nonatomic, strong) NSLayoutConstraint* constraintRootViewH;

- (void)linkConstraint;
- (void)unlinkConstraint;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBScrollView

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
    _direction = GLBScrollViewDirectionVertical;
    
    [self glb_registerAdjustmentResponder];
}

- (void)dealloc {
    [self glb_unregisterAdjustmentResponder];
}

#pragma mark - Property

- (void)setDirection:(GLBScrollViewDirection)direction {
    if(_direction != direction) {
        if(_rootView != nil) {
            [self unlinkConstraint];
        }
        _direction = direction;
        if(_rootView != nil) {
            [self linkConstraint];
        }
        [self setNeedsLayout];
    }
}

- (void)setRootView:(UIView*)rootView {
    if(_rootView != rootView) {
        if(_rootView != nil) {
            [self unlinkConstraint];
            [_rootView removeFromSuperview];
        }
        _rootView = rootView;
        if(_rootView != nil) {
            _rootView.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:_rootView];
            [self linkConstraint];
        }
        [self setNeedsLayout];
    }
}

#pragma mark - Private

- (void)linkConstraint {
    switch(_direction) {
        case GLBScrollViewDirectionStretch:
            self.constraintRootViewT = [_rootView glb_addConstraintAttribute:NSLayoutAttributeTop
                                                                    relation:NSLayoutRelationEqual
                                                                   attribute:NSLayoutAttributeTop
                                                                    constant:0.0f];
            self.constraintRootViewB = [_rootView glb_addConstraintAttribute:NSLayoutAttributeBottom
                                                                    relation:NSLayoutRelationEqual
                                                                   attribute:NSLayoutAttributeBottom
                                                                    constant:0.0f];
            self.constraintRootViewL = [_rootView glb_addConstraintAttribute:NSLayoutAttributeLeft
                                                                    relation:NSLayoutRelationEqual
                                                                   attribute:NSLayoutAttributeLeft
                                                                    constant:0.0f];
            self.constraintRootViewR = [_rootView glb_addConstraintAttribute:NSLayoutAttributeRight
                                                                    relation:NSLayoutRelationEqual
                                                                   attribute:NSLayoutAttributeRight
                                                                    constant:0.0f];
            self.constraintRootViewW = [_rootView glb_addConstraintAttribute:NSLayoutAttributeWidth
                                                                    relation:NSLayoutRelationEqual
                                                                   attribute:NSLayoutAttributeWidth
                                                                    constant:0.0f];
            self.constraintRootViewH = [_rootView glb_addConstraintAttribute:NSLayoutAttributeHeight
                                                                    relation:NSLayoutRelationEqual
                                                                   attribute:NSLayoutAttributeHeight
                                                                    constant:0.0f];
            break;
        case GLBScrollViewDirectionVertical:
            self.constraintRootViewT = [_rootView glb_addConstraintAttribute:NSLayoutAttributeTop
                                                                    relation:NSLayoutRelationEqual
                                                                   attribute:NSLayoutAttributeTop
                                                                    constant:0.0f];
            self.constraintRootViewB = [_rootView glb_addConstraintAttribute:NSLayoutAttributeBottom
                                                                    relation:NSLayoutRelationEqual
                                                                   attribute:NSLayoutAttributeBottom
                                                                    constant:0.0f];
            self.constraintRootViewL = [_rootView glb_addConstraintAttribute:NSLayoutAttributeLeft
                                                                    relation:NSLayoutRelationEqual
                                                                   attribute:NSLayoutAttributeLeft
                                                                    constant:0.0f];
            self.constraintRootViewR = [_rootView glb_addConstraintAttribute:NSLayoutAttributeRight
                                                                    relation:NSLayoutRelationEqual
                                                                   attribute:NSLayoutAttributeRight
                                                                    constant:0.0f];
            self.constraintRootViewW = [_rootView glb_addConstraintAttribute:NSLayoutAttributeWidth
                                                                    relation:NSLayoutRelationEqual
                                                                   attribute:NSLayoutAttributeWidth
                                                                    constant:0.0f];
            break;
        case GLBScrollViewDirectionHorizontal:
            
            self.constraintRootViewT = [_rootView glb_addConstraintAttribute:NSLayoutAttributeTop
                                                                    relation:NSLayoutRelationEqual
                                                                   attribute:NSLayoutAttributeTop
                                                                    constant:0.0f];
            self.constraintRootViewB = [_rootView glb_addConstraintAttribute:NSLayoutAttributeBottom
                                                                    relation:NSLayoutRelationEqual
                                                                   attribute:NSLayoutAttributeBottom
                                                                    constant:0.0f];
            self.constraintRootViewL = [_rootView glb_addConstraintAttribute:NSLayoutAttributeLeading
                                                                    relation:NSLayoutRelationEqual
                                                                   attribute:NSLayoutAttributeLeading
                                                                    constant:0.0f];
            self.constraintRootViewR = [_rootView glb_addConstraintAttribute:NSLayoutAttributeTrailing
                                                                    relation:NSLayoutRelationEqual
                                                                   attribute:NSLayoutAttributeTrailing
                                                                    constant:0.0f];
            self.constraintRootViewH = [_rootView glb_addConstraintAttribute:NSLayoutAttributeHeight
                                                                    relation:NSLayoutRelationEqual
                                                                   attribute:NSLayoutAttributeHeight
                                                                    constant:0.0f];
            break;
    }
}

- (void)unlinkConstraint {
    if(self.constraintRootViewL != nil) {
        [self removeConstraint:self.constraintRootViewL];
        self.constraintRootViewL = nil;
    }
    if(self.constraintRootViewT != nil) {
        [self removeConstraint:self.constraintRootViewT];
        self.constraintRootViewT = nil;
    }
    if(self.constraintRootViewR != nil) {
        [self removeConstraint:self.constraintRootViewR];
        self.constraintRootViewR = nil;
    }
    if(self.constraintRootViewB != nil) {
        [self removeConstraint:self.constraintRootViewB];
        self.constraintRootViewB = nil;
    }
    if(self.constraintRootViewW != nil) {
        [self removeConstraint:self.constraintRootViewW];
        self.constraintRootViewW = nil;
    }
    if(self.constraintRootViewH != nil) {
        [self removeConstraint:self.constraintRootViewH];
        self.constraintRootViewH = nil;
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
