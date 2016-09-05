/*--------------------------------------------------*/

#import "GLBModelJson.h"
#import "GLBModel.h"

/*--------------------------------------------------*/

@interface GLBModelJson () {
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJson

#pragma mark - Init / Free

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithPath:(NSString*)path {
    self = [super init];
    if(self != nil) {
        _path = path;
        _subPaths = [_path componentsSeparatedByString:@"|"];
        
        NSMutableArray* subPathParts = [NSMutableArray arrayWithCapacity:_subPaths.count];
        for(NSString* subPath in _subPaths) {
            [subPathParts addObject:[subPath componentsSeparatedByString:@"."]];
        }
        _subPathParts = subPathParts;
        
        [self setup];
    }
    return self;
}

- (void)setup {
}

#pragma mark - Public

- (id)fromJson:(id)json sheme:(NSString*)sheme {
    return nil;
}

- (id)toJson:(id)json sheme:(NSString*)sheme {
    return nil;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonSet

#pragma mark - Init / Free

- (instancetype)initWithModelClass:(Class)modelClass {
    return [self initWithPath:nil
                jsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:modelClass]];
}

- (instancetype)initWithJsonConverter:(GLBModelJson*)jsonConverter {
    return [self initWithPath:nil
                jsonConverter:jsonConverter];
}

- (instancetype)initWithPath:(NSString*)path modelClass:(Class)modelClass {
    return [self initWithPath:path
                jsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:modelClass]];
}

- (instancetype)initWithPath:(NSString*)path jsonConverter:(GLBModelJson*)jsonConverter {
    self = [super initWithPath:path];
    if(self != nil) {
        _jsonConverter = jsonConverter;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)fromJson:(id)json sheme:(NSString*)sheme {
    if([json isKindOfClass:NSArray.class] == YES) {
        NSMutableSet* result = NSMutableSet.set;
        for(id object in json) {
            id value = [_jsonConverter fromJson:object sheme:sheme];
            if(value != nil) {
                [result addObject:value];
            }
        }
        return result.copy;
    }
    return [super fromJson:json sheme:sheme];
}

- (id)toJson:(id)json sheme:(NSString*)sheme {
    if([json isKindOfClass:NSSet.class] == YES) {
        NSMutableArray* result = NSMutableArray.array;
        for(id object in json) {
            id value = [_jsonConverter toJson:object sheme:sheme];
            if(value != nil) {
                [result addObject:value];
            }
        }
        return result.copy;
    }
    return [super toJson:json sheme:sheme];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonOrderedSet

#pragma mark - Init / Free

- (instancetype)initWithModelClass:(Class)modelClass {
    return [self initWithPath:nil
                jsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:modelClass]];
}

- (instancetype)initWithJsonConverter:(GLBModelJson*)jsonConverter {
    return [self initWithPath:nil
                jsonConverter:jsonConverter];
}

- (instancetype)initWithPath:(NSString*)path modelClass:(Class)modelClass {
    return [self initWithPath:path
                jsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:modelClass]];
}

- (instancetype)initWithPath:(NSString*)path jsonConverter:(GLBModelJson*)jsonConverter {
    self = [super initWithPath:path];
    if(self != nil) {
        _jsonConverter = jsonConverter;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)fromJson:(id)json sheme:(NSString*)sheme {
    if([json isKindOfClass:NSArray.class] == YES) {
        NSMutableOrderedSet* result = NSMutableOrderedSet.orderedSet;
        for(id object in json) {
            id value = [_jsonConverter fromJson:object sheme:sheme];
            if(value != nil) {
                [result addObject:value];
            }
        }
        return result.copy;
    }
    return [super fromJson:json sheme:sheme];
}

- (id)toJson:(id)json sheme:(NSString*)sheme {
    if([json isKindOfClass:NSOrderedSet.class] == YES) {
        NSMutableArray* result = NSMutableArray.array;
        for(id object in json) {
            id value = [_jsonConverter toJson:object sheme:sheme];
            if(value != nil) {
                [result addObject:value];
            }
        }
        return result.copy;
    }
    return [super toJson:json sheme:sheme];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonArray

#pragma mark - Init / Free

- (instancetype)initWithModelClass:(Class)modelClass {
    return [self initWithPath:nil
                jsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:modelClass]];
}

- (instancetype)initWithJsonConverter:(GLBModelJson*)jsonConverter {
    return [self initWithPath:nil
                jsonConverter:jsonConverter];
}

- (instancetype)initWithPath:(NSString*)path modelClass:(Class)modelClass {
    return [self initWithPath:path
                jsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:modelClass]];
}

