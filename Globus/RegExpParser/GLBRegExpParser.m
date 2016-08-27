/*--------------------------------------------------*/

#import "GLBRegExpParser.h"

/*--------------------------------------------------*/

@interface GLBRegExpParser () {
    BOOL _needApplyParser;
}

- (void)applyParserIfNeed;
- (void)applyParser;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface GLBRegExpMatch ()

@property(nonatomic, strong) NSString* originalString;
@property(nonatomic, strong) NSArray* originalSubStrings;
@property(nonatomic) NSRange originalRange;
@property(nonatomic, strong) NSString* resultString;
@property(nonatomic) NSRange resultRange;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBRegExpParser

#pragma mark - Synthesize

@synthesize matches = _matches;
@synthesize result = _result;

#pragma mark - Init / Free

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        _needApplyParser = NO;
        [self setup];
    }
    return self;
}

- (instancetype)initWithExpression:(NSString*)expression pattern:(NSString*)pattern {
    self = [super init];
    if(self != nil) {
        _expression = expression;
        _pattern = pattern;
        _needApplyParser = NO;
        [self setup];
    }
    return self;
}

- (instancetype)initWithSting:(NSString*)string expression:(NSString*)expression pattern:(NSString*)pattern {
    self = [super init];
    if(self != nil) {
        _string = string;
        _expression = expression;
        _pattern = pattern;
        _needApplyParser = YES;
        [self setup];
    }
    return self;
}

- (void)setup {
}

#pragma mark - Property

- (void)setString:(NSString*)string {
    if([_string isEqualToString:string] == NO) {
        _string = string;
        _needApplyParser = YES;
    }
}

- (void)setExpression:(NSString*)expression {
    if([_expression isEqualToString:expression] == NO) {
        _expression = expression;
        _needApplyParser = YES;
    }
}

- (void)setPattern:(NSString*)pattern {
    if([_pattern isEqualToString:pattern] == NO) {
        _pattern = pattern;
        _needApplyParser = YES;
    }
}

- (NSArray*)matches {
    [self applyParserIfNeed];
    return _matches;
}

- (NSString*)result {
    [self applyParserIfNeed];
    return _result;
}

#pragma mark - Private

- (void)applyParserIfNeed {
    if(_needApplyParser == YES) {
        _needApplyParser = NO;
        [self applyParser];
    }
}

- (void)applyParser {
    if(_string.length > 0) {
        NSMutableArray* resultMatches = NSMutableArray.array;
        NSMutableString* resultString = [NSMutableString stringWithString:_string];
        NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:_expression options:0 error:nil];
        if(regex != nil) {
            __block NSUInteger offset = 0;
            [regex enumerateMatchesInString:_string options:0 range:NSMakeRange(0, _string.length) usingBlock:^(NSTextCheckingResult* checkingResult, NSMatchingFlags flags, BOOL* stop) {
                NSUInteger numberOfRanges = checkingResult.numberOfRanges;
                
                NSString* matchOriginalString = [_string substringWithRange:checkingResult.range];
                NSMutableArray* matchOriginalSubStrings = [NSMutableArray arrayWithCapacity:numberOfRanges];
                for(NSUInteger rangeIndex = 1; rangeIndex < numberOfRanges; rangeIndex++) {
                    NSRange range = [checkingResult rangeAtIndex:rangeIndex];
                    NSString* substring = [_string substringWithRange:range];
                    
                    [matchOriginalSubStrings addObject:substring];
                }
                NSRange matchOriginalRange = checkingResult.range;
                
                NSString* matchResultString = [regex replacementStringForResult:checkingResult inString:_string offset:0 template:(_pattern != nil) ? _pattern : @""];
                NSRange matchResultRange = NSMakeRange(matchOriginalRange.location + offset, matchResultString.length);
                
                [resultString replaceCharactersInRange:NSMakeRange(matchOriginalRange.location + offset, matchOriginalRange.length) withString:matchResultString];
                
                GLBRegExpMatch* match = [GLBRegExpMatch new];
                if(match != nil) {
                    match.originalString = matchOriginalString;
                    match.originalSubStrings = matchOriginalSubStrings;
                    match.originalRange = matchOriginalRange;
                    match.resultString = matchResultString;
                    match.resultRange = matchResultRange;
                    
                    [resultMatches addObject:match];
                }
                
                offset += (matchResultRange.length - matchOriginalRange.length);
            }];
        }
        _matches = [resultMatches copy];
        _result = [resultString copy];
    } else {
        _matches = nil;
        _result = nil;
    }
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBRegExpMatch
@end

/*--------------------------------------------------*/
