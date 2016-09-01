/*--------------------------------------------------*/

#import "GLBPhoneField.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBPhoneFieldFormatter : NSFormatter < UITextFieldDelegate > {
    NSMutableDictionary* _formats;
}

@property(nonatomic, weak) id< UITextFieldDelegate > delegate;
@property(nonatomic, weak) GLBPhoneField* field;
@property(nonatomic, copy) NSString* prefix;

- (void)setup NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/

@interface GLBPhoneField () {
    GLBPhoneFieldFormatter* _formatter;
}

@property(nonatomic, strong) id userInfo;

@end

/*--------------------------------------------------*/

@implementation GLBPhoneFieldFormatter

#pragma mark - Init / Free

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _prefix = @"";
    _formats = [NSMutableDictionary dictionary];
    
    [self _resetFormats];
}

#pragma mark - NSObject

- (BOOL)respondsToSelector:(SEL)selector {
    return (([_delegate respondsToSelector:selector] == YES) || ([super respondsToSelector:selector] == YES));
}

- (void)forwardInvocation:(NSInvocation*)invocation {
    [invocation invokeWithTarget:_delegate];
}

#pragma mark - Property

- (void)setPrefix:(NSString*)prefix {
    if(prefix == nil) {
        prefix = @"";
    }
    if([_prefix isEqualToString:prefix] == NO) {
        _prefix = prefix;
        
        NSString* phoneNumber = _field.phoneNumberWithoutPrefix;
        if(phoneNumber == nil) {
            phoneNumber = @"";
        }
        [self _applyFormat:_field forText:[_prefix stringByAppendingString:phoneNumber]];
    }
}

#pragma mark - Private

- (NSDictionary*)_defaultPattern {
    return @{
        @"format" : @"#############",
        @"userInfo" : [NSNull null]
    };
}

- (NSDictionary*)_defaultFormat {
    return @{
        @"default" : [self _defaultPattern]
    };
}

- (void)_resetFormats {
    NSDictionary* defaultPattern = _formats[@"default"];
    if(defaultPattern == nil) {
        defaultPattern = [self _defaultPattern];
    }
    [_formats removeAllObjects];
    _formats[@"default"] = defaultPattern;
}

- (void)_resetDefaultFormat {
    [_formats removeObjectForKey:@"default"];
    _formats[@"default"] = [self _defaultPattern];
}

- (void)_setDefaultOutputPattern:(NSString*)pattern userInfo:(id)userInfo {
    if(userInfo == nil) {
        userInfo = [NSNull null];
    }
    _formats[@"default"] = @{
        @"format" : pattern,
        @"userInfo" : userInfo
    };
}

- (void)_addOutputPattern:(NSString*)pattern forRegExp:(NSString*)regexp userInfo:(id)userInfo {
    if(userInfo == nil) {
        userInfo = [NSNull null];
    }
    _formats[regexp] = @{
        @"format" : pattern,
        @"userInfo" : userInfo
    };
}

- (BOOL)_logicTextField:(GLBPhoneField*)field shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {
    if((_prefix.length < 1) && (range.location < _prefix.length)) {
        return NO;
    }
    NSUInteger caretPosition = [self _pushCaretPosition:field range:range];
    NSString* newString = [field.text stringByReplacingCharactersInRange:range withString:string];
    [self _applyFormat:field forText:newString];
    [self _popCaretPosition:field range:range caretPosition:caretPosition];
    [field sendActionsForControlEvents:UIControlEventValueChanged];
    return NO;
}

- (void)_applyFormat:(GLBPhoneField*)field forText:(NSString*)text {
    if(text == nil) {
        text = @"";
    }
    NSDictionary* result = [self _valuesForString:text];
    field.text = result[@"text"];
    field.userInfo = result[@"userInfo"];
}

- (NSUInteger)_pushCaretPosition:(UITextField*)textField range:(NSRange)range {
    NSString* subString = [textField.text substringFromIndex:range.location + range.length];
    return [self _valuableCharCountIn:subString];
}

