/*--------------------------------------------------*/

#import "GLBActivityView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import "GLBBlurView.h"
#import "GLBSpinnerView.h"
#import "UIView+GLBUI.h"
#import "UILabel+GLBUI.h"
#import "GLBRect.h"

/*--------------------------------------------------*/

@interface GLBActivityView ()

@property(nonatomic, strong) UIView* panelView;
@property(nonatomic, strong) GLBSpinnerView* spinnerView;
@property(nonatomic, strong) UILabel* textView;
@property(nonatomic) NSUInteger showCount;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

#define GLBActivityViewMargin                       15.0f
#define GLBActivityViewSpacing                      8.0f
#define GLBActivityViewBackgroundColor              [UIColor colorWithWhite:0.1f alpha:0.2f]
#define GLBActivityViewPanelColor                   [UIColor colorWithWhite:0.2f alpha:0.8f]
#define GLBActivityViewPanelCornerRadius            8.0f
#define GLBActivityViewSpinnerColor                 [UIColor colorWithWhite:1.0f alpha:0.8f]
#define GLBActivityViewSpinnerSize                  42.0f
#define GLBActivityViewTextColor                    [UIColor colorWithWhite:1.0f alpha:0.8f]
#define GLBActivityViewTextFont                     [UIFont boldSystemFontOfSize:[UIFont systemFontSize]]
#define GLBActivityViewTextWidth                    NSNotFound
#define GLBActivityDuration                         0.1f
#define GLBActivityDelay                            0.1f

/*--------------------------------------------------*/

@implementation GLBActivityView

#pragma mark - Init / Free

+ (instancetype)activityViewWithStyle:(GLBActivityViewStyle)style {
    return [[self alloc] initWithStyle:style text:nil textWidth:GLBActivityViewTextWidth];
}

+ (instancetype)activityViewWithStyle:(GLBActivityViewStyle)style text:(NSString*)text {
    return [[self alloc] initWithStyle:style text:text textWidth:GLBActivityViewTextWidth];
}

+ (instancetype)activityViewWithStyle:(GLBActivityViewStyle)style text:(NSString*)text textWidth:(NSUInteger)textWidth {
    return [[self alloc] initWithStyle:style text:text textWidth:textWidth];
}

- (instancetype)initWithStyle:(GLBActivityViewStyle)style text:(NSString*)text textWidth:(NSUInteger)textWidth {
    self = [super initWithFrame:UIScreen.mainScreen.bounds];
    if(self != nil) {
        _style = style;
        _margin = GLBActivityViewMargin;
        _spacing = GLBActivityViewSpacing;
        _textWidth = textWidth;
        _showDuration = GLBActivityDuration;
        _showDelay = GLBActivityDelay;
        _hideDuration = GLBActivityDuration;
        _hideDelay = GLBActivityDelay;
        
        self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        self.backgroundColor = GLBActivityViewBackgroundColor;
        self.alpha = 0.0f;
        
        _panelView = [[UIView alloc] initWithFrame:CGRectZero];
        _panelView.backgroundColor = GLBActivityViewPanelColor;
        _panelView.glb_cornerRadius = GLBActivityViewPanelCornerRadius;
        _panelView.clipsToBounds = YES;
        [self addSubview:_panelView];
        
        switch(_style) {
            case GLBActivityViewStylePlane: _spinnerView = [[GLBSpinnerViewPlane alloc] initWithFrame:CGRectZero]; break;
            case GLBActivityViewStyleBounce: _spinnerView = [[GLBSpinnerViewBounce alloc] initWithFrame:CGRectZero]; break;
            case GLBActivityViewStyleWave: _spinnerView = [[GLBSpinnerViewWave alloc] initWithFrame:CGRectZero]; break;
            case GLBActivityViewStyleWanderingCubes: _spinnerView = [[GLBSpinnerViewWanderingCubes alloc] initWithFrame:CGRectZero]; break;
            case GLBActivityViewStylePulse: _spinnerView = [[GLBSpinnerViewPulse alloc] initWithFrame:CGRectZero]; break;
            case GLBActivityViewStyleChasingDots: _spinnerView = [[GLBSpinnerViewChasingDots alloc] initWithFrame:CGRectZero]; break;
            case GLBActivityViewStyleThreeBounce: _spinnerView = [[GLBSpinnerViewThreeBounce alloc] initWithFrame:CGRectZero]; break;
            case GLBActivityViewStyleCircle: _spinnerView = [[GLBSpinnerViewCircle alloc] initWithFrame:CGRectZero]; break;
            case GLBActivityViewStyleCircleFlip: _spinnerView = [[GLBSpinnerViewCircleFlip alloc] initWithFrame:CGRectZero]; break;
            case GLBActivityViewStyle9CubeGrid: _spinnerView = [[GLBSpinnerView9CubeGrid alloc] initWithFrame:CGRectZero]; break;
            case GLBActivityViewStyleWordPress: _spinnerView = [[GLBSpinnerViewWordPress alloc] initWithFrame:CGRectZero]; break;
            case GLBActivityViewStyleFadingCircle: _spinnerView = [[GLBSpinnerViewFadingCircle alloc] initWithFrame:CGRectZero]; break;
            case GLBActivityViewStyleFadingCircleAlt: _spinnerView = [[GLBSpinnerViewFadingCircleAlt alloc] initWithFrame:CGRectZero]; break;
            case GLBActivityViewStyleArc: _spinnerView = [[GLBSpinnerViewArc alloc] initWithFrame:CGRectZero]; break;
            case GLBActivityViewStyleArcAlt: _spinnerView = [[GLBSpinnerViewArcAlt alloc] initWithFrame:CGRectZero]; break;
            default: break;
        }
        if(_spinnerView != nil) {
            _spinnerView.color = GLBActivityViewSpinnerColor;
            _spinnerView.size = GLBActivityViewSpinnerSize;
            [_panelView addSubview:_spinnerView];
        }
        _textView = [[UILabel alloc] initWithFrame:CGRectZero];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textColor = GLBActivityViewTextColor;
        _textView.font = GLBActivityViewTextFont;
        _textView.textAlignment = NSTextAlignmentCenter;
        _textView.numberOfLines = 0;
        _textView.text = text;
        [_panelView addSubview:_textView];
        
        _showCount = NSNotFound;
        
        [self setup];
    }
    return self;
}

