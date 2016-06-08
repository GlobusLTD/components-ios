/*--------------------------------------------------*/

#import "GLBModel.h"
#import "GLBModelJson.h"
#import "GLBModelPack.h"

/*--------------------------------------------------*/

@interface GLBModel ()

@property(nonatomic, readonly, nonnull, strong) NSDictionary< NSString*, GLBModelJson* >* jsonMap;
@property(nonatomic, readonly, nonnull, strong) NSDictionary< NSString*, GLBModelPack* >* packMap;
@property(nonatomic, readonly, nonnull, strong) NSArray< NSString* >* propertyMap;
@property(nonatomic, readonly, nonnull, strong) NSArray< NSString* >* compareMap;
@property(nonatomic, readonly, nonnull, strong) NSArray< NSString* >* serializeMap;
@property(nonatomic, readonly, nonnull, strong) NSArray< NSString* >* copyMap;

+ (NSString* _Nullable)_filePathWithStoreName:(NSString* _Nonnull)storeName appGroupIdentifier:(NSString* _Nullable)appGroupIdentifier;

+ (NSDictionary< NSString*, GLBModelJson* >* _Nonnull)_buildJsonMap;
+ (NSDictionary< NSString*, GLBModelPack* >* _Nonnull)_buildPackMap;
+ (NSArray< NSString* >* _Nonnull)_buildPropertyMap;
+ (NSArray< NSString* >* _Nonnull)_buildCompareMap;
+ (NSArray< NSString* >* _Nonnull)_buildSerializeMap;
+ (NSArray< NSString* >* _Nonnull)_buildCopyMap;

- (NSString* _Nullable)_filePath;

@end

/*--------------------------------------------------*/

@interface GLBManagedModel ()

@property(nonatomic, readonly, nonnull, strong) NSDictionary< NSString*, GLBModelJson* >* jsonMap;
@property(nonatomic, readonly, nonnull, strong) NSDictionary< NSString*, GLBModelPack* >* packMap;
@property(nonatomic, readonly, nonnull, strong) NSArray< NSString* >* propertyMap;

+ (NSDictionary< NSString*, GLBModelJson* >* _Nonnull)_buildJsonMap;
+ (NSDictionary< NSString*, GLBModelPack* >* _Nonnull)_buildPackMap;
+ (NSArray< NSString* >* _Nonnull)_buildPropertyMap;

@end

/*--------------------------------------------------*/

@interface GLBManagedManager () {
    NSMutableArray< NSValue* >* _observers;
    NSURL* _containerUrl;
}

@property(nonatomic, readonly, nullable, strong) NSManagedObjectContext* storeContext;
@property(nonatomic, readonly, nullable, strong) NSManagedObjectContext* mainContext;
@property(nonatomic, readonly, nullable, strong) NSManagedObjectContext* backgroundContext;
@property(nonatomic, readonly, nullable, strong) NSManagedObjectContext* currentContext;
@property(nonatomic, readonly, nullable, strong) NSManagedObjectModel* model;
@property(nonatomic, readonly, nullable, strong) NSPersistentStoreCoordinator* coordinator;
@property(nonatomic, nullable, strong) NSURL* existStoreUrl;

@end

/*--------------------------------------------------*/

@interface GLBManagedMap : NSObject

+ (NSArray* _Nonnull)arrayMap:(NSMutableDictionary* _Nonnull)cache class:(_Nonnull Class)class selector:(_Nonnull SEL)selector;
+ (NSDictionary* _Nonnull)dictionaryMap:(NSMutableDictionary* _Nonnull)cache class:(_Nonnull Class)class selector:(_Nonnull SEL)selector;

@end

/*--------------------------------------------------*/
