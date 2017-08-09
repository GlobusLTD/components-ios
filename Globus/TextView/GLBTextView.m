/*--------------------------------------------------*/

#import "GLBTextView.h"
#import "GLBInputForm.h"
#import "GLBInputValidator.h"

/*--------------------------------------------------*/

#import "NSString+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBTextView () < UITextViewDelegate > {
    NSMutableAttributedString* _displayAttributedPlaceholder;
    UIResponder* _prevInputResponder;
    UIResponder* _nextInputResponder;
}

@end

/*--------------------------------------------------*/

static const CGFloat GLBTextView_Duration = 0.2f;
static const CGFloat GLBTextView_ToolbarHeight = 44;

/*--------------------------------------------------*/

@implementation GLBTextView

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
    self.delegate = self;
    
    _displayAttributedPlaceholder = [NSMutableAttributedString new];
    _toolbarHeight = GLBTextView_ToolbarHeight;
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didBeginEditing) name:UITextViewTextDidBeginEditingNotification object:self];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didEndEditing) name:UITextViewTextDidEndEditingNotification object:self];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didValueChanged) name:UITextViewTextDidChangeNotification object:self];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

#pragma mark - Public override

- (void)insertText:(NSString*)string {
    [super insertText:string];
    [self setNeedsDisplay];
}

#pragma mark - Override property

- (void)setContentInset:(UIEdgeInsets)contentInset {
    [super setContentInset:contentInset];
    [self __updateHeight];
    [self setNeedsDisplay];
}

- (void)setText:(NSString*)string {
    [super setText:string];
    if(self.isEditing == NO) {
        [self validate];
    }
    [self __updateHeight];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString*)attributedText {
    [super setAttributedText:attributedText];
    if(self.isEditing == NO) {
        [self validate];
    }
    [self __updateHeight];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont*)font {
    [super setFont:font];
    [self __updateHeight];
    [self setNeedsDisplay];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    [self __updateHeight];
    [self setNeedsDisplay];
}

#pragma mark - Public property

- (void)setPlaceholder:(NSString*)placeholder {
    if([placeholder isEqualToString:_attributedPlaceholder.string] == NO) {
        if(placeholder != nil) {
            NSMutableDictionary* attributes = [NSMutableDictionary new];
            if(([self isFirstResponder] == YES) && (self.typingAttributes != nil)) {
                [attributes addEntriesFromDictionary:self.typingAttributes];
            } else {
                attributes[NSFontAttributeName] = (_placeholderFont != nil) ? _placeholderFont : self.font;
                attributes[NSForegroundColorAttributeName] = (_placeholderColor != nil) ? _placeholderColor : [UIColor colorWithRed:(CGFloat)(170.0 / 255.0) green:(CGFloat)(170.0 / 255.0) blue:(CGFloat)(170.0 / 255.0) alpha:(CGFloat)(1.0)];
                if(self.textAlignment != NSTextAlignmentLeft) {
                    NSMutableParagraphStyle* paragraph = [NSMutableParagraphStyle new];
                    paragraph.alignment = self.textAlignment;
                    attributes[NSParagraphStyleAttributeName] = paragraph;
                }
            }
            _attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:attributes];
        } else {
            _attributedPlaceholder = nil;
        }
        [self __updateAttributedPlaceholder];
    }
}

- (NSString*)placeholder {
    return _attributedPlaceholder.string;
}

