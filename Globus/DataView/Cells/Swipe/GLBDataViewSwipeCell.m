/*--------------------------------------------------*/

#import "GLBDataViewSwipeCell+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBDataViewSwipeCell

#pragma mark - Synthesize

@synthesize panGestureRecognizer = _panGestureRecognizer;
@synthesize swipeEnabled = _swipeEnabled;
@synthesize swipeStyle = _swipeStyle;
@synthesize swipeThreshold = _swipeThreshold;
@synthesize swipeVelocity = _swipeVelocity;
@synthesize swipeDamping = _swipeDamping;
@synthesize swipeUseSpring = _swipeUseSpring;
@synthesize swipeDragging = _swipeDragging;
@synthesize swipeDecelerating = _swipeDecelerating;
@synthesize showedLeftSwipeView = _showedLeftSwipeView;
@synthesize leftSwipeEnabled = _leftSwipeEnabled;
@synthesize leftSwipeView = _leftSwipeView;
@synthesize leftSwipeOffset = _leftSwipeOffset;
@synthesize leftSwipeSize = _leftSwipeSize;
@synthesize leftSwipeStretchSize = _leftSwipeStretchSize;
@synthesize leftSwipeStretchMinThreshold = _leftSwipeStretchMinThreshold;
@synthesize leftSwipeStretchMaxThreshold = _leftSwipeStretchMaxThreshold;
@synthesize showedRightSwipeView = _showedRightSwipeView;
@synthesize rightSwipeEnabled = _rightSwipeEnabled;
@synthesize rightSwipeView = _rightSwipeView;
@synthesize rightSwipeOffset = _rightSwipeOffset;
@synthesize rightSwipeSize = _rightSwipeSize;
@synthesize rightSwipeStretchSize = _rightSwipeStretchSize;
@synthesize rightSwipeStretchMinThreshold = _rightSwipeStretchMinThreshold;
@synthesize rightSwipeStretchMaxThreshold = _rightSwipeStretchMaxThreshold;
@synthesize constraintLeftSwipeViewOffsetX = _constraintLeftSwipeViewOffsetX;
@synthesize constraintLeftSwipeViewCenterY = _constraintLeftSwipeViewCenterY;
@synthesize constraintLeftSwipeViewWidth = _constraintLeftSwipeViewWidth;
@synthesize constraintLeftSwipeViewHeight = _constraintLeftSwipeViewHeight;
@synthesize constraintRightSwipeViewOffsetX = _constraintRightSwipeViewOffsetX;
@synthesize constraintRightSwipeViewCenterY = _constraintRightSwipeViewCenterY;
@synthesize constraintRightSwipeViewWidth = _constraintRightSwipeViewWidth;
@synthesize constraintRightSwipeViewHeight = _constraintRightSwipeViewHeight;
@synthesize panSwipeLastOffset = _panSwipeLastOffset;
@synthesize panSwipeLastVelocity = _panSwipeLastVelocity;
@synthesize panSwipeProgress = _panSwipeProgress;
@synthesize panSwipeLeftWidth = _panSwipeLeftWidth;
@synthesize panSwipeRightWidth = _panSwipeRightWidth;
@synthesize panSwipeDirection = _panSwipeDirection;

#pragma mark - Init / Free

- (void)setup {
    [super setup];
    
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_handlerPanGestureRecognizer:)];
    
    _swipeEnabled = YES;
    _swipeStyle = GLBDataViewSwipeCellStyleLeaves;
    _swipeThreshold = 2.0f;
    _swipeVelocity = 1050.0f;
    _swipeDamping = 0.8f;
    _leftSwipeEnabled = YES;
    _leftSwipeSize = -1.0f;
    _leftSwipeStretchSize = 128.0f;
    _leftSwipeStretchMinThreshold = 0.2f;
    _leftSwipeStretchMaxThreshold = 0.6f;
    _rightSwipeEnabled = YES;
    _rightSwipeSize = -1.0f;
    _rightSwipeStretchSize = 128.0f;
    _rightSwipeStretchMinThreshold = 0.2f;
    _rightSwipeStretchMaxThreshold = 0.6f;
    _rootViewOffset = [self _rootViewOffsetBySwipeProgress:0.0f];
    _leftSwipeOffset = [self _leftViewOffsetBySwipeProgress:0.0f];
    _rightSwipeOffset = [self _rightViewOffsetBySwipeProgress:0.0f];
}

- (void)dealloc {
}

#pragma mark - Property

