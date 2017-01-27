/*--------------------------------------------------*/

#import "NSDictionary+GLBNS.h"
#import "NSArray+GLBNS.h"
#import "NSString+GLBNS.h"
#import "NSDate+GLBNS.h"

/*--------------------------------------------------*/

#import "UIColor+GLBUI.h"

/*--------------------------------------------------*/

@interface GLBModelJson : NSObject

@property(nonatomic, nullable, readonly, strong) NSString* path;
@property(nonatomic, nullable, readonly, strong) NSArray< NSString* >* subPaths;
@property(nonatomic, nullable, readonly, strong) NSArray< NSArray< NSString* >* >* subPathParts;

+ (nonnull instancetype)json NS_SWIFT_UNAVAILABLE("Use init()");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path NS_SWIFT_UNAVAILABLE("Use init(path:)");

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path NS_DESIGNATED_INITIALIZER;

- (void)setup NS_REQUIRES_SUPER;

- (nullable id)fromJson:(nullable id)json sheme:(nullable NSString*)sheme;
- (nullable id)toJson:(nullable id)json sheme:(nullable NSString*)sheme;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonSet : GLBModelJson

@property(nonatomic, nonnull, readonly, strong) GLBModelJson* jsonConverter GLB_DEPRECATED;
@property(nonatomic, nonnull, readonly, strong) GLBModelJson* converter;

+ (nonnull instancetype)json NS_UNAVAILABLE;
+ (nonnull instancetype)jsonWithModel:(nonnull Class)model NS_SWIFT_UNAVAILABLE("use init(model:)");
+ (nonnull instancetype)jsonWithConverter:(nonnull GLBModelJson*)converter NS_SWIFT_UNAVAILABLE("use init(converter:)");

+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path NS_UNAVAILABLE;
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path model:(nonnull Class)model NS_SWIFT_UNAVAILABLE("use init(path:model:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path converter:(nonnull GLBModelJson*)converter NS_SWIFT_UNAVAILABLE("use init(path:converter:)");

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithModel:(nonnull Class)model;
- (nonnull instancetype)initWithConverter:(nonnull GLBModelJson*)converter NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)initWithPath:(nonnull NSString*)path NS_UNAVAILABLE;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path model:(nonnull Class)model;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path converter:(nonnull GLBModelJson*)converter NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonOrderedSet : GLBModelJson

@property(nonatomic, nonnull, readonly, strong) GLBModelJson* jsonConverter GLB_DEPRECATED;
@property(nonatomic, nonnull, readonly, strong) GLBModelJson* converter;

+ (nonnull instancetype)json NS_UNAVAILABLE;
+ (nonnull instancetype)jsonWithModel:(nonnull Class)model NS_SWIFT_UNAVAILABLE("use init(model:)");
+ (nonnull instancetype)jsonWithConverter:(nonnull GLBModelJson*)converter NS_SWIFT_UNAVAILABLE("use init(converter:)");

+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path NS_UNAVAILABLE;
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path model:(nonnull Class)model NS_SWIFT_UNAVAILABLE("use init(path:model:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path converter:(nonnull GLBModelJson*)converter NS_SWIFT_UNAVAILABLE("use init(path:converter:)");

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithModel:(nonnull Class)model;
- (nonnull instancetype)initWithConverter:(nonnull GLBModelJson*)converter NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)initWithPath:(nonnull NSString*)path NS_UNAVAILABLE;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path model:(nonnull Class)model;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path converter:(nonnull GLBModelJson*)converter NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonArray : GLBModelJson

@property(nonatomic, nonnull, readonly, strong) GLBModelJson* jsonConverter GLB_DEPRECATED;
@property(nonatomic, nonnull, readonly, strong) GLBModelJson* converter;

+ (nonnull instancetype)json NS_UNAVAILABLE;
+ (nonnull instancetype)jsonWithModel:(nonnull Class)model NS_SWIFT_UNAVAILABLE("use init(model:)");
+ (nonnull instancetype)jsonWithConverter:(nonnull GLBModelJson*)converter NS_SWIFT_UNAVAILABLE("use init(converter:)");

