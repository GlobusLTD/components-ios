/*--------------------------------------------------*/

#import "GLBModelJson.h"
#import "GLBModel.h"

/*--------------------------------------------------*/

#import <CoreLocation/CoreLocation.h>

/*--------------------------------------------------*/

#import "NSString+GLBNS.h"
#import "NSArray+GLBNS.h"
#import "NSDictionary+GLBNS.h"
#import "NSDate+GLBNS.h"
#import "UIColor+GLBUI.h"

/*--------------------------------------------------*/

@interface GLBModelJson ()

@property(nonatomic, strong) NSArray* subPaths;
@property(nonatomic, copy) GLBModelJsonUndefinedBehaviour undefinedBehaviour;

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
    return [self initWithPath:path
           undefinedBehaviour:nil];
}

- (instancetype)initWithUndefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil
           undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    self = [self init];
    if(self != nil) {
        if(path.length > 0) {
            _path = path;
            NSMutableArray* subPaths = [NSMutableArray arrayWithArray:[path componentsSeparatedByString:@"|"]];
            [subPaths glb_eachWithIndex:^(NSString* subPath, NSUInteger index) {
                subPaths[index] = [subPath componentsSeparatedByString:@"."];
            }];
            _subPaths = subPaths;
        }
        _undefinedBehaviour = undefinedBehaviour;
    }
    return self;
}

- (void)setup {
}

#pragma mark - Public

- (id)parseJson:(id)json {
    id value = json;
    if([value isKindOfClass:NSDictionary.class] == YES) {
        for(NSArray* subPath in _subPaths) {
            value = json;
            for(NSString* path in subPath) {
                if([value isKindOfClass:NSDictionary.class] == YES) {
                    value = value[path];
                    if(value == nil) {
                        break;
                    }
                } else {
                    if(path != subPath.lastObject) {
                        value = nil;
                    }
                    break;
                }
            }
            if(value != nil) {
                break;
            }
        }
    }
    return [self convertValue:value];
}

#pragma mark - GLBModelJson

- (id)convertValue:(id)value {
    if(_undefinedBehaviour != nil) {
        return _undefinedBehaviour(self, value);
    }
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
                jsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:modelClass]
           undefinedBehaviour:nil];
}

- (instancetype)initWithModelClass:(Class)modelClass undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil
                jsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:modelClass]
           undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithJsonConverter:(GLBModelJson*)jsonConverter {
    return [self initWithPath:nil
                jsonConverter:jsonConverter
           undefinedBehaviour:nil];
}