- (NSArray*)orderedSubviews {
    NSMutableArray* result = NSMutableArray.array;
    switch(_swipeStyle) {
        case GLBDataViewSwipeCellStyleStands:
        case GLBDataViewSwipeCellStyleStretch: {
            if(_leftSwipeView != nil) {
                [result addObject:_leftSwipeView];
            }
            if(_rightSwipeView != nil) {
                [result addObject:_rightSwipeView];
            }
            if(_rootView != nil) {
                [result addObject:_rootView];
            }
            break;
        }
        case GLBDataViewSwipeCellStyleLeaves:
        case GLBDataViewSwipeCellStylePushes: {
            if(_rootView != nil) {
                [result addObject:_rootView];
            }
            if(_leftSwipeView != nil) {
                [result addObject:_leftSwipeView];
            }
            if(_rightSwipeView != nil) {
                [result addObject:_rightSwipeView];
            }
            break;
        }
    }
    return result;
}

- (void)beginEditingAnimated:(BOOL)animated {
    [super beginEditingAnimated:animated];
    
    if((_leftSwipeView != nil) && (_leftSwipeEnabled == YES)) {
        [self setShowedLeftSwipeView:YES animated:animated];
    } else if((_rightSwipeView != nil) && (_rightSwipeEnabled == YES)) {
        [self setShowedRightSwipeView:YES animated:animated];
    }
}

- (void)endEditingAnimated:(BOOL)animated {
    [super endEditingAnimated:animated];
    
    [self hideAnySwipeViewAnimated:animated];
}

- (void)setRootView:(UIView*)rootView {
    super.rootView = rootView;
    
    self.rootViewOffset = [self _rootViewOffsetBySwipeProgress:0.0f];
}

- (void)setPanGestureRecognizer:(UIPanGestureRecognizer*)panGestureRecognizer {
    if(_panGestureRecognizer != panGestureRecognizer) {
        if(_panGestureRecognizer != nil) {
            [_rootView removeGestureRecognizer:_panGestureRecognizer];
        }
        _panGestureRecognizer = panGestureRecognizer;
        if(_panGestureRecognizer != nil) {
            _panGestureRecognizer.delaysTouchesBegan = YES;
            _panGestureRecognizer.delaysTouchesEnded = YES;
            _panGestureRecognizer.delegate = self;
            [_rootView addGestureRecognizer:_panGestureRecognizer];
        }
    }
}

- (void)setSwipeStyle:(GLBDataViewSwipeCellStyle)swipeStyle {
    if(_swipeStyle != swipeStyle) {
        self.constraintLeftSwipeViewOffsetX = nil;
        self.constraintLeftSwipeViewCenterY = nil;
        self.constraintLeftSwipeViewWidth = nil;
        self.constraintLeftSwipeViewHeight = nil;
        self.constraintRightSwipeViewOffsetX = nil;
        self.constraintRightSwipeViewCenterY = nil;
        self.constraintRightSwipeViewWidth = nil;
        self.constraintRightSwipeViewHeight = nil;
        _swipeStyle = swipeStyle;
        [self glb_setSubviews:self.orderedSubviews];
        self.rootViewOffset = [self _rootViewOffsetBySwipeProgress:0.0f];
        self.leftSwipeOffset = [self _leftViewOffsetBySwipeProgress:0.0f];
        self.rightSwipeOffset = [self _rightViewOffsetBySwipeProgress:0.0f];
        [self _refreshConstraints];
    }
}

- (void)setShowedLeftSwipeView:(BOOL)showedSwipeLeft {
    [self setShowedLeftSwipeView:showedSwipeLeft animated:NO];
}

- (void)setLeftSwipeView:(UIView*)leftSwipeView {
    if(_leftSwipeView != leftSwipeView) {
        if(_leftSwipeView != nil) {
            [_leftSwipeView removeFromSuperview];
        }
        _leftSwipeView = leftSwipeView;
        if(_leftSwipeView != nil) {
            _leftSwipeView.translatesAutoresizingMaskIntoConstraints = NO;
            [self glb_setSubviews:self.orderedSubviews];
        }
        self.leftSwipeOffset = [self _leftViewOffsetBySwipeProgress:0.0f];
        [self _refreshConstraints];
    }
}

- (void)setConstraintLeftSwipeViewOffsetX:(NSLayoutConstraint*)constraintLeftSwipeViewOffsetX {
    if(_constraintLeftSwipeViewOffsetX != constraintLeftSwipeViewOffsetX) {
        if(_constraintLeftSwipeViewOffsetX != nil) {
            [self removeConstraint:_constraintLeftSwipeViewOffsetX];
        }
        _constraintLeftSwipeViewOffsetX = constraintLeftSwipeViewOffsetX;
        if(_constraintLeftSwipeViewOffsetX != nil) {
            [self addConstraint:_constraintLeftSwipeViewOffsetX];
        }
    }
}

