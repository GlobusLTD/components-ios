/*--------------------------------------------------*/

#import "GLBModelPack.h"
#import "GLBModel.h"

/*--------------------------------------------------*/

#import <CoreLocation/CoreLocation.h>

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPack

#pragma mark - Init / Free

+ (instancetype)pack {
    return [[self alloc] init];
}

#pragma mark - Public

- (id)pack:(id)packValue {
    return nil;
}

- (id)unpack:(id)packValue {
    return nil;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackSet

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(init)

#pragma mark - Init / Free

+ (instancetype)packWithModel:(Class)model {
    return [[self alloc] initWithModel:model];
}

+ (instancetype)packWithConverter:(GLBModelPack*)converter {
    return [[self alloc] initWithConverter:converter];
}

- (instancetype)initWithModel:(Class)model {
    return [self initWithConverter:[GLBModelPackModel packWithModel:model]];
}

- (instancetype)initWithConverter:(GLBModelPack*)converter {
    self = [super init];
    if(self != nil) {
        _converter = converter;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)pack:(id)packValue {
    if([packValue isKindOfClass:NSSet.class] == YES) {
        NSMutableSet* result = NSMutableSet.set;
        for(id object in packValue) {
            id convertedValue = [_converter pack:object];
            if(convertedValue != nil) {
                [result addObject:convertedValue];
            }
        }
        if(result.count > 0) {
            return result.copy;
        }
    }
    return [super pack:packValue];
}

- (id)unpack:(id)packValue {
    if([packValue isKindOfClass:NSSet.class] == YES) {
        NSMutableSet* result = NSMutableSet.set;
        for(id object in packValue) {
            id convertedValue = [_converter unpack:object];
            if(convertedValue != nil) {
                [result addObject:convertedValue];
            }
        }
        if(result.count > 0) {
            return result.copy;
        }
    }
    return [super unpack:packValue];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackOrderedSet

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(init)

#pragma mark - Init / Free

+ (instancetype)packWithModel:(Class)model {
    return [[self alloc] initWithModel:model];
}

+ (instancetype)packWithConverter:(GLBModelPack*)converter {
    return [[self alloc] initWithConverter:converter];
}

- (instancetype)initWithModel:(Class)model {
    return [self initWithConverter:[GLBModelPackModel packWithModel:model]];
}

- (instancetype)initWithConverter:(GLBModelPack*)converter {
    self = [super init];
    if(self != nil) {
        _converter = converter;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)pack:(id)packValue {
    if([packValue isKindOfClass:NSOrderedSet.class] == YES) {
        NSMutableOrderedSet* result = NSMutableOrderedSet.orderedSet;
        for(id object in packValue) {
            id convertedValue = [_converter pack:object];
            if(convertedValue != nil) {
                [result addObject:convertedValue];
            }
        }
        if(result.count > 0) {
            return result.copy;
        }
    }
    return [super pack:packValue];
}

- (id)unpack:(id)packValue {
    if([packValue isKindOfClass:NSOrderedSet.class] == YES) {
        NSMutableOrderedSet* result = NSMutableOrderedSet.orderedSet;
        for(id object in packValue) {
            id convertedValue = [_converter unpack:object];
            if(convertedValue != nil) {
                [result addObject:convertedValue];
            }
        }
        if(result.count > 0) {
            return result.copy;
        }
    }
    return [super unpack:packValue];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackArray

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(init)

#pragma mark - Init / Free

+ (instancetype)packWithModel:(Class)model {
    return [[self alloc] initWithModel:model];
}

+ (instancetype)packWithConverter:(GLBModelPack*)converter {
    return [[self alloc] initWithConverter:converter];
}

- (instancetype)initWithModel:(Class)model {
    return [self initWithConverter:[GLBModelPackModel packWithModel:model]];
}

- (instancetype)initWithConverter:(GLBModelPack*)converter {
    self = [super init];
    if(self != nil) {
        _converter = converter;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)pack:(id)packValue {
    if([packValue isKindOfClass:NSArray.class] == YES) {
        NSMutableArray* result = NSMutableArray.array;
        for(id object in packValue) {
            id convertedValue = [_converter pack:object];
            if(convertedValue != nil) {
                [result addObject:convertedValue];
            }
        }
        if(result.count > 0) {
            return result.copy;
        }
    }
    return [super pack:packValue];
}

- (id)unpack:(id)packValue {
    if([packValue isKindOfClass:NSArray.class] == YES) {
        NSMutableArray* result = NSMutableArray.array;
        for(id object in packValue) {
            id convertedValue = [_converter unpack:object];
            if(convertedValue != nil) {
                [result addObject:convertedValue];
            }
        }
        if(result.count > 0) {
            return result.copy;
        }
    }
    return [super unpack:packValue];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackDictionary

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(init)

#pragma mark - Init / Free

+ (instancetype)packWithKeyModel:(Class)keyModel valueModel:(Class)valueModel {
    return [[self alloc] initWithKeyModel:keyModel valueModel:valueModel];
}

+ (instancetype)packWithKeyConverter:(GLBModelPack*)keyConverter valueConverter:(GLBModelPack*)valueConverter {
    return [[self alloc] initWithKeyConverter:keyConverter valueConverter:valueConverter];
}

- (instancetype)initWithKeyModel:(Class)keyModel valueModel:(Class)valueModel {
    return [self initWithKeyConverter:[GLBModelPackModel packWithModel:keyModel]
                       valueConverter:[GLBModelPackModel packWithModel:valueModel]];
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

- (id)pack:(id)packValue {
    if([packValue isKindOfClass:NSDictionary.class] == YES) {
        NSMutableDictionary* result = NSMutableDictionary.dictionary;
        [packValue enumerateKeysAndObjectsUsingBlock:^(id jsonKey, id jsonObject, BOOL* stop __unused) {
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
    return [super pack:packValue];
}

- (id)unpack:(id)packValue {
    if([packValue isKindOfClass:NSDictionary.class] == YES) {
        NSMutableDictionary* result = NSMutableDictionary.dictionary;
        [packValue enumerateKeysAndObjectsUsingBlock:^(id jsonKey, id jsonObject, BOOL* stop __unused) {
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
    return [super unpack:packValue];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackBool

#pragma mark - Init / Free

+ (instancetype)packWithDefaultValue:(BOOL)defaultValue {
    return [(GLBModelPackBool*)[self alloc] initWithDefaultValue:defaultValue];
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

#pragma mark - GLBModelPack

- (id)pack:(id)packValue {
    if([packValue isKindOfClass:NSNumber.class] == YES) {
        if([packValue boolValue] != _defaultValue) {
            return packValue;
        }
    }
    return nil;
}

- (id)unpack:(id)packValue {
    if([packValue isKindOfClass:NSNumber.class] == YES) {
        return packValue;
    }
    return @(_defaultValue);
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackString

#pragma mark - Init / Free

+ (instancetype)packWithDefaultValue:(NSString*)defaultValue {
    return [(GLBModelPackString*)[self alloc] initWithDefaultValue:defaultValue];
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

#pragma mark - GLBModelPack

- (id)pack:(id)packValue {
    if([packValue isKindOfClass:NSString.class] == YES) {
        if((_defaultValue == nil) || ([packValue isEqualToString:_defaultValue] == NO)) {
            return packValue;
        }
    }
    return nil;
}

- (id)unpack:(id)packValue {
    if([packValue isKindOfClass:NSString.class] == YES) {
        return packValue;
    }
    return _defaultValue;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackUrl

#pragma mark - Init / Free

+ (instancetype)packWithDefaultValue:(NSURL*)defaultValue {
    return [(GLBModelPackUrl*)[self alloc] initWithDefaultValue:defaultValue];
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

#pragma mark - GLBModelPack

- (id)pack:(id)packValue {
    if([packValue isKindOfClass:NSURL.class] == YES) {
        if((_defaultValue == nil) || ([packValue isEqual:_defaultValue] == NO)) {
            return [packValue absoluteString];
        }
    }
    return nil;
}

- (id)unpack:(id)packValue {
    if([packValue isKindOfClass:NSString.class] == YES) {
        return [NSURL URLWithString:packValue];
    }
    return _defaultValue;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackNumber

#pragma mark - Init / Free

+ (instancetype)packWithDefaultValue:(NSNumber*)defaultValue {
    return [(GLBModelPackNumber*)[self alloc] initWithDefaultValue:defaultValue];
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

#pragma mark - GLBModelPack

- (id)pack:(id)packValue {
    if([packValue isKindOfClass:NSNumber.class] == YES) {
        if((_defaultValue == nil) || ([packValue isEqualToNumber:_defaultValue] == NO)) {
            return packValue;
        }
    }
    return nil;
}

- (id)unpack:(id)packValue {
    if([packValue isKindOfClass:NSNumber.class] == YES) {
        return packValue;
    }
    return _defaultValue;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackDate

#pragma mark - Init / Free

+ (instancetype)packWithDefaultValue:(NSDate*)defaultValue {
    return [(GLBModelPackDate*)[self alloc] initWithDefaultValue:defaultValue];
}

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithDefaultValue:(NSDate*)defaultValue {
    self = [super init];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)pack:(id)packValue {
    if([packValue isKindOfClass:NSDate.class] == YES) {
        if((_defaultValue == nil) || ([packValue isEqualToDate:_defaultValue] == NO)) {
            return @([packValue timeIntervalSince1970]);
        }
    }
    return nil;
}

- (id)unpack:(id)packValue {
    if([packValue isKindOfClass:NSNumber.class] == YES) {
        return [NSDate dateWithTimeIntervalSince1970:[packValue doubleValue]];
    }
    return _defaultValue;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackLocation

#pragma mark - Init / Free

+ (instancetype)packWithDefaultValue:(CLLocation*)defaultValue {
    return [(GLBModelPackLocation*)[self alloc] initWithDefaultValue:defaultValue];
}

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithDefaultValue:(CLLocation*)defaultValue {
    self = [super init];
    if(self != nil) {
        _defaultValue = defaultValue;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)pack:(id)packValue {
    if([packValue isKindOfClass:CLLocation.class] == YES) {
        CLLocation* location = packValue;
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

- (id)unpack:(id)packValue {
    if([packValue isKindOfClass:NSDictionary.class] == YES) {
        NSNumber* longitude = [packValue glb_numberForKey:@"lo" orDefault:nil];
        NSNumber* latitude = [packValue glb_numberForKey:@"la" orDefault:nil];
        NSNumber* altitude = [packValue glb_numberForKey:@"al" orDefault:nil];
        NSNumber* horizontalAccuracy = [packValue glb_numberForKey:@"ha" orDefault:nil];
        NSNumber* verticalAccuracy = [packValue glb_numberForKey:@"va" orDefault:nil];
#ifdef GLB_TARGET_IOS
        NSNumber* course = [packValue glb_numberForKey:@"co" orDefault:nil];
        NSNumber* speed = [packValue glb_numberForKey:@"sp" orDefault:nil];
#endif
        NSNumber* timestamp = [packValue glb_numberForKey:@"ts" orDefault:nil];
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

+ (instancetype)packWithDefaultValue:(UIColor*)defaultValue {
    return [(GLBModelPackColor*)[self alloc] initWithDefaultValue:defaultValue];
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

#pragma mark - GLBModelPack

- (id)pack:(id)packValue {
    if([packValue isKindOfClass:UIColor.class] == YES) {
        if((_defaultValue == nil) || ([packValue isEqual:_defaultValue] == NO)) {
            return [packValue glb_stringValue];
        }
    }
    return nil;
}

- (id)unpack:(id)packValue {
    if([packValue isKindOfClass:NSString.class] == YES) {
        return [UIColor glb_colorWithString:packValue];
    }
    return _defaultValue;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBModelPackModel

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(init)

#pragma mark - Init / Free

+ (instancetype)packWithModel:(Class)model {
    return [[self alloc] initWithModel:model];
}

- (instancetype)initWithModel:(Class)model {
    self = [super init];
    if(self != nil) {
        _model = model;
    }
    return self;
}

#pragma mark - GLBModelPack

- (id)pack:(id)packValue {
    if([packValue isKindOfClass:_model] == YES) {
        NSDictionary* pack = [packValue pack];
        if(pack.count > 0) {
            return pack;
        }
    }
    return nil;
}

- (id)unpack:(id)packValue {
    if([packValue isKindOfClass:NSDictionary.class] == YES) {
        return [_model modelWithPack:packValue];
    }
    return nil;
}

@end

/*--------------------------------------------------*/
