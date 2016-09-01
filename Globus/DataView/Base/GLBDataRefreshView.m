/*--------------------------------------------------*/

#import "GLBDataRefreshView+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBDataRefreshView

#pragma mark - Synthesize

@synthesize type = _type;
@synthesize view = _view;
@synthesize constraintOffset = _constraintOffset;
@synthesize constraintSize = _constraintSize;
@synthesize state = _state;
@synthesize triggeredOnRelease = _triggeredOnRelease;
@synthesize size = _size;
@synthesize threshold = _threshold;

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
    _threshold = 64.0f;
    _size = 52.0f;
}

- (void)dealloc {
}

#pragma mark - UIView

#pragma mark - Property

- (void)setState:(GLBDataRefreshViewState)state {
    if(_state != state) {
        _state = state;
        switch(_state) {
            case GLBDataRefreshViewStateIdle: [self didIdle]; break;
            case GLBDataRefreshViewStatePull: [self didPull]; break;
            case GLBDataRefreshViewStateRelease: [self didRelease]; break;
            case GLBDataRefreshViewStateLoading: [self didLoading]; break;
            default: break;
        }
    }
}

- (void)setSize:(CGFloat)size {
    if(_size != size) {
        _size = size;
        if(_state == GLBDataRefreshViewStateLoading) {
            _constraintSize.constant = _size;
        }
    }
}

#pragma mark - Public

- (void)showAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    [self _showAnimated:animated velocity:_view.velocity complete:complete];
}

- (void)hideAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    [self _hideAnimated:animated velocity:_view.velocity complete:complete];
}

- (void)didProgress:(CGFloat)progress {
}

- (void)didIdle {
}

- (void)didPull {
}

- (void)didRelease {
}

- (void)didLoading {
}

#pragma mark - Private

- (void)_showAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(GLBSimpleBlock)complete {
    if(_state != GLBDataRefreshViewStateLoading) {
        self.state = GLBDataRefreshViewStateLoading;
        
        UIEdgeInsets refreshViewInset = _view.refreshViewInset;
        CGPoint contentOffset = _view.contentOffset;
        switch(_type) {
            case GLBDataRefreshViewTypeTop:
                refreshViewInset.top = _size;
                if(_view.isTracking == NO) {
                    contentOffset.y -= _size;
                }
                break;
            case GLBDataRefreshViewTypeBottom:
                refreshViewInset.bottom = _size;
                if(_view.isTracking == NO) {
                    contentOffset.y += _size;
                }
                break;
            case GLBDataRefreshViewTypeLeft:
                refreshViewInset.left = _size;
                if(_view.isTracking == NO) {
                    contentOffset.x -= _size;
                }
                break;
            case GLBDataRefreshViewTypeRight:
                refreshViewInset.right = _size;
                if(_view.isTracking == NO) {
                    contentOffset.x += _size;
                }
                break;
        }
        if(animated == YES) {
            UIView* rootView = _view.superview;
            while(rootView.superview != nil) {
                rootView = rootView.superview;
            }
            [UIView animateWithDuration:ABS(_size - _constraintSize.constant) / ABS(velocity)
                                  delay:0.01f
                                options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut)
                             animations:^{
                                 [_view _setRefreshViewInset:refreshViewInset force:YES];
                                 _view.contentOffset = contentOffset;
                                 [rootView layoutIfNeeded];
                             }
                             completion:^(BOOL finished) {
                                 if(complete != nil) {
                                     complete();
                                 }
                             }];
        } else {
            [_view _setRefreshViewInset:refreshViewInset force:YES];
            _view.contentOffset = contentOffset;
            if(complete != nil) {
                complete();
            }
        }
    } else {
        if(complete != nil) {
            complete();
        }
    }
}

- (void)_hideAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(GLBSimpleBlock)complete {
    if(_state != GLBDataRefreshViewStateIdle) {
        self.state = GLBDataRefreshViewStateIdle;
        
        UIEdgeInsets refreshViewInset = _view.refreshViewInset;
        switch(_type) {
            case GLBDataRefreshViewTypeTop:
                refreshViewInset.top = 0.0f;
                break;
            case GLBDataRefreshViewTypeBottom:
                refreshViewInset.bottom = 0.0f;
                break;
            case GLBDataRefreshViewTypeLeft:
                refreshViewInset.left = 0.0f;
                break;
            case GLBDataRefreshViewTypeRight:
                refreshViewInset.right = 0.0f;
                break;
        }
        if(animated == YES) {
            UIView* rootView = _view.superview;
            while(rootView.superview != nil) {
                rootView = rootView.superview;
            }
            [UIView animateWithDuration:_size / ABS(velocity)
                                  delay:0.00f
                                options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut)
                             animations:^{
                                 [_view _setRefreshViewInset:refreshViewInset force:YES];
                                 [rootView layoutIfNeeded];
                             }
                             completion:^(BOOL finished) {
                                 if(complete != nil) {
                                     complete();
                                 }
                             }];
        } else {
            [_view _setRefreshViewInset:refreshViewInset force:YES];
            if(complete != nil) {
                complete();
            }
        }
    } else {
        if(complete != nil) {
            complete();
        }
    }
}

@end

/*--------------------------------------------------*/

NSString* GLBDataRefreshViewTriggered = @"GLBDataRefreshViewTriggered";

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
