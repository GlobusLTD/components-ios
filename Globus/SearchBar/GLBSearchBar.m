/*--------------------------------------------------*/

#import "GLBSearchBar.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBSearchBar () < UITextFieldDelegate > {
@protected
    NSMutableArray* _contentConstraints;
}

- (void)__updateAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

static CGFloat DefaultHeight = 44;
static CGFloat DefaultMargin = 8;
static CGFloat DefaultSpacing = 6;
static CGFloat DefaultSeparatorHeight = 0.5f;

/*--------------------------------------------------*/

@implementation GLBSearchBar

#pragma mark - Synthesize

@synthesize delegate = _delegate;
@synthesize searching = _searching;
@synthesize editing = _editing;
@synthesize margin = _margin;
@synthesize spacing = _spacing;
@synthesize alwaysShowCancelButton = _alwaysShowCancelButton;
@synthesize separatorView = _separatorView;
@synthesize searchField = _searchField;
@synthesize showCancelButton = _showCancelButton;
@synthesize cancelButton = _cancelButton;

#pragma mark - Init / Free

- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, DefaultHeight)];
}

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
    if(self.backgroundColor == nil) {
        self.backgroundColor = [UIColor colorWithRed:(CGFloat)(201.0 / 255.0)
                                               green:(CGFloat)(201.0 / 255.0)
                                                blue:(CGFloat)(206.0 / 255.0)
                                               alpha:1];
    }

    _margin = UIEdgeInsetsMake(DefaultMargin, DefaultMargin, DefaultMargin, DefaultMargin);
    _spacing = DefaultSpacing;
    _alwaysShowCancelButton = NO;
    _showCancelButton = YES;
    _contentConstraints = NSMutableArray.array;
}

- (void)dealloc {
}

#pragma mark - Property

- (void)setSearching:(BOOL)searching {
    [self setSearching:searching animated:NO complete:nil];
}

- (void)setSearching:(BOOL)searching animated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    if(_searching != searching) {
        _searching = searching;
        if(_searching == NO) {
            _editing = NO;
        }
        [self __updateAnimated:animated complete:complete];
    } else if((_searching == NO) && (_editing == YES)) {
        _editing = NO;
        [self __updateAnimated:animated complete:complete];
    } else {
        if(complete != nil) {
            complete();
        }
    }
}

- (void)setEditing:(BOOL)editing {
    [self setEditing:editing animated:NO complete:nil];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    if(_editing != editing) {
        _editing = editing;
        [self __updateAnimated:animated complete:complete];
    } else {
        if(complete != nil) {
            complete();
        }
    }
}

- (void)setSeparatorColor:(UIColor*)separatorColor {
    self.separatorView.backgroundColor = separatorColor;
}

- (UIColor*)separatorColor {
    return self.separatorView.backgroundColor;
}

- (void)setSeparatorView:(UIView*)separatorView {
    if(_separatorView != separatorView) {
        if(_separatorView != nil) {
            [_separatorView removeFromSuperview];
        }
        _separatorView = separatorView;
        if(_separatorView != nil) {
            _separatorView.translatesAutoresizingMaskIntoConstraints = NO;
            if(_separatorView.superview == nil) {
                [self addSubview:_separatorView];
            }
            [self setNeedsUpdateConstraints];
        }
    }
}

- (UIView*)separatorView {
    if(_separatorView == nil) {
        UIView* separatorView = [[UIView alloc] initWithFrame:CGRectZero];
        separatorView.backgroundColor = [UIColor colorWithRed:(CGFloat)(199.0 / 255.0)
                                                        green:(CGFloat)(199.0 / 255.0)
                                                         blue:(CGFloat)(199.0 / 255.0)
                                                        alpha:1];
        self.separatorView = separatorView;
    }
    return _separatorView;
}

