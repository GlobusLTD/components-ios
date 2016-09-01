/*--------------------------------------------------*/

#import "GLBInputValidator.h"
#import "GLBInputField.h"

/*--------------------------------------------------*/

#import "GLBAction.h"

/*--------------------------------------------------*/

@implementation GLBInputEmptyValidator

@synthesize field = _field;

- (instancetype)init {
    if(self = [super init]) {
        _required = YES;
    }
    return self;
}

- (instancetype)initWithMessage:(NSString*)message {
    if(self = [super init]) {
        _message = message;
        _required = YES;
    }
    return self;
}

- (BOOL)validate:(id)value {
    if([value isKindOfClass:NSString.class] == YES) {
        NSString* trimmed = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if(trimmed.length > 0) {
            return YES;
        } else if((_required == NO) && (trimmed.length < 1)) {
            return YES;
        }
    }
    return NO;
}

- (NSArray*)messages:(id)value {
    if([self validate:value] == NO) {
        if(_message != nil) {
            return @[ _message ];
        }
    }
    return @[];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBInputEmailValidator

@synthesize field = _field;

- (instancetype)init {
    if(self = [super init]) {
        _required = YES;
    }
    return self;
}

- (instancetype)initWithMessage:(NSString*)message {
    if(self = [super init]) {
        _message = message;
        _required = YES;
    }
    return self;
}

- (BOOL)validate:(NSString*)value {
    if([value isKindOfClass:NSString.class] == YES) {
        NSString* trimmed = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if(trimmed.length > 0) {
            return [trimmed glb_isEmail];
        } else if((_required == NO) && (trimmed.length < 1)) {
            return YES;
        }
    }
    return NO;
}

- (NSArray*)messages:(NSString*)value {
    if([self validate:value] == NO) {
        if(_message != nil) {
            return @[ _message ];
        }
    }
    return @[];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBInputRegExpValidator

@synthesize field = _field;

- (instancetype)init {
    if(self = [super init]) {
        _required = YES;
    }
    return self;
}

- (instancetype)initWithRegExp:(NSString*)regExp andMessage:(NSString*)message {
    if(self = [super init]) {
        _regExp = regExp;
        _message = message;
        _required = YES;
    }
    return self;
}

- (void)setRegExp:(NSString*)regExp {
    if([_regExp isEqualToString:regExp] == NO) {
        _regExp = regExp;
        [_field validate];
    }
}

- (BOOL)validate:(NSString*)value {
    if([value isKindOfClass:NSString.class] == YES) {
        NSString* trimmed = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if(trimmed.length > 0) {
            return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", _regExp] evaluateWithObject:trimmed];
        } else if((_required == NO) && (trimmed.length < 1)) {
            return YES;
        }
    }
    return NO;
}

- (NSArray*)messages:(NSString*)value {
    if([self validate:value] == NO) {
        if(_message != nil) {
            return @[_message];
        }
    }
    return @[];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBInputMinLengthValidator

@synthesize field = _field;

- (instancetype)init {
    if(self = [super init]) {
        _required = YES;
    }
    return self;
}

- (instancetype)initWithMessage:(NSString*)message minLength:(NSUInteger)minLength {
    if(self = [super init]) {
        _message = message;
        _minLength = minLength;
        _required = YES;
    }
    return self;
}

- (void)setMinLength:(NSUInteger)minLength {
    if(_minLength != minLength) {
        _minLength = minLength;
        [_field validate];
    }
}

- (BOOL)validate:(NSString*)value {
    if([value isKindOfClass:NSString.class] == YES) {
        NSString* trimmed = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if(trimmed.length > 0) {
            return (trimmed.length >= _minLength);
        } else if((_required == NO) && (trimmed.length < 1)) {
            return YES;
        }
    }
    return NO;
}

- (NSArray*)messages:(NSString*)value {
    if([self validate:value] == NO) {
        if(_message != nil) {
            return @[_message];
        }
    }
    return @[];
}

@end

/*--------------------------------------------------*/

@implementation GLBInputMaxLengthValidator

@synthesize field = _field;

- (instancetype)init {
    if(self = [super init]) {
        _required = YES;
    }
    return self;
}

- (instancetype)initWithMessage:(NSString*)message maxLength:(NSUInteger)maxLength {
    if(self = [super init]) {
        _message = message;
        _maxLength = maxLength;
        _required = YES;
    }
    return self;
}

- (void)setMaxLength:(NSUInteger)maxLength {
    if(_maxLength != maxLength) {
        _maxLength = maxLength;
        [_field validate];
    }
}

- (BOOL)validate:(NSString*)value {
    if([value isKindOfClass:NSString.class] == YES) {
        NSString* trimmed = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if(trimmed.length > 0) {
            return (trimmed.length <= _maxLength);
        } else if((_required == NO) && (trimmed.length < 1)) {
            return YES;
        }
    }
    return NO;
}

- (NSArray*)messages:(NSString*)value {
    if([self validate:value] == NO) {
        if(_message != nil) {
            return @[_message];
        }
    }
    return @[];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBInputDigitValidator

@synthesize field = _field;

- (instancetype)init {
    if(self = [super init]) {
        _required = YES;
    }
    return self;
}

- (instancetype)initWithMessage:(NSString*)message {
    if(self = [super init]) {
        _message = message;
        _required = YES;
    }
    return self;
}

- (BOOL)validate:(NSString*)value {
    if([value isKindOfClass:NSString.class] == YES) {
        NSString* trimmed = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if(trimmed.length > 0) {
            static NSPredicate* predicate = nil;
            if(predicate == nil) {
                predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[0-9]+"];
            }
            return [predicate evaluateWithObject:trimmed];
        } else if((_required == NO) && (trimmed.length < 1)) {
            return YES;
        }
    }
    return NO;
}

- (NSArray*)messages:(NSString*)value {
    if([self validate:value] == NO) {
        if(_message != nil) {
            return @[_message];
        }
    }
    return @[];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBInputANDValidator

@synthesize field = _field;

- (instancetype)init {
    if(self = [super init]) {
    }
    return self;
}

- (instancetype)initWithValidators:(NSArray*)validators {
    if(self = [super init]) {
        _validators = validators;
    }
    return self;
}

- (BOOL)validate:(NSString*)value {
    BOOL result = YES;
    for(id<GLBInputValidator> val in _validators) {
        if([val validate:value] == NO) {
            result = NO;
            break;
        }
    }
    return result;
}

- (NSArray*)messages:(NSString*)value {
    NSArray* results = @[];
    for(id<GLBInputValidator> val in _validators) {
        results = [results glb_unionWithArray:[val messages:value]];
    }
    return results;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBInputORValidator

@synthesize field = _field;

- (instancetype)init {
    if(self = [super init]) {
    }
    return self;
}

- (instancetype)initWithValidators:(NSArray*)validators {
    if(self = [super init]) {
        _validators = validators;
    }
    return self;
}

- (BOOL)validate:(NSString*)value {
    BOOL result = NO;
    for(id<GLBInputValidator> val in _validators) {
        if([val validate:value] == YES) {
            result = YES;
            break;
        }
    }
    return result;
}

- (NSArray*)messages:(NSString*)value {
    return @[];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/