+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path NS_UNAVAILABLE;
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path model:(nonnull Class)model NS_SWIFT_UNAVAILABLE("use init(path:model:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path converter:(nonnull GLBModelJson*)converter NS_SWIFT_UNAVAILABLE("use init(path:converter:)");

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithModel:(nonnull Class)model;
- (nonnull instancetype)initWithConverter:(nonnull GLBModelJson*)converter NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)initWithPath:(nonnull NSString*)path NS_UNAVAILABLE;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path model:(nonnull Class)model;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path converter:(nonnull GLBModelJson*)converter NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonDictionary : GLBModelJson

@property(nonatomic, nullable, readonly, strong) GLBModelJson* keyJsonConverter GLB_DEPRECATED;
@property(nonatomic, nonnull, readonly, strong) GLBModelJson* valueJsonConverter GLB_DEPRECATED;
@property(nonatomic, nullable, readonly, strong) GLBModelJson* keyConverter;
@property(nonatomic, nonnull, readonly, strong) GLBModelJson* valueConverter;

+ (nonnull instancetype)json NS_UNAVAILABLE;
+ (nonnull instancetype)jsonWithValueModel:(nonnull Class)valueModel NS_SWIFT_UNAVAILABLE("Use init(valueModel:)");
+ (nonnull instancetype)jsonWithValueConverter:(nonnull GLBModelJson*)valueConverter NS_SWIFT_UNAVAILABLE("Use init(valueConverter:)");
+ (nonnull instancetype)jsonWithKeyModel:(nonnull Class)keyModel valueModel:(nonnull Class)valueModel NS_SWIFT_UNAVAILABLE("Use init(keyModel:valueModel:)");
+ (nonnull instancetype)jsonWithKeyConverter:(nonnull GLBModelJson*)keyConverter valueConverter:(nonnull GLBModelJson*)valueConverter NS_SWIFT_UNAVAILABLE("Use init(keyConverter:valueConverter:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path NS_UNAVAILABLE;
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path valueModel:(nonnull Class)valueModel NS_SWIFT_UNAVAILABLE("Use init(path:valueModel:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path valueConverter:(nonnull GLBModelJson*)valueConverter NS_SWIFT_UNAVAILABLE("Use init(path:valueConverter:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path keyModel:(nonnull Class)keyModel valueModel:(nonnull Class)valueModel NS_SWIFT_UNAVAILABLE("Use init(path:keyModel:valueModel:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path keyConverter:(nonnull GLBModelJson*)keyConverter valueConverter:(nonnull GLBModelJson*)valueConverter NS_SWIFT_UNAVAILABLE("Use init(path:keyConverter:valueConverter:)");

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithValueModel:(nonnull Class)valueModel;
- (nonnull instancetype)initWithValueConverter:(nonnull GLBModelJson*)valueConverter NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithKeyModel:(nonnull Class)keyModel valueModel:(nonnull Class)valueModel;
- (nonnull instancetype)initWithKeyConverter:(nonnull GLBModelJson*)keyConverter valueConverter:(nonnull GLBModelJson*)valueConverter NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)initWithPath:(nonnull NSString*)path NS_UNAVAILABLE;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path valueModel:(nonnull Class)valueModel;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path valueConverter:(nonnull GLBModelJson*)valueConverter NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path keyModel:(nonnull Class)keyModel valueModel:(nonnull Class)valueModel;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path keyConverter:(nonnull GLBModelJson*)keyConverter valueConverter:(nonnull GLBModelJson*)valueConverter NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonBool : GLBModelJson

@property(nonatomic, readonly, assign) BOOL defaultValue;

+ (nonnull instancetype)jsonWithDefaultValue:(BOOL)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path defaultValue:(BOOL)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:defaultValue:)");

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithDefaultValue:(BOOL)defaultValue NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path defaultValue:(BOOL)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonString : GLBModelJson

@property(nonatomic, nullable, readonly, strong) NSString* defaultValue;

+ (nonnull instancetype)jsonWithDefaultValue:(nonnull NSString*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path defaultValue:(nonnull NSString*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:defaultValue:)");

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithDefaultValue:(nonnull NSString*)defaultValue NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path defaultValue:(nonnull NSString*)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonUrl : GLBModelJson

@property(nonatomic, nullable, readonly, strong) NSURL* defaultValue;

+ (nonnull instancetype)jsonWithDefaultValue:(nonnull NSURL*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path defaultValue:(nonnull NSURL*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:defaultValue:)");

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithDefaultValue:(nonnull NSURL*)defaultValue NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path defaultValue:(nonnull NSURL*)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonNumber : GLBModelJson

@property(nonatomic, nullable, readonly, strong) NSNumber* defaultValue;

+ (nonnull instancetype)jsonWithDefaultValue:(nonnull NSNumber*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path defaultValue:(nonnull NSNumber*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:defaultValue:)");

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithDefaultValue:(nonnull NSNumber*)defaultValue NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path defaultValue:(nonnull NSNumber*)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonDate : GLBModelJson

@property(nonatomic, nullable, readonly, strong) NSDate* defaultValue;
@property(nonatomic, nullable, readonly, strong) NSArray< NSString* >* formats;
@property(nonatomic, nullable, readonly, strong) NSTimeZone* timeZone;

+ (nonnull instancetype)jsonWithFormat:(nonnull NSString*)format NS_SWIFT_UNAVAILABLE("Use init(format:)");
+ (nonnull instancetype)jsonWithFormat:(nonnull NSString*)format defaultValue:(nonnull NSDate*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(format:defaultValue:)");
+ (nonnull instancetype)jsonWithFormat:(nonnull NSString*)format timeZone:(nullable NSTimeZone*)timeZone defaultValue:(nonnull NSDate*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(format:timeZone:defaultValue:)");
+ (nonnull instancetype)jsonWithFormats:(nonnull NSArray< NSString* >*)formats NS_SWIFT_UNAVAILABLE("Use init(formats:timeZone:defaultValue:)");
+ (nonnull instancetype)jsonWithFormats:(nonnull NSArray< NSString* >*)formats defaultValue:(nonnull NSDate*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(formats:defaultValue:)");
+ (nonnull instancetype)jsonWithFormats:(nonnull NSArray< NSString* >*)formats timeZone:(nullable NSTimeZone*)timeZone defaultValue:(nonnull NSDate*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(formats:timeZone:defaultValue:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path defaultValue:(nonnull NSDate*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:defaultValue:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path timeZone:(nullable NSTimeZone*)timeZone defaultValue:(nonnull NSDate*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:timeZone:defaultValue:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path format:(nonnull NSString*)format NS_SWIFT_UNAVAILABLE("Use init(path:format:defaultValue:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path format:(nonnull NSString*)format defaultValue:(nonnull NSDate*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:format:defaultValue:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path format:(nonnull NSString*)format timeZone:(nullable NSTimeZone*)timeZone defaultValue:(nonnull NSDate*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:format:timeZone:defaultValue:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path formats:(nonnull NSArray< NSString* >*)formats NS_SWIFT_UNAVAILABLE("Use init(path:formats:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path formats:(nonnull NSArray< NSString* >*)formats defaultValue:(nonnull NSDate*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:formats:defaultValue:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path formats:(nonnull NSArray< NSString* >*)formats timeZone:(nullable NSTimeZone*)timeZone defaultValue:(nonnull NSDate*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:formats:timeZone:defaultValue:)");

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFormat:(nonnull NSString*)format NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFormat:(nonnull NSString*)format defaultValue:(nonnull NSDate*)defaultValue;
- (nonnull instancetype)initWithFormat:(nonnull NSString*)format timeZone:(nullable NSTimeZone*)timeZone defaultValue:(nonnull NSDate*)defaultValue NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFormats:(nonnull NSArray< NSString* >*)formats NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFormats:(nonnull NSArray< NSString* >*)formats defaultValue:(nonnull NSDate*)defaultValue;
- (nonnull instancetype)initWithFormats:(nonnull NSArray< NSString* >*)formats timeZone:(nullable NSTimeZone*)timeZone defaultValue:(nonnull NSDate*)defaultValue NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path defaultValue:(nonnull NSDate*)defaultValue;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path timeZone:(nullable NSTimeZone*)timeZone defaultValue:(nonnull NSDate*)defaultValue NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path format:(nonnull NSString*)format NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path format:(nonnull NSString*)format defaultValue:(nonnull NSDate*)defaultValue;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path format:(nonnull NSString*)format timeZone:(nullable NSTimeZone*)timeZone defaultValue:(nonnull NSDate*)defaultValue NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path formats:(nonnull NSArray< NSString* >*)formats NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path formats:(nonnull NSArray< NSString* >*)formats defaultValue:(nonnull NSDate*)defaultValue;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path formats:(nonnull NSArray< NSString* >*)formats timeZone:(nullable NSTimeZone*)timeZone defaultValue:(nonnull NSDate*)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonEnum : GLBModelJson

@property(nonatomic, nullable, readonly, strong) NSNumber* defaultValue;
@property(nonatomic, nullable, readonly, strong) NSDictionary* enums;

+ (nonnull instancetype)json NS_UNAVAILABLE;
+ (nonnull instancetype)jsonWithEnums:(nonnull NSDictionary*)enums NS_SWIFT_UNAVAILABLE("Use init(enums:)");
+ (nonnull instancetype)jsonWithEnums:(nonnull NSDictionary*)enums defaultValue:(nonnull NSNumber*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(enums:defaultValue:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path NS_UNAVAILABLE;
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path enums:(nonnull NSDictionary*)enums NS_SWIFT_UNAVAILABLE("Use init(path:enums:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path enums:(nonnull NSDictionary*)enums defaultValue:(nonnull NSNumber*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:enums:defaultValue:)");

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithEnums:(nonnull NSDictionary*)enums NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithEnums:(nonnull NSDictionary*)enums defaultValue:(nonnull NSNumber*)defaultValue NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path NS_UNAVAILABLE;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path enums:(nonnull NSDictionary*)enums NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path enums:(nonnull NSDictionary*)enums defaultValue:(nonnull NSNumber*)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@class UIColor;

/*--------------------------------------------------*/

@interface GLBModelJsonColor : GLBModelJson

@property(nonatomic, nullable, readonly, strong) UIColor* defaultValue;

+ (nonnull instancetype)jsonWithDefaultValue:(nonnull UIColor*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path defaultValue:(nonnull UIColor*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:defaultValue:)");

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithDefaultValue:(nonnull UIColor*)defaultValue NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path defaultValue:(nonnull UIColor*)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonModel : GLBModelJson

@property(nonatomic, nonnull, readonly, strong) Class modelClass GLB_DEPRECATED;
@property(nonatomic, nonnull, readonly, assign) Class model;

+ (nonnull instancetype)json NS_UNAVAILABLE;
+ (nonnull instancetype)jsonWithModel:(nonnull Class)model NS_SWIFT_UNAVAILABLE("Use init(model:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path NS_UNAVAILABLE;
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path model:(nonnull Class)model NS_SWIFT_UNAVAILABLE("Use init(path:model:)");

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithModel:(nonnull Class)model NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path NS_UNAVAILABLE;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path model:(nonnull Class)model NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

typedef id _Nullable (^GLBModelJsonConvertBlock)(id _Nullable value, NSString* _Nullable sheme);

/*--------------------------------------------------*/

@interface GLBModelJsonBlock : GLBModelJson

@property(nonatomic, nonnull, readonly, copy) GLBModelJsonConvertBlock fromBlock;
@property(nonatomic, nonnull, readonly, copy) GLBModelJsonConvertBlock toBlock;

+ (nonnull instancetype)json NS_UNAVAILABLE;
+ (nonnull instancetype)jsonWithFromBlock:(nonnull GLBModelJsonConvertBlock)fromBlock toBlock:(nonnull GLBModelJsonConvertBlock)toBlock NS_SWIFT_UNAVAILABLE("Use init(fromBlock:toBlock:)");
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path NS_UNAVAILABLE;
+ (nonnull instancetype)jsonWithPath:(nonnull NSString*)path fromBlock:(nonnull GLBModelJsonConvertBlock)fromBlock toBlock:(nonnull GLBModelJsonConvertBlock)toBlock NS_SWIFT_UNAVAILABLE("Use init(path:fromBlock:toBlock:)");

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithFromBlock:(nonnull GLBModelJsonConvertBlock)fromBlock toBlock:(nonnull GLBModelJsonConvertBlock)toBlock NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path NS_UNAVAILABLE;
- (nonnull instancetype)initWithPath:(nonnull NSString*)path fromBlock:(nonnull GLBModelJsonConvertBlock)fromBlock toBlock:(nonnull GLBModelJsonConvertBlock)toBlock NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/
