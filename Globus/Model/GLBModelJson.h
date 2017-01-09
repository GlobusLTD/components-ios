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

+ (instancetype _Nonnull)json NS_SWIFT_UNAVAILABLE("Use init()");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path NS_SWIFT_UNAVAILABLE("Use init(path:)");

- (instancetype _Nonnull)init NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path NS_DESIGNATED_INITIALIZER;

- (void)setup NS_REQUIRES_SUPER;

- (id _Nullable)fromJson:(id _Nullable)json sheme:(NSString* _Nullable)sheme;
- (id _Nullable)toJson:(id _Nullable)json sheme:(NSString* _Nullable)sheme;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonSet : GLBModelJson

@property(nonatomic, nonnull, readonly, strong) GLBModelJson* jsonConverter GLB_DEPRECATED;
@property(nonatomic, nonnull, readonly, strong) GLBModelJson* converter;

+ (instancetype _Nonnull)json NS_UNAVAILABLE;
+ (instancetype _Nonnull)jsonWithModel:(Class _Nonnull)model NS_SWIFT_UNAVAILABLE("use init(model:)");
+ (instancetype _Nonnull)jsonWithConverter:(GLBModelJson* _Nonnull)converter NS_SWIFT_UNAVAILABLE("use init(converter:)");

+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path NS_UNAVAILABLE;
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path model:(Class _Nonnull)model NS_SWIFT_UNAVAILABLE("use init(path:model:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path converter:(GLBModelJson* _Nonnull)converter NS_SWIFT_UNAVAILABLE("use init(path:converter:)");

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithModel:(Class _Nonnull)model;
- (instancetype _Nonnull)initWithConverter:(GLBModelJson* _Nonnull)converter NS_DESIGNATED_INITIALIZER;

- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path model:(Class _Nonnull)model;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path converter:(GLBModelJson* _Nonnull)converter NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonOrderedSet : GLBModelJson

@property(nonatomic, nonnull, readonly, strong) GLBModelJson* jsonConverter GLB_DEPRECATED;
@property(nonatomic, nonnull, readonly, strong) GLBModelJson* converter;

+ (instancetype _Nonnull)json NS_UNAVAILABLE;
+ (instancetype _Nonnull)jsonWithModel:(Class _Nonnull)model NS_SWIFT_UNAVAILABLE("use init(model:)");
+ (instancetype _Nonnull)jsonWithConverter:(GLBModelJson* _Nonnull)converter NS_SWIFT_UNAVAILABLE("use init(converter:)");

+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path NS_UNAVAILABLE;
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path model:(Class _Nonnull)model NS_SWIFT_UNAVAILABLE("use init(path:model:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path converter:(GLBModelJson* _Nonnull)converter NS_SWIFT_UNAVAILABLE("use init(path:converter:)");

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithModel:(Class _Nonnull)model;
- (instancetype _Nonnull)initWithConverter:(GLBModelJson* _Nonnull)converter NS_DESIGNATED_INITIALIZER;

- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path model:(Class _Nonnull)model;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path converter:(GLBModelJson* _Nonnull)converter NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonArray : GLBModelJson

@property(nonatomic, nonnull, readonly, strong) GLBModelJson* jsonConverter GLB_DEPRECATED;
@property(nonatomic, nonnull, readonly, strong) GLBModelJson* converter;

+ (instancetype _Nonnull)json NS_UNAVAILABLE;
+ (instancetype _Nonnull)jsonWithModel:(Class _Nonnull)model NS_SWIFT_UNAVAILABLE("use init(model:)");
+ (instancetype _Nonnull)jsonWithConverter:(GLBModelJson* _Nonnull)converter NS_SWIFT_UNAVAILABLE("use init(converter:)");

+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path NS_UNAVAILABLE;
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path model:(Class _Nonnull)model NS_SWIFT_UNAVAILABLE("use init(path:model:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path converter:(GLBModelJson* _Nonnull)converter NS_SWIFT_UNAVAILABLE("use init(path:converter:)");

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithModel:(Class _Nonnull)model;
- (instancetype _Nonnull)initWithConverter:(GLBModelJson* _Nonnull)converter NS_DESIGNATED_INITIALIZER;

- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path model:(Class _Nonnull)model;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path converter:(GLBModelJson* _Nonnull)converter NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonDictionary : GLBModelJson

@property(nonatomic, nullable, readonly, strong) GLBModelJson* keyJsonConverter GLB_DEPRECATED;
@property(nonatomic, nonnull, readonly, strong) GLBModelJson* valueJsonConverter GLB_DEPRECATED;
@property(nonatomic, nullable, readonly, strong) GLBModelJson* keyConverter;
@property(nonatomic, nonnull, readonly, strong) GLBModelJson* valueConverter;

+ (instancetype _Nonnull)json NS_UNAVAILABLE;
+ (instancetype _Nonnull)jsonWithValueModel:(Class _Nonnull)valueModel NS_SWIFT_UNAVAILABLE("Use init(valueModel:)");
+ (instancetype _Nonnull)jsonWithValueConverter:(GLBModelJson* _Nonnull)valueConverter NS_SWIFT_UNAVAILABLE("Use init(valueConverter:)");
+ (instancetype _Nonnull)jsonWithKeyModel:(Class _Nonnull)keyModel valueModel:(Class _Nonnull)valueModel NS_SWIFT_UNAVAILABLE("Use init(keyModel:valueModel:)");
+ (instancetype _Nonnull)jsonWithKeyConverter:(GLBModelJson* _Nonnull)keyConverter valueConverter:(GLBModelJson* _Nonnull)valueConverter NS_SWIFT_UNAVAILABLE("Use init(keyConverter:valueConverter:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path NS_UNAVAILABLE;
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path valueModel:(Class _Nonnull)valueModel NS_SWIFT_UNAVAILABLE("Use init(path:valueModel:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path valueConverter:(GLBModelJson* _Nonnull)valueConverter NS_SWIFT_UNAVAILABLE("Use init(path:valueConverter:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path keyModel:(Class _Nonnull)keyModel valueModel:(Class _Nonnull)valueModel NS_SWIFT_UNAVAILABLE("Use init(path:keyModel:valueModel:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path keyConverter:(GLBModelJson* _Nonnull)keyConverter valueConverter:(GLBModelJson* _Nonnull)valueConverter NS_SWIFT_UNAVAILABLE("Use init(path:keyConverter:valueConverter:)");

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithValueModel:(Class _Nonnull)valueModel;
- (instancetype _Nonnull)initWithValueConverter:(GLBModelJson* _Nonnull)valueConverter NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithKeyModel:(Class _Nonnull)keyModel valueModel:(Class _Nonnull)valueModel;
- (instancetype _Nonnull)initWithKeyConverter:(GLBModelJson* _Nonnull)keyConverter valueConverter:(GLBModelJson* _Nonnull)valueConverter NS_DESIGNATED_INITIALIZER;

- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path valueModel:(Class _Nonnull)valueModel;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path valueConverter:(GLBModelJson* _Nonnull)valueConverter NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path keyModel:(Class _Nonnull)keyModel valueModel:(Class _Nonnull)valueModel;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path keyConverter:(GLBModelJson* _Nonnull)keyConverter valueConverter:(GLBModelJson* _Nonnull)valueConverter NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonBool : GLBModelJson

@property(nonatomic, readonly, assign) BOOL defaultValue;

+ (instancetype _Nonnull)jsonWithDefaultValue:(BOOL)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path defaultValue:(BOOL)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:defaultValue:)");

- (instancetype _Nonnull)init NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithDefaultValue:(BOOL)defaultValue NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path defaultValue:(BOOL)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonString : GLBModelJson

@property(nonatomic, nullable, readonly, strong) NSString* defaultValue;

+ (instancetype _Nonnull)jsonWithDefaultValue:(NSString* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path defaultValue:(NSString* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:defaultValue:)");

- (instancetype _Nonnull)init NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithDefaultValue:(NSString* _Nonnull)defaultValue NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path defaultValue:(NSString* _Nonnull)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonUrl : GLBModelJson

@property(nonatomic, nullable, readonly, strong) NSURL* defaultValue;

+ (instancetype _Nonnull)jsonWithDefaultValue:(NSURL* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path defaultValue:(NSURL* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:defaultValue:)");

- (instancetype _Nonnull)init NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithDefaultValue:(NSURL* _Nonnull)defaultValue NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path defaultValue:(NSURL* _Nonnull)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonNumber : GLBModelJson

@property(nonatomic, nullable, readonly, strong) NSNumber* defaultValue;

+ (instancetype _Nonnull)jsonWithDefaultValue:(NSNumber* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path defaultValue:(NSNumber* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:defaultValue:)");

- (instancetype _Nonnull)init NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithDefaultValue:(NSNumber* _Nonnull)defaultValue NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path defaultValue:(NSNumber* _Nonnull)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonDate : GLBModelJson

@property(nonatomic, nullable, readonly, strong) NSDate* defaultValue;
@property(nonatomic, nullable, readonly, strong) NSArray< NSString* >* formats;
@property(nonatomic, nullable, readonly, strong) NSTimeZone* timeZone;

+ (instancetype _Nonnull)jsonWithFormat:(NSString* _Nonnull)format NS_SWIFT_UNAVAILABLE("Use init(format:)");
+ (instancetype _Nonnull)jsonWithFormat:(NSString* _Nonnull)format defaultValue:(NSDate* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(format:defaultValue:)");
+ (instancetype _Nonnull)jsonWithFormat:(NSString* _Nonnull)format timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(format:timeZone:defaultValue:)");
+ (instancetype _Nonnull)jsonWithFormats:(NSArray< NSString* >* _Nonnull)formats NS_SWIFT_UNAVAILABLE("Use init(formats:timeZone:defaultValue:)");
+ (instancetype _Nonnull)jsonWithFormats:(NSArray< NSString* >* _Nonnull)formats defaultValue:(NSDate* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(formats:defaultValue:)");
+ (instancetype _Nonnull)jsonWithFormats:(NSArray< NSString* >* _Nonnull)formats timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(formats:timeZone:defaultValue:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path defaultValue:(NSDate* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:defaultValue:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:timeZone:defaultValue:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path format:(NSString* _Nonnull)format NS_SWIFT_UNAVAILABLE("Use init(path:format:defaultValue:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path format:(NSString* _Nonnull)format defaultValue:(NSDate* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:format:defaultValue:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path format:(NSString* _Nonnull)format timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:format:timeZone:defaultValue:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path formats:(NSArray< NSString* >* _Nonnull)formats NS_SWIFT_UNAVAILABLE("Use init(path:formats:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path formats:(NSArray< NSString* >* _Nonnull)formats defaultValue:(NSDate* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:formats:defaultValue:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path formats:(NSArray< NSString* >* _Nonnull)formats timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:formats:timeZone:defaultValue:)");

- (instancetype _Nonnull)init NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithFormat:(NSString* _Nonnull)format NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithFormat:(NSString* _Nonnull)format defaultValue:(NSDate* _Nonnull)defaultValue;
- (instancetype _Nonnull)initWithFormat:(NSString* _Nonnull)format timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nonnull)defaultValue NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithFormats:(NSArray< NSString* >* _Nonnull)formats NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithFormats:(NSArray< NSString* >* _Nonnull)formats defaultValue:(NSDate* _Nonnull)defaultValue;
- (instancetype _Nonnull)initWithFormats:(NSArray< NSString* >* _Nonnull)formats timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nonnull)defaultValue NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path defaultValue:(NSDate* _Nonnull)defaultValue;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nonnull)defaultValue NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path format:(NSString* _Nonnull)format NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path format:(NSString* _Nonnull)format defaultValue:(NSDate* _Nonnull)defaultValue;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path format:(NSString* _Nonnull)format timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nonnull)defaultValue NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path formats:(NSArray< NSString* >* _Nonnull)formats NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path formats:(NSArray< NSString* >* _Nonnull)formats defaultValue:(NSDate* _Nonnull)defaultValue;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path formats:(NSArray< NSString* >* _Nonnull)formats timeZone:(NSTimeZone* _Nullable)timeZone defaultValue:(NSDate* _Nonnull)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonEnum : GLBModelJson

@property(nonatomic, nullable, readonly, strong) NSNumber* defaultValue;
@property(nonatomic, nullable, readonly, strong) NSDictionary* enums;

+ (instancetype _Nonnull)json NS_UNAVAILABLE;
+ (instancetype _Nonnull)jsonWithEnums:(NSDictionary* _Nonnull)enums NS_SWIFT_UNAVAILABLE("Use init(enums:)");
+ (instancetype _Nonnull)jsonWithEnums:(NSDictionary* _Nonnull)enums defaultValue:(NSNumber* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(enums:defaultValue:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path NS_UNAVAILABLE;
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path enums:(NSDictionary* _Nonnull)enums NS_SWIFT_UNAVAILABLE("Use init(path:enums:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path enums:(NSDictionary* _Nonnull)enums defaultValue:(NSNumber* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:enums:defaultValue:)");

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithEnums:(NSDictionary* _Nonnull)enums NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithEnums:(NSDictionary* _Nonnull)enums defaultValue:(NSNumber* _Nonnull)defaultValue NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path enums:(NSDictionary* _Nonnull)enums NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path enums:(NSDictionary* _Nonnull)enums defaultValue:(NSNumber* _Nonnull)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@class UIColor;

/*--------------------------------------------------*/

@interface GLBModelJsonColor : GLBModelJson

@property(nonatomic, nullable, readonly, strong) UIColor* defaultValue;

+ (instancetype _Nonnull)jsonWithDefaultValue:(UIColor* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path defaultValue:(UIColor* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(path:defaultValue:)");

- (instancetype _Nonnull)init NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithDefaultValue:(UIColor* _Nonnull)defaultValue NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path defaultValue:(UIColor* _Nonnull)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelJsonModel : GLBModelJson

@property(nonatomic, nonnull, readonly, strong) Class modelClass GLB_DEPRECATED;
@property(nonatomic, nonnull, readonly, assign) Class model;

+ (instancetype _Nonnull)json NS_UNAVAILABLE;
+ (instancetype _Nonnull)jsonWithModel:(Class _Nonnull)model NS_SWIFT_UNAVAILABLE("Use init(model:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path NS_UNAVAILABLE;
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path model:(Class _Nonnull)model NS_SWIFT_UNAVAILABLE("Use init(path:model:)");

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithModel:(Class _Nonnull)model NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path model:(Class _Nonnull)model NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

typedef id _Nullable (^GLBModelJsonConvertBlock)(id _Nullable value, NSString* _Nullable sheme);

/*--------------------------------------------------*/

@interface GLBModelJsonBlock : GLBModelJson

@property(nonatomic, nonnull, readonly, copy) GLBModelJsonConvertBlock fromBlock;
@property(nonatomic, nonnull, readonly, copy) GLBModelJsonConvertBlock toBlock;

+ (instancetype _Nonnull)json NS_UNAVAILABLE;
+ (instancetype _Nonnull)jsonWithFromBlock:(GLBModelJsonConvertBlock _Nonnull)fromBlock toBlock:(GLBModelJsonConvertBlock _Nonnull)toBlock NS_SWIFT_UNAVAILABLE("Use init(fromBlock:toBlock:)");
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path NS_UNAVAILABLE;
+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path fromBlock:(GLBModelJsonConvertBlock _Nonnull)fromBlock toBlock:(GLBModelJsonConvertBlock _Nonnull)toBlock NS_SWIFT_UNAVAILABLE("Use init(path:fromBlock:toBlock:)");

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithFromBlock:(GLBModelJsonConvertBlock _Nonnull)fromBlock toBlock:(GLBModelJsonConvertBlock _Nonnull)toBlock NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithPath:(NSString* _Nonnull)path fromBlock:(GLBModelJsonConvertBlock _Nonnull)fromBlock toBlock:(GLBModelJsonConvertBlock _Nonnull)toBlock NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/
