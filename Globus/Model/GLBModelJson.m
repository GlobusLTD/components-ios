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

+ (instancetype)json {
    return [[self alloc] init];
}

+ (instancetype)jsonWithPath:(NSString*)path {
    return [[self alloc] initWithPath:path];
}

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

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(init)
GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(initPath:(NSString*)path)

#pragma mark - Init / Free

+ (instancetype)jsonWithModel:(Class)model {
    return [[self alloc] initWithModel:model];
}

+ (instancetype)jsonWithConverter:(GLBModelJson*)converter {
    return [[self alloc] initWithConverter:converter];
}

+ (instancetype)jsonWithPath:(NSString*)path model:(Class)model {
    return [[self alloc] initWithPath:path model:model];
}

+ (instancetype)jsonWithPath:(NSString*)path converter:(GLBModelJson*)converter {
    return [[self alloc] initWithPath:path converter:converter];
}

- (instancetype)initWithModel:(Class)model {
    return [self initWithConverter:[GLBModelJsonModel jsonWithModel:model]];
}

- (instancetype)initWithConverter:(GLBModelJson*)converter {
    self = [super init];
    if(self != nil) {
        _converter = converter;
    }
    return self;
}

- (instancetype)initWithPath:(NSString*)path model:(Class)model {
    return [self initWithPath:path converter:[GLBModelJsonModel jsonWithModel:model]];
}

- (instancetype)initWithPath:(NSString*)path converter:(GLBModelJson*)converter {
    self = [super initWithPath:path];
    if(self != nil) {
        _converter = converter;
    }
    return self;
}

#pragma mark - Property

- (GLBModelJson*)jsonConverter {
    return _converter;
}

#pragma mark - GLBModelJson

