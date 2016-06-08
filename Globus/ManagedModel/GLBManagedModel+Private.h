/*--------------------------------------------------*/

#import "GLBManagedModel.h"
#import "GLBModel+Private.h"

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
