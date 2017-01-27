/*--------------------------------------------------*/

#import "NSDictionary+GLBNS.h"
#import "NSArray+GLBNS.h"
#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

#import "UIColor+GLBUI.h"

/*--------------------------------------------------*/

@interface GLBModelPack : NSObject

+ (nonnull instancetype)pack NS_SWIFT_UNAVAILABLE("Use init()");

- (nullable id)pack:(nullable id)packValue;
- (nullable id)unpack:(nullable id)packValue;

@end

/*--------------------------------------------------*/

@interface GLBModelPackSet : GLBModelPack

@property(nonatomic, nonnull, readonly, strong) GLBModelPack* converter;

+ (nonnull instancetype)pack NS_UNAVAILABLE;
+ (nonnull instancetype)packWithModel:(nonnull Class)model NS_SWIFT_UNAVAILABLE("Use init(model:)");
+ (nonnull instancetype)packWithConverter:(nonnull GLBModelPack*)converter NS_SWIFT_UNAVAILABLE("Use init(converter:)");

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithModel:(nonnull Class)model;
- (nonnull instancetype)initWithConverter:(nonnull GLBModelPack*)converter NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelPackOrderedSet : GLBModelPack

@property(nonatomic, nonnull, readonly, strong) GLBModelPack* converter;

+ (nonnull instancetype)pack NS_UNAVAILABLE;
+ (nonnull instancetype)packWithModel:(nonnull Class)model NS_SWIFT_UNAVAILABLE("Use init(model:)");
+ (nonnull instancetype)packWithConverter:(nonnull GLBModelPack*)converter NS_SWIFT_UNAVAILABLE("Use init(converter:)");

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithModel:(nonnull Class)model;
- (nonnull instancetype)initWithConverter:(nonnull GLBModelPack*)converter NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelPackArray : GLBModelPack

@property(nonatomic, nonnull, readonly, strong) GLBModelPack* converter;

+ (nonnull instancetype)pack NS_UNAVAILABLE;
+ (nonnull instancetype)packWithModel:(nonnull Class)model NS_SWIFT_UNAVAILABLE("Use init(model:)");
+ (nonnull instancetype)packWithConverter:(nonnull GLBModelPack*)converter NS_SWIFT_UNAVAILABLE("Use init(converter:)");

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithModel:(nonnull Class)model;
- (nonnull instancetype)initWithConverter:(nonnull GLBModelPack*)converter NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelPackDictionary : GLBModelPack

@property(nonatomic, nonnull, readonly, strong) GLBModelPack* keyConverter;
@property(nonatomic, nonnull, readonly, strong) GLBModelPack* valueConverter;

+ (nonnull instancetype)pack NS_UNAVAILABLE;
+ (nonnull instancetype)packWithKeyModel:(nonnull Class)keyModel valueModel:(nonnull Class)valueModel NS_SWIFT_UNAVAILABLE("Use init(keyModel:valueModel:)");
+ (nonnull instancetype)packWithKeyConverter:(nonnull GLBModelPack*)keyConverter valueConverter:(nonnull GLBModelPack*)valueConverter NS_SWIFT_UNAVAILABLE("Use init(keyConverter:valueConverter:)");

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithKeyModel:(nonnull Class)keyModel valueModel:(nonnull Class)valueModel;
- (nonnull instancetype)initWithKeyConverter:(nonnull GLBModelPack*)keyConverter valueConverter:(nonnull GLBModelPack*)valueConverter NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelPackBool : GLBModelPack

@property(nonatomic, readonly, assign) BOOL defaultValue;

+ (nonnull instancetype)packWithDefaultValue:(BOOL)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithDefaultValue:(BOOL)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelPackString : GLBModelPack

@property(nonatomic, nullable, readonly, strong) NSString* defaultValue;

+ (nonnull instancetype)packWithDefaultValue:(nonnull NSString*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithDefaultValue:(nonnull NSString*)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelPackUrl : GLBModelPack

@property(nonatomic, nullable, readonly, strong) NSURL* defaultValue;

+ (nonnull instancetype)packWithDefaultValue:(nonnull NSURL*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithDefaultValue:(nonnull NSURL*)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelPackNumber : GLBModelPack

@property(nonatomic, nullable, readonly, strong) NSNumber* defaultValue;

+ (nonnull instancetype)packWithDefaultValue:(nonnull NSNumber*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithDefaultValue:(nonnull NSNumber*)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelPackDate : GLBModelPack

@property(nonatomic, nullable, readonly, strong) NSDate* defaultValue;

+ (nonnull instancetype)packWithDefaultValue:(nonnull NSDate*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithDefaultValue:(nonnull NSDate*)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@class CLLocation;

/*--------------------------------------------------*/

@interface GLBModelPackLocation : GLBModelPack

@property(nonatomic, nullable, readonly, strong) CLLocation* defaultValue;

+ (nonnull instancetype)packWithDefaultValue:(nonnull CLLocation*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithDefaultValue:(nonnull CLLocation*)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@class UIColor;

/*--------------------------------------------------*/

@interface GLBModelPackColor : GLBModelPack

@property(nonatomic, nullable, readonly, strong) UIColor* defaultValue;

+ (nonnull instancetype)packWithDefaultValue:(nonnull UIColor*)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithDefaultValue:(nonnull UIColor*)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelPackModel : GLBModelPack

@property(nonatomic, nullable, readonly, assign) Class model;

+ (nonnull instancetype)pack NS_UNAVAILABLE;
+ (nonnull instancetype)packWithModel:(nonnull Class)model NS_SWIFT_UNAVAILABLE("Use init(model:)");

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithModel:(nonnull Class)model NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/
