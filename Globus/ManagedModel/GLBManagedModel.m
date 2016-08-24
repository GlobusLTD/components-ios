/*--------------------------------------------------*/

#import "GLBManagedModel+Private.h"

/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"
#import "NSString+GLBNS.h"
#import "NSArray+GLBNS.h"
#import "NSDictionary+GLBNS.h"
#import "NSPointerArray+GLBNS.h"
#import "NSFileManager+GLBNS.h"
#import "NSBundle+GLBNS.h"

/*--------------------------------------------------*/

#include <objc/runtime.h>

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

static NSString* GLBManagedModelUriKey = @"GLBManagedModelUriKey";

/*--------------------------------------------------*/

@implementation GLBManagedModel

#pragma mark - Synthesize

@synthesize jsonMap = _jsonMap;
@synthesize jsonShemeMap = _jsonShemeMap;
@synthesize packMap = _packMap;
@synthesize propertyMap = _propertyMap;

#pragma mark - Init / Free

- (instancetype)initWithDefaultContext {
    return [super initWithEntity:self.class.entityDescription insertIntoManagedObjectContext:self.class.entityContext];
}

+ (NSManagedObjectContext*)entityContext {
    return GLBManagedManager.shared.currentContext;
}

+ (NSEntityDescription*)entityDescription {
    return [NSEntityDescription entityForName:self.entityName inManagedObjectContext:self.entityContext];
}

+ (NSString*)entityName {
    return NSStringFromClass(self.class);
}

+ (NSArray< NSString* >*)propertyMap {
    if(self == GLBModel.class) {
        return nil;
    }
    NSMutableArray* result = NSMutableArray.array;
    if(result != nil) {
        unsigned int count;
        objc_property_t* properties = class_copyPropertyList(self.class, &count);
        for(unsigned int i = 0; i < count; i++) {
            objc_property_t property = properties[i];
            NSString* propertyName = [NSString stringWithUTF8String:property_getName(property)];
            if(propertyName != nil) {
                [result addObject:propertyName];
            }
        }
        free(properties);
    }
    return result;
}

#pragma mark - Property

- (NSDictionary< NSString*, GLBModelJson* >*)jsonMap {
    @synchronized(self) {
        if(_jsonMap == nil) {
            _jsonMap = [self.class _buildJsonMap];
        }
    }
    return _jsonMap;
}

- (NSDictionary< NSString*, NSDictionary< NSString*, GLBModelJson* >* >*)jsonShemeMap {
    @synchronized(self) {
        if(_jsonShemeMap == nil) {
            _jsonShemeMap = [self.class _buildJsonShemeMap];
        }
    }
    return _jsonShemeMap;
}

- (NSDictionary< NSString*, GLBModelPack* >*)packMap {
    @synchronized(self) {
        if(_packMap == nil) {
            _packMap = [self.class _buildPackMap];
        }
    }
    return _packMap;
}

- (NSArray< NSString* >*)propertyMap {
    @synchronized(self) {
        if(_propertyMap == nil) {
            _propertyMap = [self.class _buildPropertyMap];
        }
    }
    return _propertyMap;
}

#pragma mark - GLBModel

+ (NSDictionary< NSString*, GLBModelJson* >*)jsonMap {
    return nil;
}

+ (NSDictionary< NSString*, NSDictionary< NSString*, GLBModelJson* >* >*)jsonShemeMap {
    return nil;
}

+ (NSDictionary< NSString*, GLBModelPack* >*)packMap {
    return nil;
}

+ (instancetype)modelWithJson:(id)json {
    return [[self alloc] initWithJson:json];
}

+ (instancetype)modelWithJson:(id)json sheme:(NSString*)sheme {
    return [[self alloc] initWithJson:json sheme:sheme];
}

+ (instancetype)modelWithJsonData:(NSData*)data {
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if(json != nil) {
        return [[self alloc] initWithJson:json];
    }
    return nil;
}

+ (instancetype)modelWithJsonData:(NSData*)data sheme:(NSString*)sheme {
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if(json != nil) {
        return [[self alloc] initWithJson:json sheme:sheme];
    }
    return nil;
}

+ (instancetype)modelWithPack:(NSDictionary< NSString*, id >*)data {
    return [[self alloc] initWithPack:data];
}

+ (instancetype)modelWithPackData:(NSData*)data {
    id pack = [NSObject glb_unpackFromData:data];
    if(pack != nil) {
        return [self modelWithPack:pack];
    }
    return nil;
}

- (instancetype)initWithJson:(id)json {
    self = [self initWithDefaultContext];
    if(self != nil) {
        [self fromJson:json];
    }
    return self;
}

- (instancetype)initWithJson:(id)json sheme:(NSString*)sheme {
    self = [self initWithDefaultContext];
    if(self != nil) {
        [self fromJson:json sheme:sheme];
    }
    return self;
}

