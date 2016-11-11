/*--------------------------------------------------*/

#import "GLBModel.h"

/*--------------------------------------------------*/

#import <CoreData/CoreData.h>

/*--------------------------------------------------*/

@interface GLBManagedModel : NSManagedObject < GLBModelProtocol, NSCoding, GLBObjectDebugProtocol >

- (_Nullable instancetype)initWithDefaultContext;

+ (NSManagedObjectContext* _Nullable)entityContext;
+ (NSString* _Nullable)entityName;

+ (NSArray< NSString* >* _Nullable)propertyMap;

- (void)refreshMergeChanges:(BOOL)flag;

- (BOOL)save;
- (void)remove;

@end

/*--------------------------------------------------*/

extern NSString* _Nonnull GLBManagedManagerErrorDomain;

/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBManagedManagerError) {
    GLBManagedManagerErrorInitializeModel,
    GLBManagedManagerErrorInitializeStore,
    GLBManagedManagerErrorInitializeContext,
    GLBManagedManagerErrorInitializeMigration,
    GLBManagedManagerErrorInitializeUnknown
};

/*--------------------------------------------------*/

typedef void(^GLBManagedManagerPerform)();

/*--------------------------------------------------*/

@protocol GLBManagedManagerObserver;

/*--------------------------------------------------*/

@interface GLBManagedManager : NSObject

@property(nonatomic, readonly, getter=isInitialized) BOOL initialized;
@property(nonatomic) BOOL allowsLazyInitialize;
@property(nonatomic) BOOL allowsCreateStoreDatabase;

@property(nonatomic, nullable, strong) NSString* storeAppGroupName;
@property(nonatomic, nullable, strong) NSString* storeLocalPath;
@property(nonatomic, nullable, strong) NSString* modelName;
@property(nonatomic, nullable, strong) NSString* modelExtension;

@property(nonatomic, readonly, nullable, strong) NSURL* existStoreUrl;
@property(nonatomic, readonly, nullable, strong) NSURL* storeUrl;

+ (_Nullable instancetype)shared;

- (void)setup NS_REQUIRES_SUPER;

- (void)addObserver:(_Nonnull id< GLBManagedManagerObserver >)observer;
- (void)removeObserver:(_Nonnull id< GLBManagedManagerObserver >)observer;

- (BOOL)initializeStore;
- (void)closeStore;

- (void)performBlock:(_Nonnull GLBManagedManagerPerform)update;
- (void)performBlockAndWait:(_Nonnull GLBManagedManagerPerform)update;

- (void)undo;
- (void)redo;
- (void)reset;
- (void)rollback;

- (BOOL)save;

- (__kindof NSManagedObject* _Nullable)objectRegisteredForID:(NSManagedObjectID* _Nonnull)objectID;
- (__kindof NSManagedObject* _Nullable)objectWithID:(NSManagedObjectID* _Nonnull)objectID;
- (__kindof NSManagedObject* _Nullable)existingObjectWithID:(NSManagedObjectID* _Nonnull)objectID error:(NSError* _Nullable * _Nullable)error;

- (NSArray* _Nullable)executeFetchRequest:(NSFetchRequest* _Nonnull)request error:(NSError* _Nullable * _Nullable)error;
- (NSUInteger)countForFetchRequest:(NSFetchRequest* _Nonnull)request error: (NSError* _Nullable * _Nullable)error;

- (void)setFetchRequestTemplate:(NSFetchRequest* _Nullable)fetchRequestTemplate forName:(NSString* _Nonnull)name;
- (NSFetchRequest* _Nullable)fetchRequestTemplateForName:(NSString* _Nonnull)name;
- (NSFetchRequest* _Nullable)fetchRequestFromTemplateWithName:(NSString* _Nonnull)name variables:(NSDictionary< NSString*, id >* _Nullable)variables;
- (NSArray* _Nullable)executeTemplateFetchRequestForName:(NSString* _Nonnull)name error:(NSError* _Nullable * _Nullable)error;
- (NSArray* _Nullable)executeTemplateFetchRequestForName:(NSString* _Nonnull)name variables:(NSDictionary< NSString*, id >* _Nullable)variables error:(NSError* _Nullable * _Nullable)error;

- (void)insertObject:(NSManagedObject* _Nonnull)object;
- (void)deleteObject:(NSManagedObject* _Nonnull)object;
- (void)refreshObject:(NSManagedObject* _Nonnull)object mergeChanges:(BOOL)flag;
- (void)refreshRegisteredObjectsMergeChanges:(BOOL)flag;
- (void)detectConflictsForObject:(NSManagedObject* _Nonnull)object;

@end

/*--------------------------------------------------*/

@protocol GLBManagedManagerObserver < NSObject >

@optional
- (NSURL* _Nullable)existStoreUrlInManagedManager:(GLBManagedManager* _Nonnull)managedManager;
- (void)initializeStoreInManagedManager:(GLBManagedManager* _Nonnull)managedManager error:(NSError* _Nullable)error;
- (void)closeStoreInManagedManager:(GLBManagedManager* _Nonnull)managedManager;

@end

/*--------------------------------------------------*/