- (void)setConstraintLeftSwipeViewCenterY:(NSLayoutConstraint*)constraintLeftSwipeViewCenterY {
    if(_constraintLeftSwipeViewCenterY != constraintLeftSwipeViewCenterY) {
        if(_constraintLeftSwipeViewCenterY != nil) {
            [self removeConstraint:_constraintLeftSwipeViewCenterY];
        }
        _constraintLeftSwipeViewCenterY = constraintLeftSwipeViewCenterY;
        if(_constraintLeftSwipeViewCenterY != nil) {
            [self addConstraint:_constraintLeftSwipeViewCenterY];
        }
    }
}

- (void)setConstraintLeftSwipeViewWidth:(NSLayoutConstraint*)constraintLeftSwipeViewWidth {
    if(_constraintLeftSwipeViewWidth != constraintLeftSwipeViewWidth) {
        if(_constraintLeftSwipeViewWidth != nil) {
            [self removeConstraint:_constraintLeftSwipeViewWidth];
        }
        _constraintLeftSwipeViewWidth = constraintLeftSwipeViewWidth;
        if(_constraintLeftSwipeViewWidth != nil) {
            [self addConstraint:_constraintLeftSwipeViewWidth];
        }
    }
}

- (void)setConstraintLeftSwipeViewHeight:(NSLayoutConstraint*)constraintLeftSwipeViewHeight {
    if(_constraintLeftSwipeViewHeight != constraintLeftSwipeViewHeight) {
        if(_constraintLeftSwipeViewHeight != nil) {
            [self removeConstraint:_constraintLeftSwipeViewHeight];
        }
        _constraintLeftSwipeViewHeight = constraintLeftSwipeViewHeight;
        if(_constraintLeftSwipeViewHeight != nil) {
            [self addConstraint:_constraintLeftSwipeViewHeight];
        }
    }
}

- (void)setLeftSwipeOffset:(CGFloat)leftSwipeOffset {
    if(_leftSwipeOffset != leftSwipeOffset) {
        _leftSwipeOffset = leftSwipeOffset;
        if(_constraintLeftSwipeViewOffsetX != nil) {
            _constraintLeftSwipeViewOffsetX.constant = _leftSwipeOffset;
        }
    }
}

- (void)setLeftSwipeSize:(CGFloat)leftSwipeSize {
    if(_leftSwipeSize != leftSwipeSize) {
        _leftSwipeSize = leftSwipeSize;
        if(_leftSwipeSize < 0.0f) {
            [self _refreshConstraints];
        } else if(_constraintLeftSwipeViewWidth != nil) {
            _constraintLeftSwipeViewWidth.constant = _leftSwipeSize;
        }
    }
}

- (void)setShowedRightSwipeView:(BOOL)showedRightSwipeView {
    [self setShowedRightSwipeView:showedRightSwipeView animated:NO];
}

- (void)setRightSwipeView:(UIView*)rightSwipeView {
    if(_rightSwipeView != rightSwipeView) {
        if(_rightSwipeView != nil) {
            [_rightSwipeView removeFromSuperview];
        }
        _rightSwipeView = rightSwipeView;
        if(_rightSwipeView != nil) {
            _rightSwipeView.translatesAutoresizingMaskIntoConstraints = NO;
            [self glb_setSubviews:self.orderedSubviews];
        }
        self.rightSwipeOffset = [self _rightViewOffsetBySwipeProgress:0.0f];
        [self _refreshConstraints];
    }
}

- (void)setConstraintRightSwipeViewOffsetX:(NSLayoutConstraint*)constraintRightSwipeViewOffsetX {
    if(_constraintRightSwipeViewOffsetX != constraintRightSwipeViewOffsetX) {
        if(_constraintRightSwipeViewOffsetX != nil) {
            [self removeConstraint:_constraintRightSwipeViewOffsetX];
        }
        _constraintRightSwipeViewOffsetX = constraintRightSwipeViewOffsetX;
        if(_constraintRightSwipeViewOffsetX != nil) {
            [self addConstraint:_constraintRightSwipeViewOffsetX];
        }
    }
}

- (void)setConstraintRightSwipeViewCenterY:(NSLayoutConstraint*)constraintRightSwipeViewCenterY {
    if(_constraintRightSwipeViewCenterY != constraintRightSwipeViewCenterY) {
        if(_constraintRightSwipeViewCenterY != nil) {
            [self removeConstraint:_constraintRightSwipeViewCenterY];
        }
        _constraintRightSwipeViewCenterY = constraintRightSwipeViewCenterY;
        if(_constraintRightSwipeViewCenterY != nil) {
            [self addConstraint:_constraintRightSwipeViewCenterY];
        }
    }
}

