/*--------------------------------------------------*/

#import "GLBTextField.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

static const CGFloat GLBTextField_Duration = 0.2f;
static const CGFloat GLBTextField_ToolbarHeight = 44;

/*--------------------------------------------------*/

@interface GLBTextField () {
    NSMutableAttributedString* _attributedPlaceholder;
    UIResponder* _prevInputResponder;
    UIResponder* _nextInputResponder;
}

@end

/*--------------------------------------------------*/

@implementation GLBTextField

#pragma mark - Synthesize

@synthesize form = _form;
@synthesize validator = _validator;

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
    _textInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _attributedPlaceholder = [NSMutableAttributedString new];
    _toolbarHeight = GLBTextField_ToolbarHeight;
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didBeginEditing) name:UITextFieldTextDidBeginEditingNotification object:self];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didEndEditing) name:UITextFieldTextDidEndEditingNotification object:self];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didValueChanged) name:UITextFieldTextDidChangeNotification object:self];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

#pragma mark - Property override

- (void)setText:(NSString*)text {
    [super setText:text];
    if(self.isEditing == NO) {
        [self validate];
    }
}

- (void)setAttributedText:(NSAttributedString*)attributedText {
    [super setAttributedText:attributedText];
    if(self.isEditing == NO) {
        [self validate];
    }
}

- (void)setPlaceholder:(NSString*)placeholder {
    if([_attributedPlaceholder.string isEqualToString:placeholder] == NO) {
        if(placeholder != nil) {
            [_attributedPlaceholder setAttributedString:[[NSAttributedString alloc] initWithString:placeholder]];
        } else {
            [_attributedPlaceholder deleteCharactersInRange:NSMakeRange(0, _attributedPlaceholder.length)];
        }
        [self __updateAttributedPlaceholder];
    }
}

- (void)setAttributedPlaceholder:(NSAttributedString*)attributedPlaceholder {
    if([_attributedPlaceholder isEqualToAttributedString:attributedPlaceholder] == NO) {
        if(attributedPlaceholder != nil) {
            [_attributedPlaceholder setAttributedString:attributedPlaceholder];
        } else {
            [_attributedPlaceholder deleteCharactersInRange:NSMakeRange(0, _attributedPlaceholder.length)];
        }
        [self __updateAttributedPlaceholder];
    }
}

#pragma mark - Property

- (void)setTextStyle:(GLBTextStyle*)textStyle {
    _textStyle = textStyle;
    if(_textStyle != nil) {
        NSDictionary* attributes = _textStyle.attributes;
        self.font = attributes[NSFontAttributeName];
        self.textColor = attributes[NSForegroundColorAttributeName];
        self.defaultTextAttributes = attributes;
    } else {
        self.defaultTextAttributes = @{
            NSFontAttributeName: self.font,
            NSForegroundColorAttributeName: self.textColor
        };
    }
}

- (void)setPlaceholderStyle:(GLBTextStyle*)placeholderStyle {
    _placeholderStyle = placeholderStyle;
    [self __updateAttributedPlaceholder];
}

- (void)setForm:(GLBInputForm*)form {
    if(_form != form) {
        _form = form;
        [self validate];
    }
}

- (void)setValidator:(id< GLBInputValidator >)validator {
    if(_validator != validator) {
        if(_validator != nil) {
            _validator.field = nil;
        }
        _validator = validator;
        if(_validator != nil) {
            _validator.field = self;
        }
        [self validate];
    }
}

- (void)setHiddenToolbar:(BOOL)hiddenToolbar {
    [self setHiddenToolbar:hiddenToolbar animated:NO];
}

- (void)setHiddenToolbarArrows:(BOOL)hiddenToolbarArrows {
    if(_hiddenToolbarArrows != hiddenToolbarArrows) {
        _hiddenToolbarArrows = hiddenToolbarArrows;
        if([self isEditing] == YES) {
            if(self.hiddenToolbarArrows == YES) {
                self.toolbar.items = @[ self.flexButton, self.doneButton ];
            } else {
                self.toolbar.items = @[ self.prevButton, self.nextButton, self.flexButton, self.doneButton ];
            }
        }
    }
}

