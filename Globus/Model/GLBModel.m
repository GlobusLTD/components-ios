/*--------------------------------------------------*/

#import "GLBModel+Private.h"

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

#define GLB_MODEL_EXTENSION                         @"model"

/*--------------------------------------------------*/

@implementation GLBModel

#pragma mark - Synthesize

@synthesize jsonMap = _jsonMap;
@synthesize jsonShemeMap = _jsonShemeMap;
@synthesize packMap = _packMap;
@synthesize defaultsMap = _defaultsMap;
@synthesize propertyMap = _propertyMap;
@synthesize compareMap = _compareMap;
@synthesize serializeMap = _serializeMap;
@synthesize copyMap = _copyMap;

#pragma mark - Init / Free

+ (instancetype)modelWithStoreName:(NSString*)storeName userDefaults:(NSUserDefaults*)userDefaults {
    if(userDefaults == nil) {
        userDefaults = NSUserDefaults.standardUserDefaults;
    }
    if([userDefaults objectForKey:storeName] != nil) {
        return [[self alloc] initWithStoreName:storeName userDefaults:userDefaults];
    }
    return nil;
}

+ (instancetype)modelWithStoreName:(NSString*)storeName appGroupIdentifier:(NSString*)appGroupIdentifier {
    NSString* filePath = [self.class _filePathWithStoreName:storeName appGroupIdentifier:appGroupIdentifier];
    if([NSFileManager.defaultManager fileExistsAtPath:filePath] == YES) {
        return [[self alloc] initWithStoreName:storeName appGroupIdentifier:appGroupIdentifier];
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
        NSDictionary< NSString*, id >* defaultsMap = self.defaultsMap;
        NSDictionary< NSString*, id >* serializeMap = self.serializeMap;
        [serializeMap enumerateKeysAndObjectsUsingBlock:^(NSString* propertyName, id field, BOOL* stop) {
            id value = [coder decodeObjectForKey:propertyName];
            if(value == nil) {
                if([field isKindOfClass:NSArray.class] == YES) {
                    for(NSString* subField in field) {
                        value = [coder decodeObjectForKey:subField];
                        if(value != nil) {
                            break;
                        }
                    }
                } else {
                    value = [coder decodeObjectForKey:field];
                }
            }
            if(value == nil) {
                value = defaultsMap[propertyName];
            }
            if(value != nil) {
                @try {
                    [self setValue:value forKey:propertyName];
                }
                @catch(NSException* exception) {
                    NSLog(@"GLBModel::initWithCoder:%@ Field=%@ Exception = %@", _storeName, field, exception);
                }
            }
        }];
        [self setup];
    }
    return self;
}

- (instancetype)initWithStoreName:(NSString*)storeName userDefaults:(NSUserDefaults*)userDefaults {
    self = [super init];
    if(self != nil) {
        _storeName = storeName;
        _userDefaults = userDefaults;
        [self load];
        [self setup];
    }
    return self;
}

- (instancetype)initWithStoreName:(NSString*)storeName appGroupIdentifier:(NSString*)appGroupIdentifier {
    self = [super init];
    if(self != nil) {
        _storeName = storeName;
        _appGroupIdentifier = appGroupIdentifier;
        [self load];
        [self setup];
    }
    return self;
}

