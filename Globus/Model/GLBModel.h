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

@property(nonatomic, nullable, strong) NSString* userDefaultsKey;
@property(nonatomic, nullable, strong) NSUserDefaults* userDefaults;
@property(nonatomic, nullable, strong) NSString* fileName;
@property(nonatomic, readonly, nullable, strong) NSString* filePath;

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

@property(nonatomic, nullable, weak) id< GLBManagedManagerDelegate > delegate;
@property(nonatomic, readonly, nullable, strong) NSManagedObjectContext* storeContext;
@property(nonatomic, readonly, nullable, strong) NSManagedObjectContext* mainContext;
@property(nonatomic, readonly, nullable, strong) NSManagedObjectContext* backgroundContext;
@property(nonatomic, readonly, nullable, strong) NSManagedObjectContext* currentContext;
@property(nonatomic, readonly, nullable, strong) NSManagedObjectModel* model;
@property(nonatomic, readonly, nullable, strong) NSPersistentStoreCoordinator* coordinator;
@property(nonatomic) BOOL allowsCreateStoreDatabase;
@property(nonatomic, nullable, strong) NSString* modelAppGroupName;
@property(nonatomic, nullable, strong) NSString* modelLocalPath;
@property(nonatomic, nullable, strong) NSString* modelName;
@property(nonatomic, nullable, strong) NSString* modelExtension;

+ (_Nullable instancetype)shared;

- (void)setup NS_REQUIRES_SUPER;

- (void)performBlock:(nonnull GLBManagedManagerPerform)update;
- (void)performBlockAndWait:(nonnull GLBManagedManagerPerform)update;

- (void)undo;
- (void)redo;
- (void)reset;
- (void)rollback;

- (BOOL)save;

- (__kindof NSManagedObject* _Nullable)objectRegisteredForID:(NSManagedObjectID* _Nonnull)objectID;
- (__kindof NSManagedObject* _Nullable)objectWithID:(NSManagedObjectID* _Nonnull)objectID;
- (__kindof NSManagedObject* _Nullable)existingObjectWithID:(NSManagedObjectID* _Nonnull)objectID error:(NSError* _Nullable * _Nullable)error;

- (void)insertObject:(NSManagedObject* _Nonnull)object;
- (void)deleteObject:(NSManagedObject* _Nonnull)object;
- (void)refreshObject:(NSManagedObject* _Nonnull)object mergeChanges:(BOOL)flag;
- (void)refreshRegisteredObjectsMergeChanges:(BOOL)flag;
- (void)detectConflictsForObject:(NSManagedObject* _Nonnull)object;

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
