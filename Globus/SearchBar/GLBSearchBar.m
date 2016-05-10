/*--------------------------------------------------*/

#import "GLBSearchBar.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBSearchBar () < UITextFieldDelegate > {
@protected
    __weak id< GLBSearchBarDelegate > _delegate;
    BOOL _searching;
    BOOL _editing;
    CGFloat _minimalHeight;
    UIEdgeInsets _margin;
    CGFloat _spacing;
    BOOL _alwaysShowCancelButton;
    __weak UIView* _separatorView;
    __weak GLBTextField* _searchField;
    BOOL _showCancelButton;
    __weak GLBButton* _cancelButton;
    NSMutableArray* _contentConstraints;
}

@property(nonatomic, weak) UIView* separatorView;
@property(nonatomic, weak) GLBTextField* searchField;
@property(nonatomic, weak) GLBButton* cancelButton;

- (void)updateAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

static CGFloat GLBSearchBarSeparatorHeight = 0.5f;

/*--------------------------------------------------*/

@implementation GLBSearchBar

#pragma mark - Synthesize

@synthesize delegate = _delegate;
@synthesize searching = _searching;
@synthesize editing = _editing;
@synthesize minimalHeight = _minimalHeight;
@synthesize margin = _margin;
@synthesize spacing = _spacing;
@synthesize alwaysShowCancelButton = _alwaysShowCancelButton;
@synthesize separatorView = _separatorView;
@synthesize searchField = _searchField;
@synthesize showCancelButton = _showCancelButton;
@synthesize cancelButton = _cancelButton;

#pragma mark - Init / Free

- (void)setup {
    [super setup];
    
    self.blurEnabled = NO;
    if(self.backgroundColor == nil) {
        self.backgroundColor = [UIColor colorWithRed:201.0f/255.0f green:201.0f/255.0f blue:206.0f/255.0f alpha:1.0f];
    }

    _minimalHeight = 28.0f;
    _margin = UIEdgeInsetsMake(8.0f, 8.0f, 8.0f, 8.0f);
    _spacing = 6.0f;
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
            self.searchField.clearButtonMode = UITextFieldViewModeNever;
            self.searchField.text = @"";
            [self.searchField endEditing:NO];
        }
        [self updateAnimated:animated complete:complete];
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
        if(_editing == YES) {
            [self.searchField becomeFirstResponder];
        } else {
            [self.searchField endEditing:NO];
        }
        [self updateAnimated:animated complete:complete];
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
        separatorView.backgroundColor = [UIColor colorWithRed:199.0f/255.0f green:199.0f/255.0f blue:199.0f/255.0f alpha:1.0f];
        self.separatorView = separatorView;
    }
    return _separatorView;
}

- (void)setSearchField:(GLBTextField*)searchField {
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

- (GLBTextField*)searchField {
    if(_searchField == nil) {
        GLBTextField* textField = [[GLBTextField alloc] initWithFrame:CGRectZero];
        textField.placeholder = NSLocalizedStringFromTable(@"Search", @"GLBSearchBar", @"SearchBar placeholder");
        textField.borderStyle = UITextBorderStyleNone;
        textField.backgroundColor = [UIColor whiteColor];
        textField.textColor = [UIColor darkGrayColor];
        textField.tintColor = [UIColor blackColor];
        textField.glb_cornerRadius = 4.0f;
        textField.hiddenToolbar = YES;
        textField.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0f];
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
        button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15.0f];
        self.cancelButton = button;
    }
    return _cancelButton;
}

#pragma mark - Public override

- (void)updateConstraints {
    NSDictionary* metrics = @{
        @"separatorHeight": @(GLBSearchBarSeparatorHeight),
        @"contentHeight": @(_minimalHeight),
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
        [_contentConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=marginTop)-[searchField(>=contentHeight)]-(marginBottom)-|" options:0 metrics:metrics views:views]];
        [_contentConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=marginTop)-[cancelButton(>=contentHeight)]-(marginBottom)-|" options:0 metrics:metrics views:views]];
    } else {
        [_contentConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(marginLeft)-[searchField]-(marginRight)-|" options:0 metrics:metrics views:views]];
        [_contentConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[searchField]-(marginRight)-[cancelButton]" options:0 metrics:metrics views:views]];
        [_contentConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=marginTop)-[searchField(>=contentHeight)]-(marginBottom)-|" options:0 metrics:metrics views:views]];
        [_contentConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=marginTop)-[cancelButton(>=contentHeight)]-(marginBottom)-|" options:0 metrics:metrics views:views]];
    }
    [_contentConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[separatorView]-0-|" options:0 metrics:metrics views:views]];
    [_contentConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[separatorView(==separatorHeight)]-0-|" options:0 metrics:metrics views:views]];
    [self addConstraints:_contentConstraints];
    [super updateConstraints];
}

#pragma mark - Public

#pragma mark - Private

- (void)updateAnimated:(BOOL)animated complete:(GLBSimpleBlock)complete {
    if(_searching == _editing) {
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
    if(animated == YES) {
        if((((_searching == YES) || (_editing == YES)) && (_showCancelButton == YES)) || (_alwaysShowCancelButton == YES)) {
            self.cancelButton.hidden = NO;
        }
        [UIView animateWithDuration:0.2f animations:^{
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            if((_searching == NO) && (_editing == NO) && (_alwaysShowCancelButton == NO)) {
                self.cancelButton.hidden = YES;
            }
            if(complete != nil) {
                complete();
            }
        }];
    } else {
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
    if((_searching == NO) && (self.searchField.text.length > 0)) {
        if([_delegate respondsToSelector:@selector(searchBarBeginSearch:)]) {
            [_delegate searchBarBeginSearch:self];
        }
        [self setSearching:YES animated:YES complete:nil];
    }
    if(self.searchField.text.length > 0) {
        _searchField.clearButtonMode = UITextFieldViewModeAlways;
    } else {
        _searchField.clearButtonMode = UITextFieldViewModeNever;
    }
    if([_delegate respondsToSelector:@selector(searchBar:textChanged:)]) {
        [_delegate searchBar:self textChanged:self.searchField.text];
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
    if([_delegate respondsToSelector:@selector(searchBarEndEditing:)]) {
        [_delegate searchBarEndEditing:self];
    }
    if(self.searchField.text.length < 1) {
        if([_delegate respondsToSelector:@selector(searchBarEndSearch:)]) {
            [_delegate searchBarEndSearch:self];
        }
        [self setSearching:NO animated:YES complete:nil];
    }
    [self setEditing:NO animated:YES complete:nil];
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
#endif
/*--------------------------------------------------*/
