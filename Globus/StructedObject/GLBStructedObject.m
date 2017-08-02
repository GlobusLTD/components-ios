/*--------------------------------------------------*/

#import "GLBStructedObject.h"

/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"
#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

static NSString* GLBStructedObjectPathSeparator = @".";
static NSString* GLBStructedObjectPathIndexPattern = @"^\\[\\d+\\]$";

/*--------------------------------------------------*/

@interface GLBStructedObject () {
    NSRegularExpression* _indexRegexp;
}

@end

/*--------------------------------------------------*/

@implementation GLBStructedObject

#pragma mark - Init / Free

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithRootObject:(id)rootObject {
    self = [super init];
    if(self != nil) {
        _rootObject = rootObject;
    }
    return self;
}

#pragma mark - Property

- (BOOL)isRootObjectDictionary {
    return [_rootObject glb_isDictionary];
}

- (BOOL)isRootObjectArray {
    return ([_rootObject glb_isArray] == YES) || ([_rootObject glb_isOrderedSet] == YES);
}

#pragma mark - Setters

- (BOOL)setObject:(id)object forPath:(NSString*)path {
    BOOL successful = NO;
    if(path.length > 0) {
        if([path containsString:GLBStructedObjectPathSeparator] == YES) {
            NSArray< NSString* >* paths = [self _paths:path];
            if(paths != nil) {
                [self _setPaths:paths index:0 object:object successful:&successful];
            }
        } else {
            [self _setPaths:@[ path ] index:0 object:object successful:&successful];
        }
    } else {
        _rootObject = object;
    }
    return successful;
}

- (BOOL)setRootDictionary:(NSDictionary*)rootDictionary {
    _rootObject = rootDictionary;
    return YES;
}

- (BOOL)setDictionary:(NSDictionary*)dictionary forPath:(NSString*)path {
    return [self setObject:dictionary forPath:path];
}

- (BOOL)setRootArray:(NSArray*)rootArray {
    _rootObject = rootArray;
    return YES;
}

- (BOOL)setArray:(NSArray*)array forPath:(NSString*)path {
    return [self setObject:array forPath:path];
}

- (BOOL)setBoolean:(BOOL)value forPath:(NSString*)path {
    return [self setObject:[self objectFromBoolean:value] forPath:path];
}

- (BOOL)setInt:(NSInteger)value forPath:(NSString*)path {
    return [self setObject:[self objectFromInt:value] forPath:path];
}

- (BOOL)setUInt:(NSUInteger)value forPath:(NSString*)path {
    return [self setObject:[self objectFromUInt:value] forPath:path];
}

- (BOOL)setFloat:(float)value forPath:(NSString*)path {
    return [self setObject:[self objectFromFloat:value] forPath:path];
}

- (BOOL)setDouble:(double)value forPath:(NSString*)path {
    return [self setObject:[self objectFromDouble:value] forPath:path];
}

- (BOOL)setNumber:(NSNumber*)number forPath:(NSString*)path {
    return [self setObject:[self objectFromNumber:number] forPath:path];
}

- (BOOL)setDecimalNumber:(NSDecimalNumber*)decimalNumber forPath:(NSString*)path {
    return [self setObject:[self objectFromDecimalNumber:decimalNumber] forPath:path];
}

- (BOOL)setString:(NSString*)string forPath:(NSString*)path {
    return [self setObject:[self objectFromString:string] forPath:path];
}

- (BOOL)setUrl:(NSURL*)url forPath:(NSString*)path {
    return [self setObject:[self objectFromUrl:url] forPath:path];
}

#pragma mark - Getters

- (id)objectAtPath:(NSString*)path {
    id result = nil;
    if(path.length > 0) {
        if([path containsString:GLBStructedObjectPathSeparator] == YES) {
            NSArray< NSString* >* paths = [self _paths:path];
            if(paths != nil) {
                result = [self _get:_rootObject paths:paths index:0];
            }
        } else {
            result = [self _get:_rootObject paths:@[ path ] index:0];
        }
    } else {
        result = _rootObject;
    }
    return result;
}

- (NSDictionary*)rootDictionary {
    if([_rootObject glb_isDictionary] == YES) {
        return _rootObject;
    }
    return nil;
}

- (NSDictionary*)dictionaryAtPath:(NSString*)path {
    id object = [self objectAtPath:path];
    if([object glb_isDictionary] == YES) {
        return object;
    }
    return nil;
}

