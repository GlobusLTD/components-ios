/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

typedef _Nullable id (^GLBModelJsonUndefinedBehaviour)(_Nullable id modelJson, _Nullable id value);

/*--------------------------------------------------*/

@interface GLBModelJson : NSObject

@property(nonatomic, readonly, strong, nullable) NSString* path;

- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path;
- (_Nullable instancetype)initWithUndefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;

- (void)setup NS_REQUIRES_SUPER;

- (_Nullable id)parseJson:(_Nullable id)json;

- (_Nullable id)convertValue:(_Nullable id)value;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonSet : GLBModelJson

@property(nonatomic, readonly, strong, nullable) GLBModelJson* jsonConverter;

- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithJsonConverter:(GLBModelJson* _Nullable)jsonConverter;
- (_Nullable instancetype)initWithJsonConverter:(GLBModelJson* _Nullable)jsonConverter undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path modelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path modelClass:(_Nullable Class)modelClass undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path jsonConverter:(GLBModelJson* _Nullable)jsonConverter;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path jsonConverter:(GLBModelJson* _Nullable)jsonConverter undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonOrderedSet : GLBModelJson

@property(nonatomic, readonly, strong, nullable) GLBModelJson* jsonConverter;

- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithJsonConverter:(GLBModelJson* _Nullable)jsonConverter;
- (_Nullable instancetype)initWithJsonConverter:(GLBModelJson* _Nullable)jsonConverter undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path modelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path modelClass:(_Nullable Class)modelClass undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path jsonConverter:(GLBModelJson* _Nullable)jsonConverter;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path jsonConverter:(GLBModelJson* _Nullable)jsonConverter undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonArray : GLBModelJson

@property(nonatomic, readonly, strong, nullable) GLBModelJson* jsonConverter;

- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithJsonConverter:(GLBModelJson* _Nullable)jsonConverter;
- (_Nullable instancetype)initWithJsonConverter:(GLBModelJson* _Nullable)jsonConverter undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path modelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path modelClass:(_Nullable Class)modelClass undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path jsonConverter:(GLBModelJson* _Nullable)jsonConverter;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path jsonConverter:(GLBModelJson* _Nullable)jsonConverter undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonDictionary : GLBModelJson

@property(nonatomic, readonly, strong, nullable) GLBModelJson* keyJsonConverter;
@property(nonatomic, readonly, strong, nullable) GLBModelJson* valueJsonConverter;

- (_Nullable instancetype)initWithValueModelClass:(_Nullable Class)valueModelClass;
- (_Nullable instancetype)initWithValueModelClass:(_Nullable Class)valueModelClass undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithValueJsonConverter:(GLBModelJson* _Nullable)valueJsonConverter;
- (_Nullable instancetype)initWithValueJsonConverter:(GLBModelJson* _Nullable)valueJsonConverter undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithKeyModelClass:(_Nullable Class)keyModelClass valueModelClass:(_Nullable Class)valueModelClass;
- (_Nullable instancetype)initWithKeyModelClass:(_Nullable Class)keyModelClass valueModelClass:(_Nullable Class)valueModelClass undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithKeyJsonConverter:(GLBModelJson* _Nullable)keyJsonConverter valueJsonConverter:(GLBModelJson* _Nullable)valueJsonConverter;
- (_Nullable instancetype)initWithKeyJsonConverter:(GLBModelJson* _Nullable)keyJsonConverter valueJsonConverter:(GLBModelJson* _Nullable)valueJsonConverter undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path valueModelClass:(_Nullable Class)valueModelClass;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path valueModelClass:(_Nullable Class)valueModelClass undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path valueJsonConverter:(GLBModelJson* _Nullable)valueJsonConverter;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path valueJsonConverter:(GLBModelJson* _Nullable)valueJsonConverter undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path keyModelClass:(_Nullable Class)keyModelClass valueModelClass:(_Nullable Class)valueModelClass;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path keyModelClass:(_Nullable Class)keyModelClass valueModelClass:(_Nullable Class)valueModelClass undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path keyJsonConverter:(GLBModelJson* _Nullable)keyJsonConverter valueJsonConverter:(GLBModelJson* _Nullable)valueJsonConverter;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path keyJsonConverter:(GLBModelJson* _Nullable)keyJsonConverter valueJsonConverter:(GLBModelJson* _Nullable)valueJsonConverter undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonBool : GLBModelJson

@property(nonatomic, readonly, assign) BOOL defaultValue;

- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path defaultValue:(BOOL)defaultValue;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path defaultValue:(BOOL)defaultValue undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonString : GLBModelJson

@property(nonatomic, readonly, strong, nullable) NSString* defaultValue;

- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path defaultValue:(NSString* _Nullable)defaultValue;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path defaultValue:(NSString* _Nullable)defaultValue undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonUrl : GLBModelJson

@property(nonatomic, readonly, strong, nullable) NSURL* defaultValue;

- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path defaultValue:(NSURL* _Nullable)defaultValue;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path defaultValue:(NSURL* _Nullable)defaultValue undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonNumber : GLBModelJson

@property(nonatomic, readonly, strong, nullable) NSNumber* defaultValue;

- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path defaultValue:(NSNumber* _Nullable)defaultValue;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path defaultValue:(NSNumber* _Nullable)defaultValue undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonDate : GLBModelJson

@property(nonatomic, readonly, strong, nullable) NSDate* defaultValue;
@property(nonatomic, readonly, strong, nullable) NSArray* formats;
@property(nonatomic, readonly, strong, nullable) NSTimeZone* timeZone;

- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path defaultValue:(NSDate* _Nullable)defaultValue;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nullable)defaultValue;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path defaultValue:(NSDate* _Nullable)defaultValue undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nullable)defaultValue undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithFormat:(NSString* _Nullable)format;
- (_Nullable instancetype)initWithFormat:(NSString* _Nullable)format timeZone:(NSTimeZone* _Nullable)timeZone;
- (_Nullable instancetype)initWithFormat:(NSString* _Nullable)format undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithFormat:(NSString* _Nullable)format timeZone:(NSTimeZone* _Nullable)timeZone undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithFormat:(NSString* _Nullable)format defaultValue:(NSDate* _Nullable)defaultValue;
- (_Nullable instancetype)initWithFormat:(NSString* _Nullable)format timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nullable)defaultValue;
- (_Nullable instancetype)initWithFormat:(NSString* _Nullable)format defaultValue:(NSDate* _Nullable)defaultValue undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithFormat:(NSString* _Nullable)format timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nullable)defaultValue undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path format:(NSString* _Nullable)format;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path format:(NSString* _Nullable)format timeZone:(NSTimeZone* _Nullable)timeZone;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path format:(NSString* _Nullable)format undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path format:(NSString* _Nullable)format timeZone:(NSTimeZone* _Nullable)timeZone undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path format:(NSString* _Nullable)format defaultValue:(NSDate* _Nullable)defaultValue;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path format:(NSString* _Nullable)format timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nullable)defaultValue;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path format:(NSString* _Nullable)format defaultValue:(NSDate* _Nullable)defaultValue undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path format:(NSString* _Nullable)format timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nullable)defaultValue undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithFormats:(NSArray* _Nullable)formats;
- (_Nullable instancetype)initWithFormats:(NSArray* _Nullable)formats timeZone:(NSTimeZone* _Nullable)timeZone;
- (_Nullable instancetype)initWithFormats:(NSArray* _Nullable)formats undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithFormats:(NSArray* _Nullable)formats timeZone:(NSTimeZone* _Nullable)timeZone undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithFormats:(NSArray* _Nullable)formats defaultValue:(NSDate* _Nullable)defaultValue;
- (_Nullable instancetype)initWithFormats:(NSArray* _Nullable)formats timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nullable)defaultValue;
- (_Nullable instancetype)initWithFormats:(NSArray* _Nullable)formats defaultValue:(NSDate* _Nullable)defaultValue undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithFormats:(NSArray* _Nullable)formats timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nullable)defaultValue undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path formats:(NSArray* _Nullable)formats;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path formats:(NSArray* _Nullable)formats timeZone:(NSTimeZone* _Nullable)timeZone;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path formats:(NSArray* _Nullable)formats undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path formats:(NSArray* _Nullable)formats timeZone:(NSTimeZone* _Nullable)timeZone undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path formats:(NSArray* _Nullable)formats defaultValue:(NSDate* _Nullable)defaultValue;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path formats:(NSArray* _Nullable)formats timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nullable)defaultValue;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path formats:(NSArray* _Nullable)formats defaultValue:(NSDate* _Nullable)defaultValue undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path formats:(NSArray* _Nullable)formats timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nullable)defaultValue undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonEnum : GLBModelJson

@property(nonatomic, readonly, strong, nullable) NSNumber* defaultValue;
@property(nonatomic, readonly, strong, nullable) NSDictionary* enums;

- (_Nullable instancetype)initWithEnums:(NSDictionary* _Nullable)enums;
- (_Nullable instancetype)initWithEnums:(NSDictionary* _Nullable)enums undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithEnums:(NSDictionary* _Nullable)enums defaultValue:(NSNumber* _Nullable)defaultValue;
- (_Nullable instancetype)initWithEnums:(NSDictionary* _Nullable)enums defaultValue:(NSNumber* _Nullable)defaultValue undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path enums:(NSDictionary* _Nullable)enums;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path enums:(NSDictionary* _Nullable)enums undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path enums:(NSDictionary* _Nullable)enums defaultValue:(NSNumber* _Nullable)defaultValue;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path enums:(NSDictionary* _Nullable)enums defaultValue:(NSNumber* _Nullable)defaultValue undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;

@end

/*--------------------------------------------------*/

@class CLLocation;

/*--------------------------------------------------*/

@interface GLBModelJsonLocation : GLBModelJson

@property(nonatomic, readonly, strong, nullable) CLLocation* defaultValue;

- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path defaultValue:(CLLocation* _Nullable)defaultValue;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path defaultValue:(CLLocation* _Nullable)defaultValue undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonModel : GLBModelJson

@property(nonatomic, readonly, nullable, assign) Class modelClass;
@property(nonatomic, readonly, assign) BOOL hasAnySource;

- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass hasAnySource:(BOOL)hasAnySource;
- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass hasAnySource:(BOOL)hasAnySource undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path modelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path modelClass:(_Nullable Class)modelClass hasAnySource:(BOOL)hasAnySource;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path modelClass:(_Nullable Class)modelClass undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path modelClass:(_Nullable Class)modelClass hasAnySource:(BOOL)hasAnySource undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;

@end

/*--------------------------------------------------*/

typedef _Nullable id (^GLBModelJsonConvertBlock)(_Nullable id value);

/*--------------------------------------------------*/

@interface GLBModelJsonBlock : GLBModelJson

- (_Nullable instancetype)initWithBlock:(_Nullable GLBModelJsonConvertBlock)block;
- (_Nullable instancetype)initWithBlock:(_Nullable GLBModelJsonConvertBlock)block undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path block:(_Nullable GLBModelJsonConvertBlock)block;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path block:(_Nullable GLBModelJsonConvertBlock)block undefinedBehaviour:(_Nullable GLBModelJsonUndefinedBehaviour)undefinedBehaviour;

@end

/*--------------------------------------------------*/