- (void)setAttributedPlaceholder:(NSAttributedString*)attributedPlaceholder {
    if([_attributedPlaceholder isEqualToAttributedString:attributedPlaceholder] == NO) {
        _attributedPlaceholder = attributedPlaceholder;
        [self __updateAttributedPlaceholder];
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
        if(self.isEditing == YES) {
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

#pragma mark - Public override

- (void)didMoveToWindow {
    [super didMoveToWindow];
    
    if(self.window != nil) {
        [self __updateHeight];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if(self.text.length < 1) {
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if(self.text.length < 1) {
        [_displayAttributedPlaceholder drawInRect:[self placeholderRectForBounds:self.bounds]];
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if(action == @selector(paste:)) {
        NSString* string = UIPasteboard.generalPasteboard.string;
        return (string.length > 0);
    }
    return [super canPerformAction:action withSender:sender];
}

#pragma mark - Public

- (void)setHiddenToolbar:(BOOL)hiddenToolbar animated:(BOOL)animated {
    if(_hiddenToolbar != hiddenToolbar) {
        _hiddenToolbar = hiddenToolbar;
        
        if(self.isEditing == YES) {
            CGFloat toolbarHeight = (self.hiddenToolbar == NO) ? _toolbarHeight : 0;
            if(animated == YES) {
                [UIView animateWithDuration:GLBTextView_Duration
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
        self.toolbar.glb_frameHeight = (self.hiddenToolbar == NO) ? _toolbarHeight : 0;
        self.inputAccessoryView = self.toolbar;
        [self reloadInputViews];
    }
    if(_actionBeginEditing != nil) {
        [_actionBeginEditing performWithArguments:@[ self ]];
    }
}

- (void)didValueChanged {
    if(_actionValueChanged != nil) {
        [_actionValueChanged performWithArguments:@[ self ]];
    }
    [self validate];
    [self setNeedsDisplay];
}

- (void)didEndEditing {
    _prevInputResponder = nil;
    _nextInputResponder = nil;
    if(_actionEndEditing != nil) {
        [_actionEndEditing performWithArguments:@[ self ]];
    }
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect rect = UIEdgeInsetsInsetRect(bounds, self.contentInset);
    rect = UIEdgeInsetsInsetRect(rect, self.textContainerInset);
    CGFloat padding = self.textContainer.lineFragmentPadding;
    rect.origin.x += padding;
    rect.size.width -= padding * 2;
    return rect;
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

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text {
    BOOL result = YES;
    if((_maximumNumberOfCharecters > 0) || (_maximumNumberOfLines > 0)) {
        NSString* newText = [self.text stringByReplacingCharactersInRange:range withString:text];
        if(_maximumNumberOfCharecters > 0) {
            if(newText.length > _maximumNumberOfCharecters) {
                result = NO;
            }
        }
        if(_maximumNumberOfLines > 0) {
            UIFont* font = self.font;
            NSTextContainer* textContainer = self.textContainer;
            CGFloat allowTextWidth = CGRectGetWidth(UIEdgeInsetsInsetRect(self.frame, self.textContainerInset));
            allowTextWidth -= 2.0 * textContainer.lineFragmentPadding;
            CGSize newTextSize = [newText glb_sizeWithFont:font forWidth:allowTextWidth lineBreakMode:textContainer.lineBreakMode];
            if(newTextSize.height / font.lineHeight > _maximumNumberOfLines) {
                result = NO;
            }
        }
    }
    return result;
}

- (void)textViewDidChange:(UITextView*)textView {
    [self __updateHeight];
}

#pragma mark - Private

- (void)__updateAttributedPlaceholder {
    [_displayAttributedPlaceholder deleteCharactersInRange:NSMakeRange(0, _displayAttributedPlaceholder.string.length)];
    if(_attributedPlaceholder != nil) {
        [_displayAttributedPlaceholder appendAttributedString:_attributedPlaceholder];
    }
    if(_placeholderStyle != nil) {
        [_displayAttributedPlaceholder setAttributes:_placeholderStyle.attributes range:NSMakeRange(0, _displayAttributedPlaceholder.string.length)];
    }
    [self setNeedsDisplay];
}

- (void)__updateHeight {
    if(((_minimumHeight > 0) || (_maximumHeight > 0)) && (_constraintHeight != nil)) {
        CGRect textRect = [self.layoutManager usedRectForTextContainer:self.textContainer];
        UIEdgeInsets textInsets = self.textContainerInset;
        CGFloat textHeight = textRect.size.height + textInsets.top + textInsets.bottom;
        if(_minimumHeight > 0) {
            CGFloat limit = (_maximumHeight > 0) ? MIN(_minimumHeight, _maximumHeight) : _minimumHeight;
            textHeight = MAX(textHeight, limit);
        }
        if(_maximumHeight > 0) {
            CGFloat limit = (_minimumHeight > 0) ? MAX(_minimumHeight, _maximumHeight) : _maximumHeight;
            textHeight = MIN(textHeight, limit);
        }
        if(_constraintHeight.constant != textHeight) {
            _constraintHeight.constant = textHeight;
            if(_actionHeightChanged != nil) {
                [_actionHeightChanged performWithArguments:@[ self, @(textHeight) ]];
            } else {
                [UIView animateWithDuration:GLBTextView_Duration animations:^{
                    [self.superview layoutIfNeeded];
                    [self scrollRangeToVisible:self.selectedRange];
                }];
            }
        } else {
            [self scrollRangeToVisible:self.selectedRange];
        }
    }
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
