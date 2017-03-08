/*--------------------------------------------------*/

#import "GLBScrollView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBScrollView () {
    NSMutableArray< NSLayoutConstraint* >* _constraints;
}

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
    _constraints = [NSMutableArray array];
    _direction = GLBScrollViewDirectionVertical;
    
    [self glb_registerAdjustmentResponder];
}

- (void)dealloc {
    [self glb_unregisterAdjustmentResponder];
}

#pragma mark - Property

- (void)setDirection:(GLBScrollViewDirection)direction {
    if(_direction != direction) {
        _direction = direction;
        [self setNeedsUpdateConstraints];
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
            [self addSubview:_rootView];
        }
        [self setNeedsUpdateConstraints];
    }
}

#pragma mark - UIView

- (void)updateConstraints {
    [super updateConstraints];
    
    if(_constraints.count > 0) {
        [self removeConstraints:_constraints];
        [_constraints removeAllObjects];
    }
    if(_rootView != nil) {
        NSArray* edgeConstraint = [_rootView glb_addConstraintEdgeInsets];
        if(edgeConstraint != nil) {
            [_constraints addObjectsFromArray:edgeConstraint];
        }
        switch(_direction) {
            case GLBScrollViewDirectionStretch: {
                NSLayoutConstraint* widthConstraint = [_rootView glb_addConstraintWidthItem:self];
                if(widthConstraint != nil) {
                    [_constraints addObject:widthConstraint];
                }
                NSLayoutConstraint* heightConstraint = [_rootView glb_addConstraintHeightItem:self];
                if(heightConstraint != nil) {
                    [_constraints addObject:heightConstraint];
                }
                break;
            }
            case GLBScrollViewDirectionVertical: {
                NSLayoutConstraint* widthConstraint = [_rootView glb_addConstraintWidthItem:self];
                if(widthConstraint != nil) {
                    [_constraints addObject:widthConstraint];
                }
                break;
            }
            case GLBScrollViewDirectionHorizontal: {
                NSLayoutConstraint* heightConstraint = [_rootView glb_addConstraintHeightItem:self];
                if(heightConstraint != nil) {
                    [_constraints addObject:heightConstraint];
                }
                break;
            }
        }
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
