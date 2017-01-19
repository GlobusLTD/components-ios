/*--------------------------------------------------*/

#import "GLBButton.h"
#if __has_include("GLBBadgeView.h")
#import "GLBBadgeView.h"
#endif

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBButton () {
    NSLayoutConstraint* _constraintWidth;
    NSLayoutConstraint* _constraintHeight;
}

#if __has_include("GLBBadgeView.h")
@property(nonatomic, strong) GLBBadgeView* badgeView;
@property(nonatomic, strong) NSLayoutConstraint* constraintBadgeCenterX;
@property(nonatomic, strong) NSLayoutConstraint* constraintBadgeCenterY;
#endif

@end

/*--------------------------------------------------*/

@implementation GLBButton

#pragma mark - Synthesize

#if __has_include("GLBBadgeView.h")
@synthesize badgeView = _badgeView;
#endif

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
#if __has_include("GLBBadgeView.h")
    _badgeAlias = GLBButtonBadgeAliasTitle;
    _badgeHorizontalAlignment = GLBButtonBadgeHorizontalAlignmentRight;
    _badgeVerticalAlignment = GLBButtonBadgeVerticalAlignmentTop;
#endif
}

#pragma mark - Property

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsLayout];
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    [self setNeedsLayout];
}

- (UILabel*)titleLabel {
    UILabel* titleLabel = super.titleLabel;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.autoresizingMask = UIViewAutoresizingNone;
    return titleLabel;
}

- (UIImageView*)imageView {
    UIImageView* imageView = super.imageView;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.autoresizingMask = UIViewAutoresizingNone;
    return imageView;
}

- (void)setContentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment {
    [super setContentHorizontalAlignment:contentHorizontalAlignment];
    [self setNeedsLayout];
}

- (void)setContentVerticalAlignment:(UIControlContentVerticalAlignment)contentVerticalAlignment {
    [super setContentVerticalAlignment:contentVerticalAlignment];
    [self setNeedsLayout];
}

- (void)setTitle:(NSString*)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self __updateTitleStyleForState:state];
    [self setNeedsLayout];
}

- (void)setAttributedTitle:(NSAttributedString*)attributedTitle forState:(UIControlState)state {
    [super setAttributedTitle:attributedTitle forState:state];
    [super setTitle:nil forState:state];
    [self __updateTitleStyleForState:state];
    [self setNeedsLayout];
}

- (void)setTitleEdgeInsets:(UIEdgeInsets)titleEdgeInsets {
    [super setTitleEdgeInsets:titleEdgeInsets];
    [self setNeedsLayout];
}

- (void)setImage:(UIImage*)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    [self setNeedsLayout];
}

- (void)setImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets {
    [super setImageEdgeInsets:imageEdgeInsets];
    [self setNeedsLayout];
}

- (void)setEnabled:(BOOL)enabled {
    if(self.enabled != enabled) {
        super.enabled = enabled;
        [self __updateCurrentState];
        [self setNeedsLayout];
    }
}