- (void)setConstraintRightSwipeViewWidth:(NSLayoutConstraint*)constraintRightSwipeViewWidth {
    if(_constraintRightSwipeViewWidth != constraintRightSwipeViewWidth) {
        if(_constraintRightSwipeViewWidth != nil) {
            [self removeConstraint:_constraintRightSwipeViewWidth];
        }
        _constraintRightSwipeViewWidth = constraintRightSwipeViewWidth;
        if(_constraintRightSwipeViewWidth != nil) {
            [self addConstraint:_constraintRightSwipeViewWidth];
        }
    }
}

- (void)setConstraintRightSwipeViewHeight:(NSLayoutConstraint*)constraintRightSwipeViewHeight {
    if(_constraintRightSwipeViewHeight != constraintRightSwipeViewHeight) {
        if(_constraintRightSwipeViewHeight != nil) {
            [self removeConstraint:_constraintRightSwipeViewHeight];
        }
        _constraintRightSwipeViewHeight = constraintRightSwipeViewHeight;
        if(_constraintRightSwipeViewHeight != nil) {
            [self addConstraint:_constraintRightSwipeViewHeight];
        }
    }
}

- (void)setRightSwipeOffset:(CGFloat)rightSwipeOffset {
    if(_rightSwipeOffset != rightSwipeOffset) {
        _rightSwipeOffset = rightSwipeOffset;
        if(_constraintRightSwipeViewOffsetX != nil) {
            _constraintRightSwipeViewOffsetX.constant = _rightSwipeOffset;
        }
    }
}

- (void)setRightSwipeSize:(CGFloat)rightSwipeSize {
    if(_rightSwipeSize != rightSwipeSize) {
        _rightSwipeSize = rightSwipeSize;
        if(_rightSwipeSize < 0.0f) {
            [self _refreshConstraints];
        } else if(_constraintRightSwipeViewWidth != nil) {
            _constraintRightSwipeViewWidth.constant = _rightSwipeSize;
        }
    }
}

#pragma mark - Public

- (void)setShowedLeftSwipeView:(BOOL)showedLeftSwipeView animated:(BOOL)animated {
    if(_showedLeftSwipeView != showedLeftSwipeView) {
        _showedLeftSwipeView = showedLeftSwipeView;
        _showedRightSwipeView = NO;
        
        CGFloat needSwipeProgress = (showedLeftSwipeView == YES) ? -1.0f : 0.0f;
        [self _updateSwipeProgress:needSwipeProgress
                             speed:(animated == YES) ? _leftSwipeView.glb_frameWidth * ABS(needSwipeProgress - _panSwipeProgress) : FLT_EPSILON
                        endedSwipe:NO];
    }
}

- (void)setShowedRightSwipeView:(BOOL)showedRightSwipeView animated:(BOOL)animated {
    if(_showedRightSwipeView != showedRightSwipeView) {
        _showedRightSwipeView = showedRightSwipeView;
        _showedLeftSwipeView = NO;
        
        CGFloat needSwipeProgress = (_showedRightSwipeView == YES) ? 1.0f : 0.0f;
        [self _updateSwipeProgress:needSwipeProgress
                             speed:(animated == YES) ? _rightSwipeView.glb_frameWidth * ABS(needSwipeProgress - _panSwipeProgress) : FLT_EPSILON
                        endedSwipe:NO];
    }
}

- (void)hideAnySwipeViewAnimated:(BOOL)animated {
    [self setShowedLeftSwipeView:NO animated:animated];
    [self setShowedRightSwipeView:NO animated:animated];
}

- (void)willBeganSwipe {
    _pressGestureRecognizer.enabled = NO;
    _longPressGestureRecognizer.enabled = NO;
}

- (void)didBeganSwipe {
    _swipeDragging = YES;
}

- (void)movingSwipe:(CGFloat __unused)progress {
}

- (void)willEndedSwipe:(CGFloat __unused)progress {
    _swipeDragging = NO;
    _swipeDecelerating = YES;
}

- (void)didEndedSwipe:(CGFloat)progress {
    _showedLeftSwipeView = (progress < 0.0f) ? YES : NO;
    _showedRightSwipeView = (progress > 0.0f) ? YES : NO;
    _swipeDecelerating = NO;

    if((_showedLeftSwipeView == YES) || (_showedRightSwipeView == YES)) {
        [_item beginEditingAnimated:YES];
    } else {
        [_item endEditingAnimated:YES];
    }
    _pressGestureRecognizer.enabled = YES;
    _longPressGestureRecognizer.enabled = YES;
}