- (NSArray*)rootArray {
    if(([_rootObject glb_isArray] == YES) || ([_rootObject glb_isOrderedSet] == YES)) {
        return _rootObject;
    }
    return nil;
}

- (NSArray*)arrayAtPath:(NSString*)path {
    id object = [self objectAtPath:path];
    if(([object glb_isArray] == YES) || ([object glb_isOrderedSet] == YES)) {
        return object;
    }
    return nil;
}

- (BOOL)booleanAtPath:(NSString*)path {
    id object = [self objectAtPath:path];
    if(object == nil) {
        [NSException raise:GLBStructedObjectException format:@"Invalid cast Bool from %@", object];
    }
    return [self booleanFromObject:object];
}

- (BOOL)booleanAtPath:(NSString*)path or:(BOOL)or {
    id object = [self objectAtPath:path];
    return [self booleanFromObject:object or:or];
}

- (NSInteger)intAtPath:(NSString*)path {
    id object = [self objectAtPath:path];
    if(object == nil) {
        [NSException raise:GLBStructedObjectException format:@"Invalid cast Int from %@", object];
    }
    return [self intFromObject:object];
}

- (NSInteger)intAtPath:(NSString*)path or:(NSInteger)or {
    id object = [self objectAtPath:path];
    return [self intFromObject:object or:or];
}

- (NSUInteger)uintAtPath:(NSString*)path {
    id object = [self objectAtPath:path];
    if(object == nil) {
        [NSException raise:GLBStructedObjectException format:@"Invalid cast UInt from %@", object];
    }
    return [self uintFromObject:object];
}

- (NSUInteger)uintAtPath:(NSString*)path or:(NSUInteger)or {
    id object = [self objectAtPath:path];
    return [self uintFromObject:object or:or];
}

- (float)floatAtPath:(NSString*)path {
    id object = [self objectAtPath:path];
    if(object == nil) {
        [NSException raise:GLBStructedObjectException format:@"Invalid cast Float from %@", object];
    }
    return [self floatFromObject:object];
}

- (float)floatAtPath:(NSString*)path or:(float)or {
    id object = [self objectAtPath:path];
    return [self floatFromObject:object or:or];
}

- (double)doubleAtPath:(NSString*)path {
    id object = [self objectAtPath:path];
    if(object == nil) {
        [NSException raise:GLBStructedObjectException format:@"Invalid cast Double from %@", object];
    }
    return [self doubleFromObject:object];
}

- (double)doubleAtPath:(NSString*)path or:(double)or {
    id object = [self objectAtPath:path];
    return [self doubleFromObject:object or:or];
}

- (NSNumber*)numberAtPath:(NSString*)path {
    id object = [self objectAtPath:path];
    if(object == nil) {
        [NSException raise:GLBStructedObjectException format:@"Invalid cast Number from %@", object];
    }
    return [self numberFromObject:object];
}

- (NSNumber*)numberAtPath:(NSString*)path or:(NSNumber*)or {
    id object = [self objectAtPath:path];
    return [self numberFromObject:object or:or];
}

- (NSDecimalNumber*)decimalNumberAtPath:(NSString*)path {
    id object = [self objectAtPath:path];
    if(object == nil) {
        [NSException raise:GLBStructedObjectException format:@"Invalid cast DecimalNumber from %@", object];
    }
    return [self decimalNumberFromObject:object];
}

- (NSDecimalNumber*)decimalNumberAtPath:(NSString*)path or:(NSDecimalNumber*)or {
    id object = [self objectAtPath:path];
    return [self decimalNumberFromObject:object or:or];
}

- (NSString*)stringAtPath:(NSString*)path {
    id object = [self objectAtPath:path];
    if(object == nil) {
        [NSException raise:GLBStructedObjectException format:@"Invalid cast String from %@", object];
    }
    return [self stringFromObject:object];
}

- (NSString*)stringAtPath:(NSString*)path or:(NSString*)or {
    id object = [self objectAtPath:path];
    return [self stringFromObject:object or:or];
}

- (NSURL*)urlAtPath:(NSString*)path {
    id object = [self stringAtPath:path];
    if(object == nil) {
        [NSException raise:GLBStructedObjectException format:@"Invalid cast Url from %@", object];
    }
    return [self urlFromObject:object];
}

- (NSURL*)urlAtPath:(NSString*)path or:(NSURL*)or {
    id object = [self stringAtPath:path or:nil];
    return [self urlFromObject:object or:or];
}

#pragma mark - To object

