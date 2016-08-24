/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

@interface GLBModelJson : NSObject

@property(nonatomic, readonly, nullable, strong) NSString* path;
@property(nonatomic, readonly, nullable, strong) NSArray< NSString* >* subPaths;
@property(nonatomic, readonly, nullable, strong) NSArray< NSArray< NSString* >* >* subPathParts;

- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path;

- (void)setup NS_REQUIRES_SUPER;

- (_Nullable id)fromJson:(_Nullable id)json sheme:(NSString* _Nonnull)sheme;
- (_Nullable id)toJson:(_Nullable id)json sheme:(NSString* _Nonnull)sheme;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonSet : GLBModelJson

@property(nonatomic, readonly, nullable, strong) GLBModelJson* jsonConverter;

- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithJsonConverter:(GLBModelJson* _Nullable)jsonConverter;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path modelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path jsonConverter:(GLBModelJson* _Nullable)jsonConverter;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonOrderedSet : GLBModelJson

@property(nonatomic, readonly, nullable, strong) GLBModelJson* jsonConverter;

- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithJsonConverter:(GLBModelJson* _Nullable)jsonConverter;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path modelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path jsonConverter:(GLBModelJson* _Nullable)jsonConverter;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonArray : GLBModelJson

@property(nonatomic, readonly, nullable, strong) GLBModelJson* jsonConverter;

- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithJsonConverter:(GLBModelJson* _Nullable)jsonConverter;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path modelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path jsonConverter:(GLBModelJson* _Nullable)jsonConverter;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonDictionary : GLBModelJson

@property(nonatomic, readonly, nullable, strong) GLBModelJson* keyJsonConverter;
@property(nonatomic, readonly, nullable, strong) GLBModelJson* valueJsonConverter;

- (_Nullable instancetype)initWithValueModelClass:(_Nullable Class)valueModelClass;
- (_Nullable instancetype)initWithValueJsonConverter:(GLBModelJson* _Nullable)valueJsonConverter;
- (_Nullable instancetype)initWithKeyModelClass:(_Nullable Class)keyModelClass valueModelClass:(_Nullable Class)valueModelClass;
- (_Nullable instancetype)initWithKeyJsonConverter:(GLBModelJson* _Nullable)keyJsonConverter valueJsonConverter:(GLBModelJson* _Nullable)valueJsonConverter;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path valueModelClass:(_Nullable Class)valueModelClass;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path valueJsonConverter:(GLBModelJson* _Nullable)valueJsonConverter;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path keyModelClass:(_Nullable Class)keyModelClass valueModelClass:(_Nullable Class)valueModelClass;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path keyJsonConverter:(GLBModelJson* _Nullable)keyJsonConverter valueJsonConverter:(GLBModelJson* _Nullable)valueJsonConverter;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonBool : GLBModelJson

@property(nonatomic, readonly, assign) BOOL defaultValue;

- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path defaultValue:(BOOL)defaultValue;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonString : GLBModelJson

@property(nonatomic, readonly, nullable, strong) NSString* defaultValue;

- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path defaultValue:(NSString* _Nullable)defaultValue;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonUrl : GLBModelJson

@property(nonatomic, readonly, nullable, strong) NSURL* defaultValue;

- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path defaultValue:(NSURL* _Nullable)defaultValue;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonNumber : GLBModelJson

@property(nonatomic, readonly, nullable, strong) NSNumber* defaultValue;

- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path defaultValue:(NSNumber* _Nullable)defaultValue;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonDate : GLBModelJson

@property(nonatomic, readonly, nullable, strong) NSDate* defaultValue;
@property(nonatomic, readonly, nullable, strong) NSArray< NSString* >* formats;
@property(nonatomic, readonly, nullable, strong) NSTimeZone* timeZone;

- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path defaultValue:(NSDate* _Nullable)defaultValue;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nullable)defaultValue;
- (_Nullable instancetype)initWithFormat:(NSString* _Nullable)format;
- (_Nullable instancetype)initWithFormat:(NSString* _Nullable)format timeZone:(NSTimeZone* _Nullable)timeZone;
- (_Nullable instancetype)initWithFormat:(NSString* _Nullable)format defaultValue:(NSDate* _Nullable)defaultValue;
- (_Nullable instancetype)initWithFormat:(NSString* _Nullable)format timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nullable)defaultValue;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path format:(NSString* _Nullable)format;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path format:(NSString* _Nullable)format timeZone:(NSTimeZone* _Nullable)timeZone;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path format:(NSString* _Nullable)format defaultValue:(NSDate* _Nullable)defaultValue;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path format:(NSString* _Nullable)format timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nullable)defaultValue;
- (_Nullable instancetype)initWithFormats:(NSArray< NSString* >* _Nullable)formats;
- (_Nullable instancetype)initWithFormats:(NSArray< NSString* >* _Nullable)formats timeZone:(NSTimeZone* _Nullable)timeZone;
- (_Nullable instancetype)initWithFormats:(NSArray< NSString* >* _Nullable)formats defaultValue:(NSDate* _Nullable)defaultValue;
- (_Nullable instancetype)initWithFormats:(NSArray< NSString* >* _Nullable)formats timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nullable)defaultValue;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path formats:(NSArray< NSString* >* _Nullable)formats;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path formats:(NSArray< NSString* >* _Nullable)formats timeZone:(NSTimeZone* _Nullable)timeZone;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path formats:(NSArray< NSString* >* _Nullable)formats defaultValue:(NSDate* _Nullable)defaultValue;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path formats:(NSArray< NSString* >* _Nullable)formats timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nullable)defaultValue;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonEnum : GLBModelJson

@property(nonatomic, readonly, nullable, strong) NSNumber* defaultValue;
@property(nonatomic, readonly, nullable, strong) NSDictionary* enums;

- (_Nullable instancetype)initWithEnums:(NSDictionary* _Nullable)enums;
- (_Nullable instancetype)initWithEnums:(NSDictionary* _Nullable)enums defaultValue:(NSNumber* _Nullable)defaultValue;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path enums:(NSDictionary* _Nullable)enums;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path enums:(NSDictionary* _Nullable)enums defaultValue:(NSNumber* _Nullable)defaultValue;

@end

/*--------------------------------------------------*/

@class UIColor;

/*--------------------------------------------------*/

@interface GLBModelJsonColor : GLBModelJson

@property(nonatomic, readonly, nullable, strong) UIColor* defaultValue;

- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path defaultValue:(UIColor* _Nullable)defaultValue;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonModel : GLBModelJson

@property(nonatomic, readonly, nullable, assign) Class modelClass;

- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path modelClass:(_Nullable Class)modelClass;

@end

/*--------------------------------------------------*/

typedef _Nullable id (^GLBModelJsonConvertBlock)(_Nullable id value, NSString* _Nullable sheme);

/*--------------------------------------------------*/

@interface GLBModelJsonBlock : GLBModelJson

- (_Nullable instancetype)initWithFromBlock:(_Nullable GLBModelJsonConvertBlock)fromBlock;
- (_Nullable instancetype)initWithToBlock:(_Nullable GLBModelJsonConvertBlock)toBlock;
- (_Nullable instancetype)initWithFromBlock:(_Nullable GLBModelJsonConvertBlock)fromBlock toBlock:(_Nullable GLBModelJsonConvertBlock)toBlock;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path fromBlock:(_Nullable GLBModelJsonConvertBlock)fromBlock;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path toBlock:(_Nullable GLBModelJsonConvertBlock)toBlock;
- (_Nullable instancetype)initWithPath:(NSString* _Nullable)path fromBlock:(_Nullable GLBModelJsonConvertBlock)fromBlock toBlock:(_Nullable GLBModelJsonConvertBlock)toBlock;

@end

/*--------------------------------------------------*/