- (CGFloat)endedSwipeProgress:(CGFloat)progress {
    CGFloat minProgress = (_panSwipeDirection == GLBDataCellSwipeDirectionLeft) ? -1.0f : 0.0f;
    CGFloat maxProgress = (_panSwipeDirection == GLBDataCellSwipeDirectionRight) ? 1.0f : 0.0f;
    if(_swipeStyle == GLBDataViewSwipeCellStyleStretch) {
        if(progress < 0.0f) {
            if(_panSwipeDirection == GLBDataCellSwipeDirectionLeft) {
                if(progress < -_leftSwipeStretchMaxThreshold) {
                    progress = -1.0f;
                } else if(progress < -_leftSwipeStretchMinThreshold) {
                    progress = -(_leftSwipeStretchSize / _rootView.glb_frameWidth);
                } else {
                    progress = 0.0f;
                }
            } else {
                progress = 0.0f;
            }
        } else if(progress > 0.0f) {
            if(_panSwipeDirection == GLBDataCellSwipeDirectionRight) {
                if(progress > _rightSwipeStretchMaxThreshold) {
                    progress = 1.0f;
                } else if(progress > _rightSwipeStretchMinThreshold) {
                    progress = (_rightSwipeStretchSize / _rootView.glb_frameWidth);
                } else {
                    progress = 0.0f;
                }
            } else {
                progress = 0.0f;
            }
        }
    } else {
        progress = GLB_ROUND(progress);
    }
    return MIN(MAX(minProgress, progress), maxProgress);
}

#pragma mark - Private override

- (void)_refreshConstraints {
    if(_leftSwipeView != nil) {
        if(_leftSwipeSize >= FLT_EPSILON) {
            if(_constraintLeftSwipeViewWidth == nil) {
                self.constraintLeftSwipeViewWidth = [NSLayoutConstraint constraintWithItem:_leftSwipeView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1.0f
                                                                                  constant:_leftSwipeSize];
            }
        } else {
            self.constraintLeftSwipeViewWidth = nil;
        }
        if(_constraintLeftSwipeViewOffsetX == nil) {
            self.constraintLeftSwipeViewOffsetX = [NSLayoutConstraint constraintWithItem:_leftSwipeView
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self
                                                                               attribute:NSLayoutAttributeLeft
                                                                              multiplier:1.0f
                                                                                constant:_leftSwipeOffset];
        }
        if(_constraintLeftSwipeViewCenterY == nil) {
            self.constraintLeftSwipeViewCenterY = [NSLayoutConstraint constraintWithItem:_leftSwipeView
                                                                               attribute:NSLayoutAttributeCenterY
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self
                                                                               attribute:NSLayoutAttributeCenterY
                                                                              multiplier:1.0f
                                                                                constant:0.0f];
        }
        if(_constraintLeftSwipeViewHeight == nil) {
            self.constraintLeftSwipeViewHeight = [NSLayoutConstraint constraintWithItem:_leftSwipeView
                                                                              attribute:NSLayoutAttributeHeight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self
                                                                              attribute:NSLayoutAttributeHeight
                                                                             multiplier:1.0f
                                                                               constant:0.0f];
        }
    } else {
        self.constraintLeftSwipeViewOffsetX = nil;
        self.constraintLeftSwipeViewCenterY = nil;
        self.constraintLeftSwipeViewWidth = nil;
        self.constraintLeftSwipeViewHeight = nil;
    }
    if(_rightSwipeView != nil) {
        if(_rightSwipeSize >= FLT_EPSILON) {
            if(_constraintRightSwipeViewWidth == nil) {
                self.constraintRightSwipeViewWidth = [NSLayoutConstraint constraintWithItem:_rightSwipeView
                                                                                  attribute:NSLayoutAttributeWidth
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1.0f
                                                                                   constant:_rightSwipeSize];
            }
        } else {
            self.constraintRightSwipeViewWidth = nil;
        }
        if(_constraintRightSwipeViewOffsetX == nil) {
            self.constraintRightSwipeViewOffsetX = [NSLayoutConstraint constraintWithItem:_rightSwipeView
                                                                                attribute:NSLayoutAttributeRight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1.0f
                                                                                 constant:_rightSwipeOffset];
        }
        if(_constraintRightSwipeViewCenterY == nil) {
            self.constraintRightSwipeViewCenterY = [NSLayoutConstraint constraintWithItem:_rightSwipeView
                                                                                attribute:NSLayoutAttributeCenterY
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self
                                                                                attribute:NSLayoutAttributeCenterY
                                                                               multiplier:1.0f
                                                                                 constant:0.0f];
        }
        if(_constraintRightSwipeViewHeight == nil) {
            self.constraintRightSwipeViewHeight = [NSLayoutConstraint constraintWithItem:_rightSwipeView
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self
                                                                               attribute:NSLayoutAttributeHeight
                                                                              multiplier:1.0f
                                                                                constant:0.0f];
        }
    } else {
        self.constraintRightSwipeViewOffsetX = nil;
        self.constraintRightSwipeViewCenterY = nil;
        self.constraintRightSwipeViewWidth = nil;
        self.constraintRightSwipeViewHeight = nil;
    }
    [super _refreshConstraints];
}