- (id)objectFromBoolean:(BOOL)value {
    return @(value);
}

- (id)objectFromInt:(NSInteger)value {
    return @(value);
}

- (id)objectFromUInt:(NSUInteger)value {
    return @(value);
}

- (id)objectFromFloat:(float)value {
    return @(value);
}

- (id)objectFromDouble:(double)value {
    return @(value);
}

- (id)objectFromNumber:(NSNumber*)number {
    if(number == nil) {
        return nil;
    }
    return number;
}

- (id)objectFromDecimalNumber:(NSDecimalNumber*)decimalNumber {
    if(decimalNumber == nil) {
        return nil;
    }
    return decimalNumber;
}

- (id)objectFromString:(NSString*)string {
    if(string == nil) {
        return nil;
    }
    return string;
}

- (id)objectFromUrl:(NSURL*)url {
    if(url == nil) {
        return nil;
    }
    return url.absoluteString;
}

#pragma mark - From object

- (BOOL)booleanFromObject:(id)object {
    BOOL boolean = [self booleanFromObject:object or:((BOOL)(-1))];
    if(boolean == ((BOOL)(-1))) {
        [NSException raise:GLBStructedObjectException format:@"Invalid cast Bool from %@", object];
    }
    return boolean;
}

- (BOOL)booleanFromObject:(id)object or:(BOOL)or {
    if([object glb_isString] == YES) {
        return [object glb_bool];
    } else if([object glb_isNumber] == YES) {
        return [object boolValue];
    }
    return or;
}

- (NSInteger)intFromObject:(id)object {
    NSNumber* number = [self numberFromObject:object];
    if(number == nil) {
        [NSException raise:GLBStructedObjectException format:@"Invalid cast Int from %@", object];
    }
    return [number integerValue];
}

- (NSInteger)intFromObject:(id)object or:(NSInteger)or {
    return [[self numberFromObject:object or:@(or)] integerValue];
}

- (NSUInteger)uintFromObject:(id)object {
    NSNumber* number = [self numberFromObject:object];
    if(number == nil) {
        [NSException raise:GLBStructedObjectException format:@"Invalid cast UInt from %@", object];
    }
    return [number unsignedIntegerValue];
}

- (NSUInteger)uintFromObject:(id)object or:(NSUInteger)or {
    return [[self numberFromObject:object or:@(or)] unsignedIntegerValue];
}

- (float)floatFromObject:(id)object {
    NSNumber* number = [self numberFromObject:object];
    if(number == nil) {
        [NSException raise:GLBStructedObjectException format:@"Invalid cast Float from %@", object];
    }
    return [number floatValue];
}

- (float)floatFromObject:(id)object or:(float)or {
    return [[self numberFromObject:object or:@(or)] floatValue];
}

- (double)doubleFromObject:(id)object {
    NSNumber* number = [self numberFromObject:object];
    if(number == nil) {
        [NSException raise:GLBStructedObjectException format:@"Invalid cast Double from %@", object];
    }
    return [number doubleValue];
}

- (double)doubleFromObject:(id)object or:(double)or {
    return [[self numberFromObject:object or:@(or)] doubleValue];
}

- (NSNumber*)numberFromObject:(id)object {
    NSNumber* number = [self numberFromObject:object or:nil];
    if(number == nil) {
        [NSException raise:GLBStructedObjectException format:@"Invalid cast Number from %@", object];
    }
    return number;
}

- (NSNumber*)numberFromObject:(id)object or:(NSNumber*)or {
    NSNumber* number = nil;
    if([object glb_isNumber] == YES) {
        number = object;
    } else if([object glb_isString] == YES) {
        number = [object glb_number];
    }
    if(number == nil) {
        number = or;
    }
    return number;
}

- (NSDecimalNumber*)decimalNumberFromObject:(id)object {
    NSDecimalNumber* decimalNumber = [self decimalNumberFromObject:object or:nil];
    if(decimalNumber == nil) {
        [NSException raise:GLBStructedObjectException format:@"Invalid cast DecimalNumber from %@", object];
    }
    return decimalNumber;
}

- (NSDecimalNumber*)decimalNumberFromObject:(id)object or:(NSDecimalNumber*)or {
    NSDecimalNumber* number = nil;
    if([object glb_isNumber] == YES) {
        number = [NSDecimalNumber decimalNumberWithString:[object stringValue]];
    } else if([object glb_isDecimalNumber] == YES) {
        number = object;
    } else if([object glb_isString] == YES) {
        number = [object glb_decimalNumber];
    }
    if(number == nil) {
        number = or;
    }
    return number;
}

