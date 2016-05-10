/*--------------------------------------------------*/

#import "GLBModelPack.h"
#import "GLBModel.h"

/*--------------------------------------------------*/

#import "NSString+GLBNS.h"
#import "NSArray+GLBNS.h"
#import "NSDictionary+GLBNS.h"

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPack

#pragma mark - Init / Free

- (instancetype)initWithKey:(NSString*)key {
    self = [self init];
    if(self != nil) {
        _key = key;
        _keyHash = @(key.glb_crc32);
    }
    return self;
}

- (void)setup {
}

#pragma mark - Public

- (void)pack:(NSMutableDictionary< NSNumber*, id >*)data value:(id)value {
    id packValue = [self packValue:value];
    if(packValue != nil) {
        data[_keyHash] = packValue;
    }
}

- (id)unpack:(NSDictionary< NSNumber*, id >*)data {
    id unpackValue = data[_keyHash];
    if(unpackValue != nil) {
        return [self unpackValue:unpackValue];
    }
    return nil;
}

#pragma mark - GLBModelPack

- (id)packValue:(id)value {
    return nil;
}

- (id)unpackValue:(id)value {
    return nil;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackSet

#pragma mark - Init / Free

- (instancetype)initWithModelClass:(Class)modelClass {
    return [self initWithKey:nil
                   converter:[[GLBModelPackModel alloc] initWithModelClass:modelClass]];
}

- (instancetype)initWithConverter:(GLBModelPack*)converter {
    return [self initWithKey:nil
                   converter:converter];
}

- (instancetype)initWithKey:(NSString*)key modelClass:(Class)modelClass {
    return [self initWithKey:key
                   converter:[[GLBModelPackModel alloc] initWithModelClass:modelClass]];
}

- (instancetype)initWithKey:(NSString*)key converter:(GLBModelPack*)converter {
    self = [super initWithKey:key];
    if(self != nil) {
        _converter = converter;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)packValue:(id)value {
    if([value isKindOfClass:NSSet.class] == YES) {
        NSMutableSet* result = NSMutableSet.set;
        for(id object in value) {
            id convertedValue = [_converter packValue:object];
            if(convertedValue != nil) {
                [result addObject:convertedValue];
            }
        }
        if(result.count > 0) {
            return result.copy;
        }
    }
    return [super packValue:value];
}

- (id)unpackValue:(id)value {
    if([value isKindOfClass:NSSet.class] == YES) {
        NSMutableSet* result = NSMutableSet.set;
        for(id object in value) {
            id convertedValue = [_converter unpackValue:object];
            if(convertedValue != nil) {
                [result addObject:convertedValue];
            }
        }
        if(result.count > 0) {
            return result.copy;
        }
    }
    return [super unpackValue:value];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackOrderedSet

#pragma mark - Init / Free

- (instancetype)initWithModelClass:(Class)modelClass {
    return [self initWithKey:nil
                   converter:[[GLBModelPackModel alloc] initWithModelClass:modelClass]];
}

- (instancetype)initWithConverter:(GLBModelPack*)converter {
    return [self initWithKey:nil
                   converter:converter];
}

- (instancetype)initWithKey:(NSString*)key modelClass:(Class)modelClass {
    return [self initWithKey:key
                   converter:[[GLBModelPackModel alloc] initWithModelClass:modelClass]];
}

- (instancetype)initWithKey:(NSString*)key converter:(GLBModelPack*)converter {
    self = [super initWithKey:key];
    if(self != nil) {
        _converter = converter;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)packValue:(id)value {
    if([value isKindOfClass:NSOrderedSet.class] == YES) {
        NSMutableOrderedSet* result = NSMutableOrderedSet.orderedSet;
        for(id object in value) {
            id convertedValue = [_converter packValue:object];
            if(convertedValue != nil) {
                [result addObject:convertedValue];
            }
        }
        if(result.count > 0) {
            return result.copy;
        }
    }
    return [super packValue:value];
}

- (id)unpackValue:(id)value {
    if([value isKindOfClass:NSOrderedSet.class] == YES) {
        NSMutableOrderedSet* result = NSMutableOrderedSet.orderedSet;
        for(id object in value) {
            id convertedValue = [_converter unpackValue:object];
            if(convertedValue != nil) {
                [result addObject:convertedValue];
            }
        }
        if(result.count > 0) {
            return result.copy;
        }
    }
    return [super unpackValue:value];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackArray

#pragma mark - Init / Free

- (instancetype)initWithModelClass:(Class)modelClass {
    return [self initWithKey:nil
                   converter:[[GLBModelPackModel alloc] initWithModelClass:modelClass]];
}

- (instancetype)initWithConverter:(GLBModelPack*)converter {
    return [self initWithKey:nil
                   converter:converter];
}

- (instancetype)initWithKey:(NSString*)key modelClass:(Class)modelClass {
    return [self initWithKey:key
                   converter:[[GLBModelPackModel alloc] initWithModelClass:modelClass]];
}

- (instancetype)initWithKey:(NSString*)key converter:(GLBModelPack*)converter {
    self = [super initWithKey:key];
    if(self != nil) {
        _converter = converter;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)packValue:(id)value {
    if([value isKindOfClass:NSArray.class] == YES) {
        NSMutableArray* result = NSMutableArray.array;
        for(id object in value) {
            id convertedValue = [_converter packValue:object];
            if(convertedValue != nil) {
                [result addObject:convertedValue];
            }
        }
        if(result.count > 0) {
            return result.copy;
        }
    }
    return [super packValue:value];
}

- (id)unpackValue:(id)value {
    if([value isKindOfClass:NSArray.class] == YES) {
        NSMutableArray* result = NSMutableArray.array;
        for(id object in value) {
            id convertedValue = [_converter unpackValue:object];
            if(convertedValue != nil) {
                [result addObject:convertedValue];
            }
        }
        if(result.count > 0) {
            return result.copy;
        }
    }
    return [super unpackValue:value];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackDictionary

#pragma mark - Init / Free

- (instancetype)initWithValueModelClass:(Class)valueModelClass {
    return [self initWithKey:nil
                keyConverter:nil
              valueConverter:[[GLBModelPackModel alloc] initWithModelClass:valueModelClass]];
}

- (instancetype)initWithValueConverter:(GLBModelPack*)valueConverter {
    return [self initWithKey:nil
                keyConverter:nil
              valueConverter:valueConverter];
}

- (instancetype)initWithKeyModelClass:(Class)keyModelClass valueModelClass:(Class)valueModelClass {
    return [self initWithKey:nil
                keyConverter:[[GLBModelPackModel alloc] initWithModelClass:keyModelClass]
              valueConverter:[[GLBModelPackModel alloc] initWithModelClass:valueModelClass]];
}

- (instancetype)initWithKeyConverter:(GLBModelPack*)keyConverter valueConverter:(GLBModelPack*)valueConverter {
    return [self initWithKey:nil
                keyConverter:keyConverter
              valueConverter:valueConverter];
}

- (instancetype)initWithKey:(NSString*)key valueModelClass:(Class)valueModelClass {
    return [self initWithKey:key
                keyConverter:nil
              valueConverter:[[GLBModelPackModel alloc] initWithModelClass:valueModelClass]];
}

- (instancetype)initWithKey:(NSString*)key valueConverter:(GLBModelPack*)valueConverter {
    return [self initWithKey:key
                keyConverter:nil
              valueConverter:valueConverter];
}

- (instancetype)initWithKey:(NSString*)key keyModelClass:(Class)keyModelClass valueModelClass:(Class)valueModelClass {
    return [self initWithKey:key
                keyConverter:[[GLBModelPackModel alloc] initWithModelClass:keyModelClass]
              valueConverter:[[GLBModelPackModel alloc] initWithModelClass:valueModelClass]];
}

- (instancetype)initWithKey:(NSString*)key keyConverter:(GLBModelPack*)keyConverter valueConverter:(GLBModelPack*)valueConverter {
    self = [super initWithKey:key];
    if(self != nil) {
        _keyConverter = keyConverter;
        _valueConverter = valueConverter;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)packValue:(id)value {
    if([value isKindOfClass:NSDictionary.class] == YES) {
        NSMutableDictionary* result = NSMutableDictionary.dictionary;
        [value enumerateKeysAndObjectsUsingBlock:^(id jsonKey, id jsonObject, BOOL* stop __unused) {
            id key = (_keyConverter != nil) ? [_keyConverter packValue:jsonKey] : jsonKey;
            if(key != nil) {
                id value = [_valueConverter packValue:jsonObject];
                if(value != nil) {
                    result[key] = value;
                }
            }
        }];
        if(result != nil) {
            return result.copy;
        }
    }
    return [super packValue:value];
}

- (id)unpackValue:(id)value {
    if([value isKindOfClass:NSDictionary.class] == YES) {
        NSMutableDictionary* result = NSMutableDictionary.dictionary;
        [value enumerateKeysAndObjectsUsingBlock:^(id jsonKey, id jsonObject, BOOL* stop __unused) {
            id key = (_keyConverter != nil) ? [_keyConverter unpackValue:jsonKey] : jsonKey;
            if(key != nil) {
                id value = [_valueConverter unpackValue:jsonObject];
                if(value != nil) {
                    result[key] = value;
                }
            }
        }];
        if(result != nil) {
            return result.copy;
        }
    }
    return [super unpackValue:value];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackBool

#pragma mark - Init / Free

- (instancetype)initWithKey:(NSString*)key defaultValue:(BOOL)defaultValue {
    self = [super initWithKey:key];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)packValue:(id)value {
    if([value isKindOfClass:NSNumber.class] == YES) {
        if([value boolValue] != _defaultValue) {
            return value;
        }
    }
    return nil;
}

- (id)unpackValue:(id)value {
    if([value isKindOfClass:NSNumber.class] == YES) {
        return value;
    }
    return @(_defaultValue);
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackString

#pragma mark - Init / Free

- (instancetype)initWithKey:(NSString*)key defaultValue:(NSString*)defaultValue {
    self = [super initWithKey:key];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)packValue:(id)value {
    if([value isKindOfClass:NSString.class] == YES) {
        if((_defaultValue == nil) || ([value isEqualToString:_defaultValue] == NO)) {
            return value;
        }
    }
    return nil;
}

- (id)unpackValue:(id)value {
    if([value isKindOfClass:NSString.class] == YES) {
        return value;
    }
    return _defaultValue;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackUrl

#pragma mark - Init / Free

- (instancetype)initWithKey:(NSString*)key defaultValue:(NSURL*)defaultValue {
    self = [super initWithKey:key];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)packValue:(id)value {
    if([value isKindOfClass:NSURL.class] == YES) {
        if((_defaultValue == nil) || ([value isEqual:_defaultValue] == NO)) {
            return [value absoluteString];
        }
    }
    return nil;
}

- (id)unpackValue:(id)value {
    if([value isKindOfClass:NSString.class] == YES) {
        return [NSURL URLWithString:value];
    }
    return _defaultValue;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackNumber

#pragma mark - Init / Free

- (instancetype)initWithKey:(NSString*)key defaultValue:(NSNumber*)defaultValue {
    self = [super initWithKey:key];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)packValue:(id)value {
    if([value isKindOfClass:NSNumber.class] == YES) {
        if((_defaultValue == nil) || ([value isEqualToNumber:_defaultValue] == NO)) {
            return value;
        }
    }
    return nil;
}

- (id)unpackValue:(id)value {
    if([value isKindOfClass:NSNumber.class] == YES) {
        return value;
    }
    return _defaultValue;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackDate

#pragma mark - Init / Free

- (instancetype)initWithKey:(NSString*)key defaultValue:(NSDate*)defaultValue {
    self = [super initWithKey:key];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)packValue:(id)value {
    if([value isKindOfClass:NSDate.class] == YES) {
        if((_defaultValue == nil) || ([value isEqualToDate:_defaultValue] == NO)) {
            return @([value timeIntervalSince1970]);
        }
    }
    return nil;
}

- (id)unpackValue:(id)value {
    if([value isKindOfClass:NSNumber.class] == YES) {
        return [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
    }
    return _defaultValue;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackModel

#pragma mark - Init / Free

- (instancetype)initWithModelClass:(Class)modelClass {
    return [self initWithKey:nil modelClass:modelClass];
}

- (instancetype)initWithKey:(NSString*)key modelClass:(Class)modelClass {
    self = [super initWithKey:key];
    if(self != nil) {
        _modelClass = modelClass;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)packValue:(id)value {
    if([value isKindOfClass:_modelClass] == YES) {
        NSDictionary* pack = [value pack];
        if(pack.count > 0) {
            return pack;
        }
    }
    return nil;
}

- (id)unpackValue:(id)value {
    if([value isKindOfClass:NSDictionary.class] == YES) {
        return [_modelClass modelWithPack:value];
    }
    return nil;
}

@end

/*--------------------------------------------------*/