- (void)setup {
}

#pragma mark - Public override

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize spinnerSize = CGSizeMake(self.spinnerSize, self.spinnerSize);
    CGSize textSize = [self.textView glb_sizeForWidth:self.textWidth];
    CGSize panelSize = CGSizeMake(self.margin + MAX(spinnerSize.width, textSize.width) + self.margin, self.margin + spinnerSize.height + ((self.textView.text.length > 0) ? self.spacing + textSize.height : 0.0f) + self.margin);
    CGFloat spinnerOffset = (CGFloat)floorf((panelSize.width - spinnerSize.width) * 0.5f);
    
    self.panelView.frame = GLBRectMakeCenterPoint(self.glb_frameCenter, panelSize.width, panelSize.height);
    self.spinnerView.frame = CGRectMake(spinnerOffset, self.margin, spinnerSize.width, spinnerSize.height);
    self.textView.frame = CGRectMake(self.margin, self.margin + spinnerSize.height + self.spacing, textSize.width, textSize.height);
}

#pragma mark - Property

- (void)setMargin:(CGFloat)margin {
    if(_margin != margin) {
        _margin = margin;
        [self setNeedsLayout];
    }
}

- (void)setSpacing:(CGFloat)spacing {
    if(_spacing != spacing) {
        _spacing = spacing;
        [self setNeedsLayout];
    }
}

- (void)setPanelColor:(UIColor*)panelColor {
    _panelView.backgroundColor = panelColor;
}

- (UIColor*)panelColor {
    return _panelView.backgroundColor;
}

- (void)setPanelCornerRadius:(CGFloat)panelCornerRadius {
    _panelView.glb_cornerRadius = panelCornerRadius;
}

- (CGFloat)panelCornerRadius {
    return _panelView.glb_cornerRadius;
}

- (void)setSpinnerColor:(UIColor*)spinnerColor {
    _spinnerView.color = spinnerColor;
}

- (UIColor*)spinnerColor {
    return _spinnerView.color;
}

- (void)setSpinnerSize:(CGFloat)spinnerSize {
    if(_spinnerView.size != spinnerSize) {
        _spinnerView.size = spinnerSize;
        [self setNeedsLayout];
    }
}

- (CGFloat)spinnerSize {
    return _spinnerView.size;
}

- (void)setTextColor:(UIColor*)textColor {
    _textView.textColor = textColor;
}

- (UIColor*)textColor {
    return _textView.textColor;
}

- (void)setText:(NSString*)text {
    if([_textView.text isEqualToString:text] == NO) {
        _textView.text = text;
        [self setNeedsLayout];
    }
}

- (NSString*)text {
    return _textView.text;
}

- (void)setTextFont:(UIFont*)textFont {
    if([_textView.font isEqual:textFont] == NO) {
        _textView.font = textFont;
        [self setNeedsLayout];
    }
}

- (UIFont*)textFont {
    return _textView.font;
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
                             self.panelView.alpha = 1.0f;
                             self.alpha = 1.0f;
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
                             self.panelView.alpha = 0.0f;
                             self.alpha = 0.0f;
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