- (instancetype)initWithPack:(NSDictionary< NSString*, id >*)data {
    self = [self initWithDefaultContext];
    if(self != nil) {
        [self unpack:data];
    }
    return self;
}

- (void)fromJson:(id)json {
    NSDictionary< NSString*, GLBModelJson* >* jsonMap = self.jsonMap;
    if(jsonMap == nil) {
        return;
    }
    [self _fromJson:json sheme:nil jsonMap:jsonMap];
}

- (void)fromJson:(id)json sheme:(NSString*)sheme {
    NSDictionary< NSString*, GLBModelJson* >* jsonMap = nil;
    if(sheme != nil) {
        jsonMap = self.jsonShemeMap[sheme];
    } else {
        jsonMap = self.jsonMap;
    }
    if(jsonMap == nil) {
        return;
    }
    [self _fromJson:json sheme:sheme jsonMap:jsonMap];
}

- (void)fromJsonData:(NSData*)data {
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if(json != nil) {
        [self fromJson:json];
    }
}

- (void)fromJsonData:(NSData*)data sheme:(NSString*)sheme {
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if(json != nil) {\
        [self fromJson:json sheme:sheme];
    }
}

- (NSDictionary*)toJson {
    NSDictionary< NSString*, GLBModelJson* >* jsonMap = self.jsonMap;
    if(jsonMap == nil) {
        return nil;
    }
    return [self _toJson:nil jsonMap:self.jsonMap];
}

- (NSDictionary*)toJson:(NSString*)sheme {
    NSDictionary< NSString*, GLBModelJson* >* jsonMap = nil;
    if(sheme != nil) {
        jsonMap = self.jsonShemeMap[sheme];
    } else {
        jsonMap = self.jsonMap;
    }
    if(jsonMap == nil) {
        return nil;
    }
    return [self _toJson:nil jsonMap:jsonMap];
}