- (void)_popCaretPosition:(UITextField*)textField range:(NSRange)range caretPosition:(NSUInteger)caretPosition {
    if(range.length == 0) {
        range.length = 1;
    }
    NSString* text = textField.text;
    NSUInteger lasts = caretPosition;
    NSUInteger length = text.length;
    NSUInteger start = length;
    for(NSUInteger index = length - 1; index != NSUIntegerMax && lasts > 0; index--) {
        unichar ch = [text characterAtIndex:index];
        if([self _isValuableChar:ch]) {
            lasts--;
        }
        if(lasts <= 0) {
            start = index;
            break;
        }
    }
    [self _selectTextForInput:textField atRange:NSMakeRange(start, 0)];
}

- (void)_selectTextForInput:(UITextField*)input atRange:(NSRange)range {
    UITextPosition* start = [input positionFromPosition:input.beginningOfDocument offset:(NSInteger)range.location];
    UITextPosition* end = [input positionFromPosition:start offset:(NSInteger)range.length];
    [input setSelectedTextRange:[input textRangeFromPosition:start toPosition:end]];
}

- (BOOL)_isValuableChar:(unichar)ch {
    return (ch >= '0' && ch <= '9') ? YES : NO;
}

- (NSString*)_formattedRemove:(NSString*)string atIndex:(NSRange)range {
    NSMutableString* newString = [NSMutableString stringWithString:string];
    NSUInteger removeCount = [self _valuableCharCountIn:[newString substringWithRange:range]];
    if(range.length == 1) {
        removeCount = 1;
    }
    for(NSUInteger wordCount = 0 ; wordCount < removeCount; wordCount++) {
        for(NSUInteger i = range.location + range.length - wordCount - 1; i != NSUIntegerMax; i--) {
            unichar ch = [newString characterAtIndex:i];
            if([self _isValuableChar:ch] == YES) {
                [newString deleteCharactersInRange:NSMakeRange(i, 1)];
                break;
            }
        }
    }
    return newString;
}

- (NSUInteger)_valuableCharCountIn:(NSString*)string {
    NSUInteger count = 0;
    NSUInteger length = string.length;
    for(NSUInteger i = 0; i < length; i++) {
        unichar ch = [string characterAtIndex:i];
        if([self _isValuableChar:ch] == YES) {
            count++;
        }
    }
    return count;
}

- (NSString*)_digitOnlyString:(NSString*)string {
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"\\D" options:NSRegularExpressionCaseInsensitive error:nil];
    return [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, string.length) withTemplate:@""];
}

- (NSDictionary*)_valuesForString:(NSString*)string {
    NSString* nonPrefix = string;
    if([string hasPrefix:_prefix] == YES) {
        nonPrefix = [string substringFromIndex:_prefix.length];
    }
    if(string.length > _prefix.length) {
        NSString* formattedDigits = [self _stringWithoutFormat:nonPrefix];
        NSDictionary* configDict = [self _configForSequence:formattedDigits];
        NSString* result = [self _applyFormat:configDict[@"format"] forFormattedString:formattedDigits];
        return @{
                 @"userInfo" : configDict[@"userInfo"],
                 @"text": result
                 };
    }
    return @{
             @"userInfo" : _formats[@"default"][@"userInfo"],
             @"text" : _prefix
             };
}

- (NSString*)_stringWithoutFormat:(NSString*)string {
    NSDictionary* dict = [self _configForSequence:string];
    NSArray* removeRanges = @[];
    NSString* format = dict[@"format"];
    for(NSUInteger i = 0; i < MIN(format.length, string.length); i++) {
        unichar formatCh = [format characterAtIndex:i];
        if(formatCh != [string characterAtIndex:i]) {
            break;
        }
        if([self _isValuableChar:formatCh] == YES) {
            removeRanges = [removeRanges arrayByAddingObject:[NSValue valueWithRange:NSMakeRange(i, 1)]];
        }
    }
    for(NSUInteger i = removeRanges.count - 1; i != NSUIntegerMax; i--) {
        NSValue* value = removeRanges[i];
        string = [string stringByReplacingCharactersInRange:value.rangeValue withString:@""];
    }
    return [self _digitOnlyString:string];
}

- (NSDictionary*)_configForSequence:(NSString*)string {
    for(NSString* format in _formats.allKeys) {
        if([self _matchString:string withPattern:format] == YES) {
            return _formats[format];
        }
    }
    return _formats[@"default"];
}

