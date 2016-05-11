/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

@interface GLBModelPack : NSObject

- (_Nullable id)pack:(_Nullable id)value;
- (_Nullable id)unpack:(_Nullable id)value;

@end

/*--------------------------------------------------*/

@interface GLBModelPackSet : GLBModelPack

@property(nonatomic, readonly, strong, nullable) GLBModelPack* converter;

- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithConverter:(GLBModelPack* _Nullable)converter;

@end

/*--------------------------------------------------*/

@interface GLBModelPackOrderedSet : GLBModelPack

@property(nonatomic, readonly, strong, nullable) GLBModelPack* converter;

- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithConverter:(GLBModelPack* _Nullable)converter;

@end

/*--------------------------------------------------*/

@interface GLBModelPackArray : GLBModelPack

@property(nonatomic, readonly, strong, nullable) GLBModelPack* converter;

- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithConverter:(GLBModelPack* _Nullable)converter;

@end

/*--------------------------------------------------*/

@interface GLBModelPackDictionary : GLBModelPack

@property(nonatomic, readonly, strong, nullable) GLBModelPack* keyConverter;
@property(nonatomic, readonly, strong, nullable) GLBModelPack* valueConverter;

- (_Nullable instancetype)initWithValueModelClass:(_Nullable Class)valueModelClass;
- (_Nullable instancetype)initWithValueConverter:(GLBModelPack* _Nullable)valueConverter;
- (_Nullable instancetype)initWithKeyModelClass:(_Nullable Class)keyModelClass valueModelClass:(_Nullable Class)valueModelClass;
- (_Nullable instancetype)initWithKeyConverter:(GLBModelPack* _Nullable)keyConverter valueConverter:(GLBModelPack* _Nullable)valueConverter;

@end

/*--------------------------------------------------*/

@interface GLBModelPackBool : GLBModelPack

@property(nonatomic, readonly, assign) BOOL defaultValue;

- (_Nullable instancetype)initWithDefaultValue:(BOOL)defaultValue;

@end

/*--------------------------------------------------*/

@interface GLBModelPackString : GLBModelPack

@property(nonatomic, readonly, strong, nullable) NSString* defaultValue;

- (_Nullable instancetype)initWithDefaultValue:(NSString* _Nullable)defaultValue;

@end

/*--------------------------------------------------*/

@interface GLBModelPackUrl : GLBModelPack

@property(nonatomic, readonly, strong, nullable) NSURL* defaultValue;

- (_Nullable instancetype)initWithDefaultValue:(NSURL* _Nullable)defaultValue;

@end

/*--------------------------------------------------*/

@interface GLBModelPackNumber : GLBModelPack

@property(nonatomic, readonly, strong, nullable) NSNumber* defaultValue;

- (_Nullable instancetype)initWithDefaultValue:(NSNumber* _Nullable)defaultValue;

@end

/*--------------------------------------------------*/

@interface GLBModelPackDate : GLBModelPack

@property(nonatomic, readonly, strong, nullable) NSDate* defaultValue;

- (_Nullable instancetype)initWithDefaultValue:(NSDate* _Nullable)defaultValue;

@end

/*--------------------------------------------------*/

@interface GLBModelPackModel : GLBModelPack

@property(nonatomic, readonly, nullable, assign) Class modelClass;

- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass;

@end

/*--------------------------------------------------*/