- (NSData*)toJsonData {
    NSDictionary* json = [self toJson];
    if(json != nil) {
        return [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    }
    return nil;
}

- (NSData*)toJsonData:(NSString*)sheme {
    NSDictionary* json = [self toJson:sheme];
    if(json != nil) {
        return [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    }
    return nil;
}

- (NSDictionary< NSString*, id >* _Nullable)pack {
    NSMutableDictionary* result = NSMutableDictionary.dictionary;
    [self.packMap enumerateKeysAndObjectsUsingBlock:^(NSString* field, GLBModelPack* converter, BOOL* stop __unused) {
        id value = [self valueForKey:field];
        if(value != nil) {
            id packValue = [converter pack:value];
            if(packValue != nil) {
                result[field] = packValue;
            }
        }
    }];
    return result.copy;
}

- (NSData*)packData {
    NSDictionary* pack = self.pack;
    if(pack != nil) {
        return [NSObject glb_packObject:pack];
    }
    return nil;
}

- (void)unpack:(NSDictionary< NSString*, id >*)data {
    [self.packMap enumerateKeysAndObjectsUsingBlock:^(NSString* field, GLBModelPack* converter, BOOL* stop __unused) {
        id packValue = data[field];
        if(packValue != nil) {
            id value = [converter unpack:packValue];
            @try {
                [self setValue:value forKey:field];
            }
            @catch(NSException *exception) {
            }
        }
    }];
}

- (void)unpackData:(NSData*)data {
    id object = [NSObject glb_unpackFromData:data];
    if([object isKindOfClass:NSDictionary.class] == YES) {
        [self unpack:object];
    }
}

#pragma mark - Public

- (void)refreshMergeChanges:(BOOL)flag {
    [self.managedObjectContext refreshObject:self mergeChanges:flag];
}

- (BOOL)save {
    NSError *error = nil;
    BOOL result = [self.managedObjectContext save:&error];
    if(result == NO) {
        NSLog(@"Failure save %@", error);
    }
    return result;
}

- (void)remove {
    [self.managedObjectContext deleteObject:self];
}

#pragma mark - Private

+ (NSDictionary*)_buildJsonMap {
    static NSMutableDictionary* cache = nil;
    if(cache == nil) {
        cache = NSMutableDictionary.dictionary;
    }
    return [GLBModelHelper dictionaryMap:cache class:self.class selector:@selector(jsonMap)];
}

+ (NSDictionary*)_buildJsonShemeMap {
    static NSMutableDictionary* cache = nil;
    if(cache == nil) {
        cache = NSMutableDictionary.dictionary;
    }
    return [GLBModelHelper multiDictionaryMap:cache class:self.class selector:@selector(jsonShemeMap)];
}

+ (NSDictionary*)_buildPackMap {
    static NSMutableDictionary* cache = nil;
    if(cache == nil) {
        cache = NSMutableDictionary.dictionary;
    }
    return [GLBModelHelper dictionaryMap:cache class:self.class selector:@selector(packMap)];
}

+ (NSArray< NSString* >* _Nonnull)_buildPropertyMap {
    static NSMutableDictionary* cache = nil;
    if(cache == nil) {
        cache = NSMutableDictionary.dictionary;
    }
    return [GLBModelHelper arrayMap:cache class:self.class selector:@selector(propertyMap)];
}

- (void)_fromJson:(id)json sheme:(NSString*)sheme jsonMap:(NSDictionary< NSString*, GLBModelJson* >*)jsonMap {
    [jsonMap enumerateKeysAndObjectsUsingBlock:^(NSString* field, GLBModelJson* converter, BOOL* stop __unused) {
        id value = nil;
        if(converter.subPaths.count > 0) {
            for(NSString* path in converter.subPaths) {
                value = [json valueForKeyPath:path];
                if(value != nil) {
                    break;
                }
            }
            if(value != nil) {
                value = [converter fromJson:value sheme:sheme];
            }
        }
        if(value != nil) {
            @try {
                [self setValue:value forKey:field];
            }
            @catch(NSException *exception) {
            }
        }
    }];
}

- (NSDictionary*)_toJson:(NSString*)sheme jsonMap:(NSDictionary< NSString*, GLBModelJson* >*)jsonMap {
    NSMutableDictionary* result = NSMutableDictionary.dictionary;
    [jsonMap enumerateKeysAndObjectsUsingBlock:^(NSString* field, GLBModelJson* converter, BOOL* stop __unused) {
        if(converter.subPaths.count > 0) {
            id value = [self valueForKey:field];
            if(value != nil) {
                id jsonValue = [converter toJson:value sheme:sheme];
                if(jsonValue != nil) {
                    [result setValue:jsonValue forKeyPath:converter.subPaths.firstObject];
                }
            }
        }
    }];
    return result.copy;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder*)coder {
    NSManagedObjectContext* entityContext = self.class.entityContext;
    NSManagedObjectID* objectId = [entityContext.persistentStoreCoordinator managedObjectIDForURIRepresentation:[coder decodeObjectForKey:GLBManagedModelUriKey]];
    return [entityContext objectWithID:objectId];
}

- (void)encodeWithCoder:(NSCoder*)encoder {
    [encoder encodeObject:self.objectID.URIRepresentation forKey:GLBManagedModelUriKey];
}

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    NSUInteger baseIndent = indent + 1;
    [string appendFormat:@"<%@\n", self.glb_className];
    if([context glb_indexForPointer:(__bridge void*)(self)] == NSNotFound) {
        [context addPointer:(__bridge void*)(self)];
        
        NSArray< NSString* >* propertyMap = self.propertyMap;
        if(propertyMap.count > 0) {
            NSUInteger propertyIndent = baseIndent + 1;
            [string glb_appendString:@"\t" repeat:baseIndent];
            [string appendString:@"Properties : {\n"];
            for(NSString* property in self.propertyMap) {
                id value = [self valueForKey:property];
                if(value != nil) {
                    NSString* valueString = [value glb_debugContext:context indent:propertyIndent root:NO];
                    if(valueString != nil) {
                        [string glb_appendString:@"\t" repeat:propertyIndent];
                        [string appendFormat:@"%@ : %@\n", property, valueString];
                    }
                }
            }
            [string glb_appendString:@"\t" repeat:baseIndent];
            [string appendString:@"}\n"];
        }
        [string glb_appendString:@"\t" repeat:indent];
    }
    [string appendString:@">"];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

static GLBManagedManager* GLBManagedManagerInstance = nil;

/*--------------------------------------------------*/

static NSString* GLBManagedManagerExistStoreUrlKey = @"GLBManagedManagerExistStoreUrl";

/*--------------------------------------------------*/

@implementation GLBManagedManager

#pragma mark - Synthesize

@synthesize storeContext = _storeContext;
@synthesize mainContext = _mainContext;
@synthesize backgroundContext = _backgroundContext;
@synthesize model = _model;
@synthesize coordinator = _coordinator;
@synthesize existStoreUrl = _existStoreUrl;
@synthesize storeUrl = _storeUrl;

#pragma mark - Singleton

+ (instancetype)shared {
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        GLBManagedManagerInstance = [[self alloc] init];
    });
    return GLBManagedManagerInstance;
}

#pragma mark - Init / Free

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _observers = [NSMutableArray array];
    _allowsLazyInitialize = YES;
    _allowsCreateStoreDatabase = YES;
    _storeLocalPath = NSFileManager.glb_libraryDirectory;
    _modelName = @"default";
    _modelExtension = @"db";
}

- (void)dealloc {
}

#pragma mark - Property

- (NSManagedObjectContext*)storeContext {
    if(_storeContext != nil) {
        return _storeContext;
    }
    if(_allowsLazyInitialize == YES) {
        [self initializeStore];
    } else {
        @throw [NSException exceptionWithName:GLBManagedManagerErrorDomain reason:@"Disable lazy initialization" userInfo:nil];
    }
    return _storeContext;
}

