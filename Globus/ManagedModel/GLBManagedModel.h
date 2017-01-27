/*--------------------------------------------------*/

#import "GLBModel.h"

/*--------------------------------------------------*/

#import <CoreData/CoreData.h>

/*--------------------------------------------------*/

@interface GLBManagedModel : NSManagedObject < GLBModelProtocol, NSCoding, GLBObjectDebugProtocol >

- (nullable instancetype)initWithDefaultContext;

+ (nullable NSManagedObjectContext*)entityContext;
+ (nullable NSString*)entityName;

+ (nullable NSArray< NSString* >*)propertyMap;

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

@property(nonatomic, nullable, readonly, strong) NSURL* existStoreUrl;
@property(nonatomic, nullable, readonly, strong) NSURL* storeUrl;

+ (nullable instancetype)shared;

- (void)setup NS_REQUIRES_SUPER;

- (void)addObserver:(nonnull id< GLBManagedManagerObserver >)observer;
- (void)removeObserver:(nonnull id< GLBManagedManagerObserver >)observer;

- (BOOL)initializeStore;
- (void)closeStore;

- (void)performBlock:(nonnull GLBManagedManagerPerform)update;
- (void)performBlockAndWait:(nonnull GLBManagedManagerPerform)update;

- (void)undo;
- (void)redo;
- (void)reset;
- (void)rollback;

- (BOOL)save;

- (nullable __kindof NSManagedObject*)objectRegisteredForID:(nonnull NSManagedObjectID*)objectID;
- (nullable __kindof NSManagedObject*)objectWithID:(nonnull NSManagedObjectID*)objectID;
- (nullable __kindof NSManagedObject*)existingObjectWithID:(nonnull NSManagedObjectID*)objectID error:(NSError* _Nullable * _Nullable)error;

- (nullable NSArray*)executeFetchRequest:(nonnull NSFetchRequest*)request error:(NSError* _Nullable * _Nullable)error;
- (NSUInteger)countForFetchRequest:(nonnull NSFetchRequest*)request error: (NSError* _Nullable * _Nullable)error;

- (void)setFetchRequestTemplate:(nullable NSFetchRequest*)fetchRequestTemplate forName:(nonnull NSString*)name;
- (nullable NSFetchRequest*)fetchRequestTemplateForName:(nonnull NSString*)name;
- (nullable NSFetchRequest*)fetchRequestFromTemplateWithName:(nonnull NSString*)name variables:(nullable NSDictionary< NSString*, id >*)variables;
- (nullable NSArray*)executeTemplateFetchRequestForName:(nonnull NSString*)name error:(NSError* _Nullable * _Nullable)error;
- (nullable NSArray*)executeTemplateFetchRequestForName:(nonnull NSString*)name variables:(nullable NSDictionary< NSString*, id >*)variables error:(NSError* _Nullable * _Nullable)error;

- (void)insertObject:(nonnull NSManagedObject*)object;
- (void)deleteObject:(nonnull NSManagedObject*)object;
- (void)refreshObject:(nonnull NSManagedObject*)object mergeChanges:(BOOL)flag;
- (void)refreshRegisteredObjectsMergeChanges:(BOOL)flag;
- (void)detectConflictsForObject:(nonnull NSManagedObject*)object;

@end

/*--------------------------------------------------*/

@protocol GLBManagedManagerObserver < NSObject >

@optional
- (nullable NSURL*)existStoreUrlInManagedManager:(nonnull GLBManagedManager*)managedManager;
- (void)initializeStoreInManagedManager:(nonnull GLBManagedManager*)managedManager error:(nullable NSError*)error;
- (void)closeStoreInManagedManager:(nonnull GLBManagedManager*)managedManager;

@end

/*--------------------------------------------------*/
