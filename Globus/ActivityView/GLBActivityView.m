/*--------------------------------------------------*/

#import "GLBActivityView.h"
#import "GLBArcSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBActivityView () {
    NSUInteger _showCount;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBActivityView

#pragma mark - Synthesize

@synthesize panelView = _panelView;
@synthesize spinnerView = _spinnerView;
@synthesize textLabel = _textLabel;

#pragma mark - Init / Free

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder*)coder {
    self = [super initWithCoder:coder];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _showCount = NSNotFound;
    
    _margin = UIEdgeInsetsMake(16.0f, 16.0f, 16.0f, 16.0f);
    _spacing = 8.0f;
    _panelMaximumSize = CGSizeMake(256.0f, 256.0f);
    _showDuration = 0.2f;
    _showDelay = 0.1f;
    _hideDuration = 0.2f;
    _hideDelay = 0.1f;
    
    self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.backgroundColor = [UIColor colorWithWhite:0.1f alpha:0.2f];
    self.alpha = 0.0;
}

#pragma mark - Public override

- (void)updateConstraints {
    [super updateConstraints];
    
    UIView* panelView = self.panelView;
    GLBSpinnerView* spinnerView = _spinnerView;
    GLBLabel* textLabel = _textLabel;
    
    [self glb_removeAllConstraints];
    [panelView glb_removeAllConstraints];
    [panelView glb_addConstraintCenter];
    if(_panelMaximumSize.width > GLB_EPSILON) {
        [panelView glb_addConstraintWidth:_panelMaximumSize.width relation:NSLayoutRelationLessThanOrEqual];
    }
    if(_panelMaximumSize.height > GLB_EPSILON) {
        [panelView glb_addConstraintHeight:_panelMaximumSize.height relation:NSLayoutRelationLessThanOrEqual];
    }
    if(textLabel != nil) {
        [spinnerView glb_addConstraintTop:_margin.top];
        [spinnerView glb_addConstraintLeft:_margin.left relation:NSLayoutRelationGreaterThanOrEqual];
        [spinnerView glb_addConstraintRight:_margin.right relation:NSLayoutRelationGreaterThanOrEqual];
        [spinnerView glb_addConstraintHorizontal:0.0f];
        
        [spinnerView glb_addConstraintBottom:_spacing topView:textLabel];
        
        [textLabel glb_addConstraintLeft:_margin.left relation:NSLayoutRelationGreaterThanOrEqual];
        [textLabel glb_addConstraintRight:_margin.right relation:NSLayoutRelationGreaterThanOrEqual];
        [textLabel glb_addConstraintHorizontal:0.0f];
        [textLabel glb_addConstraintBottom:_margin.bottom];
    } else {
        [spinnerView glb_addConstraintEdgeInsets:_margin];
    }
}

#pragma mark - Property

- (void)setMargin:(UIEdgeInsets)margin {
    if(UIEdgeInsetsEqualToEdgeInsets(_margin, margin) == NO) {
        _margin = margin;
        [self setNeedsUpdateConstraints];
    }
}

- (void)setSpacing:(CGFloat)spacing {
    if(_spacing != spacing) {
        _spacing = spacing;
        [self setNeedsUpdateConstraints];
    }
}

- (void)setPanelMaximumSize:(CGSize)panelMaximumSize {
    if(CGSizeEqualToSize(_panelMaximumSize, panelMaximumSize) == NO) {
        _panelMaximumSize = panelMaximumSize;
        [self setNeedsUpdateConstraints];
    }
}

- (void)setPanelView:(UIView*)panelView {
    if(_panelView != panelView) {
        if(_panelView != nil) {
            [_panelView removeFromSuperview];
        }
        _panelView = panelView;
        if(_panelView != nil) {
            _panelView.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:_panelView];
            if(_spinnerView != nil) {
                [_panelView addSubview:_spinnerView];
            }
            if(_textLabel != nil) {
                [_panelView addSubview:_textLabel];
            }
        }
        [self setNeedsUpdateConstraints];
    }
}

