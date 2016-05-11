/*--------------------------------------------------*/

#import "GLBModel+Private.h"

/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"
#import "NSArray+GLBNS.h"
#import "NSDictionary+GLBNS.h"
#import "NSFileManager+GLBNS.h"
#import "NSBundle+GLBNS.h"

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

#define GLB_MODEL_EXTENSION                         @"model"

/*--------------------------------------------------*/

@implementation GLBModel

#pragma mark - Synthesize

@synthesize jsonMap = _jsonMap;
@synthesize packMap = _packMap;
@synthesize compareMap = _compareMap;
@synthesize serializeMap = _serializeMap;
@synthesize copyMap = _copyMap;

#pragma mark - Init / Free

+ (instancetype)modelWithUserDefaultsKey:(NSString*)userDefaultsKey {
    return [self modelWithUserDefaultsKey:userDefaultsKey userDefaults:NSUserDefaults.standardUserDefaults];
}

+ (instancetype)modelWithUserDefaultsKey:(NSString*)userDefaultsKey userDefaults:(NSUserDefaults*)userDefaults {
    if(userDefaults == nil) {
        userDefaults = NSUserDefaults.standardUserDefaults;
    }
    if([userDefaults objectForKey:userDefaultsKey] != nil) {
        return [[self alloc] initWithUserDefaultsKey:userDefaultsKey userDefaults:userDefaults];
    }
    return nil;
}

+ (instancetype)modelWithFileName:(NSString*)fileName {
    NSString* filePath = [NSFileManager.glb_cachesDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", fileName, GLB_MODEL_EXTENSION]];
    if([NSFileManager.defaultManager fileExistsAtPath:filePath] == YES) {
        return [[self alloc] initWithFileName:fileName];
    }
    return nil;
}

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder*)coder {
    self = [super init];
    if(self != nil) {
        for(NSString* field in self.serializeMap) {
            id value = [coder decodeObjectForKey:field];
            if(value != nil) {
                [self setValue:value forKey:field];
            }
        }
        [self setup];
    }
    return self;
}

- (instancetype)initWithFileName:(NSString*)fileName {
    self = [super init];
    if(self != nil) {
        self.fileName = fileName;
        [self load];
        [self setup];
    }
    return self;
}

- (instancetype)initWithUserDefaultsKey:(NSString*)userDefaultsKey {
    return [self initWithUserDefaultsKey:userDefaultsKey userDefaults:NSUserDefaults.standardUserDefaults];
}

- (instancetype)initWithUserDefaultsKey:(NSString*)userDefaultsKey userDefaults:(NSUserDefaults*)userDefaults {
    self = [super init];
    if(self != nil) {
        _userDefaultsKey = userDefaultsKey;
        _userDefaults = userDefaults;
        [self load];
        [self setup];
    }
    return self;
}

- (void)setup {
    if(_userDefaults == nil) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
    if(self == object) {
        return YES;
    }
    BOOL result = NO;
    if([object isKindOfClass:self.class] == YES) {
        NSArray* map = self.compareMap;
        if(map.count < 1) {
            map = self.serializeMap;
        }
        if(map.count > 0) {
            result = YES;
            for(NSString* field in map) {
                id value1 = [self valueForKey:field];
                id value2 = [object valueForKey:field];
                if(value1 != value2) {
                    if([value1 isEqual:value2] == NO) {
                        result = NO;
                        break;
                    }
                }
            }
        }
    } else {
        result = [super isEqual:object];
    }
    return result;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder*)coder {
    for(NSString* field in self.serializeMap) {
        id value = [self valueForKey:field];
        if(value != nil) {
            [coder encodeObject:value forKey:field];
        }
    }
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone*)zone {
    GLBModel* result = [[self.class allocWithZone:zone] init];
    if(result != nil) {
        result.userDefaultsKey = _userDefaultsKey;
        result.userDefaults = _userDefaults;
        result.fileName = _fileName;
        NSArray* map = self.copyMap;
        if(map.count < 1) {
            map = self.serializeMap;
        }
        for(NSString* field in map) {
            id value = [self valueForKey:field];
            if([value isKindOfClass:NSArray.class] == YES) {
                NSMutableArray* array = [NSMutableArray arrayWithCapacity:[value count]];
                for(id item in value) {
                    [array addObject:[item copyWithZone:zone]];
                }
                [result setValue:array forKey:field];
            } else if([value isKindOfClass:NSDictionary.class] == YES) {
                NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:[value count]];
                [value glb_each:^(id key, id item) {
                    dict[key] = [item copyWithZone:zone];
                }];
                [result setValue:dict forKey:field];
            } else {
                [result setValue:[value copyWithZone:zone] forKey:field];
            }
        }
    }
    return result;
}

