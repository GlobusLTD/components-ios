/*--------------------------------------------------*/

#import "GLBModelPack.h"
#import "GLBModel.h"

/*--------------------------------------------------*/

#import <CoreLocation/CoreLocation.h>

/*--------------------------------------------------*/

#import "NSString+GLBNS.h"
#import "NSArray+GLBNS.h"
#import "NSDictionary+GLBNS.h"
#import "UIColor+GLBUI.h"

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPack

#pragma mark - Public

- (id)pack:(id)value {
    return nil;
}

- (id)unpack:(id)value {
    return nil;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackSet

#pragma mark - Init / Free

- (instancetype)initWithModelClass:(Class)modelClass {
    return [self initWithConverter:[[GLBModelPackModel alloc] initWithModelClass:modelClass]];
}

- (instancetype)initWithConverter:(GLBModelPack*)converter {
    self = [super init];
    if(self != nil) {
        _converter = converter;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)pack:(id)value {
    if([value isKindOfClass:NSSet.class] == YES) {
        NSMutableSet* result = NSMutableSet.set;
        for(id object in value) {
            id convertedValue = [_converter pack:object];
            if(convertedValue != nil) {
                [result addObject:convertedValue];
            }
        }
        if(result.count > 0) {
            return result.copy;
        }
    }
    return [super pack:value];
}

- (id)unpack:(id)value {
    if([value isKindOfClass:NSSet.class] == YES) {
        NSMutableSet* result = NSMutableSet.set;
        for(id object in value) {
            id convertedValue = [_converter unpack:object];
            if(convertedValue != nil) {
                [result addObject:convertedValue];
            }
        }
        if(result.count > 0) {
            return result.copy;
        }
    }
    return [super unpack:value];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackOrderedSet

#pragma mark - Init / Free

- (instancetype)initWithModelClass:(Class)modelClass {
    return [self initWithConverter:[[GLBModelPackModel alloc] initWithModelClass:modelClass]];
}

- (instancetype)initWithConverter:(GLBModelPack*)converter {
    self = [super init];
    if(self != nil) {
        _converter = converter;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)pack:(id)value {
    if([value isKindOfClass:NSOrderedSet.class] == YES) {
        NSMutableOrderedSet* result = NSMutableOrderedSet.orderedSet;
        for(id object in value) {
            id convertedValue = [_converter pack:object];
            if(convertedValue != nil) {
                [result addObject:convertedValue];
            }
        }
        if(result.count > 0) {
            return result.copy;
        }
    }
    return [super pack:value];
}

- (id)unpack:(id)value {
    if([value isKindOfClass:NSOrderedSet.class] == YES) {
        NSMutableOrderedSet* result = NSMutableOrderedSet.orderedSet;
        for(id object in value) {
            id convertedValue = [_converter unpack:object];
            if(convertedValue != nil) {
                [result addObject:convertedValue];
            }
        }
        if(result.count > 0) {
            return result.copy;
        }
    }
    return [super unpack:value];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackArray

#pragma mark - Init / Free

- (instancetype)initWithModelClass:(Class)modelClass {
    return [self initWithConverter:[[GLBModelPackModel alloc] initWithModelClass:modelClass]];
}

- (instancetype)initWithConverter:(GLBModelPack*)converter {
    self = [super init];
    if(self != nil) {
        _converter = converter;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)pack:(id)value {
    if([value isKindOfClass:NSArray.class] == YES) {
        NSMutableArray* result = NSMutableArray.array;
        for(id object in value) {
            id convertedValue = [_converter pack:object];
            if(convertedValue != nil) {
                [result addObject:convertedValue];
            }
        }
        if(result.count > 0) {
            return result.copy;
        }
    }
    return [super pack:value];
}

- (id)unpack:(id)value {
    if([value isKindOfClass:NSArray.class] == YES) {
        NSMutableArray* result = NSMutableArray.array;
        for(id object in value) {
            id convertedValue = [_converter unpack:object];
            if(convertedValue != nil) {
                [result addObject:convertedValue];
            }
        }
        if(result.count > 0) {
            return result.copy;
        }
    }
    return [super unpack:value];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackDictionary

#pragma mark - Init / Free

- (instancetype)initWithValueModelClass:(Class)valueModelClass {
    return [self initWithKeyConverter:nil
                       valueConverter:[[GLBModelPackModel alloc] initWithModelClass:valueModelClass]];
}

- (instancetype)initWithValueConverter:(GLBModelPack*)valueConverter {
    return [self initWithKeyConverter:nil
                       valueConverter:valueConverter];
}

- (instancetype)initWithKeyModelClass:(Class)keyModelClass valueModelClass:(Class)valueModelClass {
    return [self initWithKeyConverter:[[GLBModelPackModel alloc] initWithModelClass:keyModelClass]
                       valueConverter:[[GLBModelPackModel alloc] initWithModelClass:valueModelClass]];
}

- (instancetype)initWithKeyConverter:(GLBModelPack*)keyConverter valueConverter:(GLBModelPack*)valueConverter {
    self = [super init];
    if(self != nil) {
        _keyConverter = keyConverter;
        _valueConverter = valueConverter;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)pack:(id)value {
    if([value isKindOfClass:NSDictionary.class] == YES) {
        NSMutableDictionary* result = NSMutableDictionary.dictionary;
        [value enumerateKeysAndObjectsUsingBlock:^(id jsonKey, id jsonObject, BOOL* stop __unused) {
            id key = (_keyConverter != nil) ? [_keyConverter pack:jsonKey] : jsonKey;
            if(key != nil) {
                id value = [_valueConverter pack:jsonObject];
                if(value != nil) {
                    result[key] = value;
                }
            }
        }];
        if(result != nil) {
            return result.copy;
        }
    }
    return [super pack:value];
}

- (id)unpack:(id)value {
    if([value isKindOfClass:NSDictionary.class] == YES) {
        NSMutableDictionary* result = NSMutableDictionary.dictionary;
        [value enumerateKeysAndObjectsUsingBlock:^(id jsonKey, id jsonObject, BOOL* stop __unused) {
            id key = (_keyConverter != nil) ? [_keyConverter unpack:jsonKey] : jsonKey;
            if(key != nil) {
                id value = [_valueConverter unpack:jsonObject];
                if(value != nil) {
                    result[key] = value;
                }
            }
        }];
        if(result != nil) {
            return result.copy;
        }
    }
    return [super unpack:value];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackBool

#pragma mark - Init / Free

- (instancetype)initWithDefaultValue:(BOOL)defaultValue {
    self = [super init];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)pack:(id)value {
    if([value isKindOfClass:NSNumber.class] == YES) {
        if([value boolValue] != _defaultValue) {
            return value;
        }
    }
    return nil;
}

- (id)unpack:(id)value {
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

- (instancetype)initWithDefaultValue:(NSString*)defaultValue {
    self = [super init];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)pack:(id)value {
    if([value isKindOfClass:NSString.class] == YES) {
        if((_defaultValue == nil) || ([value isEqualToString:_defaultValue] == NO)) {
            return value;
        }
    }
    return nil;
}

- (id)unpack:(id)value {
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

- (instancetype)initWithDefaultValue:(NSURL*)defaultValue {
    self = [super init];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)pack:(id)value {
    if([value isKindOfClass:NSURL.class] == YES) {
        if((_defaultValue == nil) || ([value isEqual:_defaultValue] == NO)) {
            return [value absoluteString];
        }
    }
    return nil;
}

- (id)unpack:(id)value {
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

- (instancetype)initWithDefaultValue:(NSNumber*)defaultValue {
    self = [super init];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)pack:(id)value {
    if([value isKindOfClass:NSNumber.class] == YES) {
        if((_defaultValue == nil) || ([value isEqualToNumber:_defaultValue] == NO)) {
            return value;
        }
    }
    return nil;
}

- (id)unpack:(id)value {
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

- (instancetype)initWithDefaultValue:(NSDate*)defaultValue {
    self = [super init];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)pack:(id)value {
    if([value isKindOfClass:NSDate.class] == YES) {
        if((_defaultValue == nil) || ([value isEqualToDate:_defaultValue] == NO)) {
            return @([value timeIntervalSince1970]);
        }
    }
    return nil;
}

- (id)unpack:(id)value {
    if([value isKindOfClass:NSNumber.class] == YES) {
        return [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
    }
    return _defaultValue;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackLocation

#pragma mark - Init / Free

- (instancetype)initWithDefaultValue:(CLLocation*)defaultValue {
    self = [super init];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)pack:(id)value {
    if([value isKindOfClass:CLLocation.class] == YES) {
        CLLocation* location = value;
        if((_defaultValue == nil) || ([location isEqual:_defaultValue] == NO)) {
            return @{
                @"lo" : @(location.coordinate.longitude),
                @"la" : @(location.coordinate.latitude),
                @"al" : @(location.altitude),
                @"ha" : @(location.horizontalAccuracy),
                @"va" : @(location.verticalAccuracy),
#ifdef GLB_TARGET_IOS
                @"co" : @(location.course),
                @"sp" : @(location.speed),
#endif
                @"ts" : @([location.timestamp timeIntervalSince1970])
            };
        }
    }
    return nil;
}

- (id)unpack:(id)value {
    if([value isKindOfClass:NSDictionary.class] == YES) {
        NSNumber* longitude = [value glb_numberForKey:@"lo" orDefault:nil];
        NSNumber* latitude = [value glb_numberForKey:@"la" orDefault:nil];
        NSNumber* altitude = [value glb_numberForKey:@"al" orDefault:nil];
        NSNumber* horizontalAccuracy = [value glb_numberForKey:@"ha" orDefault:nil];
        NSNumber* verticalAccuracy = [value glb_numberForKey:@"va" orDefault:nil];
#ifdef GLB_TARGET_IOS
        NSNumber* course = [value glb_numberForKey:@"co" orDefault:nil];
        NSNumber* speed = [value glb_numberForKey:@"sp" orDefault:nil];
#endif
        NSNumber* timestamp = [value glb_numberForKey:@"ts" orDefault:nil];
        return [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue)
                                             altitude:altitude.doubleValue
                                   horizontalAccuracy:horizontalAccuracy.doubleValue
                                     verticalAccuracy:verticalAccuracy.doubleValue
#ifdef GLB_TARGET_IOS
                                               course:course.doubleValue
                                                speed:speed.doubleValue
#endif
                                            timestamp:[NSDate dateWithTimeIntervalSince1970:timestamp.doubleValue]];
    }
    return _defaultValue;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackColor

#pragma mark - Init / Free

- (instancetype)initWithDefaultValue:(UIColor*)defaultValue {
    self = [super init];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)pack:(id)value {
    if([value isKindOfClass:UIColor.class] == YES) {
        if((_defaultValue == nil) || ([value isEqual:_defaultValue] == NO)) {
            return [value glb_stringValue];
        }
    }
    return nil;
}

- (id)unpack:(id)value {
    if([value isKindOfClass:NSString.class] == YES) {
        return [UIColor glb_colorWithString:value];
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
    self = [super init];
    if(self != nil) {
        _modelClass = modelClass;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)pack:(id)value {
    if([value isKindOfClass:_modelClass] == YES) {
        NSDictionary* pack = [value pack];
        if(pack.count > 0) {
            return pack;
        }
    }
    return nil;
}

- (id)unpack:(id)value {
    if([value isKindOfClass:NSDictionary.class] == YES) {
        return [_modelClass modelWithPack:value];
    }
    return nil;
}

@end

/*--------------------------------------------------*/
