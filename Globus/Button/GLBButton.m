/*--------------------------------------------------*/

#import "GLBButton.h"
#if __has_include("GLBBadgeView.h")
#import "GLBBadgeView.h"
#endif

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBButton ()

#if __has_include("GLBBadgeView.h")
@property(nonatomic, strong) GLBBadgeView* badgeView;
@property(nonatomic, strong) NSLayoutConstraint* constraintBadgeCenterX;
@property(nonatomic, strong) NSLayoutConstraint* constraintBadgeCenterY;
#endif

- (void)_updateCurrentState;

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

- (void)setTitle:(NSString*)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self setNeedsLayout];
}

- (void)setAttributedTitle:(NSAttributedString*)attributedTitle forState:(UIControlState)state {
    [super setAttributedTitle:attributedTitle forState:state];
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
        [self _updateCurrentState];
        [self setNeedsLayout];
    }
}

- (void)setSelected:(BOOL)selected {
    if(self.selected != selected) {
        super.selected = selected;
        [self _updateCurrentState];
        [self setNeedsLayout];
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    if(self.highlighted != highlighted) {
        super.highlighted = highlighted;
        [self _updateCurrentState];
        [self setNeedsLayout];
    }
}

- (void)setImageAlignment:(GLBButtonImageAlignment)imageAlignment {
    if(_imageAlignment != imageAlignment) {
        _imageAlignment = imageAlignment;
        [self setNeedsLayout];
    }
}

- (void)setNormalBackgroundColor:(UIColor*)normalBackgroundColor {
    if([_normalBackgroundColor isEqual:normalBackgroundColor] == NO) {
        _normalBackgroundColor = normalBackgroundColor;
        [self _updateCurrentState];
    }
}

- (void)setSelectedBackgroundColor:(UIColor*)selectedBackgroundColor {
    if([_selectedBackgroundColor isEqual:selectedBackgroundColor] == NO) {
        _selectedBackgroundColor = selectedBackgroundColor;
        [self _updateCurrentState];
    }
}

- (void)setHighlightedBackgroundColor:(UIColor*)highlightedBackgroundColor {
    if([_highlightedBackgroundColor isEqual:highlightedBackgroundColor] == NO) {
        _highlightedBackgroundColor = highlightedBackgroundColor;
        [self _updateCurrentState];
    }
}

- (void)setDisabledBackgroundColor:(UIColor*)disabledBackgroundColor {
    if([_disabledBackgroundColor isEqual:disabledBackgroundColor] == NO) {
        _disabledBackgroundColor = disabledBackgroundColor;
        [self _updateCurrentState];
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

- (void)setNormalBorderColor:(UIColor*)normalBorderColor {
    if([_normalBorderColor isEqual:normalBorderColor] == NO) {
        _normalBorderColor = normalBorderColor;
        [self _updateCurrentState];
    }
}

- (void)setSelectedBorderColor:(UIColor*)selectedBorderColor {
    if([_selectedBorderColor isEqual:selectedBorderColor] == NO) {
        _selectedBorderColor = selectedBorderColor;
        [self _updateCurrentState];
    }
}

- (void)setHighlightedBorderColor:(UIColor*)highlightedBorderColor {
    if([_highlightedBorderColor isEqual:highlightedBorderColor] == NO) {
        _highlightedBorderColor = highlightedBorderColor;
        [self _updateCurrentState];
    }
}

- (void)setDisabledBorderColor:(UIColor*)disabledBorderColor {
    if([_disabledBorderColor isEqual:disabledBorderColor] == NO) {
        _disabledBorderColor = disabledBorderColor;
        [self _updateCurrentState];
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
        [self _updateCurrentState];
    }
}

- (void)setSelectedBorderWidth:(CGFloat)selectedBorderWidth {
    if(_selectedBorderWidth != selectedBorderWidth) {
        _selectedBorderWidth = selectedBorderWidth;
        [self _updateCurrentState];
    }
}

- (void)setHighlightedBorderWidth:(CGFloat)highlightedBorderWidth {
    if(_highlightedBorderWidth != highlightedBorderWidth) {
        _highlightedBorderWidth = highlightedBorderWidth;
        [self _updateCurrentState];
    }
}

- (void)setDisabledBorderWidth:(CGFloat)disabledBorderWidth {
    if(_disabledBorderWidth != disabledBorderWidth) {
        _disabledBorderWidth = disabledBorderWidth;
        [self _updateCurrentState];
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
        [self _updateCurrentState];
    }
}

- (void)setSelectedCornerRadius:(CGFloat)selectedCornerRadius {
    if(_selectedCornerRadius != selectedCornerRadius) {
        _selectedCornerRadius = selectedCornerRadius;
        [self _updateCurrentState];
    }
}

- (void)setHighlightedCornerRadius:(CGFloat)highlightedCornerRadius {
    if(_highlightedCornerRadius != highlightedCornerRadius) {
        _highlightedCornerRadius = highlightedCornerRadius;
        [self _updateCurrentState];
    }
}

- (void)setDisabledCornerRadius:(CGFloat)disabledCornerRadius {
    if(_disabledCornerRadius != disabledCornerRadius) {
        _disabledCornerRadius = disabledCornerRadius;
        [self _updateCurrentState];
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
        [self setNeedsUpdateConstraints];
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
        [self setNeedsUpdateConstraints];
    }
}

- (void)setBadgeHorizontalAlignment:(GLBButtonBadgeHorizontalAlignment)badgeHorizontalAlignment {
    if(_badgeHorizontalAlignment != badgeHorizontalAlignment) {
        _badgeHorizontalAlignment = badgeHorizontalAlignment;
        [self setNeedsUpdateConstraints];
    }
}

- (void)setBadgeVerticalAlignment:(GLBButtonBadgeVerticalAlignment)badgeVerticalAlignment {
    if(_badgeVerticalAlignment != badgeVerticalAlignment) {
        _badgeVerticalAlignment = badgeVerticalAlignment;
        [self setNeedsUpdateConstraints];
    }
}
#endif

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
        CGRect contentRect = [self contentRectForBounds:self.bounds];
        self.titleLabel.frame = [self titleRectForContentRect:contentRect];
        self.imageView.frame = [self imageRectForContentRect:contentRect];
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
        _badgeView.glb_frameCenter = [view convertPoint:anchor toView:self];
    }
#endif
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [self intrinsicContentSize];
}

- (CGSize)intrinsicContentSize {
    if(((self.currentTitle.length > 0) || (self.currentAttributedTitle.length > 0)) && (self.currentImage != nil)) {
        CGSize boundsSize = CGSizeMake(FLT_MAX, FLT_MAX);
        if(self.superview != nil) {
            boundsSize = self.superview.frame.size;
        }
        UIEdgeInsets contentEdgeInsets = self.contentEdgeInsets;
        UIEdgeInsets titleEdgeInsets = self.titleEdgeInsets;
        UIEdgeInsets imageEdgeInsets = self.imageEdgeInsets;
        CGRect contentRect = [super contentRectForBounds:CGRectMake(0.0, 0.0, boundsSize.width, boundsSize.height)];
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
        [self _layoutContentRect:contentRect imageRect:&imageRect imageEdgeInsets:self.imageEdgeInsets imageSize:self.currentImage.size titleRect:&titleRect titleEdgeInsets:self.titleEdgeInsets];
        return titleRect;
    }
    return [super titleRectForContentRect:contentRect];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    if(((self.currentTitle.length > 0) || (self.currentAttributedTitle.length > 0)) && (self.currentImage != nil)) {
        CGRect titleRect = [super titleRectForContentRect:CGRectMake(0.0, 0.0, FLT_MAX, FLT_MAX)];
        CGRect imageRect = [super imageRectForContentRect:CGRectMake(0.0, 0.0, FLT_MAX, FLT_MAX)];
        [self _layoutContentRect:contentRect imageRect:&imageRect imageEdgeInsets:self.imageEdgeInsets imageSize:self.currentImage.size titleRect:&titleRect titleEdgeInsets:self.titleEdgeInsets];
        return imageRect;
    }
    return [super imageRectForContentRect:contentRect];
}

#pragma mark - Private

- (void)_layoutContentRect:(CGRect)contentRect imageRect:(CGRect*)imageRect imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets imageSize:(CGSize)imageSize titleRect:(CGRect*)titleRect titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets {
    imageRect->size.width = imageSize.width;
    imageRect->size.height = imageSize.height;
    CGSize fullImageSize = CGSizeMake(imageEdgeInsets.left + imageRect->size.width + imageEdgeInsets.right, imageEdgeInsets.top + imageRect->size.height + imageEdgeInsets.bottom);
    CGSize fullTitleSize = CGSizeMake(titleEdgeInsets.left + titleRect->size.width + titleEdgeInsets.right, titleEdgeInsets.top + titleRect->size.height + titleEdgeInsets.bottom);
    CGSize fullSize = CGSizeMake(fullImageSize.width + fullTitleSize.width, fullImageSize.height + fullTitleSize.height);
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
}

- (void)_updateCurrentState {
    self.backgroundColor = [self currentBackgroundColor];
    self.glb_borderColor = [self currentBorderColor];
    self.glb_borderWidth = [self currentBorderWidth];
    self.glb_cornerRadius = [self currentCornerRadius];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