- (void)setup {
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
            map = self.serializeMap.allKeys;
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
    NSDictionary< NSString*, id >* serializeMap = self.serializeMap;
    [serializeMap enumerateKeysAndObjectsUsingBlock:^(NSString* propertyName, id field, BOOL* stop) {
        id value = [self valueForKey:propertyName];
        if(value == nil) {
            if([field isKindOfClass:NSArray.class] == YES) {
                for(NSString* subField in field) {
                    value = [self valueForKey:subField];
                    if(value != nil) {
                        break;
                    }
                }
            } else {
                value = [self valueForKey:field];
            }
        }
        if(value != nil) {
            [coder encodeObject:value forKey:propertyName];
        }
    }];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone*)zone {
    GLBModel* result = [[self.class allocWithZone:zone] init];
    if(result != nil) {
        result.storeName = _storeName;
        result.userDefaults = _userDefaults;
        result.appGroupIdentifier = _appGroupIdentifier;
        NSArray* map = self.copyMap;
        if(map.count < 1) {
            map = self.serializeMap.allKeys;
        }
        for(NSString* field in map) {
            id value = [self valueForKey:field];
            if([value isKindOfClass:NSArray.class] == YES) {
                NSMutableArray* array = [NSMutableArray arrayWithCapacity:[((NSArray*)(value)) count]];
                for(id item in value) {
                    id itemCopy = [item copyWithZone:zone];
                    if(itemCopy != nil) {
                        [array addObject:itemCopy];
                    }
                }
                if(value != nil) {
                    @try {
                        [result setValue:array forKey:field];
                    }
                    @catch(NSException* exception) {
                        NSLog(@"GLBModel::copyWithZone:%@ Field=%@ Exception = %@", _storeName, field, exception);
                    }
                }
            } else if([value isKindOfClass:NSDictionary.class] == YES) {
                NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:[((NSDictionary*)(value)) count]];
                [value enumerateKeysAndObjectsUsingBlock:^(id key, id item, BOOL* stop) {
                    id itemCopy = [item copyWithZone:zone];
                    if(itemCopy != nil) {
                        dict[key] = itemCopy;
                    }
                }];
                if(value != nil) {
                    @try {
                        [result setValue:dict forKey:field];
                    }
                    @catch(NSException* exception) {
                        NSLog(@"GLBModel::copyWithZone:%@ Field=%@ Exception = %@", _storeName, field, exception);
                    }
                }
            } else {
                value = [value copyWithZone:zone];
                if(value != nil) {
                    @try {
                        [result setValue:value forKey:field];
                    }
                    @catch(NSException* exception) {
                        NSLog(@"GLBModel::copyWithZone:%@ Field=%@ Exception = %@", _storeName, field, exception);
                    }
                }
            }
        }
    }
    return result;
}

#pragma mark - Property

- (void)setUserDefaults:(NSUserDefaults*)userDefaults {
    if(_userDefaults != userDefaults) {
        _userDefaults = userDefaults;
        if(_userDefaults != nil) {
            _appGroupIdentifier = nil;
        }
    }
}

- (void)setAppGroupIdentifier:(NSString*)appGroupIdentifier {
    if(_appGroupIdentifier != appGroupIdentifier) {
        _appGroupIdentifier = appGroupIdentifier;
        if(_appGroupIdentifier != nil) {
            _userDefaults = nil;
        }
    }
}

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

- (NSDictionary< NSString*, id >*)defaultsMap {
    @synchronized(self) {
        if(_defaultsMap == nil) {
            _defaultsMap = [self.class _buildDefaultsMap];
        }
    }
    return _defaultsMap;
}

- (NSDictionary< NSString*, id >*)serializeMap {
    @synchronized(self) {
        if(_serializeMap == nil) {
            _serializeMap = [self.class _buildSerializeMap];
        }
    }
    return _serializeMap;
}

- (NSArray< NSString* >*)propertyMap {
    @synchronized(self) {
        if(_propertyMap == nil) {
            _propertyMap = [self.class _buildPropertyMap];
        }
    }
    return _propertyMap;
}

- (NSArray< NSString* >*)compareMap {
    @synchronized(self) {
        if(_compareMap == nil) {
            _compareMap = [self.class _buildCompareMap];
        }
    }
    return _compareMap;
}

- (NSArray< NSString* >*)copyMap {
    @synchronized(self) {
        if(_copyMap == nil) {
            _copyMap = [self.class _buildCopyMap];
        }
    }
    return _copyMap;
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
    self = [super init];
    if(self != nil) {
        [self fromJson:json];
        [self setup];
    }
    return self;
}

