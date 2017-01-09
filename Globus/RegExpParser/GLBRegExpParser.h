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

- (instancetype _Nullable)initWithExpression:(NSString* _Nonnull)expression pattern:(NSString* _Nonnull)pattern;

- (instancetype _Nullable)initWithSting:(NSString* _Nonnull)string expression:(NSString* _Nonnull)expression pattern:(NSString* _Nonnull)pattern;

- (void)setup NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/

@interface GLBRegExpMatch : NSObject

@property(nonatomic, nullable, readonly, strong) NSString* originalString;
@property(nonatomic, nullable, readonly, strong) NSArray* originalSubStrings;
@property(nonatomic, readonly, assign) NSRange originalRange;

@property(nonatomic, nullable, readonly, strong) NSString* resultString;
@property(nonatomic, readonly, assign) NSRange resultRange;

@end

/*--------------------------------------------------*/
