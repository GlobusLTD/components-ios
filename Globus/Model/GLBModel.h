/*--------------------------------------------------*/

#import "NSObject+GLBDebug.h"
#import "NSObject+GLBPack.h"
#import "NSDictionary+GLBNS.h"
#import "NSArray+GLBNS.h"
#import "NSPointerArray+GLBNS.h"
#import "NSString+GLBNS.h"
#import "NSFileManager+GLBNS.h"
#import "NSBundle+GLBNS.h"

/*--------------------------------------------------*/

#import "UIDevice+GLBUI.h"

/*--------------------------------------------------*/

@class GLBModelJson;
@class GLBModelPack;

/*--------------------------------------------------*/

@protocol GLBModelProtocol < NSObject >

@required
+ (nullable NSDictionary< NSString*, GLBModelJson* >*)jsonMap;
+ (nullable NSDictionary< NSString*, NSDictionary< NSString*, GLBModelJson* >* >*)jsonShemeMap;
+ (nullable NSDictionary< NSString*, GLBModelPack* >*)packMap;

@required
+ (nullable instancetype)modelWithJson:(nonnull id)json NS_SWIFT_NAME(model(json:));
+ (nullable instancetype)modelWithJson:(nonnull id)json sheme:(nullable NSString*)sheme NS_SWIFT_NAME(model(json:sheme:));
+ (nullable instancetype)modelWithJsonData:(nonnull NSData*)data NS_SWIFT_NAME(model(jsonData:));
+ (nullable instancetype)modelWithJsonData:(nonnull NSData*)data sheme:(nullable NSString*)sheme NS_SWIFT_NAME(model(jsonData:sheme:));
+ (nullable instancetype)modelWithPack:(nonnull NSDictionary< NSString*, id >*)data NS_SWIFT_NAME(model(pack:));
+ (nullable instancetype)modelWithPackData:(nonnull NSData*)data NS_SWIFT_NAME(model(packData:));

- (nonnull instancetype)initWithJson:(nullable id)json;
- (nonnull instancetype)initWithJson:(nullable id)json sheme:(nullable NSString*)sheme;
- (nonnull instancetype)initWithPack:(nonnull NSDictionary< NSString*, id >*)data;

- (void)fromJson:(nonnull id)json;
- (void)fromJson:(nonnull id)json sheme:(nullable NSString*)sheme;
- (void)fromJsonData:(nonnull NSData*)data;
- (void)fromJsonData:(nonnull NSData*)data sheme:(nullable NSString*)sheme;
- (nullable NSDictionary*)toJson;
- (nullable NSDictionary*)toJson:(nullable NSString*)sheme;
- (nullable NSData*)toJsonData;
- (nullable NSData*)toJsonData:(nullable NSString*)sheme;

- (nullable NSDictionary< NSString*, id >*)pack;
- (nullable NSData*)packData;

- (void)unpack:(nonnull NSDictionary< NSString*, id >*)data;
- (void)unpackData:(nonnull NSData*)data;

@end

/*--------------------------------------------------*/

@interface GLBModel : NSObject < GLBModelProtocol, NSCoding, NSCopying, GLBObjectDebugProtocol >

@property(nonatomic, nullable, strong) NSString* storeName;
@property(nonatomic, nullable, strong) NSUserDefaults* userDefaults;
@property(nonatomic, nullable, strong) NSString* appGroupIdentifier;

+ (nullable instancetype)modelWithStoreName:(nullable NSString*)storeName userDefaults:(nullable NSUserDefaults*)userDefaults NS_SWIFT_NAME(model(storeName:userDefaults:));
+ (nullable instancetype)modelWithStoreName:(nullable NSString*)storeName appGroupIdentifier:(nullable NSString*)appGroupIdentifier NS_SWIFT_NAME(model(storeName:appGroupIdentifier:));

- (nonnull instancetype)initWithStoreName:(nullable NSString*)storeName userDefaults:(nullable NSUserDefaults*)userDefaults;
- (nonnull instancetype)initWithStoreName:(nullable NSString*)storeName appGroupIdentifier:(nullable NSString*)appGroupIdentifier;

- (void)setup NS_REQUIRES_SUPER;

+ (nullable NSDictionary< NSString*, id >*)defaultsMap;

+ (nullable id)serializeMap;
+ (nullable NSArray< NSString* >*)propertyMap;
+ (nullable NSArray< NSString* >*)compareMap;
+ (nullable NSArray< NSString* >*)copyMap;

- (void)clear;
- (void)clearComplete:(nullable GLBSimpleBlock)complete;
- (void)clearQueue:(nonnull dispatch_queue_t)queue complete:(nullable GLBSimpleBlock)complete;

- (BOOL)save;
- (void)saveSuccess:(nullable GLBSimpleBlock)success failure:(nullable GLBSimpleBlock)failure;
- (void)saveQueue:(nonnull dispatch_queue_t)queue success:(nullable GLBSimpleBlock)success failure:(nullable GLBSimpleBlock)failure;

- (void)load;
- (void)loadComplete:(nullable GLBSimpleBlock)complete;
- (void)loadQueue:(nonnull dispatch_queue_t)queue complete:(nullable GLBSimpleBlock)complete;

- (void)erase;
- (void)eraseComplete:(nullable GLBSimpleBlock)complete;
- (void)eraseQueue:(nonnull dispatch_queue_t)queue complete:(nullable GLBSimpleBlock)complete;

@end

/*--------------------------------------------------*/