- (instancetype)initWithPath:(NSString*)path jsonConverter:(GLBModelJson*)jsonConverter {
    self = [super initWithPath:path];
    if(self != nil) {
        _jsonConverter = jsonConverter;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)fromJson:(id)json sheme:(NSString*)sheme {
    if([json isKindOfClass:NSArray.class] == YES) {
        NSMutableArray* result = NSMutableArray.array;
        for(id object in json) {
            id value = [_jsonConverter fromJson:object sheme:sheme];
            if(value != nil) {
                [result addObject:value];
            }
        }
        return result.copy;
    }
    return [super fromJson:json sheme:sheme];
}

- (id)toJson:(id)json sheme:(NSString*)sheme {
    if([json isKindOfClass:NSArray.class] == YES) {
        NSMutableArray* result = NSMutableArray.array;
        for(id object in json) {
            id value = [_jsonConverter toJson:object sheme:sheme];
            if(value != nil) {
                [result addObject:value];
            }
        }
        return result.copy;
    }
    return [super toJson:json sheme:sheme];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonDictionary

#pragma mark - Init / Free

- (instancetype)initWithValueModelClass:(Class)valueModelClass {
    return [self initWithPath:nil
             keyJsonConverter:nil
           valueJsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:valueModelClass]];
}

- (instancetype)initWithValueJsonConverter:(GLBModelJson*)valueJsonConverter {
    return [self initWithPath:nil
             keyJsonConverter:nil
           valueJsonConverter:valueJsonConverter];
}

- (instancetype)initWithKeyModelClass:(Class)keyModelClass valueModelClass:(Class)valueModelClass {
    return [self initWithPath:nil
             keyJsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:keyModelClass]
           valueJsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:valueModelClass]];
}

- (instancetype)initWithKeyJsonConverter:(GLBModelJson*)keyJsonConverter valueJsonConverter:(GLBModelJson*)valueJsonConverter {
    return [self initWithPath:nil
             keyJsonConverter:keyJsonConverter
           valueJsonConverter:valueJsonConverter];
}

- (instancetype)initWithPath:(NSString*)path valueModelClass:(Class)valueModelClass {
    return [self initWithPath:path
             keyJsonConverter:nil
           valueJsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:valueModelClass]];
}

- (instancetype)initWithPath:(NSString*)path valueJsonConverter:(GLBModelJson*)valueJsonConverter {
    return [self initWithPath:path
             keyJsonConverter:nil
           valueJsonConverter:valueJsonConverter];
}

- (instancetype)initWithPath:(NSString*)path keyModelClass:(Class)keyModelClass valueModelClass:(Class)valueModelClass {
    return [self initWithPath:path
             keyJsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:keyModelClass]
           valueJsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:valueModelClass]];
}