- (id)fromJson:(id)json sheme:(NSString*)sheme {
    if([json isKindOfClass:NSArray.class] == YES) {
        NSMutableSet* result = NSMutableSet.set;
        for(id object in json) {
            id value = [_converter fromJson:object sheme:sheme];
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
            id value = [_converter toJson:object sheme:sheme];
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

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(init)
GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(initPath:(NSString*)path)

#pragma mark - Init / Free

+ (instancetype)jsonWithModel:(Class)model {
    return [[self alloc] initWithModel:model];
}

+ (instancetype)jsonWithConverter:(GLBModelJson*)converter {
    return [[self alloc] initWithConverter:converter];
}

+ (instancetype)jsonWithPath:(NSString*)path model:(Class)model {
    return [[self alloc] initWithPath:path model:model];
}

+ (instancetype)jsonWithPath:(NSString*)path converter:(GLBModelJson*)converter {
    return [[self alloc] initWithPath:path converter:converter];
}

- (instancetype)initWithModel:(Class)model {
    return [self initWithConverter:[GLBModelJsonModel jsonWithModel:model]];
}

- (instancetype)initWithConverter:(GLBModelJson*)converter {
    self = [super init];
    if(self != nil) {
        _converter = converter;
    }
    return self;
}

- (instancetype)initWithPath:(NSString*)path model:(Class)model {
    return [self initWithPath:path converter:[GLBModelJsonModel jsonWithModel:model]];
}

- (instancetype)initWithPath:(NSString*)path converter:(GLBModelJson*)converter {
    self = [super initWithPath:path];
    if(self != nil) {
        _converter = converter;
    }
    return self;
}

#pragma mark - Property

- (GLBModelJson*)jsonConverter {
    return _converter;
}

#pragma mark - GLBModelJson

- (id)fromJson:(id)json sheme:(NSString*)sheme {
    if([json isKindOfClass:NSArray.class] == YES) {
        NSMutableOrderedSet* result = NSMutableOrderedSet.orderedSet;
        for(id object in json) {
            id value = [_converter fromJson:object sheme:sheme];
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
            id value = [_converter toJson:object sheme:sheme];
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

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(init)
GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(initPath:(NSString*)path)

#pragma mark - Init / Free

+ (instancetype)jsonWithModel:(Class)model {
    return [[self alloc] initWithModel:model];
}

+ (instancetype)jsonWithConverter:(GLBModelJson*)converter {
    return [[self alloc] initWithConverter:converter];
}

+ (instancetype)jsonWithPath:(NSString*)path model:(Class)model {
    return [[self alloc] initWithPath:path model:model];
}

+ (instancetype)jsonWithPath:(NSString*)path converter:(GLBModelJson*)converter {
    return [[self alloc] initWithPath:path converter:converter];
}

- (instancetype)initWithModel:(Class)model {
    return [self initWithConverter:[GLBModelJsonModel jsonWithModel:model]];
}

- (instancetype)initWithConverter:(GLBModelJson*)converter {
    self = [super init];
    if(self != nil) {
        _converter = converter;
    }
    return self;
}

- (instancetype)initWithPath:(NSString*)path model:(Class)model {
    return [self initWithPath:path converter:[GLBModelJsonModel jsonWithModel:model]];
}

- (instancetype)initWithPath:(NSString*)path converter:(GLBModelJson*)converter {
    self = [super initWithPath:path];
    if(self != nil) {
        _converter = converter;
    }
    return self;
}

#pragma mark - Property

- (GLBModelJson*)jsonConverter {
    return _converter;
}

#pragma mark - GLBModelJson

- (id)fromJson:(id)json sheme:(NSString*)sheme {
    if([json isKindOfClass:NSArray.class] == YES) {
        NSMutableArray* result = NSMutableArray.array;
        for(id object in json) {
            id value = [_converter fromJson:object sheme:sheme];
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
            id value = [_converter toJson:object sheme:sheme];
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

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(init)
GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(initPath:(NSString*)path)

#pragma mark - Init / Free

+ (instancetype)jsonWithValueModel:(Class)valueModel {
    return [(GLBModelJsonDictionary*)[self alloc] initWithValueModel:valueModel];
}

+ (instancetype)jsonWithValueConverter:(GLBModelJson*)valueConverter {
    return [(GLBModelJsonDictionary*)[self alloc] initWithValueConverter:valueConverter];
}

+ (instancetype)jsonWithKeyModel:(Class)keyModel valueModel:(Class)valueModel {
    return [(GLBModelJsonDictionary*)[self alloc] initWithKeyModel:keyModel valueModel:valueModel];
}

+ (instancetype)jsonWithKeyConverter:(GLBModelJson*)keyConverter valueConverter:(GLBModelJson*)valueConverter {
    return [(GLBModelJsonDictionary*)[self alloc] initWithKeyConverter:keyConverter valueConverter:valueConverter];
}

+ (instancetype)jsonWithPath:(NSString*)path valueModel:(Class)valueModel {
    return [(GLBModelJsonDictionary*)[self alloc] initWithPath:path valueModel:valueModel];
}

+ (instancetype)jsonWithPath:(NSString*)path valueConverter:(GLBModelJson*)valueConverter {
    return [(GLBModelJsonDictionary*)[self alloc] initWithPath:path valueConverter:valueConverter];
}

+ (instancetype)jsonWithPath:(NSString*)path keyModel:(Class)keyModel valueModel:(Class)valueModel {
    return [(GLBModelJsonDictionary*)[self alloc] initWithPath:path keyModel:keyModel valueModel:valueModel];
}

+ (instancetype)jsonWithPath:(NSString*)path keyConverter:(GLBModelJson*)keyConverter valueConverter:(GLBModelJson*)valueConverter {
    return [(GLBModelJsonDictionary*)[self alloc] initWithPath:path keyConverter:keyConverter valueConverter:valueConverter];
}

- (instancetype)initWithValueModel:(Class)valueModel {
    return [self initWithValueConverter:[GLBModelJsonModel jsonWithModel:valueModel]];
}

- (instancetype)initWithValueConverter:(GLBModelJson*)valueConverter {
    self = [super init];
    if(self != nil) {
        _valueConverter = valueConverter;
    }
    return self;
}

- (instancetype)initWithKeyModel:(Class)keyModel valueModel:(Class)valueModel {
    return [self initWithKeyConverter:[GLBModelJsonModel jsonWithModel:keyModel] valueConverter:[GLBModelJsonModel jsonWithModel:valueModel]];
}

- (instancetype)initWithKeyConverter:(GLBModelJson*)keyConverter valueConverter:(GLBModelJson*)valueConverter {
    self = [super init];
    if(self != nil) {
        _keyConverter = keyConverter;
        _valueConverter = valueConverter;
    }
    return self;
}

- (instancetype)initWithPath:(NSString*)path valueModel:(Class)valueModel {
    return [self initWithPath:path valueConverter:[GLBModelJsonModel jsonWithModel:valueModel]];
}

- (instancetype)initWithPath:(NSString*)path valueConverter:(GLBModelJson*)valueConverter {
    self = [super initWithPath:path];
    if(self != nil) {
        _valueConverter = valueConverter;
    }
    return self;
}

- (instancetype)initWithPath:(NSString*)path keyModel:(Class)keyModel valueModel:(Class)valueModel {
    return [self initWithPath:path keyConverter:[GLBModelJsonModel jsonWithModel:keyModel] valueConverter:[GLBModelJsonModel jsonWithModel:valueModel]];
}

- (instancetype)initWithPath:(NSString*)path keyConverter:(GLBModelJson*)keyConverter valueConverter:(GLBModelJson*)valueConverter {
    self = [super initWithPath:path];
    if(self != nil) {
        _keyConverter = keyConverter;
        _valueConverter = valueConverter;
    }
    return self;
}

#pragma mark - Property

- (GLBModelJson*)jsonKeyConverter {
    return _keyConverter;
}

- (GLBModelJson*)jsonValueConverter {
    return _valueConverter;
}

#pragma mark - GLBModelJson

- (id)fromJson:(id)json sheme:(NSString*)sheme {
    if([json isKindOfClass:NSDictionary.class] == YES) {
        NSMutableDictionary* result = NSMutableDictionary.dictionary;
        [json enumerateKeysAndObjectsUsingBlock:^(id rawKey, id rawValue, BOOL* stop __unused) {
            id key = (_keyConverter != nil) ? [_keyConverter fromJson:rawKey sheme:sheme] : rawKey;
            if(key != nil) {
                id value = [_valueConverter fromJson:rawValue sheme:sheme];
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
            id key = (_keyConverter != nil) ? [_keyConverter toJson:rawKey sheme:sheme] : rawKey;
            if(key != nil) {
                id value = [_valueConverter toJson:rawValue sheme:sheme];
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

+ (instancetype)jsonWithDefaultValue:(BOOL)defaultValue {
    return [(GLBModelJsonBool*)[self alloc] initWithDefaultValue:defaultValue];
}

+ (instancetype)jsonWithPath:(NSString*)path defaultValue:(BOOL)defaultValue {
    return [(GLBModelJsonBool*)[self alloc] initWithPath:path defaultValue:defaultValue];
}

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithDefaultValue:(BOOL)defaultValue {
    self = [super init];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

- (instancetype)initWithPath:(NSString*)path {
    return [super initWithPath:path];
}

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

+ (instancetype)jsonWithDefaultValue:(NSString*)defaultValue {
    return [(GLBModelJsonString*)[self alloc] initWithDefaultValue:defaultValue];
}

+ (instancetype)jsonWithPath:(NSString*)path defaultValue:(NSString*)defaultValue {
    return [(GLBModelJsonString*)[self alloc] initWithPath:path defaultValue:defaultValue];
}

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithDefaultValue:(NSString*)defaultValue {
    self = [super init];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

- (instancetype)initWithPath:(NSString*)path {
    return [super initWithPath:path];
}

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

+ (instancetype)jsonWithDefaultValue:(NSURL*)defaultValue {
    return [(GLBModelJsonUrl*)[self alloc] initWithDefaultValue:defaultValue];
}

+ (instancetype)jsonWithPath:(NSString*)path defaultValue:(NSURL*)defaultValue {
    return [(GLBModelJsonUrl*)[self alloc] initWithPath:path defaultValue:defaultValue];
}

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithDefaultValue:(NSURL*)defaultValue {
    self = [super init];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

- (instancetype)initWithPath:(NSString*)path {
    return [super initWithPath:path];
}

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

+ (instancetype)jsonWithDefaultValue:(NSNumber*)defaultValue {
    return [(GLBModelJsonNumber*)[self alloc] initWithDefaultValue:defaultValue];
}

+ (instancetype)jsonWithPath:(NSString*)path defaultValue:(NSNumber*)defaultValue {
    return [(GLBModelJsonNumber*)[self alloc] initWithPath:path defaultValue:defaultValue];
}

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithDefaultValue:(NSNumber*)defaultValue {
    self = [super init];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

- (instancetype)initWithPath:(NSString*)path {
    return [super initWithPath:path];
}

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

+ (instancetype)jsonWithFormat:(NSString*)format {
    return [(GLBModelJsonDate*)[self alloc] initWithFormat:format];
}

+ (instancetype)jsonWithFormat:(NSString*)format defaultValue:(NSDate*)defaultValue {
    return [(GLBModelJsonDate*)[self alloc] initWithFormat:format defaultValue:defaultValue];
}

+ (instancetype)jsonWithFormat:(NSString*)format timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue {
    return [(GLBModelJsonDate*)[self alloc] initWithFormat:format timeZone:timeZone defaultValue:defaultValue];
}

+ (instancetype)jsonWithFormats:(NSArray< NSString* >*)formats {
    return [(GLBModelJsonDate*)[self alloc] initWithFormats:formats];
}

+ (instancetype)jsonWithFormats:(NSArray< NSString* >*)formats defaultValue:(NSDate*)defaultValue {
    return [(GLBModelJsonDate*)[self alloc] initWithFormats:formats defaultValue:defaultValue];
}

+ (instancetype)jsonWithFormats:(NSArray< NSString* >*)formats timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue {
    return [(GLBModelJsonDate*)[self alloc] initWithFormats:formats timeZone:timeZone defaultValue:defaultValue];
}

+ (instancetype)jsonWithPath:(NSString*)path defaultValue:(NSDate*)defaultValue {
    return [(GLBModelJsonDate*)[self alloc] initWithPath:path defaultValue:defaultValue];
}

+ (instancetype)jsonWithPath:(NSString*)path timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue {
    return [(GLBModelJsonDate*)[self alloc] initWithPath:path timeZone:timeZone defaultValue:defaultValue];
}

+ (instancetype)jsonWithPath:(NSString*)path format:(NSString*)format {
    return [(GLBModelJsonDate*)[self alloc] initWithPath:path format:format];
}

+ (instancetype)jsonWithPath:(NSString*)path format:(NSString*)format defaultValue:(NSDate*)defaultValue {
    return [(GLBModelJsonDate*)[self alloc] initWithPath:path format:format defaultValue:defaultValue];
}

+ (instancetype)jsonWithPath:(NSString*)path format:(NSString*)format timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue {
    return [(GLBModelJsonDate*)[self alloc] initWithPath:path format:format timeZone:timeZone defaultValue:defaultValue];
}

+ (instancetype)jsonWithPath:(NSString*)path formats:(NSArray< NSString* >*)formats {
    return [(GLBModelJsonDate*)[self alloc] initWithPath:path formats:formats];
}

+ (instancetype)jsonWithPath:(NSString*)path formats:(NSArray< NSString* >*)formats defaultValue:(NSDate*)defaultValue {
    return [(GLBModelJsonDate*)[self alloc] initWithPath:path formats:formats defaultValue:defaultValue];
}

+ (instancetype)jsonWithPath:(NSString*)path formats:(NSArray< NSString* >*)formats timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue {
    return [(GLBModelJsonDate*)[self alloc] initWithPath:path formats:formats timeZone:timeZone defaultValue:defaultValue];
}

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithFormat:(NSString*)format {
    self = [super init];
    if(self != nil) {
        _formats = @[ format ];
    }
    return self;
}

- (instancetype)initWithFormat:(NSString*)format defaultValue:(NSDate*)defaultValue {
    return [self initWithFormat:format timeZone:nil defaultValue:defaultValue];
}

- (instancetype)initWithFormat:(NSString*)format timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue {
    self = [super init];
    if(self != nil) {
        _formats = @[ format ];
        _timeZone = timeZone;
        _defaultValue = defaultValue;
    }
    return self;
}

- (instancetype)initWithFormats:(NSArray< NSString* >*)formats {
    self = [super init];
    if(self != nil) {
        _formats = formats;
    }
    return self;
}

- (instancetype)initWithFormats:(NSArray< NSString* >*)formats defaultValue:(NSDate*)defaultValue {
    return [self initWithFormats:formats timeZone:nil defaultValue:defaultValue];
}

- (instancetype)initWithFormats:(NSArray< NSString* >*)formats timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue {
    self = [super init];
    if(self != nil) {
        _formats = formats;
        _timeZone = timeZone;
        _defaultValue = defaultValue;
    }
    return self;
}

- (instancetype)initWithPath:(NSString*)path {
    return [super initWithPath:path];
}

- (instancetype)initWithPath:(NSString*)path defaultValue:(NSDate*)defaultValue {
    return [self initWithPath:path timeZone:nil defaultValue:defaultValue];
}

- (instancetype)initWithPath:(NSString*)path timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue {
    self = [super initWithPath:path];
    if(self != nil) {
        _timeZone = timeZone;
        _defaultValue = defaultValue;
    }
    return self;
}

- (instancetype)initWithPath:(NSString*)path format:(NSString*)format {
    self = [super initWithPath:path];
    if(self != nil) {
        _formats = @[ format ];
    }
    return self;
}

- (instancetype)initWithPath:(NSString*)path format:(NSString*)format defaultValue:(NSDate*)defaultValue {
    return [self initWithPath:path format:format timeZone:nil defaultValue:defaultValue];
}

- (instancetype)initWithPath:(NSString*)path format:(NSString*)format timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue {
    self = [super initWithPath:path];
    if(self != nil) {
        _formats = @[ format ];
        _timeZone = timeZone;
        _defaultValue = defaultValue;
    }
    return self;
}

- (instancetype)initWithPath:(NSString*)path formats:(NSArray< NSString* >*)formats {
    self = [super initWithPath:path];
    if(self != nil) {
        _formats = formats;
    }
    return self;
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
        if(result == nil) {
            NSNumber* ts = [json glb_number];
            if(ts != nil) {
                NSTimeZone* timeZone = (_timeZone != nil) ? _timeZone : NSTimeZone.localTimeZone;
                result = [NSDate glb_dateWithUnixTimestamp:[ts unsignedLongValue] timeZone:timeZone];
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

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(init)
GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(initPath:(NSString*)path)

#pragma mark - Init / Free

+ (instancetype _Nonnull)jsonWithEnums:(NSDictionary* _Nonnull)enums {
    return [[self alloc] initWithEnums:enums];
}

+ (instancetype _Nonnull)jsonWithEnums:(NSDictionary* _Nonnull)enums defaultValue:(NSNumber* _Nonnull)defaultValue {
    return [[self alloc] initWithEnums:enums defaultValue:defaultValue];
}

+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path enums:(NSDictionary* _Nonnull)enums {
    return [[self alloc] initWithPath:path enums:enums];
}

+ (instancetype _Nonnull)jsonWithPath:(NSString* _Nonnull)path enums:(NSDictionary* _Nonnull)enums defaultValue:(NSNumber* _Nonnull)defaultValue {
    return [[self alloc] initWithPath:path enums:enums defaultValue:defaultValue];
}

- (instancetype)initWithEnums:(NSDictionary*)enums {
    self = [super init];
    if(self != nil) {
        _enums = enums;
    }
    return self;
}

- (instancetype)initWithEnums:(NSDictionary*)enums defaultValue:(NSNumber*)defaultValue {
    self = [super init];
    if(self != nil) {
        _enums = enums;
        _defaultValue = defaultValue;
    }
    return self;
}

- (instancetype)initWithPath:(NSString*)path enums:(NSDictionary*)enums {
    self = [super initWithPath:path];
    if(self != nil) {
        _enums = enums;
    }
    return self;
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

+ (instancetype)jsonWithDefaultValue:(UIColor*)defaultValue {
    return [(GLBModelJsonColor*)[self alloc] initWithDefaultValue:defaultValue];
}

+ (instancetype)jsonWithPath:(NSString*)path defaultValue:(UIColor*)defaultValue {
    return [(GLBModelJsonColor*)[self alloc] initWithPath:path defaultValue:defaultValue];
}

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithDefaultValue:(UIColor*)defaultValue {
    self = [super init];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

- (instancetype)initWithPath:(NSString*)path {
    return [super initWithPath:path];
}

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

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(init)
GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(initPath:(NSString*)path)

#pragma mark - Init / Free

+ (instancetype)jsonWithModel:(Class)model {
    return [[self alloc] initWithModel:model];
}

+ (instancetype)jsonWithPath:(NSString*)path model:(Class)model {
    return [[self alloc] initWithPath:path model:model];
}

- (instancetype)initWithModel:(Class)modelClass {
    self = [super init];
    if(self != nil) {
        _model = modelClass;
    }
    return self;
}

- (instancetype)initWithPath:(NSString*)path model:(Class)model {
    self = [super initWithPath:path];
    if(self != nil) {
        _model = model;
    }
    return self;
}

#pragma mark - Property

- (Class)modelClass {
    return _model;
}

#pragma mark - GLBModelJson

- (id)fromJson:(id)json sheme:(NSString*)sheme {
    id result = [_model modelWithJson:json sheme:sheme];
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

@implementation GLBModelJsonBlock

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(init)
GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(initPath:(NSString*)path)

#pragma mark - Init / Free

+ (instancetype)jsonWithFromBlock:(GLBModelJsonConvertBlock)fromBlock toBlock:(GLBModelJsonConvertBlock)toBlock {
    return [[self alloc] initWithFromBlock:fromBlock toBlock:toBlock];
}

+ (instancetype)jsonWithPath:(NSString*)path fromBlock:(GLBModelJsonConvertBlock)fromBlock toBlock:(GLBModelJsonConvertBlock)toBlock {
    return [[self alloc] initWithPath:path fromBlock:fromBlock toBlock:toBlock];
}

- (instancetype)initWithFromBlock:(GLBModelJsonConvertBlock)fromBlock toBlock:(GLBModelJsonConvertBlock)toBlock {
    self = [super init];
    if(self != nil) {
        _fromBlock = [fromBlock copy];
        _toBlock = [toBlock copy];
    }
    return self;
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
