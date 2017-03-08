/*--------------------------------------------------*/

#import "GLBBadgeView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
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
    self.backgroundColor = UIColor.redColor;
    self.glb_cornerRadius = 9;
    self.clipsToBounds = YES;
    self.glb_horizontalContentHuggingPriority = UILayoutPriorityRequired;
    self.glb_verticalContentHuggingPriority = UILayoutPriorityRequired;
    
    _textInsets = UIEdgeInsetsMake(0, 4, 0, 4);
    _minimumSize = CGSizeMake(18, 18);
    _maximumSize = CGSizeMake((_minimumSize.width * 3), _minimumSize.height);
    
    _textLabel = [[GLBLabel alloc] initWithFrame:UIEdgeInsetsInsetRect(self.bounds, _textInsets)];
    _textLabel.translatesAutoresizingMaskIntoConstraints = self.translatesAutoresizingMaskIntoConstraints;
    _textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.backgroundColor = UIColor.clearColor;
    [self addSubview:_textLabel];
}

#pragma mark - Public override

- (CGSize)sizeThatFits:(CGSize)size {
    if(self.translatesAutoresizingMaskIntoConstraints == NO) {
        return [super sizeThatFits:size];
    }
    CGSize available = CGSizeMake(size.width, size.height);
    if(_minimumSize.width > 0.0) {
        available.width = MAX(_minimumSize.width, available.width);
    }
    if(_minimumSize.height > 0.0) {
        available.height = MAX(_minimumSize.height, available.height);
    }
    if(_maximumSize.width > 0.0) {
        available.width = MIN(_maximumSize.width, available.width);
    }
    if(_maximumSize.height > 0.0) {
        available.height = MIN(_maximumSize.height, available.height);
    }
    CGSize result = [_textLabel sizeThatFits:CGSizeMake(available.width - (_textInsets.left + _textInsets.right), available.height - (_textInsets.top + _textInsets.bottom))];
    result.width += (_textInsets.left + _textInsets.right);
    result.height += (_textInsets.top + _textInsets.bottom);
    if(_minimumSize.width > 0.0) {
        result.width = MAX(_minimumSize.width, result.width);
    }
    if(_minimumSize.height > 0.0) {
        result.height = MAX(_minimumSize.height, result.height);
    }
    if(_maximumSize.width > 0.0) {
        result.width = MIN(_maximumSize.width, result.width);
    }
    if(_maximumSize.height > 0.0) {
        result.height = MIN(_maximumSize.height, result.height);
    }
    return result;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if(self.translatesAutoresizingMaskIntoConstraints == YES) {
        _textLabel.frame = UIEdgeInsetsInsetRect(self.bounds, _textInsets);
    }
}

- (void)updateConstraints {
    [self glb_removeAllConstraints];
    
    if(self.translatesAutoresizingMaskIntoConstraints == NO) {
        [_textLabel glb_addConstraintEdgeInsets:_textInsets];
        if(_minimumSize.width > 0.0) {
            [_textLabel glb_addConstraintWidth:_minimumSize.width relation:NSLayoutRelationGreaterThanOrEqual];
        }
        if(_maximumSize.width > 0.0) {
            [_textLabel glb_addConstraintWidth:_maximumSize.width relation:NSLayoutRelationLessThanOrEqual];
        }
        if(_minimumSize.height > 0.0) {
            [_textLabel glb_addConstraintHeight:_minimumSize.height relation:NSLayoutRelationGreaterThanOrEqual];
        }
        if(_maximumSize.height > 0.0) {
            [_textLabel glb_addConstraintHeight:_maximumSize.height relation:NSLayoutRelationLessThanOrEqual];
        }
    }
    [super updateConstraints];
}

#pragma mark - Property override

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self _updateCorners];
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    [self _updateCorners];
}

- (void)setTranslatesAutoresizingMaskIntoConstraints:(BOOL)translatesAutoresizingMaskIntoConstraints {
    if(self.translatesAutoresizingMaskIntoConstraints != translatesAutoresizingMaskIntoConstraints) {
        [super setTranslatesAutoresizingMaskIntoConstraints:translatesAutoresizingMaskIntoConstraints];
        if(_textLabel != nil) {
            _textLabel.translatesAutoresizingMaskIntoConstraints = self.translatesAutoresizingMaskIntoConstraints;
        }
        [self setNeedsUpdateConstraints];
        [self setNeedsLayout];
    }
}

#pragma mark - Property public

- (void)setTextInsets:(UIEdgeInsets)textInsets {
    if(UIEdgeInsetsEqualToEdgeInsets(_textInsets, textInsets) == NO) {
        _textInsets = textInsets;
        if(self.translatesAutoresizingMaskIntoConstraints == NO) {
            [self setNeedsUpdateConstraints];
        }
    }
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

#pragma mark - Private

- (void)_updateCorners {
    CGRect bounds = self.bounds;
    self.glb_cornerRadius = GLB_CEIL(MIN(bounds.size.width - 1, bounds.size.height - 1) / 2);
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