- (BOOL)_matchString:(NSString*)string withPattern:(NSString*)pattern {
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult* match = [regex firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
    return (match != nil) ? YES : NO;
}

- (NSString*)_applyFormat:(NSString*)format forFormattedString:(NSString*)formattedDigits {
    NSUInteger charIndex = 0;
    NSMutableString* result = [NSMutableString string];
    for(NSUInteger i = 0; (i < format.length) && (charIndex < formattedDigits.length); i++) {
        unichar ch = [format characterAtIndex:i];
        if([self _isRequireSubstitute:ch] == YES) {
            unichar sp = [formattedDigits characterAtIndex:charIndex++];
            [result appendString:[NSString stringWithCharacters:&sp length:1]];
        } else {
            [result appendString:[NSString stringWithCharacters:&ch length:1]];
        }
    }
    return [NSString stringWithFormat:@"%@%@", _prefix, result];
}

- (BOOL)_isRequireSubstitute:(unichar)ch {
    return (ch == '#') ? YES : NO;
}

#pragma mark - NSFormatter

- (BOOL)getObjectValue:(id __autoreleasing *)object forString:(NSString*)string errorDescription:(NSString* __autoreleasing *)error {
    *object = [self _digitOnlyString:string];
    return YES;
}

- (NSString*)stringForObjectValue:(id)object {
    if([object isKindOfClass:[NSString class]] == YES) {
        return [self _valuesForString:object][@"text"];
    }
    return nil;
}

#pragma mark - UITextField Delegate

-(BOOL)textField:(GLBPhoneField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {
    [self _logicTextField:textField shouldChangeCharactersInRange:range replacementString:string];
    if([_delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)] == YES) {
        [_delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return NO;
}

- (BOOL)textFieldShouldClear:(GLBPhoneField*)textField {
    if([_delegate respondsToSelector:@selector(textFieldShouldClear:)] == YES) {
        return [_delegate textFieldShouldClear:textField];
    }
    BOOL result = YES;
    if(_prefix.length > 0) {
        [textField setFormattedText:@""];
        return NO;
    }
    return result;
}

@end

/*--------------------------------------------------*/

@implementation GLBPhoneField

#pragma mark - Init / Free

- (void)setup {
    [super setup];
    
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.keyboardType = UIKeyboardTypeNumberPad;
    
    _formatter = [GLBPhoneFieldFormatter new];
    _formatter.field = self;
    [super setDelegate:_formatter];
}

#pragma mark - Property

- (void)setDelegate:(id< UITextFieldDelegate >)delegate {
    _formatter.delegate = delegate;
}

- (id< UITextFieldDelegate >)delegate {
    return _formatter.delegate;
}

- (void)setPrefix:(NSString*)prefix {
    _formatter.prefix = prefix;
}

- (NSString*)prefix {
    return _formatter.prefix;
}

#pragma mark - Public

- (void)setFormattedText:(NSString*)text {
    [_formatter _applyFormat:self forText:text];
}

- (NSString*)phoneNumberWithoutPrefix {
    return [_formatter _digitOnlyString:[self.text stringByReplacingOccurrencesOfString:_formatter.prefix withString:@""]];
}

- (NSString*)phoneNumber {
    return [_formatter _digitOnlyString:self.text];
}

- (void)resetFormats {
    [_formatter _resetFormats];
}

- (void)resetDefaultFormat {
    [_formatter _resetDefaultFormat];
}

- (void)setDefaultOutputPattern:(NSString*)pattern {
    [_formatter _setDefaultOutputPattern:pattern userInfo:nil];
}

- (void)setDefaultOutputPattern:(NSString*)pattern userInfo:(id)userInfo {
    [_formatter _setDefaultOutputPattern:pattern userInfo:userInfo];
}

- (void)addOutputPattern:(NSString*)pattern forRegExp:(NSString*)regexp {
    [_formatter _addOutputPattern:pattern forRegExp:regexp userInfo:nil];
}

- (void)addOutputPattern:(NSString*)pattern forRegExp:(NSString*)regexp userInfo:(id)userInfo {
    [_formatter _addOutputPattern:pattern forRegExp:regexp userInfo:userInfo];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
