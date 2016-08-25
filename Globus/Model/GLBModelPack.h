/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

@interface GLBModelPack : NSObject

- (_Nullable id)pack:(_Nullable id)packPalue;
- (_Nullable id)unpack:(_Nullable id)packPalue;

@end

/*--------------------------------------------------*/

@interface GLBModelPackSet : GLBModelPack

@property(nonatomic, readonly, nullable, strong) GLBModelPack* converter;

- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithConverter:(GLBModelPack* _Nullable)converter;

@end

/*--------------------------------------------------*/

@interface GLBModelPackOrderedSet : GLBModelPack

@property(nonatomic, readonly, nullable, strong) GLBModelPack* converter;

- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithConverter:(GLBModelPack* _Nullable)converter;

@end

/*--------------------------------------------------*/

@interface GLBModelPackArray : GLBModelPack

@property(nonatomic, readonly, nullable, strong) GLBModelPack* converter;

- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass;
- (_Nullable instancetype)initWithConverter:(GLBModelPack* _Nullable)converter;

@end

/*--------------------------------------------------*/

@interface GLBModelPackDictionary : GLBModelPack

@property(nonatomic, readonly, nullable, strong) GLBModelPack* keyConverter;
@property(nonatomic, readonly, nullable, strong) GLBModelPack* valueConverter;

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

@property(nonatomic, readonly, nullable, strong) NSString* defaultValue;

- (_Nullable instancetype)initWithDefaultValue:(NSString* _Nullable)defaultValue;

@end

/*--------------------------------------------------*/

@interface GLBModelPackUrl : GLBModelPack

@property(nonatomic, readonly, nullable, strong) NSURL* defaultValue;

- (_Nullable instancetype)initWithDefaultValue:(NSURL* _Nullable)defaultValue;

@end

/*--------------------------------------------------*/

@interface GLBModelPackNumber : GLBModelPack

@property(nonatomic, readonly, nullable, strong) NSNumber* defaultValue;

- (_Nullable instancetype)initWithDefaultValue:(NSNumber* _Nullable)defaultValue;

@end

/*--------------------------------------------------*/

@interface GLBModelPackDate : GLBModelPack

@property(nonatomic, readonly, nullable, strong) NSDate* defaultValue;

- (_Nullable instancetype)initWithDefaultValue:(NSDate* _Nullable)defaultValue;

@end

/*--------------------------------------------------*/

@class CLLocation;

/*--------------------------------------------------*/

@interface GLBModelPackLocation : GLBModelPack

@property(nonatomic, readonly, nullable, strong) CLLocation* defaultValue;

- (_Nullable instancetype)initWithDefaultValue:(CLLocation* _Nullable)defaultValue;

@end

/*--------------------------------------------------*/

@class UIColor;

/*--------------------------------------------------*/

@interface GLBModelPackColor : GLBModelPack

@property(nonatomic, readonly, nullable, strong) UIColor* defaultValue;

- (_Nullable instancetype)initWithDefaultValue:(UIColor* _Nullable)defaultValue;

@end

/*--------------------------------------------------*/

@interface GLBModelPackModel : GLBModelPack

@property(nonatomic, readonly, nullable, assign) Class modelClass;

- (_Nullable instancetype)initWithModelClass:(_Nullable Class)modelClass;

@end

/*--------------------------------------------------*/
