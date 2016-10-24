/*--------------------------------------------------*/

#import "NSDictionary+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSDictionary (GLB_NS)

- (BOOL)glb_boolForKey:(id)key orDefault:(BOOL)defaultValue {
    NSNumber* number = [self glb_numberForKey:key orDefault:nil];
    if(number != nil) {
        return number.boolValue;
    }
    return defaultValue;
}

- (NSInteger)glb_integerForKey:(id)key orDefault:(NSInteger)defaultValue {
    NSNumber* number = [self glb_numberForKey:key orDefault:nil];
    if(number != nil) {
        return number.integerValue;
    }
    return defaultValue;
}

- (NSUInteger)glb_unsignedIntegerForKey:(id)key orDefault:(NSUInteger)defaultValue {
    NSNumber* number = [self glb_numberForKey:key orDefault:nil];
    if(number != nil) {
        return number.unsignedIntegerValue;
    }
    return defaultValue;
}

- (float)glb_floatForKey:(id)key orDefault:(float)defaultValue {
    NSNumber* number = [self glb_numberForKey:key orDefault:nil];
    if(number != nil) {
        return number.floatValue;
    }
    return defaultValue;
}

- (double)glb_doubleForKey:(id)key orDefault:(double)defaultValue {
    NSNumber* number = [self glb_numberForKey:key orDefault:nil];
    if(number != nil) {
        return number.doubleValue;
    }
    return defaultValue;
}

- (NSNumber*)glb_numberForKey:(id)key orDefault:(NSNumber*)defaultValue {
    id value = self[key];
    if([value isKindOfClass:NSNumber.class] == YES) {
        return value;
    } else if([value isKindOfClass:NSString.class] == YES) {
        return [value glb_number];
    }
    return defaultValue;
}

- (NSString*)glb_stringForKey:(id)key orDefault:(NSString*)defaultValue {
    id value = self[key];
    if([value isKindOfClass:NSString.class] == YES) {
        return value;
    } else if([value isKindOfClass:NSNumber.class] == YES) {
        return [value stringValue];
    }
    return defaultValue;
}

- (NSArray*)glb_arrayForKey:(id)key orDefault:(NSArray*)defaultValue {
    id value = self[key];
    if([value isKindOfClass:NSArray.class] == YES) {
        return value;
    }
    return defaultValue;
}

- (NSDictionary*)glb_dictionaryForKey:(id)key orDefault:(NSDictionary*)defaultValue {
    id value = self[key];
    if([value isKindOfClass:NSDictionary.class] == YES) {
        return value;
    }
    return defaultValue;
}

- (NSDate*)glb_dateForKey:(id)key orDefault:(NSDate*)defaultValue {
    id value = self[key];
    if([value isKindOfClass:NSDate.class] == YES) {
        return value;
    }
    return defaultValue;
}

- (NSData*)glb_dataForKey:(id)key orDefault:(NSData*)defaultValue {
    id value = self[key];
    if([value isKindOfClass:NSData.class] == YES) {
        return value;
    }
    return defaultValue;
}

- (id)glb_objectForKey:(id)key orDefault:(id)defaultValue {
    id value = self[key];
    if(value != nil) {
        return value;
    }
    return defaultValue;
}

- (NSString*)glb_stringFromQueryComponents {
    NSString* result = nil;
    for(NSString* dictKey in self.allKeys) {
        NSString* key = [dictKey glb_stringByEncodingURLFormat];
        NSArray* allValues = self[key];
        if([allValues isKindOfClass:NSArray.class]) {
            for(NSString* dictValue in allValues) {
                NSString* value = [dictValue.description glb_stringByEncodingURLFormat];
                if(result == nil) {
                    result = [NSString stringWithFormat:@"%@=%@", key, value];
                } else {
                    result = [result stringByAppendingFormat:@"&%@=%@", key, value];
                }
            }
        } else {
            NSString* value = [allValues.description glb_stringByEncodingURLFormat];
            if(result == nil) {
                result = [NSString stringWithFormat:@"%@=%@", key, value];
            } else {
                result = [result stringByAppendingFormat:@"&%@=%@", key, value];
            }
        }
    }
    return result;
}

- (void)glb_each:(void(^)(id key, id value))block {
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
        block(key, obj);
    }];
}

- (void)glb_eachWithIndex:(void(^)(id key, id value, NSUInteger index))block {
    __block NSUInteger index = 0;
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
        block(key, obj, index);
        index++;
    }];
}

- (void)glb_eachKey:(void(^)(id key))block {
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
        block(key);
    }];
}

- (void)glb_eachKeyWithIndex:(void(^)(id key, NSUInteger index))block {
    __block NSUInteger index = 0;
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
        block(key, index);
        index++;
    }];
}

- (void)glb_eachValue:(void(^)(id value))block {
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
        block(obj);
    }];
}

- (void)glb_eachValueWithIndex:(void(^)(id value, NSUInteger index))block {
    __block NSUInteger index = 0;
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
        block(obj, index);
        index++;
    }];
}

- (NSArray*)glb_map:(id(^)(id key, id value))block {
    NSMutableArray* array = [NSMutableArray array];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
        id object = block(key, obj);
        if(object != nil) {
            [array addObject:object];
        }
    }];
    return array;
}

- (id)glb_findObject:(BOOL(^)(id key, id value))block {
    __block id result = nil;
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        if(block(key, value) == YES) {
            result = value;
            *stop = YES;
        }
    }];
    return result;
}

- (id)glb_findObjectByKey:(BOOL(^)(id key))block {
    __block id result = nil;
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        if(block(key) == YES) {
            result = value;
            *stop = YES;
        }
    }];
    return result;
}

- (BOOL)glb_hasKey:(id)key {
    return (self[key] != nil);
}

@end

/*--------------------------------------------------*/