- (void)setSearchField:(GLBSearchBarTextField*)searchField {
    if(_searchField != searchField) {
        if(_searchField != nil) {
            [_searchField removeFromSuperview];
        }
        _searchField = searchField;
        if(_searchField != nil) {
            [_searchField addTarget:self action:@selector(changeTextField) forControlEvents:UIControlEventEditingChanged];
            _searchField.translatesAutoresizingMaskIntoConstraints = NO;
            _searchField.delegate = self;
            if(_searchField.superview == nil) {
                [self addSubview:_searchField];
            }
            [_searchField setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
            [self setNeedsUpdateConstraints];
        }
    }
}

- (GLBSearchBarTextField*)searchField {
    if(_searchField == nil) {
        GLBSearchBarTextField* textField = [[GLBSearchBarTextField alloc] initWithFrame:CGRectZero];
        textField.placeholder = NSLocalizedStringFromTable(@"Search", @"GLBSearchBar", @"SearchBar placeholder");
        textField.borderStyle = UITextBorderStyleNone;
        textField.backgroundColor = UIColor.whiteColor;
        textField.textColor = UIColor.darkGrayColor;
        textField.tintColor = UIColor.blackColor;
        textField.glb_cornerRadius = 4;
        textField.hiddenToolbar = YES;
        textField.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        UIImage* image = [UIImage imageNamed:@"icon_searchbar.png"];
        if(image != nil) {
            textField.leftView = [[UIImageView alloc] initWithImage:image];
            textField.leftViewMode = UITextFieldViewModeAlways;
        }
        self.searchField = textField;
    }
    return _searchField;
}

- (void)setCancelButton:(GLBButton*)cancelButton {
    if(_cancelButton != cancelButton) {
        if(_cancelButton != nil) {
            [_cancelButton removeFromSuperview];
        }
        _cancelButton = cancelButton;
        if(_cancelButton != nil) {
            [_cancelButton addTarget:self action:@selector(pressedCancel) forControlEvents:UIControlEventTouchUpInside];
            _cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
            if((((_searching == YES) || (_editing == YES)) && (_showCancelButton == YES)) || (_alwaysShowCancelButton == YES)) {
                _cancelButton.hidden = NO;
            } else {
                _cancelButton.hidden = YES;
            }
            if(_cancelButton.superview == nil) {
                [self addSubview:_cancelButton];
            }
            [_cancelButton setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
            [self setNeedsUpdateConstraints];
        }
    }
}

- (GLBButton*)cancelButton {
    if(_cancelButton == nil) {
        GLBButton* button = [[GLBButton alloc] initWithFrame:CGRectZero];
        button.glb_normalTitle = NSLocalizedStringFromTable(@"Cancel", @"GLBSearchBar", @"Cancel title");
        button.glb_normalTitleColor = [UIColor darkGrayColor];
        button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        self.cancelButton = button;
    }
    return _cancelButton;
}

#pragma mark - Public override

- (void)updateConstraints {
    NSDictionary* metrics = @{
        @"separatorHeight": @(DefaultSeparatorHeight),
        @"marginTop": @(_margin.top),
        @"marginBottom": @(_margin.bottom),
        @"marginLeft": @(_margin.left),
        @"marginRight": @(_margin.right),
        @"spacing": @(_spacing),
    };
    NSDictionary* views = @{
        @"separatorView": self.separatorView,
        @"searchField": self.searchField,
        @"cancelButton": self.cancelButton,
    };
    [self removeConstraints:_contentConstraints];
    [_contentConstraints removeAllObjects];
    if((((_searching == YES) || (_editing == YES)) && (_showCancelButton == YES)) || (_alwaysShowCancelButton == YES)) {
        [_contentConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(marginLeft)-[searchField]-(spacing)-[cancelButton]-(marginRight)-|" options:0 metrics:metrics views:views]];
        [_contentConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(marginTop)-[searchField]-(marginBottom)-|" options:0 metrics:metrics views:views]];
        [_contentConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(marginTop)-[cancelButton]-(marginBottom)-|" options:0 metrics:metrics views:views]];
    } else {
        [_contentConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(marginLeft)-[searchField]-(marginRight)-|" options:0 metrics:metrics views:views]];
        [_contentConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[searchField]-(marginRight)-[cancelButton]" options:0 metrics:metrics views:views]];
        [_contentConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(marginTop)-[searchField]-(marginBottom)-|" options:0 metrics:metrics views:views]];
        [_contentConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(marginTop)-[cancelButton]-(marginBottom)-|" options:0 metrics:metrics views:views]];
    }
    [_contentConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[separatorView]-0-|" options:0 metrics:metrics views:views]];
    [_contentConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[separatorView(==separatorHeight)]-0-|" options:0 metrics:metrics views:views]];
    [self addConstraints:_contentConstraints];
    [super updateConstraints];
}

#pragma mark - Public

#pragma mark - Private

- (void)__updateAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    if(_searching == _editing) {
        [self setNeedsUpdateConstraints];
    }
    if(animated == YES) {
        if((((_searching == YES) || (_editing == YES)) && (_showCancelButton == YES)) || (_alwaysShowCancelButton == YES)) {
            self.cancelButton.hidden = NO;
        }
        [UIView animateWithDuration:0.2f animations:^{
            if(_searching == NO) {
                self.searchField.clearButtonMode = UITextFieldViewModeNever;
                self.searchField.text = @"";
            }
            if(self.searchField.text.length > 0) {
                self.searchField.clearButtonMode = UITextFieldViewModeAlways;
            } else {
                self.searchField.clearButtonMode = UITextFieldViewModeNever;
            }
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            if(_editing == YES) {
                [self.searchField becomeFirstResponder];
            } else {
                [self.searchField endEditing:NO];
            }
            if((_searching == NO) && (_editing == NO) && (_alwaysShowCancelButton == NO)) {
                self.cancelButton.hidden = YES;
            }
            if(complete != nil) {
                complete();
            }
        }];
    } else {
        if(_searching == NO) {
            self.searchField.clearButtonMode = UITextFieldViewModeNever;
            self.searchField.text = @"";
        }
        if(_editing == YES) {
            [self.searchField becomeFirstResponder];
        } else {
            [self.searchField endEditing:NO];
        }
        if(self.searchField.text.length > 0) {
            self.searchField.clearButtonMode = UITextFieldViewModeAlways;
        } else {
            self.searchField.clearButtonMode = UITextFieldViewModeNever;
        }
        if((((_searching == YES) || (_editing == YES)) && (_showCancelButton == YES)) || (_alwaysShowCancelButton == YES)) {
            self.cancelButton.hidden = NO;
        } else {
            self.cancelButton.hidden = YES;
        }
        if(complete != nil) {
            complete();
        }
    }
}

#pragma mark - Action

- (void)changeTextField {
    NSString* text = self.searchField.text;
    if(text == nil) {
        text = @"";
    }
    if(text.length > 0) {
        if(_searching == NO) {
            [self setSearching:YES animated:YES complete:nil];
            if([_delegate respondsToSelector:@selector(searchBarBeginSearch:)]) {
                [_delegate searchBarBeginSearch:self];
            }
        } else {
            _searchField.clearButtonMode = UITextFieldViewModeAlways;
        }
    } else {
        _searchField.clearButtonMode = UITextFieldViewModeNever;
    }
    if([_delegate respondsToSelector:@selector(searchBar:textChanged:)]) {
        [_delegate searchBar:self textChanged:text];
    }
}

- (void)pressedCancel {
    __weak GLBSearchBar* weakSelf = self;
    [self setSearching:NO animated:YES complete:^{
        if([weakSelf.delegate respondsToSelector:@selector(searchBarEndEditing:)] == YES) {
            [weakSelf.delegate searchBarPressedCancel:weakSelf];
        }
    }];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField*)textField {
    if([_delegate respondsToSelector:@selector(searchBarBeginEditing:)]) {
        [_delegate searchBarBeginEditing:self];
    }
    [self setEditing:YES animated:YES complete:nil];
}

- (void)textFieldDidEndEditing:(UITextField*)textField {
    if(self.searchField.text.length < 1) {
        [self setSearching:NO animated:YES complete:nil];
        if([_delegate respondsToSelector:@selector(searchBarEndEditing:)]) {
            [_delegate searchBarEndEditing:self];
        }
        if([_delegate respondsToSelector:@selector(searchBarEndSearch:)]) {
            [_delegate searchBarEndSearch:self];
        }
    } else {
        if([_delegate respondsToSelector:@selector(searchBarEndEditing:)]) {
            [_delegate searchBarEndEditing:self];
        }
        [self setEditing:NO animated:YES complete:nil];
    }
}

- (BOOL)textFieldShouldClear:(UITextField*)textField {
    if([_delegate respondsToSelector:@selector(searchBarPressedClear:)]) {
        [_delegate searchBarPressedClear:self];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    if([_delegate respondsToSelector:@selector(searchBarPressedReturn:)]) {
        [_delegate searchBarPressedReturn:self];
    }
    return YES;
}

@end

/*--------------------------------------------------*/

@implementation GLBSearchBarTextField

- (void)setup {
    [super setup];
    
    self.textInsets = UIEdgeInsetsMake(0, 10, 0, 10);
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