- (void)setSelected:(BOOL)selected {
    if(self.selected != selected) {
        super.selected = selected;
        [self __updateCurrentState];
        [self setNeedsLayout];
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    if(self.highlighted != highlighted) {
        super.highlighted = highlighted;
        [self __updateCurrentState];
        [self setNeedsLayout];
    }
}

- (void)setImageAlignment:(GLBButtonImageAlignment)imageAlignment {
    if(_imageAlignment != imageAlignment) {
        _imageAlignment = imageAlignment;
        [self setNeedsLayout];
    }
}

- (void)setNormalTitleStyle:(GLBTextStyle*)normalTitleStyle {
    _normalTitleStyle = normalTitleStyle;
    [self __updateTitleStyleForState:UIControlStateNormal];
}

- (void)setSelectedTitleStyle:(GLBTextStyle*)selectedTitleStyle {
    _selectedTitleStyle = selectedTitleStyle;
    [self __updateTitleStyleForState:UIControlStateSelected];
}

- (void)setHighlightedTitleStyle:(GLBTextStyle*)highlightedTitleStyle {
    _highlightedTitleStyle = highlightedTitleStyle;
    [self __updateTitleStyleForState:UIControlStateHighlighted];
}

- (void)setDisabledTitleStyle:(GLBTextStyle*)disabledTitleStyle {
    _disabledTitleStyle = disabledTitleStyle;
    [self __updateTitleStyleForState:UIControlStateDisabled];
}

- (GLBTextStyle*)currentTitleStyle {
    if(self.isEnabled == NO) {
        if(_disabledTitleStyle != nil) {
            return _disabledTitleStyle;
        }
    } else if(self.isHighlighted == YES) {
        if(_highlightedTitleStyle != nil) {
            return _highlightedTitleStyle;
        }
    } else if(self.isSelected == YES) {
        if(_selectedTitleStyle != nil) {
            return _selectedTitleStyle;
        }
    }
    return _normalTitleStyle;
}

- (void)setNormalBackgroundColor:(UIColor*)normalBackgroundColor {
    if([_normalBackgroundColor isEqual:normalBackgroundColor] == NO) {
        _normalBackgroundColor = normalBackgroundColor;
        [self __updateCurrentState];
    }
}

- (void)setSelectedBackgroundColor:(UIColor*)selectedBackgroundColor {
    if([_selectedBackgroundColor isEqual:selectedBackgroundColor] == NO) {
        _selectedBackgroundColor = selectedBackgroundColor;
        [self __updateCurrentState];
    }
}

- (void)setHighlightedBackgroundColor:(UIColor*)highlightedBackgroundColor {
    if([_highlightedBackgroundColor isEqual:highlightedBackgroundColor] == NO) {
        _highlightedBackgroundColor = highlightedBackgroundColor;
        [self __updateCurrentState];
    }
}

- (void)setDisabledBackgroundColor:(UIColor*)disabledBackgroundColor {
    if([_disabledBackgroundColor isEqual:disabledBackgroundColor] == NO) {
        _disabledBackgroundColor = disabledBackgroundColor;
        [self __updateCurrentState];
    }
}

- (UIColor*)currentBackgroundColor {
    if(self.isEnabled == NO) {
        if(_disabledBackgroundColor != nil) {
            return _disabledBackgroundColor;
        }
        if(_normalBackgroundColor != nil) {
            return [_normalBackgroundColor glb_multiplyBrightness:0.85f];
        }
    } else if(self.isHighlighted == YES) {
        if(_highlightedBackgroundColor != nil) {
            return _highlightedBackgroundColor;
        }
        if(_normalBackgroundColor != nil) {
            return [_normalBackgroundColor glb_multiplyBrightness:1.35f];
        }
    } else if(self.isSelected == YES) {
        if(_selectedBackgroundColor != nil) {
            return _selectedBackgroundColor;
        }
        if(_normalBackgroundColor != nil) {
            return [_normalBackgroundColor glb_multiplyBrightness:1.10f];
        }
    } else if(_normalBackgroundColor != nil) {
        return _normalBackgroundColor;
    }
    return nil;
}

- (void)setNormalTintColor:(UIColor*)normalTintColor {
    if([_normalTintColor isEqual:normalTintColor] == NO) {
        _normalTintColor = normalTintColor;
        [self __updateCurrentState];
    }
}

- (void)setSelectedTintColor:(UIColor*)selectedTintColor {
    if([_selectedTintColor isEqual:selectedTintColor] == NO) {
        _selectedTintColor = selectedTintColor;
        [self __updateCurrentState];
    }
}

- (void)setHighlightedTintColor:(UIColor*)highlightedTintColor {
    if([_highlightedTintColor isEqual:highlightedTintColor] == NO) {
        _highlightedTintColor = highlightedTintColor;
        [self __updateCurrentState];
    }
}

- (void)setDisabledTintColor:(UIColor*)disabledTintColor {
    if([_disabledTintColor isEqual:disabledTintColor] == NO) {
        _disabledTintColor = disabledTintColor;
        [self __updateCurrentState];
    }
}

- (UIColor*)currentTintColor {
    if(self.isEnabled == NO) {
        if(_disabledTintColor != nil) {
            return _disabledTintColor;
        }
        if(_normalTintColor != nil) {
            return [_normalTintColor glb_multiplyBrightness:0.85f];
        }
    } else if(self.isHighlighted == YES) {
        if(_highlightedTintColor != nil) {
            return _highlightedTintColor;
        }
        if(_normalTintColor != nil) {
            return [_normalTintColor glb_multiplyBrightness:1.35f];
        }
    } else if(self.isSelected == YES) {
        if(_selectedTintColor != nil) {
            return _selectedTintColor;
        }
        if(_normalTintColor != nil) {
            return [_normalTintColor glb_multiplyBrightness:1.10f];
        }
    } else if(_normalTintColor != nil) {
        return _normalTintColor;
    }
    return nil;
}

- (void)setNormalBorderColor:(UIColor*)normalBorderColor {
    if([_normalBorderColor isEqual:normalBorderColor] == NO) {
        _normalBorderColor = normalBorderColor;
        [self __updateCurrentState];
    }
}

- (void)setSelectedBorderColor:(UIColor*)selectedBorderColor {
    if([_selectedBorderColor isEqual:selectedBorderColor] == NO) {
        _selectedBorderColor = selectedBorderColor;
        [self __updateCurrentState];
    }
}

- (void)setHighlightedBorderColor:(UIColor*)highlightedBorderColor {
    if([_highlightedBorderColor isEqual:highlightedBorderColor] == NO) {
        _highlightedBorderColor = highlightedBorderColor;
        [self __updateCurrentState];
    }
}

- (void)setDisabledBorderColor:(UIColor*)disabledBorderColor {
    if([_disabledBorderColor isEqual:disabledBorderColor] == NO) {
        _disabledBorderColor = disabledBorderColor;
        [self __updateCurrentState];
    }
}

- (UIColor*)currentBorderColor {
    if(self.isEnabled == NO) {
        if(_disabledBorderColor != nil) {
            return _disabledBorderColor;
        }
        if(_normalBorderColor != nil) {
            return [_normalBorderColor glb_multiplyBrightness:0.85f];
        }
    } else if(self.isHighlighted == YES) {
        if(_highlightedBorderColor != nil) {
            return _highlightedBorderColor;
        }
        if(_normalBorderColor != nil) {
            return [_normalBorderColor glb_multiplyBrightness:1.35f];
        }
    } else if(self.isSelected == YES) {
        if(_selectedBorderColor != nil) {
            return _selectedBorderColor;
        }
        if(_normalBorderColor != nil) {
            return [_normalBorderColor glb_multiplyBrightness:1.10f];
        }
    } else if(_normalBorderColor != nil) {
        return _normalBorderColor;
    }
    return nil;
}

- (void)setNormalBorderWidth:(CGFloat)normalBorderWidth {
    if(_normalBorderWidth != normalBorderWidth) {
        _normalBorderWidth = normalBorderWidth;
        [self __updateCurrentState];
    }
}

- (void)setSelectedBorderWidth:(CGFloat)selectedBorderWidth {
    if(_selectedBorderWidth != selectedBorderWidth) {
        _selectedBorderWidth = selectedBorderWidth;
        [self __updateCurrentState];
    }
}

- (void)setHighlightedBorderWidth:(CGFloat)highlightedBorderWidth {
    if(_highlightedBorderWidth != highlightedBorderWidth) {
        _highlightedBorderWidth = highlightedBorderWidth;
        [self __updateCurrentState];
    }
}

- (void)setDisabledBorderWidth:(CGFloat)disabledBorderWidth {
    if(_disabledBorderWidth != disabledBorderWidth) {
        _disabledBorderWidth = disabledBorderWidth;
        [self __updateCurrentState];
    }
}

- (CGFloat)currentBorderWidth {
    if(self.isEnabled == NO) {
        if(_disabledBorderWidth > FLT_EPSILON) {
            return _disabledBorderWidth;
        }
    } else if(self.isHighlighted == YES) {
        if(_highlightedBorderWidth > FLT_EPSILON) {
            return _highlightedBorderWidth;
        }
    } else if(self.isSelected == YES) {
        if(_selectedBorderWidth > FLT_EPSILON) {
            return _selectedBorderWidth;
        }
    }
    if(_normalBorderWidth > FLT_EPSILON) {
        return _normalBorderWidth;
    }
    return 0.0;
}

- (void)setNormalCornerRadius:(CGFloat)normalCornerRadius {
    if(_normalCornerRadius != normalCornerRadius) {
        _normalCornerRadius = normalCornerRadius;
        [self __updateCurrentState];
    }
}

- (void)setSelectedCornerRadius:(CGFloat)selectedCornerRadius {
    if(_selectedCornerRadius != selectedCornerRadius) {
        _selectedCornerRadius = selectedCornerRadius;
        [self __updateCurrentState];
    }
}

- (void)setHighlightedCornerRadius:(CGFloat)highlightedCornerRadius {
    if(_highlightedCornerRadius != highlightedCornerRadius) {
        _highlightedCornerRadius = highlightedCornerRadius;
        [self __updateCurrentState];
    }
}

- (void)setDisabledCornerRadius:(CGFloat)disabledCornerRadius {
    if(_disabledCornerRadius != disabledCornerRadius) {
        _disabledCornerRadius = disabledCornerRadius;
        [self __updateCurrentState];
    }
}

- (CGFloat)currentCornerRadius {
    if(self.isEnabled == NO) {
        if(_disabledCornerRadius > FLT_EPSILON) {
            return _disabledCornerRadius;
        }
    } else if(self.isHighlighted == YES) {
        if(_highlightedCornerRadius > FLT_EPSILON) {
            return _highlightedCornerRadius;
        }
    } else if(self.isSelected == YES) {
        if(_selectedCornerRadius > FLT_EPSILON) {
            return _selectedCornerRadius;
        }
    }
    if(_normalCornerRadius > FLT_EPSILON) {
        return _normalCornerRadius;
    }
    return 0.0;
}

#if __has_include("GLBBadgeView.h")
- (void)setBadgeView:(GLBBadgeView*)badgeView {
    if(_badgeView != badgeView) {
        if(_badgeView != nil) {
            [_badgeView removeFromSuperview];
        }
        _badgeView = badgeView;
        if(_badgeView != nil) {
            _badgeView.translatesAutoresizingMaskIntoConstraints = YES;
            _badgeView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
            [self addSubview:_badgeView];
        }
        [self setNeedsLayout];
    }
}

- (GLBBadgeView*)badgeView {
    if(_badgeView == nil) {
        self.badgeView = [GLBBadgeView new];
    }
    return _badgeView;
}

- (void)setBadgeAlias:(GLBButtonBadgeAlias)badgeAlias {
    if(_badgeAlias != badgeAlias) {
        _badgeAlias = badgeAlias;
        [self setNeedsLayout];
    }
}

- (void)setBadgeHorizontalAlignment:(GLBButtonBadgeHorizontalAlignment)badgeHorizontalAlignment {
    if(_badgeHorizontalAlignment != badgeHorizontalAlignment) {
        _badgeHorizontalAlignment = badgeHorizontalAlignment;
        [self setNeedsLayout];
    }
}

- (void)setBadgeVerticalAlignment:(GLBButtonBadgeVerticalAlignment)badgeVerticalAlignment {
    if(_badgeVerticalAlignment != badgeVerticalAlignment) {
        _badgeVerticalAlignment = badgeVerticalAlignment;
        [self setNeedsLayout];
    }
}

- (void)setBadgeOffset:(UIOffset)badgeOffset {
    if(UIOffsetEqualToOffset(_badgeOffset, badgeOffset) == NO) {
        _badgeOffset = badgeOffset;
        [self setNeedsLayout];
    }
}
#endif

#pragma mark - Public

- (void)setTitleStyle:(GLBTextStyle*)titleStyle forState:(UIControlState)state {
    switch(state) {
        case UIControlStateNormal:
            _normalTitleStyle = titleStyle;
            break;
        case UIControlStateSelected:
            _selectedTitleStyle = titleStyle;
            break;
        case UIControlStateHighlighted:
            _highlightedTitleStyle = titleStyle;
            break;
        case UIControlStateDisabled:
            _disabledTitleStyle = titleStyle;
            break;
        default:
            break;
    }
    [self __updateTitleStyleForState:state];
}

- (GLBTextStyle*)titleStyleForState:(UIControlState)state {
    switch(state) {
        case UIControlStateNormal: return _normalTitleStyle;
        case UIControlStateSelected: return _selectedTitleStyle;
        case UIControlStateHighlighted: return _highlightedTitleStyle;
        case UIControlStateDisabled: return _disabledTitleStyle;
        default: return nil;
    }
}

#pragma mark - Public override

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    if(self.superview != nil) {
        [self setNeedsLayout];
    }
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    
    if(self.superview != nil) {
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if(((self.currentTitle.length > 0) || (self.currentAttributedTitle.length > 0)) && (self.currentImage != nil)) {
        CGSize size = self.frame.size;
        CGRect contentRect = [self contentRectForBounds:CGRectMake(0.0f, 0.0f, size.width, size.height)];
        CGRect titleRect = [super titleRectForContentRect:CGRectMake(0.0, 0.0, FLT_MAX, FLT_MAX)];
        CGRect imageRect = [super imageRectForContentRect:CGRectMake(0.0, 0.0, FLT_MAX, FLT_MAX)];
        CGSize fullSize = [self __layoutContentRect:contentRect contentEdgeInsets:self.contentEdgeInsets
                                          imageRect:&imageRect imageEdgeInsets:self.imageEdgeInsets imageSize:self.currentImage.size
                                          titleRect:&titleRect titleEdgeInsets:self.titleEdgeInsets];
        self.titleLabel.frame = titleRect;
        self.imageView.frame = imageRect;
        if((_constraintWidth != nil) && (_constraintWidth.constant != fullSize.width)) {
            _constraintWidth.constant = fullSize.width;
        }
        if((_constraintHeight != nil) && (_constraintHeight.constant != fullSize.height)) {
            _constraintHeight.constant = fullSize.height;
        }
    }
#if __has_include("GLBBadgeView.h")
    if(_badgeView != nil) {
        UIView* view = nil;
        switch(_badgeAlias) {
            case GLBButtonBadgeAliasContent: view = self; break;
            case GLBButtonBadgeAliasTitle: view = self.titleLabel; break;
            case GLBButtonBadgeAliasImage: view = self.imageView; break;
        }
        CGPoint anchor = CGPointZero;
        switch(_badgeHorizontalAlignment) {
            case GLBButtonBadgeHorizontalAlignmentLeft: anchor.x = CGRectGetMinX(view.bounds); break;
            case GLBButtonBadgeHorizontalAlignmentCenter: anchor.x = CGRectGetMidX(view.bounds); break;
            case GLBButtonBadgeHorizontalAlignmentRight: anchor.x = CGRectGetMaxX(view.bounds); break;
        }
        switch(_badgeVerticalAlignment) {
            case GLBButtonBadgeVerticalAlignmentTop: anchor.y = CGRectGetMinY(view.bounds); break;
            case GLBButtonBadgeVerticalAlignmentCenter: anchor.y = CGRectGetMidY(view.bounds); break;
            case GLBButtonBadgeVerticalAlignmentBottom: anchor.y = CGRectGetMaxY(view.bounds); break;
        }
        [_badgeView sizeToFit];
        
        CGPoint center = [view convertPoint:anchor toView:self];
        _badgeView.glb_frameCenter = CGPointMake(center.x + _badgeOffset.horizontal, center.y + _badgeOffset.vertical);
    }
#endif
}

- (void)updateConstraints {
    [super updateConstraints];
    
    _constraintWidth = nil;
    _constraintHeight = nil;
    
    Class contentSizeLayoutConstraint = objc_getClass(GLB_STR(NSContentSizeLayoutConstraint));
    if(contentSizeLayoutConstraint != nil) {
        for(NSLayoutConstraint* constraint in self.constraints) {
            if(([constraint isKindOfClass:contentSizeLayoutConstraint] == YES) && (constraint.firstItem == self)) {
                switch(constraint.firstAttribute) {
                    case NSLayoutAttributeWidth:
                        _constraintWidth = constraint;
                        break;
                    case NSLayoutAttributeHeight:
                        _constraintHeight = constraint;
                        break;
                    default:
                        break;
                }
            }
        }
    }
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [self intrinsicContentSize];
}

- (CGSize)intrinsicContentSize {
    if(((self.currentTitle.length > 0) || (self.currentAttributedTitle.length > 0)) && (self.currentImage != nil)) {
        CGSize size = self.superview.frame.size;
        UIEdgeInsets contentEdgeInsets = self.contentEdgeInsets;
        UIEdgeInsets titleEdgeInsets = self.titleEdgeInsets;
        UIEdgeInsets imageEdgeInsets = self.imageEdgeInsets;
        CGRect contentRect = [super contentRectForBounds:CGRectMake(0.0, 0.0, size.width, size.height)];
        CGRect titleRect = [super titleRectForContentRect:contentRect];
        CGRect imageRect = [super imageRectForContentRect:contentRect];
        CGSize fullTitleSize = CGSizeMake(titleEdgeInsets.left + titleRect.size.width + titleEdgeInsets.right, titleEdgeInsets.top + titleRect.size.height + titleEdgeInsets.bottom);
        CGSize fullImageSize = CGSizeMake(imageEdgeInsets.left + imageRect.size.width + imageEdgeInsets.right, imageEdgeInsets.top + imageRect.size.height + imageEdgeInsets.bottom);
        CGSize result = CGSizeMake(contentEdgeInsets.left + contentEdgeInsets.right, contentEdgeInsets.top + contentEdgeInsets.bottom);
        switch(_imageAlignment) {
            case GLBButtonImageAlignmentLeft:
            case GLBButtonImageAlignmentRight:
                result.width += fullTitleSize.width + fullImageSize.width;
                result.height += MAX(fullTitleSize.height, fullImageSize.height);
                break;
            case GLBButtonImageAlignmentTop:
            case GLBButtonImageAlignmentBottom:
                result.width += MAX(fullTitleSize.width, fullImageSize.width);
                result.height += fullTitleSize.height + fullImageSize.height;
                break;
        }
        return result;
    }
    return [super intrinsicContentSize];
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    if(((self.currentTitle.length > 0) || (self.currentAttributedTitle.length > 0)) && (self.currentImage != nil)) {
        CGRect titleRect = [super titleRectForContentRect:CGRectMake(0.0, 0.0, FLT_MAX, FLT_MAX)];
        CGRect imageRect = [super imageRectForContentRect:CGRectMake(0.0, 0.0, FLT_MAX, FLT_MAX)];
        [self __layoutContentRect:contentRect contentEdgeInsets:UIEdgeInsetsZero imageRect:&imageRect imageEdgeInsets:self.imageEdgeInsets imageSize:self.currentImage.size titleRect:&titleRect titleEdgeInsets:self.titleEdgeInsets];
        return titleRect;
    }
    return [super titleRectForContentRect:contentRect];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    if(((self.currentTitle.length > 0) || (self.currentAttributedTitle.length > 0)) && (self.currentImage != nil)) {
        CGRect titleRect = [super titleRectForContentRect:CGRectMake(0.0, 0.0, FLT_MAX, FLT_MAX)];
        CGRect imageRect = [super imageRectForContentRect:CGRectMake(0.0, 0.0, FLT_MAX, FLT_MAX)];
        [self __layoutContentRect:contentRect contentEdgeInsets:UIEdgeInsetsZero imageRect:&imageRect imageEdgeInsets:self.imageEdgeInsets imageSize:self.currentImage.size titleRect:&titleRect titleEdgeInsets:self.titleEdgeInsets];
        return imageRect;
    }
    return [super imageRectForContentRect:contentRect];
}

#pragma mark - Private

- (CGSize)__layoutContentRect:(CGRect)contentRect contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets imageRect:(CGRect*)imageRect imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets imageSize:(CGSize)imageSize titleRect:(CGRect*)titleRect titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets {
    imageRect->size.width = imageSize.width;
    imageRect->size.height = imageSize.height;
    CGSize fullImageSize = CGSizeMake(imageEdgeInsets.left + imageRect->size.width + imageEdgeInsets.right, imageEdgeInsets.top + imageRect->size.height + imageEdgeInsets.bottom);
    CGSize fullTitleSize = CGSizeMake(titleEdgeInsets.left + titleRect->size.width + titleEdgeInsets.right, titleEdgeInsets.top + titleRect->size.height + titleEdgeInsets.bottom);
    CGSize fullSize = CGSizeMake(contentEdgeInsets.left + contentEdgeInsets.right, contentEdgeInsets.top + contentEdgeInsets.bottom);
    switch(_imageAlignment) {
        case GLBButtonImageAlignmentTop:
        case GLBButtonImageAlignmentBottom:
            fullSize.width += MAX(fullTitleSize.width, fullImageSize.width);
            fullSize.height += fullTitleSize.height + fullImageSize.height ;
            break;
        case GLBButtonImageAlignmentLeft:
        case GLBButtonImageAlignmentRight:
            fullSize.width += fullTitleSize.width + fullImageSize.width;
            fullSize.height += MAX(fullTitleSize.height, fullImageSize.height);
            break;
    }
    switch(self.contentHorizontalAlignment) {
        case UIControlContentHorizontalAlignmentLeft: {
            switch(_imageAlignment) {
                case GLBButtonImageAlignmentTop:
                case GLBButtonImageAlignmentBottom:
                    imageRect->origin.x = contentRect.origin.x + imageEdgeInsets.left;
                    titleRect->origin.x = contentRect.origin.x + titleEdgeInsets.left;
                    break;
                case GLBButtonImageAlignmentLeft:
                    imageRect->origin.x = contentRect.origin.x + imageEdgeInsets.left;
                    titleRect->origin.x = (imageRect->origin.x + imageRect->size.width + imageEdgeInsets.right) + titleEdgeInsets.left;
                    break;
                case GLBButtonImageAlignmentRight:
                    titleRect->origin.x = contentRect.origin.x + titleEdgeInsets.left;
                    imageRect->origin.x = (titleRect->origin.x + titleRect->size.width + titleEdgeInsets.right) + imageEdgeInsets.left;
                    break;
            }
            break;
        }
        case UIControlContentHorizontalAlignmentCenter: {
            switch(_imageAlignment) {
                case GLBButtonImageAlignmentTop:
                case GLBButtonImageAlignmentBottom:
                    imageRect->origin.x = (contentRect.origin.x + (contentRect.size.width * 0.5f)) - (imageRect->size.width * 0.5f);
                    titleRect->origin.x = (contentRect.origin.x + (contentRect.size.width * 0.5f)) - (titleRect->size.width * 0.5f);
                    break;
                case GLBButtonImageAlignmentLeft:
                    imageRect->origin.x = ((contentRect.origin.x + (contentRect.size.width * 0.5f)) - (fullSize.width * 0.5f)) + imageEdgeInsets.left;
                    titleRect->origin.x = (imageRect->origin.x + imageRect->size.width + imageEdgeInsets.right) + titleEdgeInsets.left;
                    break;
                case GLBButtonImageAlignmentRight:
                    titleRect->origin.x = ((contentRect.origin.x + (contentRect.size.width * 0.5f)) - (fullSize.width * 0.5f)) + titleEdgeInsets.left;
                    imageRect->origin.x = (titleRect->origin.x + titleRect->size.width + titleEdgeInsets.right) + imageEdgeInsets.left;
                    break;
            }
            break;
        }
        case UIControlContentHorizontalAlignmentRight: {
            switch(_imageAlignment) {
                case GLBButtonImageAlignmentTop:
                case GLBButtonImageAlignmentBottom:
                    imageRect->origin.x = (contentRect.origin.x + contentRect.size.width) - (imageRect->size.width + imageEdgeInsets.right);
                    titleRect->origin.x = (contentRect.origin.x + contentRect.size.width) - (titleRect->size.width + titleEdgeInsets.right);
                    break;
                case GLBButtonImageAlignmentLeft:
                    titleRect->origin.x = (contentRect.origin.x + contentRect.size.width) - (titleRect->size.width + titleEdgeInsets.right);
                    imageRect->origin.x = (titleRect->origin.x - titleEdgeInsets.left) - (imageRect->size.width + imageEdgeInsets.right);
                    break;
                case GLBButtonImageAlignmentRight:
                    imageRect->origin.x = (contentRect.origin.x + contentRect.size.width) - (imageRect->size.width + imageEdgeInsets.right);
                    titleRect->origin.x = (imageRect->origin.x - imageEdgeInsets.left) - (titleRect->size.width + titleEdgeInsets.right);
                    break;
            }
            break;
        }
        case UIControlContentHorizontalAlignmentFill: {
            switch(_imageAlignment) {
                case GLBButtonImageAlignmentLeft:
                    imageRect->origin.x = contentRect.origin.x + imageEdgeInsets.left;
                    titleRect->origin.x = (imageRect->origin.x + imageRect->size.width + imageEdgeInsets.right) + titleEdgeInsets.left;
                    titleRect->size.width = contentRect.size.width - (imageEdgeInsets.left + imageRect->size.width + imageEdgeInsets.right + titleEdgeInsets.left + titleEdgeInsets.right);
                    break;
                case GLBButtonImageAlignmentRight:
                    titleRect->origin.x = contentRect.origin.x + titleEdgeInsets.left;
                    titleRect->size.width = contentRect.size.width - (imageEdgeInsets.left + imageRect->size.width + imageEdgeInsets.right + titleEdgeInsets.left + titleEdgeInsets.right);
                    imageRect->origin.x = (titleRect->origin.x + titleRect->size.width + titleEdgeInsets.right) + imageEdgeInsets.left;
                    break;
                default:
                    imageRect->origin.x = contentRect.origin.x + imageEdgeInsets.left;
                    imageRect->size.width = contentRect.size.width - (imageEdgeInsets.left + imageEdgeInsets.right);
                    titleRect->origin.x = contentRect.origin.x + titleEdgeInsets.left;
                    titleRect->size.width = contentRect.size.width - (titleEdgeInsets.left + titleEdgeInsets.right);
                    break;
            }
            break;
        }
    }
    switch(self.contentVerticalAlignment) {
        case UIControlContentVerticalAlignmentTop: {
            switch(_imageAlignment) {
                case GLBButtonImageAlignmentTop:
                    imageRect->origin.y = contentRect.origin.y + imageEdgeInsets.top;
                    titleRect->origin.y = (imageRect->origin.y + imageRect->size.height + imageEdgeInsets.bottom) + titleEdgeInsets.top;
                    break;
                case GLBButtonImageAlignmentBottom:
                    imageRect->origin.y = (contentRect.origin.y + contentRect.size.height) + imageEdgeInsets.top;
                    titleRect->origin.y = (imageRect->origin.y - imageEdgeInsets.top) + titleEdgeInsets.bottom;
                    break;
                case GLBButtonImageAlignmentLeft:
                case GLBButtonImageAlignmentRight:
                    imageRect->origin.y = contentRect.origin.y + imageEdgeInsets.top;
                    titleRect->origin.y = contentRect.origin.y + titleEdgeInsets.top;
                    break;
            }
            break;
        }
        case UIControlContentVerticalAlignmentCenter: {
            switch(_imageAlignment) {
                case GLBButtonImageAlignmentTop:
                    imageRect->origin.y = ((contentRect.origin.y + (contentRect.size.height * 0.5f)) - (fullSize.height * 0.5f)) + imageEdgeInsets.top;
                    titleRect->origin.y = (imageRect->origin.y + imageRect->size.height + imageEdgeInsets.bottom) + titleEdgeInsets.top;
                    break;
                case GLBButtonImageAlignmentBottom:
                    titleRect->origin.y = ((contentRect.origin.y + (contentRect.size.height * 0.5f)) - (fullSize.height * 0.5f)) + titleEdgeInsets.top;
                    imageRect->origin.y = (titleRect->origin.y + titleRect->size.height + titleEdgeInsets.bottom) + imageEdgeInsets.top;
                    break;
                case GLBButtonImageAlignmentLeft:
                case GLBButtonImageAlignmentRight:
                    imageRect->origin.y = (contentRect.origin.y + (contentRect.size.height * 0.5f)) - (imageRect->size.height * 0.5f);
                    titleRect->origin.y = (contentRect.origin.y + (contentRect.size.height * 0.5f)) - (titleRect->size.height * 0.5f);
                    break;
            }
            break;
        }
        case UIControlContentVerticalAlignmentBottom: {
            switch(_imageAlignment) {
                case GLBButtonImageAlignmentTop:
                    titleRect->origin.y = (contentRect.origin.y + contentRect.size.height) - (titleRect->size.width + titleEdgeInsets.bottom);
                    imageRect->origin.y = (titleRect->origin.y - titleEdgeInsets.top) - (imageRect->size.height + imageEdgeInsets.bottom);
                    break;
                case GLBButtonImageAlignmentBottom:
                    imageRect->origin.y = (contentRect.origin.y + contentRect.size.height) - (imageRect->size.width + imageEdgeInsets.bottom);
                    titleRect->origin.y = (imageRect->origin.y - imageEdgeInsets.top) - (titleRect->size.height + titleEdgeInsets.bottom);
                    break;
                case GLBButtonImageAlignmentLeft:
                case GLBButtonImageAlignmentRight:
                    imageRect->origin.y = (contentRect.origin.y + contentRect.size.height) - (imageRect->size.height + imageEdgeInsets.bottom);
                    titleRect->origin.y = (contentRect.origin.y + contentRect.size.height) - (titleRect->size.height + titleEdgeInsets.bottom);
                    break;
            }
            break;
        }
        case UIControlContentVerticalAlignmentFill: {
            switch(_imageAlignment) {
                case GLBButtonImageAlignmentTop:
                    imageRect->origin.y = contentRect.origin.y + imageEdgeInsets.top;
                    titleRect->origin.y = (imageRect->origin.y + imageRect->size.height + imageEdgeInsets.bottom) + titleEdgeInsets.top;
                    titleRect->size.height = contentRect.size.height - (imageEdgeInsets.top + imageRect->size.height + imageEdgeInsets.bottom + titleEdgeInsets.top + titleEdgeInsets.bottom);
                    break;
                case GLBButtonImageAlignmentBottom:
                    titleRect->origin.y = contentRect.origin.y + titleEdgeInsets.top;
                    titleRect->size.height = contentRect.size.height - (imageEdgeInsets.top + imageRect->size.height + imageEdgeInsets.bottom + titleEdgeInsets.top + titleEdgeInsets.bottom);
                    imageRect->origin.y = (titleRect->origin.y + titleRect->size.height + titleEdgeInsets.bottom) + imageEdgeInsets.top;
                    break;
                default:
                    imageRect->origin.y = contentRect.origin.y + imageEdgeInsets.top;
                    imageRect->size.height = contentRect.size.height - (imageEdgeInsets.top + imageEdgeInsets.bottom);
                    titleRect->origin.y = contentRect.origin.y + titleEdgeInsets.top;
                    titleRect->size.height = contentRect.size.height - (titleEdgeInsets.top + titleEdgeInsets.bottom);
                    break;
            }
            break;
        }
    }
    return fullSize;
}

- (void)__updateTitleStyleForState:(UIControlState)state {
    NSMutableAttributedString* result = [NSMutableAttributedString new];
    NSString* title = [self titleForState:state];
    if(title != nil) {
        [result appendAttributedString:[[NSAttributedString alloc] initWithString:title]];
    } else {
        NSAttributedString* attributedTitle = [self attributedTitleForState:state];
        if(attributedTitle != nil) {
            [result appendAttributedString:attributedTitle];
        }
    }
    NSRange range = NSMakeRange(0, result.string.length);
    UIColor* titleColor = [self titleColorForState:state];
    if(titleColor != nil) {
        [result addAttribute:NSForegroundColorAttributeName value:titleColor range:range];
    }
    UIColor* titleShadowColor = [self titleShadowColorForState:state];
    if(titleShadowColor != nil) {
        NSShadow* shadow = [NSShadow new];
        shadow.shadowColor = titleShadowColor;
        [result addAttribute:NSShadowAttributeName value:shadow range:range];
    }
    GLBTextStyle* style = [self titleStyleForState:state];
    if(style != nil) {
        [result setAttributes:style.attributes range:NSMakeRange(0, result.string.length)];
    }
    [super setAttributedTitle:result forState:state];
}

- (void)__updateCurrentState {
    self.backgroundColor = [self currentBackgroundColor];
    self.glb_borderColor = [self currentBorderColor];
    self.glb_borderWidth = [self currentBorderWidth];
    self.glb_cornerRadius = [self currentCornerRadius];
    
    UIColor* tintColor = [self currentTintColor];
    self.tintColor = tintColor;
    self.titleLabel.tintColor = tintColor;
    self.imageView.tintColor = tintColor;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