#pragma mark - Debug

- (NSString*)description {
    NSMutableArray* result = NSMutableArray.array;
    for(NSString* field in self.serializeMap) {
        [result addObject:[NSString stringWithFormat:@"%@ = %@", field, [self valueForKey:field]]];
    }
    return [result componentsJoinedByString:@"; "];
}

#pragma mark - Property

- (void)setFileName:(NSString*)fileName {
    if(_fileName != fileName) {
        _fileName = fileName;
        if(_fileName != nil) {
            _filePath = [NSFileManager.glb_cachesDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", _fileName, GLB_MODEL_EXTENSION]];
        } else {
            _filePath = nil;
        }
    }
}

- (NSDictionary*)jsonMap {
    if(_jsonMap == nil) {
        _jsonMap = [self.class _buildJsonMap];
    }
    return _jsonMap;
}

- (NSDictionary*)packMap {
    if(_packMap == nil) {
        _packMap = [self.class _buildPackMap];
    }
    return _packMap;
}

- (NSArray*)compareMap {
    if(_compareMap == nil) {
        _compareMap = [self.class _buildCompareMap];
    }
    return _compareMap;
}

- (NSArray*)serializeMap {
    if(_serializeMap == nil) {
        _serializeMap = [self.class _buildSerializeMap];
    }
    return _serializeMap;
}

- (NSArray*)copyMap {
    if(_copyMap == nil) {
        _copyMap = [self.class _buildCopyMap];
    }
    return _copyMap;
}

#pragma mark - GLBModel

+ (NSDictionary*)jsonMap {
    return nil;
}

+ (NSDictionary*)packMap {
    return nil;
}

+ (instancetype)modelWithJson:(id)json {
    return [[self alloc] initWithJson:json];
}

+ (instancetype)modelWithJsonData:(NSData*)data {
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if(json != nil) {
        return [self modelWithJson:json];
    }
    return nil;
}

+ (instancetype)modelWithPack:(NSDictionary< NSString*, id >*)data {
    return [[self alloc] initWithPack:data];
}

+ (instancetype)modelWithPackData:(NSData*)data {
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if(json != nil) {
        return [self modelWithPack:json];
    }
    return nil;
}

- (instancetype)initWithJson:(id)json {
    self = [super init];
    if(self != nil) {
        [self fromJson:json];
        [self setup];
    }
    return self;
}

- (instancetype)initWithPack:(NSDictionary< NSString*, id >*)data {
    self = [super init];
    if(self != nil) {
        [self unpack:data];
        [self setup];
    }
    return self;
}

- (void)fromJson:(id)json {
    [self.jsonMap enumerateKeysAndObjectsUsingBlock:^(NSString* field, GLBModelJson* converter, BOOL* stop __unused) {
        id value = [converter parseJson:json];
        if(value != nil) {
            [self setValue:value forKey:field];
        }
    }];
}

- (void)fromJsonData:(NSData*)data {
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if(json != nil) {
        [self fromJson:json];
    }
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
    NSDictionary* packDict = self.pack;
    if(packDict != nil) {
        return [NSJSONSerialization dataWithJSONObject:packDict options:0 error:nil];
    }
    return nil;
}

- (void)unpack:(NSDictionary< NSString*, id >*)data {
    [self.packMap enumerateKeysAndObjectsUsingBlock:^(NSString* field, GLBModelPack* converter, BOOL* stop __unused) {
        id packValue = data[field];
        if(packValue != nil) {
            id value = [converter unpack:packValue];
            if(value != nil) {
                [self setValue:value forKey:field];
            }
        }
    }];
}

- (void)unpackData:(NSData*)data {
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if(json != nil) {
        [self unpack:json];
    }
}

#pragma mark - Public

+ (NSArray*)compareMap {
    return nil;
}

+ (NSArray*)serializeMap {
    return nil;
}

+ (NSArray*)copyMap {
    return nil;
}

- (void)clear {
    for(NSString* field in self.serializeMap) {
        @try {
            [self setValue:nil forKey:field];
        }
        @catch(NSException *exception) {
        }
    }
}

- (void)clearComplete:(GLBModelBlock)complete {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self clear];
        if(complete != nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                complete();
            });
        }
    });
}