- (instancetype)initWithJson:(id)json sheme:(NSString*)sheme {
    self = [super init];
    if(self != nil) {
        [self fromJson:json sheme:sheme];
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

- (NSDictionary< NSString*, id >*)pack {
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
    NSDictionary* pack = [self pack];
    if(pack != nil) {
        return [NSObject glb_packObject:pack];
    }
    return nil;
}

- (void)unpack:(NSDictionary< NSString*, id >*)data {
    NSMutableSet* fields = [NSMutableSet set];
    NSDictionary< NSString*, id >* defaultsMap = self.defaultsMap;
    if(defaultsMap.count > 0) {
        [fields addObjectsFromArray:defaultsMap.allKeys];
    }
    NSDictionary< NSString*, GLBModelPack* >* packMap = self.packMap;
    if(packMap.count > 0) {
        [fields addObjectsFromArray:packMap.allKeys];
    }
    for(NSString* field in fields) {
        id packValue = data[field];
        if(packValue != nil) {
            id value = nil;
            GLBModelPack* converter = packMap[field];
            if(converter != nil) {
                value = [converter unpack:packValue];
            }
            if(value == nil) {
                value = defaultsMap[field];
            }
            if(value != nil) {
                @try {
                    [self setValue:value forKey:field];
                }
                @catch(NSException* exception) {
                    NSLog(@"GLBModel::unpack:%@ Field=%@ Exception = %@", _storeName, field, exception);
                }
            }
        }
    }
}

- (void)unpackData:(NSData*)data {
    id object = [NSObject glb_unpackFromData:data];
    if([object isKindOfClass:NSDictionary.class] == YES) {
        [self unpack:object];
    }
}

#pragma mark - Public

+ (NSDictionary< NSString*, id >*)defaultsMap {
    return nil;
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

+ (NSArray< NSString* >*)compareMap {
    return nil;
}

+ (NSArray< NSString* >*)serializeMap {
    return nil;
}

+ (NSArray< NSString* >*)copyMap {
    return nil;
}

- (void)clear {
    NSDictionary< NSString*, id >* defaultsMap = self.defaultsMap;
    NSDictionary< NSString*, id >* serializeMap = self.serializeMap;
    for(NSString* field in serializeMap.allKeys) {
        id value = defaultsMap[field];
        if(value != nil) {
            @try {
                [self setValue:value forKey:field];
            }
            @catch(NSException* exception) {
                NSLog(@"GLBModel::clear:%@ Field=%@ Exception = %@", _storeName, field, exception);
            }
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
    BOOL result = NO;
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
                    NSLog(@"GLBModel::save:%@ Field=%@ Exception = %@", _storeName, field, exception);
                }
            }
            if(_userDefaults != nil) {
                [_userDefaults setObject:dict forKey:_storeName];
#if defined(GLB_TARGET_IOS)
                if([UIDevice glb_compareSystemVersion:@"10.0"] == NSOrderedAscending) {
                    result = [_userDefaults synchronize];
                } else {
                    result = YES;
                }
#else
                result = [_userDefaults synchronize];
#endif
            } else {
                NSString* filePath = [self _filePath];
                if(filePath != nil) {
                    result = [NSKeyedArchiver archiveRootObject:dict toFile:self._filePath];
                }
            }
        }
    }
    @catch(NSException* exception) {
        NSLog(@"GLBModel::save:%@ Exception = %@", _storeName, exception);
    }
    return result;
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
        if(_userDefaults != nil) {
            dict = [_userDefaults objectForKey:_storeName];
        } else {
            NSString* filePath = [self _filePath];
            if(filePath != nil) {
                dict = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
            }
        }
        if(dict != nil) {
            NSDictionary< NSString*, id >* defaultsMap = self.defaultsMap;
            NSDictionary< NSString*, id >* serializeMap = self.serializeMap;
            [serializeMap enumerateKeysAndObjectsUsingBlock:^(NSString* propertyName, id field, BOOL* stop) {
                id value = dict[propertyName];
                if(value == nil) {
                    if([field isKindOfClass:NSArray.class] == YES) {
                        for(NSString* subField in field) {
                            value = dict[subField];
                            if(value != nil) {
                                break;
                            }
                        }
                    } else {
                        value = dict[field];
                    }
                }
                if(value == nil) {
                    value = defaultsMap[propertyName];
                } else if([value isKindOfClass:NSData.class] == YES) {
                    @try {
                        value = [NSKeyedUnarchiver unarchiveObjectWithData:value];
                    }
                    @catch(NSException* exception) {
                        value = nil;
                    }
                }
                if(value != nil) {
                    @try {
                        [self setValue:value forKey:propertyName];
                    }
                    @catch(NSException* exception) {
                        NSLog(@"GLBModel::load:%@ Field=%@ Exception = %@", _storeName, field, exception);
                    }
                }
            }];
        }
    }
    @catch(NSException* exception) {
        NSLog(@"GLBModel::load:%@ Exception = %@", _storeName, exception);
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
    if(_userDefaults != nil) {
        [_userDefaults removeObjectForKey:_storeName];
#if defined(GLB_TARGET_IOS)
        if([UIDevice glb_compareSystemVersion:@"10.0"] == NSOrderedAscending) {
            [_userDefaults synchronize];
        }
#else
        [_userDefaults synchronize];
#endif
    } else {
        NSString* filePath = [self _filePath];
        if(filePath != nil) {
            [NSFileManager.defaultManager removeItemAtPath:filePath error:nil];
        }
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

+ (NSString*)_filePathWithStoreName:(NSString*)storeName appGroupIdentifier:(NSString*)appGroupIdentifier {
    NSString* file = [NSString stringWithFormat:@"%@.%@", storeName, GLB_MODEL_EXTENSION];
    NSString* filePath = nil;
    if(appGroupIdentifier != nil) {
        NSURL* containerUrl = [NSFileManager.defaultManager containerURLForSecurityApplicationGroupIdentifier:appGroupIdentifier];
        if(containerUrl != nil) {
            filePath = [containerUrl.path stringByAppendingPathComponent:file];
        }
    } else {
        filePath = [NSFileManager.glb_cachesDirectory stringByAppendingPathComponent:file];
    }
    return filePath;
}

+ (NSDictionary< NSString*, GLBModelJson* >*)_buildJsonMap {
    static NSMutableDictionary* cache = nil;
    if(cache == nil) {
        cache = NSMutableDictionary.dictionary;
    }
    return [GLBModelHelper dictionaryMap:cache class:self.class selector:@selector(jsonMap)];
}

+ (NSDictionary< NSString*, NSDictionary< NSString*, GLBModelJson* >* >*)_buildJsonShemeMap {
    static NSMutableDictionary* cache = nil;
    if(cache == nil) {
        cache = NSMutableDictionary.dictionary;
    }
    return [GLBModelHelper multiDictionaryMap:cache class:self.class selector:@selector(jsonShemeMap)];
}

+ (NSDictionary< NSString*, GLBModelPack* >*)_buildPackMap {
    static NSMutableDictionary* cache = nil;
    if(cache == nil) {
        cache = NSMutableDictionary.dictionary;
    }
    return [GLBModelHelper dictionaryMap:cache class:self.class selector:@selector(packMap)];
}

+ (NSDictionary< NSString*, id >*)_buildDefaultsMap {
    static NSMutableDictionary* cache = nil;
    if(cache == nil) {
        cache = NSMutableDictionary.dictionary;
    }
    return [GLBModelHelper dictionaryMap:cache class:self.class selector:@selector(defaultsMap)];
}

+ (NSDictionary< NSString*, id >*)_buildSerializeMap {
    static NSMutableDictionary* cache = nil;
    if(cache == nil) {
        cache = NSMutableDictionary.dictionary;
    }
    return [GLBModelHelper dictionaryMap:cache class:self.class selector:@selector(serializeMap) convert:^id(id value) {
        if([value isKindOfClass:NSArray.class] == YES) {
            NSArray* sourceArray = value;
            NSMutableDictionary* result = [NSMutableDictionary dictionaryWithCapacity:sourceArray.count];
            for(id sourceItem in sourceArray) {
                result[sourceItem] = sourceItem;
            }
            return result.copy;
        }
        return nil;
    }];
}

+ (NSArray< NSString* >* _Nonnull)_buildPropertyMap {
    static NSMutableDictionary* cache = nil;
    if(cache == nil) {
        cache = NSMutableDictionary.dictionary;
    }
    return [GLBModelHelper arrayMap:cache class:self.class selector:@selector(propertyMap)];
}

+ (NSArray< NSString* >*)_buildCompareMap {
    static NSMutableDictionary* cache = nil;
    if(cache == nil) {
        cache = NSMutableDictionary.dictionary;
    }
    return [GLBModelHelper arrayMap:cache class:self.class selector:@selector(compareMap)];
}

+ (NSArray< NSString* >*)_buildCopyMap {
    static NSMutableDictionary* cache = nil;
    if(cache == nil) {
        cache = NSMutableDictionary.dictionary;
    }
    return [GLBModelHelper arrayMap:cache class:self.class selector:@selector(copyMap)];
}

- (NSString*)_filePath {
    return [self.class _filePathWithStoreName:_storeName appGroupIdentifier:_appGroupIdentifier];
}

- (void)_fromJson:(id)json sheme:(NSString*)sheme jsonMap:(NSDictionary< NSString*, GLBModelJson* >*)jsonMap {
    NSMutableSet* fields = [NSMutableSet set];
    NSDictionary< NSString*, id >* defaultsMap = self.defaultsMap;
    if(defaultsMap.count > 0) {
        [fields addObjectsFromArray:defaultsMap.allKeys];
    }
    if(jsonMap.count > 0) {
        [fields addObjectsFromArray:jsonMap.allKeys];
    }
    for(NSString* field in fields) {
        id value = nil;
        GLBModelJson* converter = jsonMap[field];
        if(converter != nil) {
            for(NSString* path in converter.subPaths) {
                value = [json valueForKeyPath:path];
                if(value != nil) {
                    break;
                }
            }
            value = [converter fromJson:value sheme:sheme];
        }
        if(value == nil) {
            value = defaultsMap[field];
        }
        if(value != nil) {
            @try {
                [self setValue:value forKey:field];
            }
            @catch(NSException* exception) {
                NSLog(@"GLBModel::fromJson:%@ Field=%@ Exception = %@", _storeName, field, exception);
            }
        }
    }
}

- (NSDictionary*)_toJson:(NSString*)sheme jsonMap:(NSDictionary< NSString*, GLBModelJson* >*)jsonMap {
    NSMutableDictionary* result = [NSMutableDictionary dictionary];
    [jsonMap enumerateKeysAndObjectsUsingBlock:^(NSString* field, GLBModelJson* converter, BOOL* stop __unused) {
        if(converter.subPaths.count > 0) {
            id value = [self valueForKey:field];
            if(value != nil) {
                id jsonValue = [converter toJson:value sheme:sheme];
                if(jsonValue != nil) {
                    __block NSMutableDictionary* dict = result;
                    NSString* subPath = converter.subPaths.firstObject;
                    NSArray* subPathParts = converter.subPathParts.firstObject;
                    if(subPathParts.count > 1) {
                        subPath = subPathParts.lastObject;
                        [subPathParts glb_each:^(NSString* key) {
                            NSMutableDictionary* subDict = dict[key];
                            if(subDict == nil) {
                                subDict = [NSMutableDictionary dictionary];
                                dict[key] = subDict;
                            }
                            dict = subDict;
                        } range:NSMakeRange(0, subPathParts.count - 1)];
                    }
                    [dict setValue:jsonValue forKeyPath:subPath];
                }
            }
        }
    }];
    return result.copy;
}

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    NSUInteger baseIndent = indent + 1;
    [string appendFormat:@"<%@\n", self.glb_className];
    if(_storeName != nil) {
        [string glb_appendString:@"\t" repeat:baseIndent];
        [string appendFormat:@"StoreName : %@\n", _storeName];
    }
    if(_userDefaults != nil) {
        if(_userDefaults == NSUserDefaults.standardUserDefaults) {
            [string glb_appendString:@"\t" repeat:baseIndent];
            [string appendString:@"UserDefault : Default\n"];
        } else {
            [string glb_appendString:@"\t" repeat:baseIndent];
            [string appendString:@"UserDefault : Custom\n"];
        }
    }
    if(_appGroupIdentifier != nil) {
        [string glb_appendString:@"\t" repeat:baseIndent];
        [string appendFormat:@"AppGroupIdentifier : %@\n", _appGroupIdentifier];
    }
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
    }
    [string glb_appendString:@"\t" repeat:indent];
    [string appendString:@">"];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelHelper

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

+ (NSDictionary< id, NSDictionary* >*)multiDictionaryMap:(NSMutableDictionary*)cache class:(Class)class selector:(SEL)selector {
    return [self multiDictionaryMap:cache class:class selector:selector convert:nil];
}

+ (NSDictionary< id, NSDictionary* >*)multiDictionaryMap:(NSMutableDictionary*)cache class:(Class)class selector:(SEL)selector convert:(GLBModelHelperConvertBlock)convert {
    NSString* className = NSStringFromClass(class);
    NSDictionary* classMap = cache[className];
    if(classMap != nil) {
        return classMap;
    }
    if([class conformsToProtocol:@protocol(GLBModel)] != YES) {
        return @{};
    }
    NSDictionary* map = nil;
    NSDictionary< id, NSDictionary* >* superMap = nil;
    Class superClass = [class superclass];
    if(superClass != nil) {
        superMap = [self dictionaryMap:cache class:superClass selector:selector convert:convert];
    }
    NSDictionary< id, NSDictionary* >* partMap = [class performSelector:selector];
    if([partMap isKindOfClass:NSDictionary.class] == NO) {
        if(convert != nil) {
            partMap = convert(partMap);
        }
    }
    if(partMap != nil) {
        NSMutableDictionary* mutMap = [NSMutableDictionary dictionary];
        NSArray* shemes = [NSArray glb_arrayWithArray:superMap.allKeys addingObjectsFromArray:partMap.allKeys];
        for(id sheme in shemes) {
            NSDictionary* superShemeMap = superMap[sheme];
            NSDictionary* partShemeMap = partMap[sheme];
            NSMutableDictionary* shemeMap = [NSMutableDictionary dictionaryWithCapacity:superShemeMap.count + partShemeMap.count];
            if(superShemeMap != nil) {
                [shemeMap addEntriesFromDictionary:superShemeMap];
            }
            if(partShemeMap != nil) {
                [shemeMap addEntriesFromDictionary:partShemeMap];
            }
            mutMap[sheme] = shemeMap;
        }
        map = mutMap.copy;
    } else {
        map = superMap;
    }
    if(map == nil) {
        map = @{};
    }
    cache[className] = map;
    return map;
}

+ (NSDictionary*)dictionaryMap:(NSMutableDictionary*)cache class:(Class)class selector:(SEL)selector {
    return [self dictionaryMap:cache class:class selector:selector convert:nil];
}

+ (NSDictionary*)dictionaryMap:(NSMutableDictionary*)cache class:(Class)class selector:(SEL)selector convert:(GLBModelHelperConvertBlock)convert {
    NSString* className = NSStringFromClass(class);
    NSDictionary* classMap = cache[className];
    if(classMap != nil) {
        return classMap;
    }
    if([class conformsToProtocol:@protocol(GLBModel)] != YES) {
        return @{};
    }
    NSMutableDictionary* mutMap = [NSMutableDictionary dictionary];
    Class superClass = [class superclass];
    if(superClass != nil) {
        NSDictionary* superMap = [self dictionaryMap:cache class:superClass selector:selector convert:convert];
        if(superMap != nil) {
            [mutMap addEntriesFromDictionary:superMap];
        }
    }
    id partMap = [class performSelector:selector];
    if([partMap isKindOfClass:NSDictionary.class] == NO) {
        if(convert != nil) {
            partMap = convert(partMap);
        }
    }
    if(partMap != nil) {
        [mutMap addEntriesFromDictionary:partMap];
    }
    NSDictionary* map = mutMap.copy;
    cache[className] = map;
    return map;
}

+ (NSArray*)arrayMap:(NSMutableDictionary*)cache class:(Class)class selector:(SEL)selector {
    return [self arrayMap:cache class:class selector:selector convert:nil];
}

+ (NSArray*)arrayMap:(NSMutableDictionary*)cache class:(Class)class selector:(SEL)selector convert:(GLBModelHelperConvertBlock)convert {
    NSString* className = NSStringFromClass(class);
    NSArray* classMap = cache[className];
    if(classMap != nil) {
        return classMap;
    }
    if([class conformsToProtocol:@protocol(GLBModel)] != YES) {
        return @[];
    }
    NSMutableArray* mutMap = [NSMutableArray array];
    Class superClass = [class superclass];
    if(superClass != nil) {
        NSArray* superMap = [self arrayMap:cache class:superClass selector:selector convert:convert];
        if(superMap != nil) {
            [mutMap addObjectsFromArray:superMap];
        }
    }
    id partMap = [class performSelector:selector];
    if([partMap isKindOfClass:NSArray.class] == NO) {
        if(convert != nil) {
            partMap = convert(partMap);
        }
    }
    if(partMap != nil) {
        [mutMap addObjectsFromArray:partMap];
    }
    NSArray* map = mutMap.copy;
    cache[className] = map;
    return map;
}

#pragma clang diagnostic pop

@end

/*--------------------------------------------------*/