- (NSString*)stringFromObject:(id)object {
    NSString* string = [self stringFromObject:object or:nil];
    if(string == nil) {
        [NSException raise:GLBStructedObjectException format:@"Invalid cast String from %@", object];
    }
    return string;
}

- (NSString*)stringFromObject:(id)object or:(NSString*)or {
    NSString* string = nil;
    if([object glb_isString] == YES) {
        string = object;
    } else if([object glb_isNumber] == YES) {
        string = [object stringValue];
    }
    if(string == nil) {
        string = or;
    }
    return string;
}

- (NSURL*)urlFromObject:(id)object {
    NSURL* url = [self urlFromObject:object or:nil];
    if(url == nil) {
        [NSException raise:GLBStructedObjectException format:@"Invalid cast Url from %@", object];
    }
    return url;
}

- (NSURL*)urlFromObject:(id)object or:(NSURL*)or {
    NSURL* url = nil;
    if([object glb_isString] == YES) {
        url = [NSURL URLWithString:object];
    }
    if(url == nil) {
        url = or;
    }
    return url;
}

#pragma mark - Internal

- (NSArray*)_paths:(NSString*)path {
    NSArray< NSString* >* subPaths = [path componentsSeparatedByString:GLBStructedObjectPathSeparator];
    NSMutableArray* result = [NSMutableArray arrayWithCapacity:subPaths.count];
    for(NSString* subPath in subPaths) {
        NSNumber* asIndex = nil;
        if([self _path:subPath index:&asIndex] == YES) {
            [result addObject:asIndex];
        } else {
            [result addObject:subPath];
        }
    }
    return result;
}

- (BOOL)_path:(NSString*)path index:(NSNumber**)index {
    BOOL result = NO;
    if(_indexRegexp == nil) {
        _indexRegexp = [NSRegularExpression regularExpressionWithPattern:GLBStructedObjectPathIndexPattern options:NSRegularExpressionAnchorsMatchLines error:nil];
    }
    NSUInteger pathLength = path.length;
    NSRange range = [_indexRegexp rangeOfFirstMatchInString:path options:(NSMatchingOptions)0 range:NSMakeRange(0, pathLength)];
    if((range.location != NSNotFound) && (range.length > 0)) {
        NSNumber* number = nil;
        if(range.length > 0) {
            NSString* string = [path substringWithRange:NSMakeRange(1, pathLength - 2)];
            number = string.glb_number;
        }
        if(number != nil) {
            *index = number;
        }
        result = YES;
    }
    return result;
}

- (void)_setPaths:(NSArray*)paths index:(NSUInteger)index object:(id)object successful:(BOOL*)successful {
    if(_rootObject == nil) {
        id path = paths[index];
        if([path glb_isNumber] == YES) {
            _rootObject = [NSMutableArray array];
        } else {
            _rootObject = [NSMutableDictionary dictionary];
        }
    }
    id mutating = [self _set:_rootObject paths:paths index:index object:object successful:successful];
    if(mutating != nil) {
        _rootObject = mutating;
    }
}