- (instancetype)initWithJsonConverter:(GLBModelJson*)jsonConverter undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil
                jsonConverter:jsonConverter
           undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path modelClass:(Class)modelClass {
    return [self initWithPath:path
                jsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:modelClass]
           undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path modelClass:(Class)modelClass undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:path
                jsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:modelClass]
           undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path jsonConverter:(GLBModelJson*)jsonConverter {
    return [self initWithPath:path
                jsonConverter:jsonConverter
           undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path jsonConverter:(GLBModelJson*)jsonConverter undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    self = [super initWithPath:path undefinedBehaviour:undefinedBehaviour];
    if(self != nil) {
        _jsonConverter = jsonConverter;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)convertValue:(id)value {
    if([value isKindOfClass:NSArray.class] == YES) {
        NSMutableSet* result = NSMutableSet.set;
        for(id object in value) {
            id convertedValue = [_jsonConverter parseJson:object];
            if(convertedValue != nil) {
                [result addObject:convertedValue];
            }
        }
        if(result != nil) {
            return result.copy;
        }
    }
    return [super convertValue:value];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonOrderedSet

#pragma mark - Init / Free

- (instancetype)initWithModelClass:(Class)modelClass {
    return [self initWithPath:nil
                jsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:modelClass]
           undefinedBehaviour:nil];
}

- (instancetype)initWithModelClass:(Class)modelClass undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil
                jsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:modelClass]
           undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithJsonConverter:(GLBModelJson*)jsonConverter {
    return [self initWithPath:nil
                jsonConverter:jsonConverter
           undefinedBehaviour:nil];
}

- (instancetype)initWithJsonConverter:(GLBModelJson*)jsonConverter undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil
                jsonConverter:jsonConverter
           undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path modelClass:(Class)modelClass {
    return [self initWithPath:path
                jsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:modelClass]
           undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path modelClass:(Class)modelClass undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:path
                jsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:modelClass]
           undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path jsonConverter:(GLBModelJson*)jsonConverter {
    return [self initWithPath:path
                jsonConverter:jsonConverter
           undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path jsonConverter:(GLBModelJson*)jsonConverter undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    self = [super initWithPath:path undefinedBehaviour:undefinedBehaviour];
    if(self != nil) {
        _jsonConverter = jsonConverter;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)convertValue:(id)value {
    if([value isKindOfClass:NSArray.class] == YES) {
        NSMutableOrderedSet* result = NSMutableOrderedSet.orderedSet;
        for(id object in value) {
            id convertedValue = [_jsonConverter parseJson:object];
            if(convertedValue != nil) {
                [result addObject:convertedValue];
            }
        }
        if(result != nil) {
            return result.copy;
        }
    }
    return [super convertValue:value];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonArray

#pragma mark - Init / Free

- (instancetype)initWithModelClass:(Class)modelClass {
    return [self initWithPath:nil
                jsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:modelClass]
           undefinedBehaviour:nil];
}

- (instancetype)initWithModelClass:(Class)modelClass undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil
                jsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:modelClass]
           undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithJsonConverter:(GLBModelJson*)jsonConverter {
    return [self initWithPath:nil
                jsonConverter:jsonConverter
           undefinedBehaviour:nil];
}

- (instancetype)initWithJsonConverter:(GLBModelJson*)jsonConverter undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil
                jsonConverter:jsonConverter
           undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path modelClass:(Class)modelClass {
    return [self initWithPath:path
                jsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:modelClass]
           undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path modelClass:(Class)modelClass undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:path
                jsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:modelClass]
           undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path jsonConverter:(GLBModelJson*)jsonConverter {
    return [self initWithPath:path
                jsonConverter:jsonConverter
           undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path jsonConverter:(GLBModelJson*)jsonConverter undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    self = [super initWithPath:path undefinedBehaviour:undefinedBehaviour];
    if(self != nil) {
        _jsonConverter = jsonConverter;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)convertValue:(id)value {
    if([value isKindOfClass:NSArray.class] == YES) {
        NSMutableArray* result = NSMutableArray.array;
        for(id object in value) {
            id convertedValue = [_jsonConverter parseJson:object];
            if(convertedValue != nil) {
                [result addObject:convertedValue];
            }
        }
        if(result != nil) {
            return result.copy;
        }
    }
    return [super convertValue:value];
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
           valueJsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:valueModelClass]
           undefinedBehaviour:nil];
}

- (instancetype)initWithValueModelClass:(Class)valueModelClass undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil
             keyJsonConverter:nil
           valueJsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:valueModelClass]
           undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithValueJsonConverter:(GLBModelJson*)valueJsonConverter {
    return [self initWithPath:nil
             keyJsonConverter:nil
           valueJsonConverter:valueJsonConverter
           undefinedBehaviour:nil];
}

- (instancetype)initWithValueJsonConverter:(GLBModelJson*)valueJsonConverter undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil
             keyJsonConverter:nil
           valueJsonConverter:valueJsonConverter
           undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithKeyModelClass:(Class)keyModelClass valueModelClass:(Class)valueModelClass {
    return [self initWithPath:nil
             keyJsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:keyModelClass]
           valueJsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:valueModelClass]
           undefinedBehaviour:nil];
}

