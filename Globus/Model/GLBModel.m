/*--------------------------------------------------*/

#import "GLBModel+Private.h"

/*--------------------------------------------------*/

#import "NSString+GLBNS.h"
#import "NSArray+GLBNS.h"
#import "NSDictionary+GLBNS.h"
#import "NSFileManager+GLBNS.h"
#import "NSBundle+GLBNS.h"

/*--------------------------------------------------*/

#include <objc/runtime.h>

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

#define GLB_MODEL_EXTENSION                         @"model"

/*--------------------------------------------------*/

@implementation GLBModel

#pragma mark - Synthesize

@synthesize jsonMap = _jsonMap;
@synthesize packMap = _packMap;
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
        result.storeName = _storeName;
        result.userDefaults = _userDefaults;
        result.appGroupIdentifier = _appGroupIdentifier;
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
    if(_jsonMap == nil) {
        _jsonMap = [self.class _buildJsonMap];
    }
    return _jsonMap;
}

- (NSDictionary< NSString*, GLBModelPack* >*)packMap {
    if(_packMap == nil) {
        _packMap = [self.class _buildPackMap];
    }
    return _packMap;
}

- (NSArray< NSString* >*)propertyMap {
    if(_propertyMap == nil) {
        _propertyMap = [self.class _buildPropertyMap];
    }
    return _propertyMap;
}

- (NSArray< NSString* >*)compareMap {
    if(_compareMap == nil) {
        _compareMap = [self.class _buildCompareMap];
    }
    return _compareMap;
}

- (NSArray< NSString* >*)serializeMap {
    if(_serializeMap == nil) {
        _serializeMap = [self.class _buildSerializeMap];
    }
    return _serializeMap;
}

- (NSArray< NSString* >*)copyMap {
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
                result = [_userDefaults synchronize];
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
        NSLog(@"GLBModel::loadItem:%@ Exception = %@", _storeName, exception);
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
        [_userDefaults synchronize];
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

+ (NSDictionary< NSString*, GLBModelPack* >*)_buildPackMap {
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

+ (NSArray< NSString* >*)_buildCompareMap {
    static NSMutableDictionary* cache = nil;
    if(cache == nil) {
        cache = NSMutableDictionary.dictionary;
    }
    return [GLBModelHelper arrayMap:cache class:self.class selector:@selector(compareMap)];
}

+ (NSArray< NSString* >*)_buildSerializeMap {
    static NSMutableDictionary* cache = nil;
    if(cache == nil) {
        cache = NSMutableDictionary.dictionary;
    }
    return [GLBModelHelper arrayMap:cache class:self.class selector:@selector(serializeMap)];
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

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string indent:(NSUInteger)indent root:(BOOL)root {
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
    NSArray< NSString* >* propertyMap = self.propertyMap;
    if(propertyMap.count > 0) {
        NSUInteger propertyIndent = baseIndent + 1;
        [string glb_appendString:@"\t" repeat:baseIndent];
        [string appendString:@"Properties : {\n"];
        for(NSString* property in self.propertyMap) {
            id value = [self valueForKey:property];
            if(value != nil) {
                [string glb_appendString:@"\t" repeat:propertyIndent];
                [string appendFormat:@"%@ : %@\n", property, [value glb_debug]];
            }
        }
        [string glb_appendString:@"\t" repeat:baseIndent];
        [string appendString:@"}\n"];
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

+ (NSArray*)arrayMap:(NSMutableDictionary*)cache class:(Class)class selector:(SEL)selector {
    NSString* className = NSStringFromClass(class);
    NSMutableArray* map = cache[className];
    if(map == nil) {
        Class superClass = [class superclass];
        NSArray* superMap = nil;
        if(superClass != nil) {
            superMap = [self arrayMap:cache class:superClass selector:selector];
        }
        map = [NSMutableArray arrayWithArray:superMap];
        if([class respondsToSelector:selector] == YES) {
            NSArray* mapPart = [class performSelector:selector];
            if([mapPart isKindOfClass:NSArray.class] == YES) {
                [map addObjectsFromArray:mapPart];
            }
        }
        cache[className] = map;
    }
    return map;
}

+ (NSDictionary*)dictionaryMap:(NSMutableDictionary*)cache class:(Class)class selector:(SEL)selector {
    NSString* className = NSStringFromClass(class);
    NSMutableDictionary* map = cache[className];
    if(map == nil) {
        Class superClass = [class superclass];
        NSDictionary* superMap = nil;
        if(superClass != nil) {
            superMap = [self dictionaryMap:cache class:superClass selector:selector];
        }
        map = [NSMutableDictionary dictionaryWithDictionary:superMap];
        if([class respondsToSelector:selector] == YES) {
            NSDictionary* mapPart = [class performSelector:selector];
            if([mapPart isKindOfClass:NSDictionary.class] == YES) {
                [map addEntriesFromDictionary:mapPart];
            }
        }
        cache[className] = map;
    }
    return map;
}

#pragma clang diagnostic pop

@end

/*--------------------------------------------------*/