- (id)_set:(id)json paths:(NSArray*)paths index:(NSUInteger)index object:(id)object successful:(BOOL*)successful {
    BOOL isDictionary = [json glb_isDictionary];
    BOOL isArray = (isDictionary == NO) ? ([json glb_isArray] == YES) : NO;
    BOOL isOrderedSet = (isArray == NO) ? ([json glb_isOrderedSet] == YES) : NO;
    BOOL isCollection = ((isArray == YES) || (isOrderedSet == YES));
    BOOL isLastPath = (index == paths.count - 1);
    id path = paths[index];
    id mutating = nil;
    if(isLastPath == YES) {
        if(isDictionary == YES) {
            if([json glb_isMutableDictionary] == NO) {
                mutating = [NSMutableDictionary dictionaryWithDictionary:json];
                json = mutating;
            }
            if(object != nil) {
                [json setObject:object forKey:path];
            } else {
                id exist = [json objectForKey:path];
                if(exist != nil) {
                    [json removeObjectForKey:path];
                }
            }
            *successful = YES;
        } else if(isCollection == YES) {
            if((isArray == YES) && ([json glb_isMutableArray] == NO)) {
                mutating = [NSMutableArray arrayWithArray:json];
                json = mutating;
            } else if((isOrderedSet == YES) && ([json glb_isMutableOrderedSet] == NO)) {
                mutating = [NSMutableOrderedSet orderedSetWithOrderedSet:json];
                json = mutating;
            }
            NSUInteger arrayCount = [json count];
            NSUInteger pathAsIndex = [path unsignedIntegerValue];
            if(object != nil) {
                if(pathAsIndex < arrayCount) {
                    [json setObject:object atIndex:pathAsIndex];
                } else {
                    NSUInteger fc = pathAsIndex - arrayCount;
                    for(NSUInteger fi = 0; fi < fc; fi++) {
                        [json addObject:[NSNull null]];
                    }
                }
            } else {
                if(pathAsIndex < arrayCount) {
                    [json removeObjectAtIndex:pathAsIndex];
                }
            }
            *successful = YES;
        }
    } else {
        id exist = nil;
        NSUInteger pathAsIndex = NSNotFound;
        if(isDictionary == YES) {
            exist = [json objectForKey:path];
            if(exist == nil) {
                id nextPath = paths[index + 1];
                if([nextPath glb_isNumber] == YES) {
                    exist = [NSMutableArray array];
                } else {
                    exist = [NSMutableDictionary dictionary];
                }
                [json setValue:exist forKey:path];
            }
        } else if(isCollection == YES) {
            if([path glb_isNumber] == YES) {
                NSUInteger arrayCount = [json count];
                pathAsIndex = [path unsignedIntegerValue];
                if(pathAsIndex < arrayCount) {
                    exist = [json objectAtIndex:pathAsIndex];
                    if([exist glb_isNull] == YES) {
                        id nextPath = paths[index + 1];
                        if([nextPath glb_isNumber] == YES) {
                            exist = [NSMutableArray array];
                        } else {
                            exist = [NSMutableDictionary dictionary];
                        }
                        [json setObject:exist atIndex:pathAsIndex];
                    }
                } else {
                    id nextPath = paths[index + 1];
                    if([nextPath glb_isNumber] == YES) {
                        exist = [NSMutableArray array];
                    } else {
                        exist = [NSMutableDictionary dictionary];
                    }
                    NSUInteger fc = pathAsIndex - arrayCount;
                    for(NSUInteger fi = 0; fi < fc; fi++) {
                        [json addObject:[NSNull null]];
                    }
                    [json addObject:exist];
                }
            }
        }
        if(exist != nil) {
            id nextMutating = [self _set:exist paths:paths index:index + 1 object:object successful:successful];
            if(nextMutating != nil) {
                if(isDictionary == YES) {
                    if([json glb_isMutableDictionary] == NO) {
                        mutating = [NSMutableDictionary dictionaryWithDictionary:json];
                        json = mutating;
                    }
                    [json setValue:nextMutating forKey:path];
                } else if(isCollection == YES) {
                    if(pathAsIndex != NSNotFound) {
                        if((isArray == YES) && ([json glb_isMutableArray] == NO)) {
                            mutating = [NSMutableArray arrayWithArray:json];
                            json = mutating;
                        } else if((isOrderedSet == YES) && ([json glb_isMutableOrderedSet] == NO)) {
                            mutating = [NSMutableOrderedSet orderedSetWithOrderedSet:json];
                            json = mutating;
                        }
                        [json setObject:nextMutating atIndex:pathAsIndex];
                    } else {
                        [NSException raise:@"Invalid json" format:@"Please check build code"];
                    }
                }
            }
        }
    }
    return mutating;
}

- (id)_get:(id)json paths:(NSArray*)paths index:(NSUInteger)index {
    id result = nil;
    BOOL isLastPath = (index == paths.count - 1);
    id path = paths[index];
    if([json glb_isDictionary] == YES) {
        result = [json objectForKey:path];
        if((result != nil) && (isLastPath == NO)) {
            result = [self _get:result paths:paths index:index + 1];
        }
    } else if(([json glb_isArray] == YES) || ([json glb_isOrderedSet] == YES)) {
        if([path glb_isNumber] == YES) {
            NSUInteger pathAsIndex = [path unsignedIntegerValue];
            result = [json objectAtIndex:pathAsIndex];
            if((result != nil) && (isLastPath == NO)) {
                result = [self _get:result paths:paths index:index + 1];
            }
        }
    }
    return result;
}

@end

/*--------------------------------------------------*/

NSExceptionName GLBStructedObjectException = @"GLBStructedObjectException";

/*--------------------------------------------------*/
