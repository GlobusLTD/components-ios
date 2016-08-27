/*--------------------------------------------------*/

#import "GLBBadgeView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/

@interface GLBBadgeView ()

@property(nonatomic, strong) UILabel* label;
@property(nonatomic, strong) NSLayoutConstraint* constraintLabelTop;
@property(nonatomic, strong) NSLayoutConstraint* constraintLabelBottom;
@property(nonatomic, strong) NSLayoutConstraint* constraintLabelLeft;
@property(nonatomic, strong) NSLayoutConstraint* constraintLabelRight;
@property(nonatomic, strong) NSLayoutConstraint* constraintMinWidth;
@property(nonatomic, strong) NSLayoutConstraint* constraintMinHeight;
@property(nonatomic, strong) NSLayoutConstraint* constraintMaxWidth;
@property(nonatomic, strong) NSLayoutConstraint* constraintMaxHeight;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBBadgeView

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
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor redColor];
    self.glb_cornerRadius = 9.0;
    self.clipsToBounds = YES;
    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    _textInsets = UIEdgeInsetsMake(0, 4, 0, 4);
    _minimumSize = CGSizeMake(18, 18);
    _maximumSize = CGSizeMake((_minimumSize.width * 3), _minimumSize.height);
    
    self.label = [[UILabel alloc] initWithFrame:UIEdgeInsetsInsetRect(self.bounds, _textInsets)];
}

#pragma mark - Public override

- (CGSize)sizeThatFits:(CGSize)size {
    if(self.translatesAutoresizingMaskIntoConstraints == NO) {
        return [super sizeThatFits:size];
    }
    CGSize available = CGSizeMake(size.width, size.height);
    if(self.minimumSize.width > 0.0) {
        available.width = MAX(self.minimumSize.width, available.width);
    }
    if(self.minimumSize.height > 0.0) {
        available.height = MAX(self.minimumSize.height, available.height);
    }
    if(self.maximumSize.width > 0.0) {
        available.width = MIN(self.maximumSize.width, available.width);
    }
    if(self.maximumSize.height > 0.0) {
        available.height = MIN(self.maximumSize.height, available.height);
    }
    CGSize result = [self.label sizeThatFits:CGSizeMake(available.width - (self.textInsets.left + self.textInsets.right), available.height - (self.textInsets.top + self.textInsets.bottom))];
    result.width += (self.textInsets.left + self.textInsets.right);
    result.height += (self.textInsets.top + self.textInsets.bottom);
    if(self.minimumSize.width > 0.0) {
        result.width = MAX(self.minimumSize.width, result.width);
    }
    if(self.minimumSize.height > 0.0) {
        result.height = MAX(self.minimumSize.height, result.height);
    }
    if(self.maximumSize.width > 0.0) {
        result.width = MIN(self.maximumSize.width, result.width);
    }
    if(self.maximumSize.height > 0.0) {
        result.height = MIN(self.maximumSize.height, result.height);
    }
    return result;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if(self.translatesAutoresizingMaskIntoConstraints == YES) {
        self.label.frame = UIEdgeInsetsInsetRect(self.bounds, self.textInsets);
    }
}

- (void)updateConstraints {
    if(self.translatesAutoresizingMaskIntoConstraints == NO) {
        if(self.label != nil) {
            if(self.constraintLabelTop == nil) {
                self.constraintLabelTop = [self.label glb_addConstraintAttribute:NSLayoutAttributeTop
                                                                        relation:NSLayoutRelationEqual
                                                                       attribute:NSLayoutAttributeTop
                                                                        constant:self.textInsets.top];
            } else {
                self.constraintLabelTop.constant = self.textInsets.top;
            }
            if(self.constraintLabelBottom == nil) {
                self.constraintLabelBottom = [self.label glb_addConstraintAttribute:NSLayoutAttributeBottom
                                                                           relation:NSLayoutRelationEqual
                                                                          attribute:NSLayoutAttributeBottom
                                                                           constant:-self.textInsets.bottom];
            } else {
                self.constraintLabelBottom.constant = -self.textInsets.bottom;
            }
            if(self.constraintLabelLeft == nil) {
                self.constraintLabelLeft = [self.label glb_addConstraintAttribute:NSLayoutAttributeLeft
                                                                         relation:NSLayoutRelationEqual
                                                                        attribute:NSLayoutAttributeLeft
                                                                         constant:self.textInsets.left];
            } else {
                self.constraintLabelLeft.constant = self.textInsets.left;
            }
            if(self.constraintLabelRight == nil) {
                self.constraintLabelRight = [self.label glb_addConstraintAttribute:NSLayoutAttributeRight
                                                                          relation:NSLayoutRelationEqual
                                                                         attribute:NSLayoutAttributeRight
                                                                          constant:-self.textInsets.right];
            } else {
                self.constraintLabelRight.constant = -self.textInsets.right;
            }
        } else {
            self.constraintLabelTop = nil;
            self.constraintLabelBottom = nil;
            self.constraintLabelLeft = nil;
            self.constraintLabelRight = nil;
        }
        if(self.minimumSize.width > 0.0) {
            if(self.constraintMinWidth == nil) {
                self.constraintMinWidth = [self glb_addConstraintAttribute:NSLayoutAttributeWidth
                                                                  relation:NSLayoutRelationGreaterThanOrEqual
                                                                  constant:self.minimumSize.width];
            } else {
                self.constraintMinWidth.constant = self.minimumSize.width;
            }
        } else {
            self.constraintMinWidth = nil;
        }
        if(self.maximumSize.width > 0.0) {
            if(self.constraintMaxWidth == nil) {
                self.constraintMaxWidth = [self glb_addConstraintAttribute:NSLayoutAttributeWidth
                                                                  relation:NSLayoutRelationLessThanOrEqual
                                                                  constant:self.maximumSize.width];
            } else {
                self.constraintMaxWidth.constant = self.maximumSize.width;
            }
        } else {
            self.constraintMaxWidth = nil;
        }
        if(self.minimumSize.height > 0.0) {
            if(self.constraintMinHeight == nil) {
                self.constraintMinHeight = [self glb_addConstraintAttribute:NSLayoutAttributeHeight
                                                                   relation:NSLayoutRelationGreaterThanOrEqual
                                                                   constant:self.minimumSize.height];
            } else {
                self.constraintMinHeight.constant = self.minimumSize.height;
            }
        } else {
            self.constraintMinHeight = nil;
        }
        if(self.maximumSize.height > 0.0) {
            if(self.constraintMaxHeight == nil) {
                self.constraintMaxHeight = [self glb_addConstraintAttribute:NSLayoutAttributeHeight
                                                                   relation:NSLayoutRelationLessThanOrEqual
                                                                   constant:self.maximumSize.height];
            } else {
                self.constraintMaxHeight.constant = self.maximumSize.height;
            }
        } else {
            self.constraintMaxHeight = nil;
        }
    } else {
        self.constraintLabelTop = nil;
        self.constraintLabelBottom = nil;
        self.constraintLabelLeft = nil;
        self.constraintLabelRight = nil;
        self.constraintMinWidth = nil;
        self.constraintMaxWidth = nil;
        self.constraintMinHeight = nil;
        self.constraintMaxHeight = nil;
    }
    [super updateConstraints];
}

