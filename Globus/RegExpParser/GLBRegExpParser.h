/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

@interface GLBRegExpParser : NSObject

@property(nonatomic, strong) NSString* string;
@property(nonatomic, strong) NSString* expression;
@property(nonatomic, strong) NSString* pattern;
@property(nonatomic, readonly, strong) NSArray* matches;
@property(nonatomic, readonly, strong) NSString* result;

- (instancetype)initWithExpression:(NSString*)expression pattern:(NSString*)pattern;
- (instancetype)initWithSting:(NSString*)string expression:(NSString*)expression pattern:(NSString*)pattern;

- (void)setup NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/

@interface GLBRegExpMatch : NSObject

@property(nonatomic, readonly, strong) NSString* originalString;
@property(nonatomic, readonly, strong) NSArray* originalSubStrings;
@property(nonatomic, readonly, assign) NSRange originalRange;

@property(nonatomic, readonly, strong) NSString* resultString;
@property(nonatomic, readonly, assign) NSRange resultRange;

@end

/*--------------------------------------------------*/
