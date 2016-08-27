/*--------------------------------------------------*/

#import "GLBTextField.h"
#import "GLBInputForm.h"
#import "GLBInputValidator.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import "UIResponder+GLBUI.h"
#import "UIView+GLBUI.h"

/*--------------------------------------------------*/

static const CGFloat GLBTextField_Duration = 0.2f;
static const CGFloat GLBTextField_ToolbarHeight = 44;

/*--------------------------------------------------*/

@interface GLBTextField ()

@property(nonatomic, weak) UIResponder* prevInputResponder;
@property(nonatomic, weak) UIResponder* nextInputResponder;

@property(nonatomic) NSInteger prevPhoneDigitsCount;
@property(nonatomic) NSInteger formatDigitsCount;
@property(nonatomic, strong) NSString* phonePrefixWithoutSpaces;

- (void)pressedPrev;
- (void)pressedNext;
- (void)pressedDone;
 
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
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didBeginEditing) name:UITextFieldTextDidBeginEditingNotification object:self];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didEndEditing) name:UITextFieldTextDidEndEditingNotification object:self];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didValueChanged) name:UITextFieldTextDidChangeNotification object:self];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

#pragma mark - Property

- (void)setText:(NSString*)string {
    [super setText:string];
    if(self.isEditing == NO) {
        [self validate];
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
        if([self isEditing] == YES) {
            if(self.hiddenToolbarArrows == YES) {
                self.toolbar.items = @[ self.flexButton, self.doneButton ];
            } else {
                self.toolbar.items = @[ self.prevButton, self.nextButton, self.flexButton, self.doneButton ];
            }
        }
    }
}

#pragma mark - Public

- (void)setHiddenToolbar:(BOOL)hiddenToolbar animated:(BOOL)animated {
    if(_hiddenToolbar != hiddenToolbar) {
        _hiddenToolbar = hiddenToolbar;
        
        if([self isEditing] == YES) {
            CGFloat toolbarHeight = (_hiddenToolbar == NO) ? GLBTextField_ToolbarHeight : 0;
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
        self.toolbar.glb_frameHeight = (self.hiddenToolbar == NO) ? GLBTextField_ToolbarHeight : 0;
        self.inputAccessoryView = self.toolbar;
        [self reloadInputViews];
    }
}

- (void)didValueChanged {
    [self validate];
}

- (void)didEndEditing {
    self.prevInputResponder = nil;
    self.nextInputResponder = nil;
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