#pragma mark - Property override

- (void)setTranslatesAutoresizingMaskIntoConstraints:(BOOL)translatesAutoresizingMaskIntoConstraints {
    if(self.translatesAutoresizingMaskIntoConstraints != translatesAutoresizingMaskIntoConstraints) {
        [super setTranslatesAutoresizingMaskIntoConstraints:translatesAutoresizingMaskIntoConstraints];
        if(self.label != nil) {
            self.label.translatesAutoresizingMaskIntoConstraints = self.translatesAutoresizingMaskIntoConstraints;
        }
        [self setNeedsUpdateConstraints];
        [self setNeedsLayout];
    }
}

#pragma mark - Property public

- (void)setText:(NSString*)text {
    self.label.text = text;
    self.hidden = (text == nil);
}

- (NSString*)text {
    return self.label.text;
}

- (void)setTextInsets:(UIEdgeInsets)textInsets {
    if(UIEdgeInsetsEqualToEdgeInsets(_textInsets, textInsets) == NO) {
        _textInsets = textInsets;
        [self setNeedsUpdateConstraints];
    }
}

- (void)setTextColor:(UIColor*)textColor {
    self.label.textColor = textColor;
}

- (UIColor*)textColor {
    return self.label.textColor;
}

- (void)setTextFont:(UIFont*)textFont {
    self.label.font = textFont;
}

- (UIFont*)textFont {
    return self.label.font;
}

- (void)setTextShadowColor:(UIColor*)textShadowColor {
    self.label.glb_shadowColor = textShadowColor;
}

- (UIColor*)textShadowColor {
    return self.label.glb_shadowColor;
}

- (void)setTextShadowRadius:(CGFloat)textShadowRadius {
    self.label.glb_shadowRadius = textShadowRadius;
}

- (CGFloat)textShadowRadius {
    return self.label.glb_shadowRadius;
}

- (void)setTextShadowOffset:(CGSize)textShadowOffset {
    self.label.glb_shadowOffset = textShadowOffset;
}

- (CGSize)textShadowOffset {
    return self.label.glb_shadowOffset;
}

- (void)setMinimumSize:(CGSize)minimumSize {
    if(CGSizeEqualToSize(_minimumSize, minimumSize) == NO) {
        _minimumSize = minimumSize;
        [self setNeedsUpdateConstraints];
    }
}

- (void)setMaximumSize:(CGSize)maximumSize {
    if(CGSizeEqualToSize(_maximumSize, maximumSize) == NO) {
        _maximumSize = maximumSize;
        [self setNeedsUpdateConstraints];
    }
}

#pragma mark - Property private

- (void)setLabel:(UILabel*)label {
    if(_label != label) {
        if(_label != nil) {
            [_label removeFromSuperview];
        }
        _label = label;
        if(_label != nil) {
            _label.translatesAutoresizingMaskIntoConstraints = self.translatesAutoresizingMaskIntoConstraints;
            _label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            _label.textAlignment = NSTextAlignmentCenter;
            _label.font = [UIFont systemFontOfSize:12.0];
            _label.textColor = [UIColor whiteColor];
            [self addSubview:_label];
        }
        [self setNeedsUpdateConstraints];
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