- (instancetype)initWithPath:(NSString*)path keyJsonConverter:(GLBModelJson*)keyJsonConverter valueJsonConverter:(GLBModelJson*)valueJsonConverter {
    self = [super initWithPath:path];
    if(self != nil) {
        _keyJsonConverter = keyJsonConverter;
        _valueJsonConverter = valueJsonConverter;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)fromJson:(id)json sheme:(NSString*)sheme {
    if([json isKindOfClass:NSDictionary.class] == YES) {
        NSMutableDictionary* result = NSMutableDictionary.dictionary;
        [json enumerateKeysAndObjectsUsingBlock:^(id rawKey, id rawValue, BOOL* stop __unused) {
            id key = (_keyJsonConverter != nil) ? [_keyJsonConverter fromJson:rawKey sheme:sheme] : rawKey;
            if(key != nil) {
                id value = [_valueJsonConverter fromJson:rawValue sheme:sheme];
                if(value != nil) {
                    result[key] = value;
                }
            }
        }];
        return result.copy;
    }
    return [super fromJson:json sheme:sheme];
}

- (id)toJson:(id)json sheme:(NSString*)sheme {
    if([json isKindOfClass:NSDictionary.class] == YES) {
        NSMutableDictionary* result = NSMutableDictionary.dictionary;
        [json enumerateKeysAndObjectsUsingBlock:^(id rawKey, id rawValue, BOOL* stop __unused) {
            id key = (_keyJsonConverter != nil) ? [_keyJsonConverter toJson:rawKey sheme:sheme] : rawKey;
            if(key != nil) {
                id value = [_valueJsonConverter toJson:rawValue sheme:sheme];
                if(value != nil) {
                    result[key] = value;
                }
            }
        }];
        return result.copy;
    }
    return [super toJson:json sheme:sheme];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonBool

#pragma mark - Init / Free

- (instancetype)initWithPath:(NSString*)path defaultValue:(BOOL)defaultValue {
    self = [super initWithPath:path];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)fromJson:(id)json sheme:(NSString*)sheme {
    id result = nil;
    if([json isKindOfClass:NSString.class] == YES) {
        result = @([json glb_bool]);
    } else if([json isKindOfClass:NSNumber.class] == YES) {
        result = json;
    }
    if(result != nil) {
        return result;
    }
    return @(_defaultValue);
}

- (id)toJson:(id)json sheme:(NSString*)sheme {
    if([json isKindOfClass:NSNumber.class] == YES) {
        return json;
    }
    return [super toJson:json sheme:sheme];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonString

#pragma mark - Init / Free

- (instancetype)initWithPath:(NSString*)path defaultValue:(NSString*)defaultValue {
    self = [super initWithPath:path];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)fromJson:(id)json sheme:(NSString*)sheme {
    id result = nil;
    if([json isKindOfClass:NSString.class] == YES) {
        result = json;
    } else if([json isKindOfClass:NSNumber.class] == YES) {
        result = [json stringValue];
    }
    if(result != nil) {
        return result;
    } else if(_defaultValue != nil) {
        return _defaultValue;
    }
    return [super fromJson:json sheme:sheme];
}

- (id)toJson:(id)json sheme:(NSString*)sheme {
    if([json isKindOfClass:NSString.class] == YES) {
        return json;
    }
    return [super toJson:json sheme:sheme];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonUrl

#pragma mark - Init / Free

- (instancetype)initWithPath:(NSString*)path defaultValue:(NSURL*)defaultValue {
    self = [super initWithPath:path];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)fromJson:(id)json sheme:(NSString*)sheme {
    id result = nil;
    if([json isKindOfClass:NSString.class] == YES) {
        result = [NSURL URLWithString:json];
        if(result == nil) {
            result = [NSURL URLWithString:[json glb_stringByEncodingURLFormat]];
        }
    }
    if(result != nil) {
        return result;
    } else if(_defaultValue != nil) {
        return _defaultValue;
    }
    return [super fromJson:json sheme:sheme];
}

- (id)toJson:(id)json sheme:(NSString*)sheme {
    if([json isKindOfClass:NSURL.class] == YES) {
        return [json absoluteString];
    }
    return [super toJson:json sheme:sheme];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonNumber

#pragma mark - Init / Free

- (instancetype)initWithPath:(NSString*)path defaultValue:(NSNumber*)defaultValue {
    self = [super initWithPath:path];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)fromJson:(id)json sheme:(NSString*)sheme {
    id result = nil;
    if([json isKindOfClass:NSNumber.class] == YES) {
        result = json;
    } else if([json isKindOfClass:NSString.class] == YES) {
        result = [json glb_number];
    }
    if(result != nil) {
        return result;
    } else if(_defaultValue != nil) {
        return _defaultValue;
    }
    return [super fromJson:json sheme:sheme];
}

- (id)toJson:(id)json sheme:(NSString*)sheme {
    if([json isKindOfClass:NSNumber.class] == YES) {
        return json;
    }
    return [super toJson:json sheme:sheme];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonDate

#pragma mark - Init / Free

- (instancetype)initWithPath:(NSString*)path defaultValue:(NSDate*)defaultValue {
    return [self initWithPath:path formats:nil timeZone:nil defaultValue:defaultValue];
}

- (instancetype)initWithPath:(NSString*)path timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue {
    return [self initWithPath:path formats:nil timeZone:timeZone defaultValue:defaultValue];
}

- (instancetype)initWithFormat:(NSString*)format {
    return [self initWithPath:nil formats:@[ format ] timeZone:nil defaultValue:nil];
}

- (instancetype)initWithFormat:(NSString*)format timeZone:(NSTimeZone*)timeZone {
    return [self initWithPath:nil formats:@[ format ] timeZone:timeZone defaultValue:nil];
}

- (instancetype)initWithFormat:(NSString*)format defaultValue:(NSDate*)defaultValue {
    return [self initWithPath:nil formats:@[ format ] timeZone:nil defaultValue:defaultValue];
}

- (instancetype)initWithFormat:(NSString*)format timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue {
    return [self initWithPath:nil formats:@[ format ] timeZone:timeZone defaultValue:defaultValue];
}

- (instancetype)initWithPath:(NSString*)path format:(NSString*)format {
    return [self initWithPath:path formats:@[ format ] timeZone:nil defaultValue:nil];
}

- (instancetype)initWithPath:(NSString*)path format:(NSString*)format timeZone:(NSTimeZone*)timeZone {
    return [self initWithPath:path formats:@[ format ] timeZone:timeZone defaultValue:nil];
}

- (instancetype)initWithPath:(NSString*)path format:(NSString*)format defaultValue:(NSDate*)defaultValue {
    return [self initWithPath:path formats:@[ format ] timeZone:nil defaultValue:defaultValue];
}

- (instancetype)initWithPath:(NSString*)path format:(NSString*)format timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue {
    return [self initWithPath:path formats:@[ format ] timeZone:timeZone defaultValue:defaultValue];
}

- (instancetype)initWithFormats:(NSArray< NSString* >*)formats {
    return [self initWithPath:nil formats:formats timeZone:nil defaultValue:nil];
}

- (instancetype)initWithFormats:(NSArray< NSString* >*)formats timeZone:(NSTimeZone*)timeZone {
    return [self initWithPath:nil formats:formats timeZone:timeZone defaultValue:nil];
}

- (instancetype)initWithFormats:(NSArray< NSString* >*)formats defaultValue:(NSDate*)defaultValue {
    return [self initWithPath:nil formats:formats timeZone:nil defaultValue:defaultValue];
}

- (instancetype)initWithFormats:(NSArray< NSString* >*)formats timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue {
    return [self initWithPath:nil formats:formats timeZone:timeZone defaultValue:defaultValue];
}

- (instancetype)initWithPath:(NSString*)path formats:(NSArray< NSString* >*)formats {
    return [self initWithPath:path formats:formats timeZone:nil defaultValue:nil];
}

- (instancetype)initWithPath:(NSString*)path formats:(NSArray< NSString* >*)formats timeZone:(NSTimeZone*)timeZone {
    return [self initWithPath:path formats:formats timeZone:timeZone defaultValue:nil];
}

- (instancetype)initWithPath:(NSString*)path formats:(NSArray< NSString* >*)formats defaultValue:(NSDate*)defaultValue {
    return [self initWithPath:path formats:formats timeZone:nil defaultValue:defaultValue];
}

- (instancetype)initWithPath:(NSString*)path formats:(NSArray< NSString* >*)formats timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue {
    self = [super initWithPath:path];
    if(self != nil) {
        _formats = formats;
        _defaultValue = defaultValue;
        _timeZone = timeZone;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)fromJson:(id)json sheme:(NSString*)sheme {
    id result = nil;
    if([json isKindOfClass:NSString.class] == YES) {
        NSDateFormatter* dateFormatter = self.dateFormatter;
        for(NSString* format in _formats) {
            dateFormatter.dateFormat = format;
            NSDate* date = [dateFormatter dateFromString:json];
            if(date != nil) {
                result = date;
                break;
            }
        }
    } else if([json isKindOfClass:NSNumber.class] == YES) {
        NSTimeZone* timeZone = (_timeZone != nil) ? _timeZone : NSTimeZone.localTimeZone;
        result = [NSDate glb_dateWithUnixTimestamp:[json unsignedLongValue] timeZone:timeZone];
    }
    if(result != nil) {
        return result;
    } else if(_defaultValue != nil) {
        return _defaultValue;
    }
    return [super fromJson:json sheme:sheme];
}

- (id)toJson:(id)json sheme:(NSString*)sheme {
    if([json isKindOfClass:NSDate.class] == YES) {
        if(_formats.count > 0) {
            NSDateFormatter* dateFormatter = self.dateFormatter;
            return [dateFormatter stringFromDate:json];
        } else {
            NSTimeZone* timeZone = (_timeZone != nil) ? _timeZone : NSTimeZone.localTimeZone;
            return @([json glb_unixTimestampToTimeZone:timeZone]);
        }
    }
    return [super toJson:json sheme:sheme];
}

#pragma mark - Private

- (NSDateFormatter*)dateFormatter {
    static NSDateFormatter* dateFormatter = nil;
    if(dateFormatter == nil) {
        dateFormatter = [NSDateFormatter new];
    }
    if(_timeZone != nil) {
        dateFormatter.timeZone = _timeZone;
    } else {
        dateFormatter.timeZone = NSTimeZone.localTimeZone;
    }
    return dateFormatter;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonEnum

#pragma mark - Init / Free

- (instancetype)initWithEnums:(NSDictionary*)enums {
    return [self initWithPath:nil enums:enums defaultValue:nil];
}

- (instancetype)initWithEnums:(NSDictionary*)enums defaultValue:(NSNumber*)defaultValue {
    return [self initWithPath:nil enums:enums defaultValue:defaultValue];
}

- (instancetype)initWithPath:(NSString*)path enums:(NSDictionary*)enums {
    return [self initWithPath:path enums:enums defaultValue:nil];
}

- (instancetype)initWithPath:(NSString*)path enums:(NSDictionary*)enums defaultValue:(NSNumber*)defaultValue {
    self = [super initWithPath:path];
    if(self != nil) {
        _enums = enums;
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)fromJson:(id)json sheme:(NSString*)sheme {
    id result = _enums[json];
    if(result != nil) {
        return result;
    } else if(_defaultValue != nil) {
        return _defaultValue;
    }
    return [super fromJson:json sheme:sheme];
}

- (id)toJson:(id)json sheme:(NSString*)sheme {
    if(json != nil) {
        NSArray* keys = [_enums allKeysForObject:json];
        if(keys.count > 0) {
            return keys.firstObject;
        }
    }
    return [super toJson:json sheme:sheme];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonColor

#pragma mark - Init / Free

- (instancetype)initWithPath:(NSString*)path defaultValue:(UIColor*)defaultValue {
    self = [super initWithPath:path];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)fromJson:(id)json sheme:(NSString*)sheme {
    if([json isKindOfClass:NSString.class] == YES) {
        return [UIColor glb_colorWithString:json];
    }
    return [super fromJson:json sheme:sheme];
}

- (id)toJson:(id)json sheme:(NSString*)sheme {
    if([json isKindOfClass:UIColor.class] == YES) {
        return [json glb_stringValue];
    }
    return [super toJson:json sheme:sheme];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonModel

#pragma mark - Init / Free

- (instancetype)initWithModelClass:(Class)modelClass {
    return [self initWithPath:nil modelClass:modelClass];
}

- (instancetype)initWithPath:(NSString*)path modelClass:(Class)modelClass {
    self = [super initWithPath:path];
    if(self != nil) {
        _modelClass = modelClass;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)fromJson:(id)json sheme:(NSString*)sheme {
    id result = [_modelClass modelWithJson:json sheme:sheme];
    if(result != nil) {
        return result;
    }
    return [super fromJson:json sheme:sheme];
}

- (id)toJson:(id)json sheme:(NSString*)sheme {
    if(json != nil) {
        return [json toJson:sheme];
    }
    return [super toJson:json sheme:sheme];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface GLBModelJsonBlock ()

@property(nonatomic, readonly, copy) GLBModelJsonConvertBlock fromBlock;
@property(nonatomic, readonly, copy) GLBModelJsonConvertBlock toBlock;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonBlock

#pragma mark - Init / Free

- (instancetype)initWithFromBlock:(GLBModelJsonConvertBlock)fromBlock {
    return [self initWithPath:nil fromBlock:fromBlock toBlock:nil];
}

- (instancetype)initWithToBlock:(GLBModelJsonConvertBlock)toBlock {
    return [self initWithPath:nil fromBlock:nil toBlock:toBlock];
}

- (instancetype)initWithFromBlock:(GLBModelJsonConvertBlock)fromBlock toBlock:(GLBModelJsonConvertBlock)toBlock {
    return [self initWithPath:nil fromBlock:fromBlock toBlock:toBlock];
}

- (instancetype)initWithPath:(NSString*)path fromBlock:(GLBModelJsonConvertBlock)fromBlock {
    return [self initWithPath:path fromBlock:fromBlock toBlock:nil];
}

- (instancetype)initWithPath:(NSString*)path toBlock:(GLBModelJsonConvertBlock)toBlock {
    return [self initWithPath:path fromBlock:nil toBlock:toBlock];
}

- (instancetype)initWithPath:(NSString*)path fromBlock:(GLBModelJsonConvertBlock)fromBlock toBlock:(GLBModelJsonConvertBlock)toBlock {
    self = [super initWithPath:path];
    if(self != nil) {
        _fromBlock = [fromBlock copy];
        _toBlock = [toBlock copy];
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)fromJson:(id)json sheme:(NSString*)sheme {
    if(_fromBlock != nil) {
        return _fromBlock(json, sheme);
    }
    return [super fromJson:json sheme:sheme];
}

- (id)toJson:(id)json sheme:(NSString*)sheme {
    if(_toBlock != nil) {
        return _toBlock(json, sheme);
    }
    return [super toJson:json sheme:sheme];
}

@end

/*--------------------------------------------------*/
