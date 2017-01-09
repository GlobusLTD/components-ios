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
+ (NSDictionary< NSString*, GLBModelJson* >* _Nullable)jsonMap;
+ (NSDictionary< NSString*, NSDictionary< NSString*, GLBModelJson* >* >* _Nullable)jsonShemeMap;
+ (NSDictionary< NSString*, GLBModelPack* >* _Nullable)packMap;

@required
+ (instancetype _Nullable)modelWithJson:(id _Nonnull)json NS_SWIFT_NAME(model(json:));
+ (instancetype _Nullable)modelWithJson:(id _Nonnull)json sheme:(NSString* _Nullable)sheme NS_SWIFT_NAME(model(json:sheme:));
+ (instancetype _Nullable)modelWithJsonData:(NSData* _Nonnull)data NS_SWIFT_NAME(model(jsonData:));
+ (instancetype _Nullable)modelWithJsonData:(NSData* _Nonnull)data sheme:(NSString* _Nullable)sheme NS_SWIFT_NAME(model(jsonData:sheme:));
+ (instancetype _Nullable)modelWithPack:(NSDictionary< NSString*, id >* _Nonnull)data NS_SWIFT_NAME(model(pack:));
+ (instancetype _Nullable)modelWithPackData:(NSData* _Nonnull)data NS_SWIFT_NAME(model(packData:));

- (instancetype _Nonnull)initWithJson:(id _Nullable)json;
- (instancetype _Nonnull)initWithJson:(id _Nullable)json sheme:(NSString* _Nullable)sheme;
- (instancetype _Nonnull)initWithPack:(NSDictionary< NSString*, id >* _Nonnull)data;

- (void)fromJson:(id _Nonnull)json;
- (void)fromJson:(id _Nonnull)json sheme:(NSString* _Nullable)sheme;
- (void)fromJsonData:(NSData* _Nonnull)data;
- (void)fromJsonData:(NSData* _Nonnull)data sheme:(NSString* _Nullable)sheme;
- (NSDictionary* _Nullable)toJson;
- (NSDictionary* _Nullable)toJson:(NSString* _Nullable)sheme;
- (NSData* _Nullable)toJsonData;
- (NSData* _Nullable)toJsonData:(NSString* _Nullable)sheme;

- (NSDictionary< NSString*, id >* _Nullable)pack;
- (NSData* _Nullable)packData;

- (void)unpack:(NSDictionary< NSString*, id >* _Nonnull)data;
- (void)unpackData:(NSData* _Nonnull)data;

@end

/*--------------------------------------------------*/

@interface GLBModel : NSObject < GLBModelProtocol, NSCoding, NSCopying, GLBObjectDebugProtocol >

@property(nonatomic, nullable, strong) NSString* storeName;
@property(nonatomic, nullable, strong) NSUserDefaults* userDefaults;
@property(nonatomic, nullable, strong) NSString* appGroupIdentifier;

+ (instancetype _Nullable)modelWithStoreName:(NSString* _Nullable)storeName userDefaults:(NSUserDefaults* _Nullable)userDefaults NS_SWIFT_NAME(model(storeName:userDefaults:));
+ (instancetype _Nullable)modelWithStoreName:(NSString* _Nullable)storeName appGroupIdentifier:(NSString* _Nullable)appGroupIdentifier NS_SWIFT_NAME(model(storeName:appGroupIdentifier:));

- (instancetype _Nonnull)initWithStoreName:(NSString* _Nullable)storeName userDefaults:(NSUserDefaults* _Nullable)userDefaults;
- (instancetype _Nonnull)initWithStoreName:(NSString* _Nullable)storeName appGroupIdentifier:(NSString* _Nullable)appGroupIdentifier;

- (void)setup NS_REQUIRES_SUPER;

+ (NSDictionary< NSString*, id >* _Nullable)defaultsMap;

+ (id _Nullable)serializeMap;
+ (NSArray< NSString* >* _Nullable)propertyMap;
+ (NSArray< NSString* >* _Nullable)compareMap;
+ (NSArray< NSString* >* _Nullable)copyMap;

- (void)clear;
- (void)clearComplete:(GLBSimpleBlock _Nullable)complete;
- (void)clearQueue:(dispatch_queue_t _Nonnull)queue complete:(GLBSimpleBlock _Nullable)complete;

- (BOOL)save;
- (void)saveSuccess:(GLBSimpleBlock _Nullable)success failure:(GLBSimpleBlock _Nullable)failure;
- (void)saveQueue:(dispatch_queue_t _Nonnull)queue success:(GLBSimpleBlock _Nullable)success failure:(GLBSimpleBlock _Nullable)failure;

- (void)load;
- (void)loadComplete:(GLBSimpleBlock _Nullable)complete;
- (void)loadQueue:(dispatch_queue_t _Nonnull)queue complete:(GLBSimpleBlock _Nullable)complete;

- (void)erase;
- (void)eraseComplete:(GLBSimpleBlock _Nullable)complete;
- (void)eraseQueue:(dispatch_queue_t _Nonnull)queue complete:(GLBSimpleBlock _Nullable)complete;

@end

/*--------------------------------------------------*/