- (void)_pressed {
    if(_showedLeftSwipeView == YES) {
        [self setShowedLeftSwipeView:NO animated:YES];
    } else if(_showedRightSwipeView == YES) {
        [self setShowedRightSwipeView:NO animated:YES];
    } else {
        [super _pressed];
    }
}

- (void)_longPressed {
    if(_showedLeftSwipeView == YES) {
        [self setShowedLeftSwipeView:NO animated:YES];
    } else if(_showedRightSwipeView == YES) {
        [self setShowedRightSwipeView:NO animated:YES];
    } else {
        [super _longPressed];
    }
}

#pragma mark - Private

- (UIOffset)_rootViewOffsetBySwipeProgress:(CGFloat)swipeProgress {
    switch(_swipeStyle) {
        case GLBDataViewSwipeCellStyleStands:
        case GLBDataViewSwipeCellStyleLeaves:
            if(swipeProgress < 0.0f) {
                return UIOffsetMake(_leftSwipeView.glb_frameWidth * -swipeProgress, _rootViewOffset.vertical);
            } else if(swipeProgress > 0.0f) {
                return UIOffsetMake(-_rightSwipeView.glb_frameWidth * swipeProgress, _rootViewOffset.vertical);
            }
            break;
        case GLBDataViewSwipeCellStyleStretch:
            if(swipeProgress < 0.0f) {
                return UIOffsetMake(_rootView.glb_frameWidth * -swipeProgress, _rootViewOffset.vertical);
            } else if(swipeProgress > 0.0f) {
                return UIOffsetMake(-_rootView.glb_frameWidth * swipeProgress, _rootViewOffset.vertical);
            }
            break;
        case GLBDataViewSwipeCellStylePushes:
            break;
    }
    return UIOffsetMake(0.0f, _rootViewOffset.vertical);
}

- (CGFloat)_leftViewOffsetBySwipeProgress:(CGFloat)swipeProgress {
    CGFloat leftWidth = _leftSwipeView.glb_frameWidth;
    switch(_swipeStyle) {
        case GLBDataViewSwipeCellStyleStands:
            return 0.0f;
        case GLBDataViewSwipeCellStyleLeaves:
        case GLBDataViewSwipeCellStylePushes:
            if(swipeProgress < 0.0f) {
                return -leftWidth + (leftWidth * (-swipeProgress));
            }
            break;
        case GLBDataViewSwipeCellStyleStretch:
            return 0.0f;
    }
    return -leftWidth;
}

- (CGFloat)_leftViewSizeBySwipeProgress:(CGFloat)swipeProgress {
    switch(_swipeStyle) {
        case GLBDataViewSwipeCellStyleStretch:
            if(swipeProgress < 0.0f) {
                return _rootView.glb_frameWidth * -swipeProgress;
            }
            return 0.0f;
        default:
            break;
    }
    return -1.0f;
}

- (CGFloat)_rightViewOffsetBySwipeProgress:(CGFloat)swipeProgress {
    CGFloat rigthWidth = _rightSwipeView.glb_frameWidth;
    switch(_swipeStyle) {
        case GLBDataViewSwipeCellStyleStands:
            return 0.0f;
        case GLBDataViewSwipeCellStyleLeaves:
        case GLBDataViewSwipeCellStylePushes:
            if(swipeProgress > 0.0f) {
                return rigthWidth * (1.0f - swipeProgress);
            }
            break;
        case GLBDataViewSwipeCellStyleStretch:
            return 0.0f;
    }
    return rigthWidth;
}

- (CGFloat)_rightViewSizeBySwipeProgress:(CGFloat)swipeProgress {
    switch(_swipeStyle) {
        case GLBDataViewSwipeCellStyleStretch:
            if(swipeProgress > 0.0f) {
                return _rootView.glb_frameWidth * swipeProgress;
            }
            return 0.0f;
        default:
            break;
    }
    return -1.0f;
}

