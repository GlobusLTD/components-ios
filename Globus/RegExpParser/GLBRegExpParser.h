/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

@class GLBRegExpMatch;

/*--------------------------------------------------*/

@interface GLBRegExpParser : NSObject

@property(nonatomic, nullable, strong) NSString* string;
@property(nonatomic, nonnull, strong) NSString* expression;
@property(nonatomic, nonnull, strong) NSString* pattern;
@property(nonatomic, nullable, readonly, strong) NSArray< GLBRegExpMatch* >* matches;
@property(nonatomic, nullable, readonly, strong) NSString* result;

- (nullable instancetype)initWithExpression:(nonnull NSString*)expression pattern:(nonnull NSString*)pattern;

- (nullable instancetype)initWithSting:(nonnull NSString*)string expression:(nonnull NSString*)expression pattern:(nonnull NSString*)pattern;

@end

/*--------------------------------------------------*/

@interface GLBRegExpMatch : NSObject

@property(nonatomic, nullable, readonly, strong) NSString* originalString;
@property(nonatomic, nullable, readonly, strong) NSArray* originalSubStrings;
@property(nonatomic, readonly) NSRange originalRange;

@property(nonatomic, nullable, readonly, strong) NSString* resultString;
@property(nonatomic, readonly) NSRange resultRange;

@end

/*--------------------------------------------------*/