- (BOOL)save {
    @try {
        NSMutableDictionary* dict = NSMutableDictionary.dictionary;
        if(dict != nil) {
            for(NSString* field in self.serializeMap) {
                @try {
                    id value = [self valueForKey:field];
                    if(value != nil) {
                        NSData* archive = [NSKeyedArchiver archivedDataWithRootObject:value];
                        if(archive != nil) {
                            dict[field] = archive;
                        }
                    }
                }
                @catch (NSException* exception) {
                    NSLog(@"GLBModel::saveItem:%@ Exception = %@ Field=%@", _userDefaultsKey, exception, field);
                }
            }
            if((_userDefaults != nil) && (_userDefaultsKey.length > 0)) {
                [_userDefaults setObject:dict forKey:_userDefaultsKey];
                return [_userDefaults synchronize];
            } else if(_filePath.length > 0) {
                return [NSKeyedArchiver archiveRootObject:dict toFile:_filePath];
            }
        }
    }
    @catch(NSException* exception) {
        NSLog(@"GLBModel::saveItem:%@ Exception = %@", _userDefaultsKey, exception);
    }
    return NO;
}

- (void)saveSuccess:(GLBModelBlock)success failure:(GLBModelBlock)failure {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        if([self save] == YES) {
            if(success != nil) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    success();
                });
            }
        } else {
            if(failure != nil) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    failure();
                });
            }
        }
    });
}

- (void)load {
    @try {
        NSDictionary* dict = nil;
        if((_userDefaults != nil) && (_userDefaultsKey.length > 0)) {
            dict = [_userDefaults objectForKey:_userDefaultsKey];
        } else if(_filePath.length > 0) {
            dict = [NSKeyedUnarchiver unarchiveObjectWithFile:_filePath];
        }
        if(dict != nil) {
            for(NSString* field in self.serializeMap) {
                id value = dict[field];
                if(value != nil) {
                    if([value isKindOfClass:NSData.class] == YES) {
                        id unarchive = [NSKeyedUnarchiver unarchiveObjectWithData:value];
                        if(unarchive != nil) {
                            @try {
                                [self setValue:unarchive forKey:field];
                            }
                            @catch(NSException *exception) {
                            }
                        }
                    }
                }
            }
        }
    }
    @catch(NSException* exception) {
        NSLog(@"GLBModel::loadItem:%@ Exception = %@", _userDefaultsKey, exception);
    }
}

- (void)loadComplete:(GLBModelBlock)complete {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self load];
        if(complete != nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                complete();
            });
        }
    });
}

- (void)erase {
    if((_userDefaults != nil) && (_userDefaultsKey.length > 0)) {
        NSDictionary* dict = [_userDefaults objectForKey:_userDefaultsKey];
        if(dict != nil) {
            [_userDefaults removeObjectForKey:_userDefaultsKey];
            [_userDefaults synchronize];
        }
    } else if(_filePath.length > 0) {
        [NSFileManager.defaultManager removeItemAtPath:_filePath error:nil];
    }
}

- (void)eraseComplete:(GLBModelBlock)complete {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self erase];
        if(complete != nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                complete();
            });
        }
    });
}

#pragma mark - Private

+ (NSDictionary*)_buildJsonMap {
    static NSMutableDictionary* cache = nil;
    if(cache == nil) {
        cache = NSMutableDictionary.dictionary;
    }
    return [GLBManagedMap dictionaryMap:cache class:self.class selector:@selector(jsonMap)];
}

