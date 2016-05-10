/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

@interface GLBModelPack : NSObject

@property(nonatomic, readonly, strong, nullable) NSString* key;
@property(nonatomic, readonly, strong, nullable) NSNumber* keyHash;

- (_Nullable instancetype)initWithKey:(NSString* _Nullable)key;

- (void)setup NS_REQUIRES_SUPER;

- (void)pack:(NSMutableDictionary< NSNumber*, id >* _Nonnull)data value:(_Nullable id)value;
- (_Nullable id)unpack:(NSDictionary< NSNumber*, id >* _Nonnull)data;

- (_Nullable id)packValue:(_Nullable id)value;
- (_Nullable id)unpackValue:(_Nullable id)value;

@end

/*--------------------------------------------------*/

@interface GLBModelPackSet : GLBModelPack

@property(nonatomic, readonly, strong, nullable) GLBModelPack* converter;

- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithConverter:(GLBModelPack* _Nullable)converter;
- (_Nullable instancetype)initWithKey:(NSString* _Nullable)key modelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithKey:(NSString* _Nullable)key converter:(GLBModelPack* _Nullable)converter;

@end

/*--------------------------------------------------*/

@interface GLBModelPackOrderedSet : GLBModelPack

@property(nonatomic, readonly, strong, nullable) GLBModelPack* converter;

- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithConverter:(GLBModelPack* _Nullable)converter;
- (_Nullable instancetype)initWithKey:(NSString* _Nullable)key modelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithKey:(NSString* _Nullable)key converter:(GLBModelPack* _Nullable)converter;

@end

/*--------------------------------------------------*/

@interface GLBModelPackArray : GLBModelPack

@property(nonatomic, readonly, strong, nullable) GLBModelPack* converter;

- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithConverter:(GLBModelPack* _Nullable)converter;
- (_Nullable instancetype)initWithKey:(NSString* _Nullable)key modelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithKey:(NSString* _Nullable)key converter:(GLBModelPack* _Nullable)converter;

@end

/*--------------------------------------------------*/

@interface GLBModelPackDictionary : GLBModelPack

@property(nonatomic, readonly, strong, nullable) GLBModelPack* keyConverter;
@property(nonatomic, readonly, strong, nullable) GLBModelPack* valueConverter;

- (_Nullable instancetype)initWithValueModelClass:(_Nullable Class)valueModelClass;
- (_Nullable instancetype)initWithValueConverter:(GLBModelPack* _Nullable)valueConverter;
- (_Nullable instancetype)initWithKeyModelClass:(_Nullable Class)keyModelClass valueModelClass:(_Nullable Class)valueModelClass;
- (_Nullable instancetype)initWithKeyConverter:(GLBModelPack* _Nullable)keyConverter valueConverter:(GLBModelPack* _Nullable)valueConverter;
- (_Nullable instancetype)initWithKey:(NSString* _Nullable)key valueModelClass:(_Nullable Class)valueModelClass;
- (_Nullable instancetype)initWithKey:(NSString* _Nullable)key valueConverter:(GLBModelPack* _Nullable)valueConverter;
- (_Nullable instancetype)initWithKey:(NSString* _Nullable)key keyModelClass:(_Nullable Class)keyModelClass valueModelClass:(_Nullable Class)valueModelClass;
- (_Nullable instancetype)initWithKey:(NSString* _Nullable)key keyConverter:(GLBModelPack* _Nullable)keyConverter valueConverter:(GLBModelPack* _Nullable)valueConverter;

@end

/*--------------------------------------------------*/

@interface GLBModelPackBool : GLBModelPack

@property(nonatomic, readonly, assign) BOOL defaultValue;

- (_Nullable instancetype)initWithKey:(NSString* _Nullable)key defaultValue:(BOOL)defaultValue;

@end

/*--------------------------------------------------*/

@interface GLBModelPackString : GLBModelPack

@property(nonatomic, readonly, strong, nullable) NSString* defaultValue;

- (_Nullable instancetype)initWithKey:(NSString* _Nullable)key defaultValue:(NSString* _Nullable)defaultValue;

@end

/*--------------------------------------------------*/

@interface GLBModelPackUrl : GLBModelPack

@property(nonatomic, readonly, strong, nullable) NSURL* defaultValue;

- (_Nullable instancetype)initWithKey:(NSString* _Nullable)key defaultValue:(NSURL* _Nullable)defaultValue;

@end

/*--------------------------------------------------*/

@interface GLBModelPackNumber : GLBModelPack

@property(nonatomic, readonly, strong, nullable) NSNumber* defaultValue;

- (_Nullable instancetype)initWithKey:(NSString* _Nullable)key defaultValue:(NSNumber* _Nullable)defaultValue;

@end

/*--------------------------------------------------*/

@interface GLBModelPackDate : GLBModelPack

@property(nonatomic, readonly, strong, nullable) NSDate* defaultValue;

- (_Nullable instancetype)initWithKey:(NSString* _Nullable)key defaultValue:(NSDate* _Nullable)defaultValue;

@end

/*--------------------------------------------------*/

@interface GLBModelPackModel : GLBModelPack

@property(nonatomic, readonly, nullable, assign) Class modelClass;

- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithKey:(NSString* _Nullable)key modelClass:(_Nullable Class)modelClass;

@end

/*--------------------------------------------------*/