- (void)_updateSwipeProgress:(CGFloat)swipeProgress speed:(CGFloat)speed endedSwipe:(BOOL)endedSwipe {
    CGFloat minSwipeProgress = (_panSwipeDirection == GLBDataCellSwipeDirectionLeft) ? -1.0f : 0.0f;
    CGFloat maxSwipeProgress = (_panSwipeDirection == GLBDataCellSwipeDirectionRight) ? 1.0f : 0.0f;
    CGFloat normalizedSwipeProgress = MIN(MAX(minSwipeProgress, swipeProgress), maxSwipeProgress);
    if(_panSwipeProgress != normalizedSwipeProgress) {
        _panSwipeProgress = normalizedSwipeProgress;
        self.rootViewOffset = [self _rootViewOffsetBySwipeProgress:_panSwipeProgress];
        self.leftSwipeOffset = [self _leftViewOffsetBySwipeProgress:_panSwipeProgress];
        self.leftSwipeSize = [self _leftViewSizeBySwipeProgress:_panSwipeProgress];
        self.rightSwipeOffset = [self _rightViewOffsetBySwipeProgress:_panSwipeProgress];
        self.rightSwipeSize = [self _rightViewSizeBySwipeProgress:_panSwipeProgress];
        [self _refreshConstraints];
        
        if(endedSwipe == YES) {
            [self willEndedSwipe:_panSwipeProgress];
        }
        CGFloat duration = ABS(speed) / _swipeVelocity;
        UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState;
        if((_swipeUseSpring == YES) && (endedSwipe == YES)) {
            [UIView animateWithDuration:duration delay:0.0f usingSpringWithDamping:_swipeDamping initialSpringVelocity:0.0f options:options | UIViewAnimationOptionCurveLinear animations:^{
                [self movingSwipe:_panSwipeProgress];
                [self layoutIfNeeded];
            } completion:^(BOOL finished) {
                [self didEndedSwipe:_panSwipeProgress];
            }];
        } else {
            if(endedSwipe == YES) {
                options |= UIViewAnimationOptionCurveEaseOut;
            }
            [UIView animateWithDuration:duration delay:0.0f options:options animations:^{
                [self movingSwipe:_panSwipeProgress];
                [self layoutIfNeeded];
            } completion:^(BOOL finished __unused) {
                if(endedSwipe == YES) {
                    [self didEndedSwipe:_panSwipeProgress];
                }
            }];
        }
    } else {
        if(endedSwipe == YES) {
            [self willEndedSwipe:_panSwipeProgress];
            [self didEndedSwipe:_panSwipeProgress];
        }
    }
}