- (instancetype)initWithKeyModelClass:(Class)keyModelClass valueModelClass:(Class)valueModelClass undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil
             keyJsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:keyModelClass]
           valueJsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:valueModelClass]
           undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithKeyJsonConverter:(GLBModelJson*)keyJsonConverter valueJsonConverter:(GLBModelJson*)valueJsonConverter {
    return [self initWithPath:nil
             keyJsonConverter:keyJsonConverter
           valueJsonConverter:valueJsonConverter
           undefinedBehaviour:nil];
}

- (instancetype)initWithKeyJsonConverter:(GLBModelJson*)keyJsonConverter valueJsonConverter:(GLBModelJson*)valueJsonConverter undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil
             keyJsonConverter:keyJsonConverter
           valueJsonConverter:valueJsonConverter
           undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path valueModelClass:(Class)valueModelClass {
    return [self initWithPath:path
             keyJsonConverter:nil
           valueJsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:valueModelClass]
           undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path valueModelClass:(Class)valueModelClass undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:path
             keyJsonConverter:nil
           valueJsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:valueModelClass]
           undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path valueJsonConverter:(GLBModelJson*)valueJsonConverter {
    return [self initWithPath:path
             keyJsonConverter:nil
           valueJsonConverter:valueJsonConverter
           undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path valueJsonConverter:(GLBModelJson*)valueJsonConverter undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:path
             keyJsonConverter:nil
           valueJsonConverter:valueJsonConverter
           undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path keyModelClass:(Class)keyModelClass valueModelClass:(Class)valueModelClass {
    return [self initWithPath:path
             keyJsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:keyModelClass]
           valueJsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:valueModelClass]
           undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path keyModelClass:(Class)keyModelClass valueModelClass:(Class)valueModelClass undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:path
             keyJsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:keyModelClass]
           valueJsonConverter:[[GLBModelJsonModel alloc] initWithModelClass:valueModelClass]
           undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path keyJsonConverter:(GLBModelJson*)keyJsonConverter valueJsonConverter:(GLBModelJson*)valueJsonConverter {
    return [self initWithPath:path
             keyJsonConverter:keyJsonConverter
           valueJsonConverter:valueJsonConverter
           undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path keyJsonConverter:(GLBModelJson*)keyJsonConverter valueJsonConverter:(GLBModelJson*)valueJsonConverter undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    self = [super initWithPath:path undefinedBehaviour:undefinedBehaviour];
    if(self != nil) {
        _keyJsonConverter = keyJsonConverter;
        _valueJsonConverter = valueJsonConverter;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)convertValue:(id)value {
    if([value isKindOfClass:NSDictionary.class] == YES) {
        NSMutableDictionary* result = NSMutableDictionary.dictionary;
        [value enumerateKeysAndObjectsUsingBlock:^(id jsonKey, id jsonObject, BOOL* stop __unused) {
            id key = (_keyJsonConverter != nil) ? [_keyJsonConverter parseJson:jsonKey] : jsonKey;
            if(key != nil) {
                id value = [_valueJsonConverter parseJson:jsonObject];
                if(value != nil) {
                    result[key] = value;
                }
            }
        }];
        if(result != nil) {
            return result.copy;
        }
    }
    return [super convertValue:value];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonBool

#pragma mark - Init / Free

- (instancetype)initWithPath:(NSString*)path defaultValue:(BOOL)defaultValue {
    return [self initWithPath:path defaultValue:defaultValue undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path defaultValue:(BOOL)defaultValue undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    self = [super initWithPath:path undefinedBehaviour:undefinedBehaviour];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)convertValue:(id)value {
    id result = nil;
    if([value isKindOfClass:NSString.class] == YES) {
        result = @([value glb_bool]);
    } else if([value isKindOfClass:NSNumber.class] == YES) {
        result = value;
    }
    if(result != nil) {
        return result;
    }
    return @(_defaultValue);
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonString

#pragma mark - Init / Free

- (instancetype)initWithPath:(NSString*)path defaultValue:(NSString*)defaultValue {
    return [self initWithPath:path defaultValue:defaultValue undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path defaultValue:(NSString*)defaultValue undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    self = [super initWithPath:path undefinedBehaviour:undefinedBehaviour];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)convertValue:(id)value {
    id result = nil;
    if([value isKindOfClass:NSString.class] == YES) {
        result = value;
    } else if([value isKindOfClass:NSNumber.class] == YES) {
        result = [value stringValue];
    }
    if(result != nil) {
        return result;
    } else if(_defaultValue != nil) {
        return _defaultValue;
    }
    return [super convertValue:value];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonUrl

#pragma mark - Init / Free

- (instancetype)initWithPath:(NSString*)path defaultValue:(NSURL*)defaultValue {
    return [self initWithPath:path defaultValue:defaultValue undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path defaultValue:(NSURL*)defaultValue undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    self = [super initWithPath:path undefinedBehaviour:undefinedBehaviour];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)convertValue:(id)value {
    id result = nil;
    if([value isKindOfClass:NSString.class] == YES) {
        result = [NSURL URLWithString:value];
        if (result == nil) {
            result = [NSURL URLWithString:[value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    if(result != nil) {
        return result;
    } else if(_defaultValue != nil) {
        return _defaultValue;
    }
    return [super convertValue:value];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonNumber

#pragma mark - Init / Free

- (instancetype)initWithPath:(NSString*)path defaultValue:(NSNumber*)defaultValue {
    return [self initWithPath:path defaultValue:defaultValue undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path defaultValue:(NSNumber*)defaultValue undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    self = [super initWithPath:path undefinedBehaviour:undefinedBehaviour];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)convertValue:(id)value {
    id result = nil;
    if([value isKindOfClass:NSNumber.class] == YES) {
        result = value;
    } else if([value isKindOfClass:NSString.class] == YES) {
        result = [value glb_number];
    }
    if(result != nil) {
        return result;
    } else if(_defaultValue != nil) {
        return _defaultValue;
    }
    return [super convertValue:value];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonDate

#pragma mark - Init / Free

- (instancetype)initWithPath:(NSString*)path defaultValue:(NSDate*)defaultValue {
    return [self initWithPath:path formats:nil timeZone:nil defaultValue:defaultValue undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue {
    return [self initWithPath:path formats:nil timeZone:timeZone defaultValue:defaultValue undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path defaultValue:(NSDate*)defaultValue undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:path formats:nil timeZone:nil defaultValue:defaultValue undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:path formats:nil timeZone:timeZone defaultValue:defaultValue undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithFormat:(NSString*)format {
    return [self initWithPath:nil formats:@[ format ] timeZone:nil defaultValue:nil undefinedBehaviour:nil];
}

- (instancetype)initWithFormat:(NSString*)format timeZone:(NSTimeZone*)timeZone {
    return [self initWithPath:nil formats:@[ format ] timeZone:timeZone defaultValue:nil undefinedBehaviour:nil];
}

- (instancetype)initWithFormat:(NSString*)format undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil formats:@[ format ] timeZone:nil defaultValue:nil undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithFormat:(NSString*)format timeZone:(NSTimeZone*)timeZone undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil formats:@[ format ] timeZone:timeZone defaultValue:nil undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithFormat:(NSString*)format defaultValue:(NSDate*)defaultValue {
    return [self initWithPath:nil formats:@[ format ] timeZone:nil defaultValue:defaultValue undefinedBehaviour:nil];
}

- (instancetype)initWithFormat:(NSString*)format timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue {
    return [self initWithPath:nil formats:@[ format ] timeZone:timeZone defaultValue:defaultValue undefinedBehaviour:nil];
}

- (instancetype)initWithFormat:(NSString*)format defaultValue:(NSDate*)defaultValue undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil formats:@[ format ] timeZone:nil defaultValue:defaultValue undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithFormat:(NSString*)format timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil formats:@[ format ] timeZone:timeZone defaultValue:defaultValue undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path format:(NSString*)format {
    return [self initWithPath:path formats:@[ format ] timeZone:nil defaultValue:nil undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path format:(NSString*)format timeZone:(NSTimeZone*)timeZone {
    return [self initWithPath:path formats:@[ format ] timeZone:timeZone defaultValue:nil undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path format:(NSString*)format undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:path formats:@[ format ] timeZone:nil defaultValue:nil undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path format:(NSString*)format timeZone:(NSTimeZone*)timeZone undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:path formats:@[ format ] timeZone:timeZone defaultValue:nil undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path format:(NSString*)format defaultValue:(NSDate*)defaultValue {
    return [self initWithPath:path formats:@[ format ] timeZone:nil defaultValue:defaultValue undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path format:(NSString*)format timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue {
    return [self initWithPath:path formats:@[ format ] timeZone:timeZone defaultValue:defaultValue undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path format:(NSString*)format defaultValue:(NSDate*)defaultValue undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:path formats:@[ format ] timeZone:nil defaultValue:defaultValue undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path format:(NSString*)format timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:path formats:@[ format ] timeZone:timeZone defaultValue:defaultValue undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithFormats:(NSArray*)formats {
    return [self initWithPath:nil formats:formats timeZone:nil defaultValue:nil undefinedBehaviour:nil];
}

- (instancetype)initWithFormats:(NSArray*)formats timeZone:(NSTimeZone*)timeZone {
    return [self initWithPath:nil formats:formats timeZone:timeZone defaultValue:nil undefinedBehaviour:nil];
}

- (instancetype)initWithFormats:(NSArray*)formats undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil formats:formats timeZone:nil defaultValue:nil undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithFormats:(NSArray*)formats timeZone:(NSTimeZone*)timeZone undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil formats:formats timeZone:timeZone defaultValue:nil undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithFormats:(NSArray*)formats defaultValue:(NSDate*)defaultValue {
    return [self initWithPath:nil formats:formats timeZone:nil defaultValue:defaultValue undefinedBehaviour:nil];
}

- (instancetype)initWithFormats:(NSArray*)formats timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue {
    return [self initWithPath:nil formats:formats timeZone:timeZone defaultValue:defaultValue undefinedBehaviour:nil];
}

- (instancetype)initWithFormats:(NSArray*)formats defaultValue:(NSDate*)defaultValue undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil formats:formats timeZone:nil defaultValue:defaultValue undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithFormats:(NSArray*)formats timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil formats:formats timeZone:timeZone defaultValue:defaultValue undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path formats:(NSArray*)formats {
    return [self initWithPath:path formats:formats timeZone:nil defaultValue:nil undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path formats:(NSArray*)formats timeZone:(NSTimeZone*)timeZone {
    return [self initWithPath:path formats:formats timeZone:timeZone defaultValue:nil undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path formats:(NSArray*)formats undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:path formats:formats timeZone:nil defaultValue:nil undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path formats:(NSArray*)formats timeZone:(NSTimeZone*)timeZone undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:path formats:formats timeZone:timeZone defaultValue:nil undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path formats:(NSArray*)formats defaultValue:(NSDate*)defaultValue {
    return [self initWithPath:path formats:formats timeZone:nil defaultValue:defaultValue undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path formats:(NSArray*)formats timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue {
    return [self initWithPath:path formats:formats timeZone:timeZone defaultValue:defaultValue undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path formats:(NSArray*)formats defaultValue:(NSDate*)defaultValue undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:path formats:formats timeZone:nil defaultValue:defaultValue undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path formats:(NSArray*)formats timeZone:(NSTimeZone*)timeZone defaultValue:(NSDate*)defaultValue undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    self = [super initWithPath:path undefinedBehaviour:undefinedBehaviour];
    if(self != nil) {
        _formats = formats;
        _defaultValue = defaultValue;
        _timeZone = timeZone;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)convertValue:(id)value {
    id result = nil;
    if([value isKindOfClass:NSString.class] == YES) {
        static NSDateFormatter* dateFormatter = nil;
        if(dateFormatter == nil) {
            dateFormatter = [NSDateFormatter new];
        }
        if(_timeZone != nil) {
            dateFormatter.timeZone = _timeZone;
        } else {
            dateFormatter.timeZone = NSTimeZone.localTimeZone;
        }
        for(NSString* format in _formats) {
            if([format isKindOfClass:NSString.class] == true) {
                dateFormatter.dateFormat = format;
            }
            NSDate* date = [dateFormatter dateFromString:value];
            if(date != nil) {
                result = date;
                break;
            }
        }
    } else if([value isKindOfClass:NSNumber.class] == YES) {
        result = [NSDate glb_dateWithUnixTimestamp:[value longValue] timeZone:(_timeZone != nil) ? _timeZone : NSTimeZone.localTimeZone];
    }
    if(result != nil) {
        return result;
    } else if(_defaultValue != nil) {
        return _defaultValue;
    }
    return [super convertValue:value];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonEnum

#pragma mark - Init / Free

- (instancetype)initWithEnums:(NSDictionary*)enums {
    return [self initWithPath:nil enums:enums defaultValue:nil undefinedBehaviour:nil];
}

- (instancetype)initWithEnums:(NSDictionary*)enums undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil enums:enums defaultValue:nil undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithEnums:(NSDictionary*)enums defaultValue:(NSNumber*)defaultValue {
    return [self initWithPath:nil enums:enums defaultValue:defaultValue undefinedBehaviour:nil];
}

- (instancetype)initWithEnums:(NSDictionary*)enums defaultValue:(NSNumber*)defaultValue undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil enums:enums defaultValue:defaultValue undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path enums:(NSDictionary*)enums {
    return [self initWithPath:path enums:enums defaultValue:nil undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path enums:(NSDictionary*)enums undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:path enums:enums defaultValue:nil undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path enums:(NSDictionary*)enums defaultValue:(NSNumber*)defaultValue {
    return [self initWithPath:path enums:enums defaultValue:defaultValue undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path enums:(NSDictionary*)enums defaultValue:(NSNumber*)defaultValue undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    self = [super initWithPath:path undefinedBehaviour:undefinedBehaviour];
    if(self != nil) {
        _enums = enums;
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)convertValue:(id)value {
    id result = nil;
    if([value isKindOfClass:NSString.class] == YES) {
        if([_enums.allKeys containsObject:value] == YES) {
            result = _enums[value];
        }
    } else if([value isKindOfClass:NSNumber.class] == YES) {
        if([_enums.allKeys containsObject:value] == YES) {
            result = _enums[value];
        }
    }
    if(result != nil) {
        return result;
    } else if(_defaultValue != nil) {
        return _defaultValue;
    }
    return [super convertValue:value];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonLocation

#pragma mark - Init / Free

- (instancetype)initWithPath:(NSString*)path defaultValue:(CLLocation*)defaultValue {
    return [self initWithPath:path defaultValue:defaultValue undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path defaultValue:(CLLocation*)defaultValue undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    self = [super initWithPath:path undefinedBehaviour:undefinedBehaviour];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)convertValue:(id)value {
    id latitude = nil;
    id longitude = nil;
    if([value isKindOfClass:NSString.class] == YES) {
        NSArray* parts = [value componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-/_,"]];
        if(parts.count == 2) {
            latitude = [parts[0] glb_number];
            longitude = [parts[1] glb_number];
        }
    } else if([value isKindOfClass:NSArray.class] == YES) {
        if([value count] == 2) {
            latitude = value[0];
            if([latitude isKindOfClass:NSString.class] == YES) {
                latitude = [latitude glb_number];
            }
            longitude = value[1];
            if([longitude isKindOfClass:NSString.class] == YES) {
                longitude = [longitude glb_number];
            }
        }
    } else if([value isKindOfClass:NSDictionary.class] == YES) {
        latitude = value[@"latitude"];
        if(latitude == nil) {
            latitude = value[@"lat"];
        }
        if([latitude isKindOfClass:NSString.class] == YES) {
            latitude = [latitude glb_number];
        }
        longitude = value[@"longitude"];
        if(longitude == nil) {
            longitude = value[@"lon"];
        }
        if([longitude isKindOfClass:NSString.class] == YES) {
            longitude = [longitude glb_number];
        }
    }
    id result = nil;
    if((latitude != nil) && (longitude != nil)) {
        result = [[CLLocation alloc] initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]];
    }
    if(result != nil) {
        return result;
    } else if(_defaultValue != nil) {
        return _defaultValue;
    }
    return [super convertValue:value];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonColor

#pragma mark - Init / Free

- (instancetype)initWithPath:(NSString*)path defaultValue:(UIColor*)defaultValue {
    return [self initWithPath:path defaultValue:defaultValue undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path defaultValue:(UIColor*)defaultValue undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    self = [super initWithPath:path undefinedBehaviour:undefinedBehaviour];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)convertValue:(id)value {
    if([value isKindOfClass:NSString.class] == YES) {
        return [UIColor glb_colorWithString:value];
    }
    return [super convertValue:value];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonModel

#pragma mark - Init / Free

- (instancetype)initWithModelClass:(Class)modelClass {
    return [self initWithPath:nil modelClass:modelClass hasAnySource:NO undefinedBehaviour:nil];
}

- (instancetype)initWithModelClass:(Class)modelClass hasAnySource:(BOOL)hasAnySource {
    return [self initWithPath:nil modelClass:modelClass hasAnySource:hasAnySource undefinedBehaviour:nil];
}

- (instancetype)initWithModelClass:(Class)modelClass undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil modelClass:modelClass hasAnySource:NO undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithModelClass:(Class)modelClass hasAnySource:(BOOL)hasAnySource undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil modelClass:modelClass hasAnySource:hasAnySource undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path modelClass:(Class)modelClass {
    return [self initWithPath:path modelClass:modelClass hasAnySource:NO undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path modelClass:(Class)modelClass hasAnySource:(BOOL)hasAnySource {
    return [self initWithPath:path modelClass:modelClass hasAnySource:hasAnySource undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path modelClass:(Class)modelClass undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:path modelClass:modelClass hasAnySource:NO undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path modelClass:(Class)modelClass hasAnySource:(BOOL)hasAnySource undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    self = [super initWithPath:path undefinedBehaviour:undefinedBehaviour];
    if(self != nil) {
        _modelClass = modelClass;
        _hasAnySource = hasAnySource;
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)convertValue:(id)value {
    id result = nil;
    if((_hasAnySource == YES) || ([value isKindOfClass:NSDictionary.class] == YES)) {
        result = [_modelClass modelWithJson:value];
    }
    if(result != nil) {
        return result;
    }
    return [super convertValue:value];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface GLBModelJsonBlock ()

@property(nonatomic, readonly, copy) GLBModelJsonConvertBlock block;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelJsonBlock

#pragma mark - Init / Free

- (instancetype)initWithBlock:(GLBModelJsonConvertBlock)block {
    return [self initWithPath:nil block:block undefinedBehaviour:nil];
}

- (instancetype)initWithBlock:(GLBModelJsonConvertBlock)block undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    return [self initWithPath:nil block:block undefinedBehaviour:undefinedBehaviour];
}

- (instancetype)initWithPath:(NSString*)path block:(GLBModelJsonConvertBlock)block {
    return [self initWithPath:path block:block undefinedBehaviour:nil];
}

- (instancetype)initWithPath:(NSString*)path block:(GLBModelJsonConvertBlock)block undefinedBehaviour:(GLBModelJsonUndefinedBehaviour)undefinedBehaviour {
    self = [super initWithPath:path undefinedBehaviour:undefinedBehaviour];
    if(self != nil) {
        _block = [block copy];
    }
    return self;
}

#pragma mark - GLBModelJson

- (id)convertValue:(id)value {
    if(_block != nil) {
        return _block(value);
    }
    return [super convertValue:value];
}

@end

/*--------------------------------------------------*/
