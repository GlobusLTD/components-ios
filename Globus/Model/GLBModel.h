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

typedef void (^GLBModelBlock)();

/*--------------------------------------------------*/

@protocol GLBModelProtocol < NSObject >

@required
+ (NSDictionary< NSString*, GLBModelJson* >* _Nullable)jsonMap;
+ (NSDictionary< NSString*, NSDictionary< NSString*, GLBModelJson* >* >* _Nullable)jsonShemeMap;
+ (NSDictionary< NSString*, GLBModelPack* >* _Nullable)packMap;

@required
+ (_Nullable instancetype)modelWithJson:(id _Nonnull)json NS_SWIFT_NAME(model(json:));
+ (_Nullable instancetype)modelWithJson:(id _Nonnull)json sheme:(NSString* _Nullable)sheme NS_SWIFT_NAME(model(json:sheme:));
+ (_Nullable instancetype)modelWithJsonData:(NSData* _Nonnull)data NS_SWIFT_NAME(model(jsonData:));
+ (_Nullable instancetype)modelWithJsonData:(NSData* _Nonnull)data sheme:(NSString* _Nullable)sheme NS_SWIFT_NAME(model(jsonData:sheme:));
+ (_Nullable instancetype)modelWithPack:(NSDictionary< NSString*, id >* _Nonnull)data NS_SWIFT_NAME(model(pack:));
+ (_Nullable instancetype)modelWithPackData:(NSData* _Nonnull)data NS_SWIFT_NAME(model(packData:));

- (_Nullable instancetype)initWithJson:(_Nullable id)json;
- (_Nullable instancetype)initWithJson:(_Nullable id)json sheme:(NSString* _Nullable)sheme;
- (_Nullable instancetype)initWithPack:(NSDictionary< NSString*, id >* _Nonnull)data;

- (void)fromJson:(_Nonnull id)json;
- (void)fromJson:(_Nonnull id)json sheme:(NSString* _Nullable)sheme;
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

+ (_Nullable instancetype)modelWithStoreName:(NSString* _Nullable)storeName userDefaults:(NSUserDefaults* _Nullable)userDefaults NS_SWIFT_NAME(model(storeName:userDefaults:));
+ (_Nullable instancetype)modelWithStoreName:(NSString* _Nullable)storeName appGroupIdentifier:(NSString* _Nullable)appGroupIdentifier NS_SWIFT_NAME(model(storeName:appGroupIdentifier:));

- (_Nullable instancetype)initWithStoreName:(NSString* _Nullable)storeName userDefaults:(NSUserDefaults* _Nullable)userDefaults;
- (_Nullable instancetype)initWithStoreName:(NSString* _Nullable)storeName appGroupIdentifier:(NSString* _Nullable)appGroupIdentifier;

- (void)setup NS_REQUIRES_SUPER;

+ (NSDictionary< NSString*, id >* _Nullable)defaultsMap;

+ (id _Nullable)serializeMap;
+ (NSArray< NSString* >* _Nullable)propertyMap;
+ (NSArray< NSString* >* _Nullable)compareMap;
+ (NSArray< NSString* >* _Nullable)copyMap;

- (void)clear;
- (void)clearComplete:(_Nullable GLBModelBlock)complete;
- (void)clearQueue:(_Nonnull dispatch_queue_t)queue complete:(_Nullable GLBModelBlock)complete;

- (BOOL)save;
- (void)saveSuccess:(_Nullable GLBModelBlock)success failure:(_Nullable GLBModelBlock)failure;
- (void)saveQueue:(_Nonnull dispatch_queue_t)queue success:(_Nullable GLBModelBlock)success failure:(_Nullable GLBModelBlock)failure;

- (void)load;
- (void)loadComplete:(_Nullable GLBModelBlock)complete;
- (void)loadQueue:(_Nonnull dispatch_queue_t)queue complete:(_Nullable GLBModelBlock)complete;

- (void)erase;
- (void)eraseComplete:(_Nullable GLBModelBlock)complete;
- (void)eraseQueue:(_Nonnull dispatch_queue_t)queue complete:(_Nullable GLBModelBlock)complete;

@end

/*--------------------------------------------------*/