- (NSManagedObjectContext*)mainContext {
    if(_mainContext != nil) {
        return _mainContext;
    }
    if(_allowsLazyInitialize == YES) {
        [self initializeStore];
    } else {
        @throw [NSException exceptionWithName:GLBManagedManagerErrorDomain reason:@"Disable lazy initialization" userInfo:nil];
    }
    return _mainContext;
}

- (NSManagedObjectContext*)backgroundContext {
    if(_backgroundContext != nil) {
        return _backgroundContext;
    }
    if(_allowsLazyInitialize == YES) {
        [self initializeStore];
    } else {
        @throw [NSException exceptionWithName:GLBManagedManagerErrorDomain reason:@"Disable lazy initialization" userInfo:nil];
    }
    return _backgroundContext;
}

- (NSManagedObjectContext*)currentContext {
    if(NSThread.isMainThread == YES) {
        return self.mainContext;
    }
    return self.backgroundContext;
}

- (NSManagedObjectModel*)model {
    if(_model != nil) {
        return _model;
    }
    if(_allowsLazyInitialize == YES) {
        [self initializeStore];
    } else {
        @throw [NSException exceptionWithName:GLBManagedManagerErrorDomain reason:@"Disable lazy initialization" userInfo:nil];
    }
    return _model;
}

- (NSPersistentStoreCoordinator*)coordinator {
    if(_coordinator != nil) {
        return _coordinator;
    }
    if(_allowsLazyInitialize == YES) {
        [self initializeStore];
    } else {
        @throw [NSException exceptionWithName:GLBManagedManagerErrorDomain reason:@"Disable lazy initialization" userInfo:nil];
    }
    return _coordinator;
}

- (void)setStoreAppGroupName:(NSString*)storeAppGroupName {
    if(_storeAppGroupName != storeAppGroupName) {
        if(_initialized == YES) {
            @throw [NSException exceptionWithName:GLBManagedManagerErrorDomain reason:@"Store already initialized" userInfo:nil];
        }
        _storeAppGroupName = storeAppGroupName;
        if(_storeAppGroupName.length > 0) {
            _containerUrl = [NSFileManager.defaultManager containerURLForSecurityApplicationGroupIdentifier:_storeAppGroupName];
        } else {
            _containerUrl = nil;
        }
    }
}

- (void)setStoreLocalPath:(NSString*)storeLocalPath {
    if(_storeLocalPath != storeLocalPath) {
        if(_initialized == YES) {
            @throw [NSException exceptionWithName:GLBManagedManagerErrorDomain reason:@"Store already initialized" userInfo:nil];
        }
        _storeLocalPath = storeLocalPath;
    }
}

- (void)setModelName:(NSString*)modelName {
    if(_modelName != modelName) {
        if(_initialized == YES) {
            @throw [NSException exceptionWithName:GLBManagedManagerErrorDomain reason:@"Store already initialized" userInfo:nil];
        }
        _modelName = modelName;
    }
}

- (void)setModelExtension:(NSString*)modelExtension {
    if(_modelExtension != modelExtension) {
        if(_initialized == YES) {
            @throw [NSException exceptionWithName:GLBManagedManagerErrorDomain reason:@"Store already initialized" userInfo:nil];
        }
        _modelExtension = modelExtension;
    }
}

- (void)setExistStoreUrl:(NSURL*)existStoreUrl {
    if([_existStoreUrl isEqual:existStoreUrl] == NO) {
        _existStoreUrl = existStoreUrl;
        [NSUserDefaults.standardUserDefaults setURL:_existStoreUrl forKey:GLBManagedManagerExistStoreUrlKey];
        [NSUserDefaults.standardUserDefaults synchronize];
    }
}

- (NSURL*)existStoreUrl {
    if(_existStoreUrl == nil) {
        _existStoreUrl = [NSUserDefaults.standardUserDefaults URLForKey:GLBManagedManagerExistStoreUrlKey];
        if(_existStoreUrl == nil) {
            _existStoreUrl = [self _observeExistStoreUrl];
        }
    }
    return _existStoreUrl;
}