- (UIView*)panelView {
    if(_panelView == nil) {
        UIView* panelView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
        panelView.backgroundColor = [UIColor colorWithWhite:0.2f alpha:0.8f];
        panelView.glb_cornerRadius = 8.0f;
        panelView.clipsToBounds = YES;
        self.panelView = panelView;
    }
    return _panelView;
}

- (void)setSpinnerView:(GLBSpinnerView*)spinnerView {
    if(_spinnerView != spinnerView) {
        if(_spinnerView != nil) {
            [_spinnerView removeFromSuperview];
        }
        _spinnerView = spinnerView;
        if(_spinnerView != nil) {
            _spinnerView.translatesAutoresizingMaskIntoConstraints = NO;
            [self.panelView addSubview:_spinnerView];
        }
        [self setNeedsUpdateConstraints];
    }
}

- (GLBSpinnerView*)spinnerView {
    if(_spinnerView == nil) {
        GLBSpinnerView* spinnerView = [GLBArcSpinnerView new];
        spinnerView.color = UIColor.whiteColor;
        self.spinnerView = spinnerView;
    }
    return _spinnerView;
}

- (void)setTextLabel:(GLBLabel*)textLabel {
    if(_textLabel != textLabel) {
        if(_textLabel != nil) {
            [_textLabel removeFromSuperview];
        }
        _textLabel = textLabel;
        if(_textLabel != nil) {
            _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
            [self.panelView addSubview:_textLabel];
        }
        [self setNeedsUpdateConstraints];
    }
}

- (GLBLabel*)textLabel {
    if(_textLabel == nil) {
        GLBLabel* textLabel = [GLBLabel new];
        textLabel.backgroundColor = UIColor.clearColor;
        textLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.8f];
        textLabel.font = [UIFont boldSystemFontOfSize:UIFont.systemFontSize];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.numberOfLines = 0;
        self.textLabel = textLabel;
    }
    return _textLabel;
}

- (BOOL)isShowed {
    return (_showCount != NSNotFound) && (_showCount > 0);
}

#pragma mark - Public

- (void)show {
    [self showPrepare:nil complete:nil];
}

- (void)showComplete:(GLBSimpleBlock)complete {
    [self showPrepare:nil complete:complete];
}

- (void)showPrepare:(GLBSimpleBlock)prepare complete:(GLBSimpleBlock)complete {
    if(_showCount == NSNotFound) {
        _showCount = 1;
        [self.spinnerView startAnimating];
        [self layoutIfNeeded];
        [UIView animateWithDuration:_showDuration
                              delay:_showDelay
                            options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut)
                         animations:^{
                             if(prepare != nil) {
                                 prepare();
                                 [self layoutIfNeeded];
                             }
                             self.panelView.alpha = 1.0;
                             self.alpha = 1.0;
                         } completion:^(BOOL finished) {
                             if(complete != nil) {
                                 complete();
                             }
                         }];
    } else if(_showCount != NSNotFound) {
        _showCount++;
    }
}

- (void)hide {
    [self hidePrepare:nil complete:nil];
}

- (void)hideComplete:(GLBSimpleBlock)complete {
    [self hidePrepare:nil complete:complete];
}

- (void)hidePrepare:(GLBSimpleBlock)prepare complete:(GLBSimpleBlock)complete {
    if(_showCount == 1) {
        _showCount = NSNotFound;
        [self layoutIfNeeded];
        [UIView animateWithDuration:_hideDuration
                              delay:_hideDelay
                            options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut)
                         animations:^{
                             if(prepare != nil) {
                                 prepare();
                                 [self layoutIfNeeded];
                             }
                             self.panelView.alpha = 0.0;
                             self.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             [self.spinnerView stopAnimating];
                             if(complete != nil) {
                                 complete();
                             }
                         }];
    } else if(_showCount != NSNotFound) {
        _showCount--;
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
