/*--------------------------------------------------*/

#import "GLBTextView.h"
#import "GLBInputForm.h"
#import "GLBInputValidator.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import "UIResponder+GLBUI.h"
#import "UIView+GLBUI.h"

/*--------------------------------------------------*/

static const CGFloat GLBTextField_Duration = 0.2f;
static const CGFloat GLBTextField_ToolbarHeight = 44.0f;

/*--------------------------------------------------*/

@interface GLBTextView ()

@property(nonatomic, weak) UIResponder* prevInputResponder;
@property(nonatomic, weak) UIResponder* nextInputResponder;

- (void)pressedPrev;
- (void)pressedNext;
- (void)pressedDone;
 
@end

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

#pragma mark - Property

- (void)setContentInset:(UIEdgeInsets)contentInset {
    [super setContentInset:contentInset];
    [self setNeedsDisplay];
}

- (void)setText:(NSString*)string {
    [super setText:string];
    if(self.isEditing == NO) {
        [self validate];
    }
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString*)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont*)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString*)string {
    if([string isEqualToString:self.attributedPlaceholder.string] == NO) {
        NSMutableDictionary* attributes = [[NSMutableDictionary alloc] init];
        if(([self isFirstResponder] == YES) && (self.typingAttributes != nil)) {
            [attributes addEntriesFromDictionary:self.typingAttributes];
        } else {
            attributes[NSFontAttributeName] = (self.placeholderFont != nil) ? self.placeholderFont : self.font;
            attributes[NSForegroundColorAttributeName] = (self.placeholderColor != nil) ? self.placeholderColor : [UIColor colorWithRed:170.0f/255 green:170.0f/255 blue:170.0f/255 alpha:1.0f];
            if(self.textAlignment != NSTextAlignmentLeft) {
                NSMutableParagraphStyle* paragraph = [[NSMutableParagraphStyle alloc] init];
                paragraph.alignment = self.textAlignment;
                attributes[NSParagraphStyleAttributeName] = paragraph;
            }
        }
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:string attributes:attributes];
        [self setNeedsDisplay];
    }
}

- (NSString*)placeholder {
    return self.attributedPlaceholder.string;
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
    if([_attributedPlaceholder isEqualToAttributedString:attributedPlaceholder] == NO) {
        _attributedPlaceholder = attributedPlaceholder;
        [self setNeedsDisplay];
    }
}

- (void)setForm:(GLBInputForm*)form {
    if([_form isEqual:form] == NO) {
        _form = form;
        [self validate];
    }
}

- (void)setValidator:(id< GLBInputValidator >)validator {
    if([_validator isEqual:validator] == NO) {
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

#pragma mark - Public override

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if((self.attributedPlaceholder != nil) && (self.text.length < 1)) {
        [self.attributedPlaceholder drawInRect:[self placeholderRectForBounds:self.bounds]];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    if((self.attributedPlaceholder != nil) && (self.text.length < 1)) {
        [self setNeedsDisplay];
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
            CGFloat toolbarHeight = (self.hiddenToolbar == NO) ? GLBTextField_ToolbarHeight : 0.0f;
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
    if(self.toolbar == nil) {
        CGRect windowBounds = self.window.bounds;
        self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(windowBounds.origin.x, windowBounds.origin.y, windowBounds.size.width, GLBTextField_ToolbarHeight)];
        self.prevButton = [[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(pressedPrev)];
        self.nextButton = [[UIBarButtonItem alloc] initWithTitle:@">" style:UIBarButtonItemStylePlain target:self action:@selector(pressedNext)];
        self.flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        self.doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pressedDone)];
        
        self.toolbar.barStyle = UIBarStyleDefault;
        self.toolbar.clipsToBounds = YES;
    }
    if(self.toolbar != nil) {
        self.prevInputResponder = [UIResponder glb_prevResponderFromView:self];
        self.nextInputResponder = [UIResponder glb_nextResponderFromView:self];
        if(self.hiddenToolbarArrows == YES) {
            self.toolbar.items = @[ self.flexButton, self.doneButton ];
        } else {
            self.toolbar.items = @[ self.prevButton, self.nextButton, self.flexButton, self.doneButton ];
        }
        self.prevButton.enabled = (self.prevInputResponder != nil);
        self.nextButton.enabled = (self.nextInputResponder != nil);
        self.toolbar.glb_frameHeight = (self.hiddenToolbar == NO) ? GLBTextField_ToolbarHeight : 0.0f;
        self.inputAccessoryView = self.toolbar;
        [self reloadInputViews];
    }
}

- (void)didValueChanged {
    [self setNeedsDisplay];
    [self validate];
}

- (void)didEndEditing {
    self.prevInputResponder = nil;
    self.nextInputResponder = nil;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect rect = UIEdgeInsetsInsetRect(bounds, self.contentInset);
    if([self respondsToSelector:@selector(textContainer)] == YES) {
        rect = UIEdgeInsetsInsetRect(rect, self.textContainerInset);
        CGFloat padding = self.textContainer.lineFragmentPadding;
        rect.origin.x += padding;
        rect.size.width -= padding * 2.0f;
    } else {
        if(self.contentInset.left == 0.0f) {
            rect.origin.x += 8.0f;
        }
        rect.origin.y += 8.0f;
    }
    return rect;
}

#pragma mark - GLBInputField

- (void)validate {
    if((self.form != nil) && (self.validator != nil)) {
        [self.form performValidator:self.validator value:self.text];
    }
}

- (NSArray*)messages {
    if((self.form != nil) && (self.validator != nil)) {
        return [self.validator messages:self.text];
    }
    return @[];
}

#pragma mark - Private

- (void)pressedPrev {
    if(self.prevInputResponder != nil) {
        [self.prevInputResponder becomeFirstResponder];
    }
}

- (void)pressedNext {
    if(self.nextInputResponder != nil) {
        [self.nextInputResponder becomeFirstResponder];
    }
}

- (void)pressedDone {
    [self endEditing:NO];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