+ (NSDictionary*)_buildPackMap {
    static NSMutableDictionary* cache = nil;
    if(cache == nil) {
        cache = NSMutableDictionary.dictionary;
    }
    return [GLBManagedMap dictionaryMap:cache class:self.class selector:@selector(packMap)];
}

+ (NSArray*)_buildCompareMap {
    static NSMutableDictionary* cache = nil;
    if(cache == nil) {
        cache = NSMutableDictionary.dictionary;
    }
    return [GLBManagedMap arrayMap:cache class:self.class selector:@selector(compareMap)];
}

+ (NSArray*)_buildSerializeMap {
    static NSMutableDictionary* cache = nil;
    if(cache == nil) {
        cache = NSMutableDictionary.dictionary;
    }
    return [GLBManagedMap arrayMap:cache class:self.class selector:@selector(serializeMap)];
}

+ (NSArray*)_buildCopyMap {
    static NSMutableDictionary* cache = nil;
    if(cache == nil) {
        cache = NSMutableDictionary.dictionary;
    }
    return [GLBManagedMap arrayMap:cache class:self.class selector:@selector(copyMap)];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

static NSString* GLBManagedModelUriKey = @"GLBManagedModelUriKey";

/*--------------------------------------------------*/

@implementation GLBManagedModel

#pragma mark - Synthesize

@synthesize jsonMap = _jsonMap;
@synthesize packMap = _packMap;

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

#pragma mark - Property

- (NSDictionary*)jsonMap {
    if(_jsonMap == nil) {
        _jsonMap = [self.class _buildJsonMap];
    }
    return _jsonMap;
}

- (NSDictionary*)packMap {
    if(_packMap == nil) {
        _packMap = [self.class _buildPackMap];
    }
    return _packMap;
}


#pragma mark - GLBModel

+ (NSDictionary*)jsonMap {
    return nil;
}

+ (NSDictionary*)packMap {
    return nil;
}

+ (instancetype)modelWithJson:(id)json {
    return [[self alloc] initWithJson:json];
}

+ (instancetype)modelWithJsonData:(NSData*)data {
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if(json != nil) {
        return [self modelWithJson:json];
    }
    return nil;
}

+ (instancetype)modelWithPack:(NSDictionary< NSString*, id >*)data {
    return [[self alloc] initWithPack:data];
}

+ (instancetype)modelWithPackData:(NSData*)data {
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if(json != nil) {
        return [self modelWithPack:json];
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

- (instancetype)initWithPack:(NSDictionary< NSString*, id >*)data {
    self = [self initWithDefaultContext];
    if(self != nil) {
        [self unpack:data];
    }
    return self;
}

- (void)fromJson:(id)json {
    [self.jsonMap enumerateKeysAndObjectsUsingBlock:^(NSString* field, GLBModelJson* converter, BOOL* stop __unused) {
        id value = [converter parseJson:json];
        if(value != nil) {
            [self setValue:value forKey:field];
        }
    }];
}

- (void)fromJsonData:(NSData*)data {
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if(json != nil) {
        [self fromJson:json];
    }
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
    NSDictionary* packDict = self.pack;
    if(packDict != nil) {
        return [NSJSONSerialization dataWithJSONObject:packDict options:0 error:nil];
    }
    return nil;
}

- (void)unpack:(NSDictionary< NSString*, id >*)data {
    [self.packMap enumerateKeysAndObjectsUsingBlock:^(NSString* field, GLBModelPack* converter, BOOL* stop __unused) {
        id packValue = data[field];
        if(packValue != nil) {
            id value = [converter unpack:packValue];
            if(value != nil) {
                [self setValue:value forKey:field];
            }
        }
    }];
}

- (void)unpackData:(NSData*)data {
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if(json != nil) {
        [self unpack:json];
    }
}

#pragma mark - Public

- (void)remove {
    [self.managedObjectContext deleteObject:self];
}

- (BOOL)save {
    NSError *error = nil;
    BOOL result = [self.managedObjectContext save:&error];
    if(result == NO) {
        NSLog(@"Failure save %@", error);
    }
    return result;
}

#pragma mark - Private

+ (NSDictionary*)_buildJsonMap {
    static NSMutableDictionary* cache = nil;
    if(cache == nil) {
        cache = NSMutableDictionary.dictionary;
    }
    return [GLBManagedMap dictionaryMap:cache class:self.class selector:@selector(jsonMap)];
}

+ (NSDictionary*)_buildPackMap {
    static NSMutableDictionary* cache = nil;
    if(cache == nil) {
        cache = NSMutableDictionary.dictionary;
    }
    return [GLBManagedMap dictionaryMap:cache class:self.class selector:@selector(packMap)];
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

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

static GLBManagedManager* GLBManagedManagerInstance = nil;
static NSString* GLBManagedManagerModelNameKey = @"GLBManagedManagerModelName";
static NSString* GLBManagedManagerModelExtensionKey = @"GLBManagedManagerModelExtension";

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
    _allowsCreateStoreDatabase = YES;
    _modelLocalPath = NSFileManager.glb_libraryDirectory;
    _modelName = [NSBundle.mainBundle glb_objectForInfoDictionaryKey:GLBManagedManagerModelNameKey defaultValue:@"default"];
    _modelExtension = [NSBundle.mainBundle glb_objectForInfoDictionaryKey:GLBManagedManagerModelExtensionKey defaultValue:@"db"];
}

- (void)dealloc {
}

#pragma mark - Property

- (NSManagedObjectContext*)storeContext {
    if((_storeContext == nil) && (self.coordinator != nil)) {
        [self.class _perform:^{
            _storeContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
            _storeContext.persistentStoreCoordinator = self.coordinator;
            _storeContext.mergePolicy = NSErrorMergePolicy;
        }];
    }
    return _storeContext;
}

- (NSManagedObjectContext*)mainContext {
    if((_mainContext == nil) && (self.storeContext != nil)) {
        [self.class _perform:^{
            _mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
            _mainContext.parentContext = self.storeContext;
            _mainContext.mergePolicy = _mainContext.parentContext.mergePolicy;
            [NSNotificationCenter.defaultCenter addObserver:self
                                                   selector:@selector(_notificationDidSaveMainContext:)
                                                       name:NSManagedObjectContextDidSaveNotification
                                                     object:_mainContext];
        }];
    }
    return _mainContext;
}

- (NSManagedObjectContext*)backgroundContext {
    if((_backgroundContext == nil) && (self.mainContext != nil)) {
        [self.class _perform:^{
            _backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
            _backgroundContext.parentContext = self.mainContext;
            _backgroundContext.mergePolicy = _backgroundContext.parentContext.mergePolicy;
            [NSNotificationCenter.defaultCenter addObserver:self
                                                   selector:@selector(_notificationDidSaveBackgroundContext:)
                                                       name:NSManagedObjectContextDidSaveNotification
                                                     object:_backgroundContext];
        }];
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
    if(_model == nil) {
        [self.class _perform:^{
            NSURL* url = [NSBundle.mainBundle URLForResource:_modelName withExtension:@"momd"];
            if(url != nil) {
                _model = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
            }
        }];
    }
    return _model;
}

- (NSPersistentStoreCoordinator*)coordinator {
    if((_coordinator == nil) && (self.model != nil)) {
        [self.class _perform:^{
            NSMutableDictionary* options = [NSMutableDictionary dictionary];
            options[NSMigratePersistentStoresAutomaticallyOption] = @YES;
            options[NSInferMappingModelAutomaticallyOption] = @YES;
            options[NSSQLitePragmasOption] = @{ @"journal_mode" : @"WAL" };
            NSError* error = nil;
            NSURL* srcStoreUrl = self.existStoreUrl;
            NSURL* dstStoreUrl = self.storeUrl;
            NSPersistentStoreCoordinator* coordinator = nil;
            NSPersistentStore* store = nil;
            if((srcStoreUrl != nil) || (dstStoreUrl != nil)) {
                if(_allowsCreateStoreDatabase == YES) {
                    if((srcStoreUrl != nil) && (dstStoreUrl != nil)) {
                        if([srcStoreUrl isEqual:dstStoreUrl] == NO) {
                            if([NSFileManager.defaultManager fileExistsAtPath:srcStoreUrl.path] == YES) {
                                if([NSFileManager.defaultManager fileExistsAtPath:dstStoreUrl.path] == YES) {
                                    if([NSFileManager.defaultManager removeItemAtURL:dstStoreUrl error:&error] == NO) {
                                        dstStoreUrl = nil;
                                    } else {
                                        NSLog(@"%@: Cant remove destination database: %@", self.glb_className, error);
                                    }
                                }
                            } else {
                                dstStoreUrl = nil;
                            }
                        } else {
                            dstStoreUrl = nil;
                        }
                    } else if((srcStoreUrl == nil) && (dstStoreUrl != nil)) {
                        srcStoreUrl = dstStoreUrl;
                        dstStoreUrl = nil;
                    }
                    if([self _migrateURL:srcStoreUrl options:options type:NSSQLiteStoreType model:self.model error:&error] == YES) {
                        coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
                        store = [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:srcStoreUrl options:options error:&error];
                        if(store == nil) {
                            options[NSSQLitePragmasOption] = @{ @"journal_mode" : @"DELETE" };
                            store = [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:srcStoreUrl options:options error:&error];
                            if(store != nil) {
                                [coordinator removePersistentStore:store error:NULL];
                                options[NSSQLitePragmasOption] = @{ @"journal_mode" : @"WAL" };
                                store = [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:srcStoreUrl options:options error:&error];
                                if(store == nil) {
                                    NSLog(@"%@: Unresolved error: %@", self.glb_className, error);
                                }
                            } else {
                                NSLog(@"%@: Unresolved error: %@", self.glb_className, error);
                            }
                            dstStoreUrl = nil;
                        }
                        if(dstStoreUrl != nil) {
                            store = [coordinator migratePersistentStore:store toURL:dstStoreUrl options:options withType:NSSQLiteStoreType error:&error];
                            if(store != nil) {
                                if([NSFileManager.defaultManager removeItemAtURL:srcStoreUrl error:&error] == NO) {
                                    NSLog(@"%@: Cant remove source database: %@", self.glb_className, error);
                                }
                            } else {
                                NSLog(@"%@: Unresolved error: %@", self.glb_className, error);
                            }
                            self.existStoreUrl = dstStoreUrl;
                        } else {
                            self.existStoreUrl = srcStoreUrl;
                        }
                    } else {
                        NSLog(@"%@: Unresolved error: %@", self.glb_className, error);
                    }
                } else {
                    NSURL* storeUrl = (dstStoreUrl != nil) ? dstStoreUrl : srcStoreUrl;
                    if([NSFileManager.defaultManager fileExistsAtPath:storeUrl.path] == YES) {
                        if([self _migrateURL:storeUrl options:options type:NSSQLiteStoreType model:self.model error:&error] == YES) {
                            coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
                            store = [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error];
                            if(store == nil) {
                                options[NSSQLitePragmasOption] = @{ @"journal_mode" : @"DELETE" };
                                store = [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error];
                                if(store != nil) {
                                    [coordinator removePersistentStore:store error:NULL];
                                    options[NSSQLitePragmasOption] = @{ @"journal_mode" : @"WAL" };
                                    store = [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error];
                                    if(store == nil) {
                                        NSLog(@"%@: Unresolved error: %@", self.glb_className, error);
                                    }
                                } else {
                                    NSLog(@"%@: Unresolved error: %@", self.glb_className, error);
                                }
                                dstStoreUrl = nil;
                            }
                        } else {
                            NSLog(@"%@: Unresolved error: %@", self.glb_className, error);
                        }
                    }
                }
            } else {
                NSLog(@"%@: Invalid store url", self.glb_className);
            }
            if(store != nil) {
                _coordinator = coordinator;
            } else {
                if([_delegate respondsToSelector:@selector(failedInitializeStoreInManagedManager:)] == YES) {
                    [_delegate failedInitializeStoreInManagedManager:self];
                }
            }
        }];
    }
    return _coordinator;
}

- (void)setModelAppGroupName:(NSString*)modelAppGroupName {
    if(_modelAppGroupName != modelAppGroupName) {
        [self.class _perform:^{
            _modelAppGroupName = modelAppGroupName;
            if(_modelAppGroupName.length > 0) {
                _containerUrl = [NSFileManager.defaultManager containerURLForSecurityApplicationGroupIdentifier:_modelAppGroupName];
            } else {
                _containerUrl = nil;
            }
        }];
    }
}

- (void)setExistStoreUrl:(NSURL*)existStoreUrl {
    if([_existStoreUrl isEqual:existStoreUrl] == NO) {
        [self.class _perform:^{
            _existStoreUrl = existStoreUrl;
            [NSUserDefaults.standardUserDefaults setURL:_existStoreUrl forKey:GLBManagedManagerExistStoreUrlKey];
            [NSUserDefaults.standardUserDefaults synchronize];
        }];
    }
}

- (NSURL*)existStoreUrl {
    if(_existStoreUrl == nil) {
        [self.class _perform:^{
            _existStoreUrl = [NSUserDefaults.standardUserDefaults URLForKey:GLBManagedManagerExistStoreUrlKey];
            if([_delegate respondsToSelector:@selector(existStoreUrlInManagedManager:)] == YES) {
                _existStoreUrl = [_delegate existStoreUrlInManagedManager:self];
            }
        }];
    }
    return _existStoreUrl;
}

- (NSURL*)storeUrl {
    if(_storeUrl == nil) {
        [self.class _perform:^{
            if(_containerUrl != nil) {
                _storeUrl = [NSURL fileURLWithPath:[_containerUrl.path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", _modelName, _modelExtension]]];
            }
            if((_storeUrl == nil) && (_modelLocalPath.length > 0)) {
                _storeUrl = [NSURL fileURLWithPath:[_modelLocalPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", _modelName, _modelExtension]]];
            }
        }];
    }
    return _storeUrl;
}

#pragma mark - Public

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

- (NSManagedObject*)objectWithID:(NSManagedObjectID*)objectID {
    return [self.currentContext objectWithID:objectID];
}

#pragma mark - Private

+ (void)_perform:(dispatch_block_t)block {
    if(NSThread.isMainThread == YES) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

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
        [context processPendingChanges];
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

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBManagedMap

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

+ (NSArray*)arrayMap:(NSMutableDictionary*)cache class:(Class)class selector:(SEL)selector {
    NSString* className = NSStringFromClass(class);
    NSMutableArray* map = cache[className];
    if(map == nil) {
        map = NSMutableArray.array;
        while(class != nil) {
            if([class respondsToSelector:selector] == YES) {
                NSArray* mapPart = [class performSelector:selector];
                if([mapPart isKindOfClass:NSArray.class] == YES) {
                    [map addObjectsFromArray:mapPart];
                }
            }
            class = [class superclass];
        }
        cache[className] = map;
    }
    return map;
}

+ (NSDictionary*)dictionaryMap:(NSMutableDictionary*)cache class:(Class)class selector:(SEL)selector {
    NSString* className = NSStringFromClass(class);
    NSMutableDictionary* map = cache[className];
    if(map == nil) {
        map = NSMutableDictionary.dictionary;
        while(class != nil) {
            if([class respondsToSelector:selector] == YES) {
                NSDictionary* mapPart = [class performSelector:selector];
                if([mapPart isKindOfClass:NSDictionary.class] == YES) {
                    [map addEntriesFromDictionary:mapPart];
                }
            }
            class = [class superclass];
        }
        cache[className] = map;
    }
    return map;
}

#pragma clang diagnostic pop

@end

/*--------------------------------------------------*/

NSString* GLBManagedManagerErrorDomain = @"GLBManagedManagerErrorDomain";

/*--------------------------------------------------*/

NSString* GLBManagedManagerExistStoreUrlKey = @"GLBManagedManagerExistStoreUrl";

/*--------------------------------------------------*/
