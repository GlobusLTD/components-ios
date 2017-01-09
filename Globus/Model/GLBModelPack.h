/*--------------------------------------------------*/

#import "NSDictionary+GLBNS.h"
#import "NSArray+GLBNS.h"
#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

#import "UIColor+GLBUI.h"

/*--------------------------------------------------*/

@interface GLBModelPack : NSObject

+ (instancetype _Nonnull)pack NS_SWIFT_UNAVAILABLE("Use init()");

- (id _Nullable)pack:(id _Nullable)packValue;
- (id _Nullable)unpack:(id _Nullable)packValue;

@end

/*--------------------------------------------------*/

@interface GLBModelPackSet : GLBModelPack

@property(nonatomic, nonnull, readonly, strong) GLBModelPack* converter;

+ (instancetype _Nonnull)pack NS_UNAVAILABLE;
+ (instancetype _Nonnull)packWithModel:(Class _Nonnull)model NS_SWIFT_UNAVAILABLE("Use init(model:)");
+ (instancetype _Nonnull)packWithConverter:(GLBModelPack* _Nonnull)converter NS_SWIFT_UNAVAILABLE("Use init(converter:)");

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithModel:(Class _Nonnull)model;
- (instancetype _Nonnull)initWithConverter:(GLBModelPack* _Nonnull)converter NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelPackOrderedSet : GLBModelPack

@property(nonatomic, nonnull, readonly, strong) GLBModelPack* converter;

+ (instancetype _Nonnull)pack NS_UNAVAILABLE;
+ (instancetype _Nonnull)packWithModel:(Class _Nonnull)model NS_SWIFT_UNAVAILABLE("Use init(model:)");
+ (instancetype _Nonnull)packWithConverter:(GLBModelPack* _Nonnull)converter NS_SWIFT_UNAVAILABLE("Use init(converter:)");

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithModel:(Class _Nonnull)model;
- (instancetype _Nonnull)initWithConverter:(GLBModelPack* _Nonnull)converter NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelPackArray : GLBModelPack

@property(nonatomic, nonnull, readonly, strong) GLBModelPack* converter;

+ (instancetype _Nonnull)pack NS_UNAVAILABLE;
+ (instancetype _Nonnull)packWithModel:(Class _Nonnull)model NS_SWIFT_UNAVAILABLE("Use init(model:)");
+ (instancetype _Nonnull)packWithConverter:(GLBModelPack* _Nonnull)converter NS_SWIFT_UNAVAILABLE("Use init(converter:)");

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithModel:(Class _Nonnull)model;
- (instancetype _Nonnull)initWithConverter:(GLBModelPack* _Nonnull)converter NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelPackDictionary : GLBModelPack

@property(nonatomic, nonnull, readonly, strong) GLBModelPack* keyConverter;
@property(nonatomic, nonnull, readonly, strong) GLBModelPack* valueConverter;

+ (instancetype _Nonnull)pack NS_UNAVAILABLE;
+ (instancetype _Nonnull)packWithKeyModel:(Class _Nonnull)keyModel valueModel:(Class _Nonnull)valueModel NS_SWIFT_UNAVAILABLE("Use init(keyModel:valueModel:)");
+ (instancetype _Nonnull)packWithKeyConverter:(GLBModelPack* _Nonnull)keyConverter valueConverter:(GLBModelPack* _Nonnull)valueConverter NS_SWIFT_UNAVAILABLE("Use init(keyConverter:valueConverter:)");

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithKeyModel:(Class _Nonnull)keyModel valueModel:(Class _Nonnull)valueModel;
- (instancetype _Nonnull)initWithKeyConverter:(GLBModelPack* _Nonnull)keyConverter valueConverter:(GLBModelPack* _Nonnull)valueConverter NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelPackBool : GLBModelPack

@property(nonatomic, readonly, assign) BOOL defaultValue;

+ (instancetype _Nonnull)packWithDefaultValue:(BOOL)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");

- (instancetype _Nonnull)init NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithDefaultValue:(BOOL)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelPackString : GLBModelPack

@property(nonatomic, nullable, readonly, strong) NSString* defaultValue;

+ (instancetype _Nonnull)packWithDefaultValue:(NSString* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");

- (instancetype _Nonnull)init NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithDefaultValue:(NSString* _Nonnull)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelPackUrl : GLBModelPack

@property(nonatomic, nullable, readonly, strong) NSURL* defaultValue;

+ (instancetype _Nonnull)packWithDefaultValue:(NSURL* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");

- (instancetype _Nonnull)init NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithDefaultValue:(NSURL* _Nonnull)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelPackNumber : GLBModelPack

@property(nonatomic, nullable, readonly, strong) NSNumber* defaultValue;

+ (instancetype _Nonnull)packWithDefaultValue:(NSNumber* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");

- (instancetype _Nonnull)init NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithDefaultValue:(NSNumber* _Nonnull)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelPackDate : GLBModelPack

@property(nonatomic, nullable, readonly, strong) NSDate* defaultValue;

+ (instancetype _Nonnull)packWithDefaultValue:(NSDate* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");

- (instancetype _Nonnull)init NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithDefaultValue:(NSDate* _Nonnull)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@class CLLocation;

/*--------------------------------------------------*/

@interface GLBModelPackLocation : GLBModelPack

@property(nonatomic, nullable, readonly, strong) CLLocation* defaultValue;

+ (instancetype _Nonnull)packWithDefaultValue:(CLLocation* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");

- (instancetype _Nonnull)init NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithDefaultValue:(CLLocation* _Nonnull)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@class UIColor;

/*--------------------------------------------------*/

@interface GLBModelPackColor : GLBModelPack

@property(nonatomic, nullable, readonly, strong) UIColor* defaultValue;

+ (instancetype _Nonnull)packWithDefaultValue:(UIColor* _Nonnull)defaultValue NS_SWIFT_UNAVAILABLE("Use init(defaultValue:)");

- (instancetype _Nonnull)init NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithDefaultValue:(UIColor* _Nonnull)defaultValue NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/

@interface GLBModelPackModel : GLBModelPack

@property(nonatomic, nullable, readonly, assign) Class model;

+ (instancetype _Nonnull)pack NS_UNAVAILABLE;
+ (instancetype _Nonnull)packWithModel:(Class _Nonnull)model NS_SWIFT_UNAVAILABLE("Use init(model:)");

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithModel:(Class _Nonnull)model NS_DESIGNATED_INITIALIZER;

@end

/*--------------------------------------------------*/
