/*--------------------------------------------------*/

#import "GLBManagedModel.h"
#import "GLBModel+Private.h"

/*--------------------------------------------------*/

@interface GLBManagedModel ()

@property(nonatomic, nonnull, readonly, strong) NSDictionary< NSString*, GLBModelJson* >* jsonMap;
@property(nonatomic, nonnull, readonly, strong) NSDictionary< NSString*, NSDictionary< NSString*, GLBModelJson* >* >* jsonShemeMap;
@property(nonatomic, nonnull, readonly, strong) NSDictionary< NSString*, GLBModelPack* >* packMap;
@property(nonatomic, nonnull, readonly, strong) NSArray< NSString* >* propertyMap;

+ (NSDictionary< NSString*, GLBModelJson* >* _Nonnull)_buildJsonMap;
+ (NSDictionary< NSString*, NSDictionary< NSString*, GLBModelJson* >* >* _Nonnull)_buildJsonShemeMap;
+ (NSDictionary< NSString*, GLBModelPack* >* _Nonnull)_buildPackMap;
+ (NSArray< NSString* >* _Nonnull)_buildPropertyMap;

@end

/*--------------------------------------------------*/

@interface GLBManagedManager () {
    NSMutableArray< NSValue* >* _observers;
    NSURL* _containerUrl;
}

@property(nonatomic, nullable, readonly, strong) NSManagedObjectContext* storeContext;
@property(nonatomic, nullable, readonly, strong) NSManagedObjectContext* mainContext;
@property(nonatomic, nullable, readonly, strong) NSManagedObjectContext* backgroundContext;
@property(nonatomic, nullable, readonly, strong) NSManagedObjectContext* currentContext;
@property(nonatomic, nullable, readonly, strong) NSManagedObjectModel* model;
@property(nonatomic, nullable, readonly, strong) NSPersistentStoreCoordinator* coordinator;
@property(nonatomic, nullable, strong) NSURL* existStoreUrl;

@end

/*--------------------------------------------------*/
