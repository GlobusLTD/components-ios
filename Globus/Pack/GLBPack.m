/*--------------------------------------------------*/

#import "GLBPack.h"

/*--------------------------------------------------*/

#import "NSObject+GLBPack.h"

/*--------------------------------------------------*/

#import "NSNumber+GLBNS.h"
#import "NSString+GLBNS.h"
#import "NSDate+GLBNS.h"
#import "UIColor+GLBUI.h"

/*--------------------------------------------------*/

@implementation GLBPack

#pragma mark - Init / Free

+ (instancetype)packWithRootObject:(id)rootObject {
    return [[self alloc] initWithRootObject:rootObject];
}

+ (instancetype)packWithData:(NSData*)data {
    return [[self alloc] initWithData:data];
}

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithRootObject:(id)rootObject {
    return [super initWithRootObject:rootObject];
}

- (instancetype)initWithData:(NSData*)data {
    id rootObject = [NSObject glb_unpackFromData:data];
    return [self initWithRootObject:rootObject];
}

#pragma mark - Public

- (NSData*)toData {
    if(self.rootObject != nil) {
        return [NSObject glb_packObject:self.rootObject];
    }
    return nil;
}

#pragma mark - Setters

- (BOOL)setDate:(NSDate*)date forPath:(NSString*)path {
    return [self setObject:[self objectFromDate:date] forPath:path];
}

- (BOOL)setValue:(id)value map:(NSDictionary*)map forPath:(NSString*)path {
    id object = map[value];
    return [self setObject:object forPath:path];
}

- (BOOL)setColor:(UIColor*)color forPath:(NSString*)path {
    return [self setObject:[self objectFromColor:color] forPath:path];
}

#pragma mark - Getters

- (NSDate*)dateAtPath:(NSString*)path or:(NSDate*)or {
    id object = [self objectAtPath:path];
    return [self dateFromObject:object or:or];
}

- (id)valueAtPath:(NSString*)path map:(NSDictionary*)map or:(id)or {
    id object = [self objectAtPath:path];
    if(object != nil) {
        id result = map[object];
        if(result != nil) {
            return result;
        }
    }
    return or;
}

- (UIColor*)colorAtPath:(NSString*)path or:(UIColor*)or {
    id object = [self objectAtPath:path];
    return [self colorFromObject:object or:or];
}

#pragma mark - To object

- (id)objectFromDate:(NSDate*)date {
    if(date == nil) {
        return nil;
    }
    return @([date glb_unixTimestamp]);
}

- (id)objectFromColor:(UIColor*)color {
    if(color == nil) {
        return nil;
    }
    return color.glb_stringValue;
}

#pragma mark - From object

- (NSDate*)dateFromObject:(id)object or:(NSDate*)or {
    if([object glb_isNumber] == YES) {
        NSDate* date = [NSDate glb_dateWithUnixTimestamp:[object unsignedLongValue]];
        if(date != nil) {
            return date;
        }
    }
    return or;
}

- (UIColor*)colorFromObject:(id)object or:(UIColor*)or {
    if([object glb_isString] == YES) {
        return [UIColor glb_colorWithString:object];
    }
    return or;
}

@end

/*--------------------------------------------------*/