- (void)setToolbarHeight:(CGFloat)toolbarHeight {
    if(_toolbarHeight != toolbarHeight) {
        _toolbarHeight = toolbarHeight;
        if(_toolbar != nil) {
            _toolbar.glb_frameHeight = _toolbarHeight;
        }
    }
}

- (UIToolbar*)toolbar {
    if(_toolbar == nil) {
        CGRect windowBounds = self.window.bounds;
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(windowBounds.origin.x, windowBounds.origin.y, windowBounds.size.width, _toolbarHeight)];
        _toolbar.barStyle = UIBarStyleDefault;
        _toolbar.clipsToBounds = YES;
    }
    return _toolbar;
}

- (UIBarButtonItem*)prevButton {
    if(_prevButton == nil) {
        _prevButton = [[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(__pressedPrev)];
    }
    return _prevButton;
}

- (UIBarButtonItem*)nextButton {
    if(_nextButton == nil) {
        _nextButton = [[UIBarButtonItem alloc] initWithTitle:@">" style:UIBarButtonItemStylePlain target:self action:@selector(__pressedNext)];
    }
    return _nextButton;
}

- (UIBarButtonItem*)flexButton {
    if(_flexButton == nil) {
        _flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    }
    return _flexButton;
}

- (UIBarButtonItem*)doneButton {
    if(_doneButton == nil) {
        _doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(__pressedDone)];
    }
    return _doneButton;
}

#pragma mark - Public

- (void)setHiddenToolbar:(BOOL)hiddenToolbar animated:(BOOL)animated {
    if(_hiddenToolbar != hiddenToolbar) {
        _hiddenToolbar = hiddenToolbar;
        
        if([self isEditing] == YES) {
            CGFloat toolbarHeight = (_hiddenToolbar == NO) ? _toolbarHeight : 0;
            if(animated == YES) {
                [UIView animateWithDuration:GLBTextField_Duration
                                 animations:^{
                                     self.toolbar.glb_frameHeight = toolbarHeight;
                                 }];
            } else {
                self.toolbar.glb_frameHeight = toolbarHeight;
            }
        }
    }
}

- (void)didBeginEditing {
    if(self.toolbar != nil) {
        _prevInputResponder = [UIResponder glb_prevResponderFromView:self];
        _nextInputResponder = [UIResponder glb_nextResponderFromView:self];
        if(self.hiddenToolbarArrows == YES) {
            self.toolbar.items = @[ self.flexButton, self.doneButton ];
        } else {
            self.toolbar.items = @[ self.prevButton, self.nextButton, self.flexButton, self.doneButton ];
        }
        self.prevButton.enabled = (_prevInputResponder != nil);
        self.nextButton.enabled = (_nextInputResponder != nil);
        self.toolbar.glb_frameHeight = (self.hiddenToolbar == NO) ? self.toolbarHeight : 0;
        self.inputAccessoryView = self.toolbar;
        [self reloadInputViews];
    }
}

- (void)didValueChanged {
    [self validate];
}

- (void)didEndEditing {
    _prevInputResponder = nil;
    _nextInputResponder = nil;
}

#pragma mark - Public override

- (CGRect)textRectForBounds:(CGRect)bounds {
    return UIEdgeInsetsInsetRect(bounds, _textInsets);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return UIEdgeInsetsInsetRect(bounds, _textInsets);
}

#pragma mark - GLBInputField

- (void)validate {
    if((_form != nil) && (_validator != nil)) {
        [_form performValidator:_validator value:self.text];
    }
}

- (NSArray*)messages {
    if((_form != nil) && (_validator != nil)) {
        return [_validator messages:self.text];
    }
    return @[];
}

#pragma mark - Private

- (void)__updateAttributedPlaceholder {
    NSMutableAttributedString* result = [[NSMutableAttributedString alloc] initWithAttributedString:_attributedPlaceholder];
    if(_placeholderStyle != nil) {
        [result setAttributes:_placeholderStyle.attributes range:NSMakeRange(0, result.string.length)];
    }
    [super setAttributedPlaceholder:result];
}

- (void)__pressedPrev {
    if(_prevInputResponder != nil) {
        [_prevInputResponder becomeFirstResponder];
    }
}

- (void)__pressedNext {
    if(_nextInputResponder != nil) {
        [_nextInputResponder becomeFirstResponder];
    }
}

- (void)__pressedDone {
    [self endEditing:NO];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
