/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

#import <CoreData/CoreData.h>

/*--------------------------------------------------*/

@class GLBModelJson;
@class GLBModelPack;

/*--------------------------------------------------*/

typedef void (^GLBModelBlock)();

/*--------------------------------------------------*/

@protocol GLBModel < NSObject >

@required
+ (NSDictionary< NSString*, GLBModelJson* >* _Nullable)jsonMap;
+ (NSDictionary< NSString*, GLBModelPack* >* _Nullable)packMap;

@required
+ (_Nullable instancetype)modelWithJson:(id _Nonnull)json;
+ (_Nullable instancetype)modelWithJsonData:(NSData* _Nonnull)data;
+ (_Nullable instancetype)modelWithPack:(NSDictionary< NSString*, id >* _Nonnull)data;
+ (_Nullable instancetype)modelWithPackData:(NSData* _Nonnull)data;

- (_Nullable instancetype)initWithJson:(_Nullable id)json;
- (_Nullable instancetype)initWithPack:(NSDictionary< NSString*, id >* _Nonnull)data;

- (void)fromJson:(_Nonnull id)json;
- (void)fromJsonData:(NSData* _Nonnull)data;

- (NSDictionary< NSString*, id >* _Nullable)pack;
- (NSData* _Nullable)packData;

- (void)unpack:(NSDictionary< NSString*, id >* _Nonnull)data;
- (void)unpackData:(NSData* _Nonnull)data;

@end

/*--------------------------------------------------*/

@interface GLBModel : NSObject < GLBModel, NSCoding, NSCopying >

@property(nonatomic, strong, nullable) NSString* userDefaultsKey;
@property(nonatomic, strong, nullable) NSUserDefaults* userDefaults;
@property(nonatomic, strong, nullable) NSString* fileName;
@property(nonatomic, readonly, strong, nullable) NSString* filePath;

+ (_Nullable instancetype)modelWithUserDefaultsKey:(NSString* _Nullable)userDefaultsKey;
+ (_Nullable instancetype)modelWithUserDefaultsKey:(NSString* _Nullable)userDefaultsKey userDefaults:(NSUserDefaults* _Nullable)userDefaults;
+ (_Nullable instancetype)modelWithFileName:(NSString* _Nullable)fileName;

- (_Nullable instancetype)initWithUserDefaultsKey:(NSString* _Nullable)userDefaultsKey;
- (_Nullable instancetype)initWithUserDefaultsKey:(NSString* _Nullable)userDefaultsKey userDefaults:(NSUserDefaults* _Nullable)userDefaults;
- (_Nullable instancetype)initWithFileName:(NSString* _Nullable)fileName;

- (void)setup NS_REQUIRES_SUPER;

+ (NSArray< NSString* >* _Nullable)compareMap;
+ (NSArray< NSString* >* _Nullable)serializeMap;
+ (NSArray< NSString* >* _Nullable)copyMap;

- (void)clear;
- (void)clearComplete:(_Nullable GLBModelBlock)complete;

- (BOOL)save;
- (void)saveSuccess:(_Nullable GLBModelBlock)success failure:(_Nullable GLBModelBlock)failure;

- (void)load;
- (void)loadComplete:(_Nullable GLBModelBlock)complete;

- (void)erase;
- (void)eraseComplete:(_Nullable GLBModelBlock)complete;

@end

/*--------------------------------------------------*/

@interface GLBManagedModel : NSManagedObject < GLBModel, NSCoding >

- (_Nullable instancetype)initWithDefaultContext;

+ (NSManagedObjectContext* _Nullable)entityContext;
+ (NSString* _Nullable)entityName;

- (void)remove;
- (BOOL)save;

@end

/*--------------------------------------------------*/

typedef void(^GLBManagedManagerPerform)();

/*--------------------------------------------------*/

@protocol GLBManagedManagerDelegate;

/*--------------------------------------------------*/

@interface GLBManagedManager : NSObject

@property(nonatomic, weak, nullable) id< GLBManagedManagerDelegate > delegate;
@property(nonatomic, readonly, strong, nullable) NSManagedObjectContext* storeContext;
@property(nonatomic, readonly, strong, nullable) NSManagedObjectContext* mainContext;
@property(nonatomic, readonly, strong, nullable) NSManagedObjectContext* backgroundContext;
@property(nonatomic, readonly, strong, nullable) NSManagedObjectContext* currentContext;
@property(nonatomic, readonly, strong, nullable) NSManagedObjectModel* model;
@property(nonatomic, readonly, strong, nullable) NSPersistentStoreCoordinator* coordinator;
@property(nonatomic) BOOL allowsCreateStoreDatabase;
@property(nonatomic, strong, nullable) NSString* modelAppGroupName;
@property(nonatomic, strong, nullable) NSString* modelLocalPath;
@property(nonatomic, strong, nullable) NSString* modelName;
@property(nonatomic, strong, nullable) NSString* modelExtension;

+ (_Nullable instancetype)shared;

- (void)setup NS_REQUIRES_SUPER;

- (void)performBlock:(nonnull GLBManagedManagerPerform)update;
- (void)performBlockAndWait:(nonnull GLBManagedManagerPerform)update;

- (void)undo;
- (void)redo;
- (void)reset;
- (void)rollback;

- (BOOL)save;

- (nullable __kindof NSManagedObject*)objectWithID:(NSManagedObjectID* _Nonnull)objectID;

@end

/*--------------------------------------------------*/

extern NSString* _Nonnull GLBManagedManagerErrorDomain;

/*--------------------------------------------------*/

extern NSString* _Nonnull GLBManagedManagerExistStoreUrlKey;

/*--------------------------------------------------*/

@protocol GLBManagedManagerDelegate < NSObject >

@optional
- (NSURL* _Nullable)existStoreUrlInManagedManager:(GLBManagedManager* _Nonnull)managedManager;
- (void)failedInitializeStoreInManagedManager:(GLBManagedManager* _Nonnull)managedManager;

@end

/*--------------------------------------------------*/