- (void)_handlerPanGestureRecognizer:(UIPanGestureRecognizer*)gestureRecognizer {
    if(_swipeDecelerating == NO) {
        CGPoint translation = [gestureRecognizer translationInView:self];
        CGPoint velocity = [gestureRecognizer velocityInView:self];
        switch([gestureRecognizer state]) {
            case UIGestureRecognizerStateBegan: {
                [self willBeganSwipe];
                _panSwipeLastOffset = translation.x;
                _panSwipeLastVelocity = velocity.x;
                switch(_swipeStyle) {
                    case GLBDataViewSwipeCellStyleStands:
                    case GLBDataViewSwipeCellStyleLeaves:
                    case GLBDataViewSwipeCellStylePushes:
                        _panSwipeLeftWidth = -_leftSwipeView.glb_frameWidth;
                        _panSwipeRightWidth = _rightSwipeView.glb_frameWidth;
                        break;
                    case GLBDataViewSwipeCellStyleStretch:
                        _panSwipeLeftWidth = (_leftSwipeView != nil) ? -_rootView.glb_frameWidth : 0.0f;
                        _panSwipeRightWidth = (_rightSwipeView != nil) ? _rootView.glb_frameWidth : 0.0f;
                        break;
                }
                _panSwipeDirection = GLBDataCellSwipeDirectionUnknown;
                break;
            }
            case UIGestureRecognizerStateChanged: {
                CGFloat delta = _panSwipeLastOffset - translation.x;
                if(_panSwipeDirection == GLBDataCellSwipeDirectionUnknown) {
                    switch(_swipeStyle) {
                        case GLBDataViewSwipeCellStyleStands:
                        case GLBDataViewSwipeCellStyleLeaves:
                        case GLBDataViewSwipeCellStylePushes:
                            if((_leftSwipeEnabled == YES) && (_showedLeftSwipeView == YES) && (_leftSwipeView != nil) && (delta > _swipeThreshold)) {
                                _panSwipeDirection = GLBDataCellSwipeDirectionLeft;
                                [self didBeganSwipe];
                            } else if((_rightSwipeEnabled == YES) && (_showedRightSwipeView == YES) && (_rightSwipeView != nil) && (delta < -_swipeThreshold)) {
                                _panSwipeDirection = GLBDataCellSwipeDirectionRight;
                                [self didBeganSwipe];
                            } else if((_leftSwipeEnabled == YES) && (_showedLeftSwipeView == NO) && (_leftSwipeView != nil) && (delta < -_swipeThreshold)) {
                                _panSwipeDirection = GLBDataCellSwipeDirectionLeft;
                                [self didBeganSwipe];
                            } else if((_rightSwipeEnabled == YES) && (_showedRightSwipeView == NO) && (_rightSwipeView != nil) && (delta > _swipeThreshold)) {
                                _panSwipeDirection = GLBDataCellSwipeDirectionRight;
                                [self didBeganSwipe];
                            }
                            break;
                        case GLBDataViewSwipeCellStyleStretch:
                            if(((_leftSwipeEnabled == YES) && (_leftSwipeView != nil) && (delta < -_swipeThreshold)) || (_showedLeftSwipeView == YES)) {
                                _panSwipeDirection = GLBDataCellSwipeDirectionLeft;
                                [self didBeganSwipe];
                            } else if(((_rightSwipeEnabled == YES) && (_rightSwipeView != nil) && (delta > _swipeThreshold)) || (_showedRightSwipeView == YES)) {
                                _panSwipeDirection = GLBDataCellSwipeDirectionRight;
                                [self didBeganSwipe];
                            }
                            break;
                    }
                }
                if(_panSwipeDirection != GLBDataCellSwipeDirectionUnknown) {
                    if(_panSwipeDirection == GLBDataCellSwipeDirectionLeft) {
                        CGFloat localDelta = MIN(MAX(_panSwipeLeftWidth, delta), -_panSwipeLeftWidth);
                        [self _updateSwipeProgress:_panSwipeProgress - (localDelta / _panSwipeLeftWidth) speed:localDelta endedSwipe:NO];
                        [self movingSwipe:_panSwipeProgress];
                    } else if(_panSwipeDirection == GLBDataCellSwipeDirectionRight) {
                        CGFloat localDelta = MIN(MAX(-_panSwipeRightWidth, delta), _panSwipeRightWidth);
                        [self _updateSwipeProgress:_panSwipeProgress + (localDelta / _panSwipeRightWidth) speed:localDelta endedSwipe:NO];
                        [self movingSwipe:_panSwipeProgress];
                    }
                    _panSwipeLastOffset = translation.x;
                    _panSwipeLastVelocity = velocity.x;
                }
                break;
            }
            case UIGestureRecognizerStateEnded:
            case UIGestureRecognizerStateCancelled: {
                CGFloat swipeProgress = [self endedSwipeProgress:_panSwipeProgress - (_panSwipeLastVelocity / _swipeVelocity)];
                if(_panSwipeDirection == GLBDataCellSwipeDirectionLeft) {
                    [self _updateSwipeProgress:swipeProgress speed:_panSwipeLeftWidth * ABS(swipeProgress - _panSwipeProgress) endedSwipe:YES];
                } else if(_panSwipeDirection == GLBDataCellSwipeDirectionRight) {
                    [self _updateSwipeProgress:swipeProgress speed:_panSwipeRightWidth * ABS(swipeProgress - _panSwipeProgress) endedSwipe:YES];
                }
                break;
            }
            default: {
                break;
            }
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    BOOL result = [super gestureRecognizerShouldBegin:gestureRecognizer];
    if(result == YES) {
        if(gestureRecognizer == _panGestureRecognizer) {
            if((_swipeEnabled == YES) && (_swipeDragging == NO) && (_swipeDecelerating == NO)) {
                if([_item.view shouldBeganEditItem:_item] == YES) {
                    CGPoint translation = [_panGestureRecognizer translationInView:self];
                    CGFloat absX = ABS(translation.x);
                    CGFloat absY = ABS(translation.y);
                    if(absX >= absY) {
                        if((_leftSwipeEnabled == YES) && (_leftSwipeView != nil)) {
                            if(_showedLeftSwipeView == YES) {
                                return (translation.x < FLT_EPSILON);
                            } else {
                                return (translation.x > FLT_EPSILON);
                            }
                        } else if((_rightSwipeEnabled == YES) && (_rightSwipeView != nil)) {
                            if(_showedRightSwipeView == YES) {
                                return (translation.x > FLT_EPSILON);
                            } else {
                                return (translation.x < FLT_EPSILON);
                            }
                        }
                    }
                }
            }
            return NO;
        }
    }
    return result;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*)otherGestureRecognizer {
    if((gestureRecognizer == _panGestureRecognizer) && ([_rootView.gestureRecognizers containsObject:otherGestureRecognizer] == NO)) {
        return NO;
    }
    return [super gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