- (NSURL*)storeUrl {
    if(_storeUrl == nil) {
        if(_containerUrl != nil) {
            _storeUrl = [NSURL fileURLWithPath:[_containerUrl.path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", _modelName, _modelExtension]]];
        }
        if((_storeUrl == nil) && (_storeLocalPath.length > 0)) {
            _storeUrl = [NSURL fileURLWithPath:[_storeLocalPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", _modelName, _modelExtension]]];
        }
    }
    return _storeUrl;
}

#pragma mark - Public

- (void)addObserver:(id< GLBManagedManagerObserver >)observer {
    NSUInteger index = [_observers indexOfObjectPassingTest:^BOOL(NSValue* value, NSUInteger index, BOOL* stop) {
        return (value.nonretainedObjectValue == observer);
    }];
    if(index == NSNotFound) {
        [_observers addObject:[NSValue valueWithNonretainedObject:observer]];
    }
}

- (void)removeObserver:(id< GLBManagedManagerObserver >)observer {
    [_observers glb_each:^(NSValue* value) {
        if(value.nonretainedObjectValue == observer) {
            [_observers removeObject:value];
        }
    }];
}

- (BOOL)initializeStore {
    if(_initialized == NO) {
        NSError* error = nil;
        if(_model == nil) {
            NSURL* url = [NSBundle.mainBundle URLForResource:_modelName withExtension:@"momd"];
            if(url != nil) {
                _model = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
            } else {
                error = [NSError errorWithDomain:GLBManagedManagerErrorDomain
                                            code:GLBManagedManagerErrorInitializeModel
                                        userInfo:nil];
            }
        }
        if((_coordinator == nil) && (_model != nil)) {
            NSPersistentStoreCoordinator* coordinator = nil;
            NSMutableDictionary* coordinatorOptions = [NSMutableDictionary dictionary];
            coordinatorOptions[NSMigratePersistentStoresAutomaticallyOption] = @YES;
            coordinatorOptions[NSInferMappingModelAutomaticallyOption] = @YES;
            coordinatorOptions[NSSQLitePragmasOption] = @{
                @"journal_mode" : @"WAL"
            };
            NSPersistentStore* store = nil;
            NSURL* storeSrcUrl = self.existStoreUrl;
            NSURL* storeDstUrl = self.storeUrl;
            if((storeSrcUrl != nil) || (storeDstUrl != nil)) {
                if((storeSrcUrl != nil) && (storeDstUrl != nil)) {
                    if([storeSrcUrl isEqual:storeDstUrl] == NO) {
                        if([NSFileManager.defaultManager fileExistsAtPath:storeSrcUrl.path] == YES) {
                            if([NSFileManager.defaultManager fileExistsAtPath:storeDstUrl.path] == YES) {
                                if([NSFileManager.defaultManager removeItemAtURL:storeDstUrl error:&error] == NO) {
                                    storeDstUrl = nil;
                                }
                            }
                        } else {
                            storeDstUrl = nil;
                        }
                    } else {
                        storeDstUrl = nil;
                    }
                } else if((storeSrcUrl == nil) && (storeDstUrl != nil)) {
                    storeSrcUrl = storeDstUrl;
                    storeDstUrl = nil;
                }
                BOOL storeSrcExist = [NSFileManager.defaultManager fileExistsAtPath:storeSrcUrl.path];
                if((_allowsCreateStoreDatabase == YES) || (storeSrcExist == YES)) {
                    if([self _migrateURL:storeSrcUrl options:coordinatorOptions type:NSSQLiteStoreType model:_model error:&error] == YES) {
                        coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
                        store = [coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                          configuration:nil
                                                                    URL:storeSrcUrl
                                                                options:coordinatorOptions
                                                                  error:&error];
                        if(store == nil) {
                            coordinatorOptions[NSSQLitePragmasOption] = @{
                                @"journal_mode" : @"DELETE"
                            };
                            store = [coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                              configuration:nil
                                                                        URL:storeSrcUrl
                                                                    options:coordinatorOptions
                                                                      error:&error];
                            if(store != nil) {
                                [coordinator removePersistentStore:store error:NULL];
                                coordinatorOptions[NSSQLitePragmasOption] = @{
                                    @"journal_mode" : @"WAL"
                                };
                                store = [coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                                  configuration:nil URL:storeSrcUrl
                                                                        options:coordinatorOptions
                                                                          error:&error];
                            }
                            storeDstUrl = nil;
                        }
                        if(storeDstUrl != nil) {
                            store = [coordinator migratePersistentStore:store
                                                                  toURL:storeDstUrl
                                                                options:coordinatorOptions
                                                               withType:NSSQLiteStoreType
                                                                  error:&error];
                            if(store != nil) {
                                [NSFileManager.defaultManager removeItemAtURL:storeSrcUrl error:&error];
                            }
                            self.existStoreUrl = storeDstUrl;
                        } else {
                            self.existStoreUrl = storeSrcUrl;
                        }
                    } else {
                        if(error == nil) {
                            error = [NSError errorWithDomain:GLBManagedManagerErrorDomain
                                                        code:GLBManagedManagerErrorInitializeMigration
                                                    userInfo:nil];
                        }
                    }
                }
            }
            if(store != nil) {
                _coordinator = coordinator;
            } else {
                error = [NSError errorWithDomain:GLBManagedManagerErrorDomain
                                            code:GLBManagedManagerErrorInitializeStore
                                        userInfo:nil];
            }
        }
        if((_storeContext == nil) && (_coordinator != nil)) {
            _storeContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
            if(_storeContext != nil) {
                _storeContext.persistentStoreCoordinator = _coordinator;
                _storeContext.mergePolicy = NSErrorMergePolicy;
            } else {
                error = [NSError errorWithDomain:GLBManagedManagerErrorDomain
                                            code:GLBManagedManagerErrorInitializeContext
                                        userInfo:nil];
            }
        }
        if((_mainContext == nil) && (_storeContext != nil)) {
            _mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
            if(_mainContext != nil) {
                _mainContext.parentContext = _storeContext;
                _mainContext.mergePolicy = _storeContext.mergePolicy;
                [NSNotificationCenter.defaultCenter addObserver:self
                                                       selector:@selector(_notificationDidSaveMainContext:)
                                                           name:NSManagedObjectContextDidSaveNotification
                                                         object:_mainContext];
            } else {
                error = [NSError errorWithDomain:GLBManagedManagerErrorDomain
                                            code:GLBManagedManagerErrorInitializeContext
                                        userInfo:nil];
            }
        }
        if((_backgroundContext == nil) && (_mainContext != nil)) {
            _backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
            if(_backgroundContext != nil) {
                _backgroundContext.parentContext = _mainContext;
                _backgroundContext.mergePolicy = _mainContext.mergePolicy;
                [NSNotificationCenter.defaultCenter addObserver:self
                                                       selector:@selector(_notificationDidSaveBackgroundContext:)
                                                           name:NSManagedObjectContextDidSaveNotification
                                                         object:_backgroundContext];
            } else {
                error = [NSError errorWithDomain:GLBManagedManagerErrorDomain
                                            code:GLBManagedManagerErrorInitializeContext
                                        userInfo:nil];
            }
        }
        if((_model != nil) && (_coordinator != nil) && (_storeContext != nil) && (_mainContext != nil) && (_backgroundContext != nil)) {
            _initialized = YES;
        } else {
            if(error == nil) {
                error = [NSError errorWithDomain:GLBManagedManagerErrorDomain
                                            code:GLBManagedManagerErrorInitializeUnknown
                                        userInfo:nil];
            }
        }
        [self _observeInitializeStoreError:error];
    }
    return _initialized;
}

- (void)closeStore {
    if(_initialized == YES) {
        if(_backgroundContext != nil) {
            [NSNotificationCenter.defaultCenter removeObserver:self
                                                          name:NSManagedObjectContextDidSaveNotification
                                                        object:_backgroundContext];
            _backgroundContext = nil;
        }
        if(_mainContext != nil) {
            [NSNotificationCenter.defaultCenter removeObserver:self
                                                          name:NSManagedObjectContextDidSaveNotification
                                                        object:_mainContext];
            _mainContext = nil;
        }
        if(_storeContext != nil) {
            // TODO
            _storeContext = nil;
        }
        if(_coordinator != nil) {
            // TODO
            _coordinator = nil;
        }
        if(_model != nil) {
            // TODO
            _model = nil;
        }
        _initialized = NO;
        [self _observeCloseStore];
    }
}

- (void)performBlock:(GLBManagedManagerPerform)update {
    [self.currentContext performBlock:update];
}

- (void)performBlockAndWait:(GLBManagedManagerPerform)update {
    [self.currentContext performBlockAndWait:update];
}

- (void)undo {
    [self.currentContext undo];
}

- (void)redo {
    [self.currentContext redo];
}

- (void)reset {
    [self.currentContext reset];
}

- (void)rollback {
    [self.currentContext rollback];
}

- (BOOL)save {
    return [self _saveContext:self.currentContext];
}

- (NSManagedObject*)objectRegisteredForID:(NSManagedObjectID*)objectID {
    return [self.currentContext objectRegisteredForID:objectID];
}

- (NSManagedObject*)objectWithID:(NSManagedObjectID*)objectID {
    return [self.currentContext objectWithID:objectID];
}

- (NSManagedObject*)existingObjectWithID:(NSManagedObjectID*)objectID error:(NSError**)error {
    return [self.currentContext existingObjectWithID:objectID error:error];
}

- (NSArray*)executeFetchRequest:(NSFetchRequest*)request error:(NSError**)error {
    return [self.currentContext executeFetchRequest:request error:error];
}

- (NSUInteger)countForFetchRequest:(NSFetchRequest*)request error: (NSError**)error {
    return [self.currentContext countForFetchRequest:request error:error];
}

- (void)setFetchRequestTemplate:(NSFetchRequest*)fetchRequestTemplate forName:(NSString*)name {
    [self.model setFetchRequestTemplate:fetchRequestTemplate forName:name];
}

- (NSFetchRequest*)fetchRequestTemplateForName:(NSString*)name {
    return [self.model fetchRequestTemplateForName:name];
}

- (NSFetchRequest*)fetchRequestFromTemplateWithName:(NSString*)name variables:(NSDictionary< NSString*, id >*)variables {
    return [self.model fetchRequestFromTemplateWithName:name substitutionVariables:variables];
}

- (NSArray*)executeTemplateFetchRequestForName:(NSString*)name error:(NSError**)error {
    NSFetchRequest* request = [self.model fetchRequestTemplateForName:name];
    if(request != nil) {
        return [self.currentContext executeFetchRequest:request error:error];
    }
    return nil;
}

- (NSArray*)executeTemplateFetchRequestForName:(NSString*)name variables:(NSDictionary< NSString*, id >*)variables error:(NSError**)error {
    NSFetchRequest* request = [self.model fetchRequestFromTemplateWithName:name substitutionVariables:variables];
    if(request != nil) {
        return [self.currentContext executeFetchRequest:request error:error];
    }
    return nil;
}

- (void)insertObject:(NSManagedObject* _Nonnull)object {
    [self.currentContext insertObject:object];
}

- (void)deleteObject:(NSManagedObject* _Nonnull)object {
    [self.currentContext deleteObject:object];
}

- (void)refreshObject:(NSManagedObject* _Nonnull)object mergeChanges:(BOOL)flag {
    [self.currentContext refreshObject:object mergeChanges:flag];
}

- (void)refreshRegisteredObjectsMergeChanges:(BOOL)flag {
    NSManagedObjectContext* currentContext = self.currentContext;
    for(NSManagedObject* object in currentContext.registeredObjects) {
        [currentContext refreshObject:object mergeChanges:flag];
    }
}

- (void)detectConflictsForObject:(NSManagedObject* _Nonnull)object {
    [self.currentContext detectConflictsForObject:object];
}

#pragma mark - Private

- (BOOL)_saveContext:(NSManagedObjectContext*)context {
    BOOL result = NO;
    if(context.hasChanges == YES) {
        NSError* error = nil;
        NSSet* insertedObjects = context.insertedObjects;
        if(insertedObjects.count > 0) {
            if([context obtainPermanentIDsForObjects:insertedObjects.allObjects error:&error] == NO) {
                NSLog(@"Failure obtain permanent ids: %@", error);
            }
        }
        result = [context save:&error];
        if(result == NO) {
            NSLog(@"Failure save:%@", error);
        }
    } else {
        result = YES;
    }
    return result;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

- (BOOL)_migrateURL:(NSURL*)sourceStoreURL options:(NSDictionary*)options type:(NSString*)type model:(NSManagedObjectModel*)model error:(NSError**)error {
    NSDictionary* sourceMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:type URL:sourceStoreURL error:error];
    if(sourceMetadata == nil) {
        return YES;
    }
    if([model isConfiguration:nil compatibleWithStoreMetadata:sourceMetadata] == YES) {
        if(error != NULL) {
            *error = nil;
        }
        return YES;
    }
    NSManagedObjectModel* sourceModel = [self _modelForMetadata:sourceMetadata];
    NSManagedObjectModel* destinationModel = nil;
    NSMappingModel* mappingModel = nil;
    NSString* modelName = nil;
    if([self _destinationModel:&destinationModel mappingModel:&mappingModel modelName:&modelName forSourceModel:sourceModel error:error] == NO) {
        return NO;
    }
    NSURL* destinationStoreURL = [self _destinationStoreURLWithSourceStoreURL:sourceStoreURL modelName:modelName];
    NSMigrationManager* manager = [[NSMigrationManager alloc] initWithSourceModel:sourceModel destinationModel:destinationModel];
    if([manager migrateStoreFromURL:sourceStoreURL type:type options:options withMappingModel:mappingModel toDestinationURL:destinationStoreURL destinationType:type destinationOptions:nil error:error] == NO) {
        return NO;
    }
    if([self _backupSourceStoreAtURL:sourceStoreURL destinationStoreAtURL:destinationStoreURL error:error] == NO) {
        return NO;
    }
    return [self _migrateURL:sourceStoreURL options:options type:type model:model error:error];
}

#pragma clang diagnostic pop

- (NSManagedObjectModel*)_modelForMetadata:(NSDictionary*)sourceMetadata {
    return [NSManagedObjectModel mergedModelFromBundles:@[ NSBundle.mainBundle ] forStoreMetadata:sourceMetadata];
}

- (BOOL)_destinationModel:(NSManagedObjectModel**)destinationModel
             mappingModel:(NSMappingModel**)mappingModel
                modelName:(NSString**)modelName
           forSourceModel:(NSManagedObjectModel*)sourceModel
                    error:(NSError**)error {
    NSArray* modelPaths = [self _allModelPaths];
    if(modelPaths.count < 1) {
        if(error != NULL) {
            *error = [NSError errorWithDomain:GLBManagedManagerErrorDomain code:8001 userInfo:@{
                NSLocalizedDescriptionKey : @"No models found!"
            }];
        }
        return NO;
    }
    NSManagedObjectModel* model = nil;
    NSMappingModel* mapping = nil;
    NSString* modelPath = nil;
    for(modelPath in modelPaths) {
        model = [[NSManagedObjectModel alloc] initWithContentsOfURL:[NSURL fileURLWithPath:modelPath]];
        mapping = [NSMappingModel mappingModelFromBundles:@[ NSBundle.mainBundle ] forSourceModel:sourceModel destinationModel:model];
        if(mapping != nil) {
            break;
        }
    }
    if(mapping == nil) {
        if(error != NULL) {
            *error = [NSError errorWithDomain:GLBManagedManagerErrorDomain code:8001 userInfo:@{
                NSLocalizedDescriptionKey : @"No mapping model found in bundle"
            }];
        }
        return NO;
    }
    *destinationModel = model;
    *mappingModel = mapping;
    *modelName = modelPath.lastPathComponent.stringByDeletingPathExtension;
    return YES;
}

- (NSArray*)_allModelPaths {
    static NSArray* paths = nil;
    if(paths == nil) {
        NSMutableArray* findedPaths = [NSMutableArray array];
        NSBundle* bundle = NSBundle.mainBundle;
        NSArray* momdArray = [bundle pathsForResourcesOfType:@"momd" inDirectory:nil];
        for(NSString* momdPath in momdArray) {
            [findedPaths addObjectsFromArray:[bundle pathsForResourcesOfType:@"mom" inDirectory:momdPath.lastPathComponent]];
        }
        [findedPaths addObjectsFromArray:[bundle pathsForResourcesOfType:@"mom" inDirectory:nil]];
        paths = findedPaths.copy;
    }
    return paths;
}

- (NSURL*)_destinationStoreURLWithSourceStoreURL:(NSURL*)sourceStoreURL modelName:(NSString*)modelName {
    NSString* storeExtension = sourceStoreURL.path.pathExtension;
    NSString* storePath = sourceStoreURL.path.stringByDeletingPathExtension;
    return [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@.%@.%@", storePath, modelName, storeExtension]];
}

- (BOOL)_backupSourceStoreAtURL:(NSURL*)sourceStoreURL destinationStoreAtURL:(NSURL*)destinationStoreURL error:(NSError**)error {
    NSString* guid = [[NSProcessInfo processInfo] globallyUniqueString];
    NSString* backupPath = [NSTemporaryDirectory() stringByAppendingPathComponent:guid];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if([fileManager moveItemAtPath:sourceStoreURL.path toPath:backupPath error:error] == NO) {
        return NO;
    }
    if([fileManager moveItemAtPath:destinationStoreURL.path toPath:sourceStoreURL.path error:error] == NO) {
        [fileManager moveItemAtPath:backupPath toPath:sourceStoreURL.path error:nil];
        return NO;
    }
    NSString* sourceStorePath = sourceStoreURL.path;
    NSString* sourceStoreDir = [sourceStorePath stringByDeletingLastPathComponent];
    NSString* sourceStoreFileName = sourceStorePath.lastPathComponent;
    NSArray* sourceStoreFiles = [fileManager contentsOfDirectoryAtPath:sourceStoreDir error:nil];
    for(NSString* sourceStoreFile in sourceStoreFiles) {
        if(([sourceStoreFile hasPrefix:sourceStoreFileName] == YES) && ([sourceStoreFile isEqualToString:sourceStoreFileName] == NO)) {
            [fileManager removeItemAtPath:[sourceStoreDir stringByAppendingPathComponent:sourceStoreFile] error:nil];
        }
    }
    return YES;
}

#pragma mark - NSNotification

- (void)_notificationDidSaveMainContext:(NSNotification*)notification {
    [_storeContext performBlock:^{
        [_storeContext mergeChangesFromContextDidSaveNotification:notification];
        [self _saveContext:_storeContext];
    }];
}

- (void)_notificationDidSaveBackgroundContext:(NSNotification*)notification {
    [_mainContext performBlock:^{
        [_mainContext mergeChangesFromContextDidSaveNotification:notification];
        [self _saveContext:_mainContext];
    }];
}

#pragma mark - Observer

- (NSURL*)_observeExistStoreUrl {
    __block NSURL* result = nil;
    [_observers enumerateObjectsUsingBlock:^(NSValue* value, NSUInteger index, BOOL* stop) {
        id< GLBManagedManagerObserver > observer = value.nonretainedObjectValue;
        if([observer respondsToSelector:@selector(existStoreUrlInManagedManager:)] == YES) {
            result = [observer existStoreUrlInManagedManager:self];
            if(result != nil) {
            }
        }
    }];
    return result;
}

- (void)_observeInitializeStoreError:(NSError*)error {
    [_observers glb_each:^(NSValue* value) {
        id< GLBManagedManagerObserver > observer = value.nonretainedObjectValue;
        if([observer respondsToSelector:@selector(initializeStoreInManagedManager:error:)] == YES) {
            [observer initializeStoreInManagedManager:self error:error];
        }
    }];
}

- (void)_observeCloseStore {
    [_observers glb_each:^(NSValue* value) {
        id< GLBManagedManagerObserver > observer = value.nonretainedObjectValue;
        if([observer respondsToSelector:@selector(closeStoreInManagedManager:)] == YES) {
            [observer closeStoreInManagedManager:self];
        }
    }];
}

@end

/*--------------------------------------------------*/

NSString* GLBManagedManagerErrorDomain = @"GLBManagedManagerErrorDomain";

/*--------------------------------------------------*/
