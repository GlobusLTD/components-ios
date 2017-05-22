/*--------------------------------------------------*/

#import "GLBJson.h"

/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"
#import "NSNumber+GLBNS.h"
#import "NSString+GLBNS.h"
#import "NSDate+GLBNS.h"
#import "UIColor+GLBUI.h"

/*--------------------------------------------------*/

static NSString* GLBJsonDefaultDateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";

/*--------------------------------------------------*/

@implementation GLBJson

#pragma mark - Init / Free

+ (instancetype)jsonWithRootObject:(id)rootObject {
    return [[self alloc] initWithRootObject:rootObject];
}

+ (instancetype)jsonWithData:(NSData*)data {
    return [[self alloc] initWithData:data];
}

+ (instancetype)jsonWithString:(NSString*)string {
    return [[self alloc] initWithString:string];
}

+ (instancetype)jsonWithString:(NSString*)string encoding:(NSStringEncoding)encoding {
    return [[self alloc] initWithString:string encoding:encoding];
}

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithRootObject:(id)rootObject {
    return [super initWithRootObject:rootObject];
}

- (instancetype)initWithData:(NSData*)data {
    id rootObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return [self initWithRootObject:rootObject];
}

- (instancetype)initWithString:(NSString*)string {
    return [self initWithString:string encoding:NSUTF8StringEncoding];
}

- (instancetype)initWithString:(NSString*)string encoding:(NSStringEncoding)encoding {
    NSData* data = [string dataUsingEncoding:encoding];
    return [self initWithData:data];
}

#pragma mark - Public

- (NSData*)toData {
    if(self.rootObject != nil) {
        return [NSJSONSerialization dataWithJSONObject:self.rootObject options:(NSJSONWritingOptions)0 error:nil];
    }
    return nil;
}

- (NSString*)toString {
    return [self toStringEncoding:NSUTF8StringEncoding];
}

- (NSString*)toStringEncoding:(NSStringEncoding)encoding {
    NSData* data = [self toData];
    if(data != nil) {
        return [NSString glb_stringWithData:data encoding:encoding];
    }
    return nil;
}

#pragma mark - Setters

- (BOOL)setDate:(NSDate*)date forPath:(NSString*)path {
    return [self setObject:[self objectFromDate:date] forPath:path];
}

- (BOOL)setDate:(NSDate*)date format:(NSString*)format forPath:(NSString*)path {
    return [self setObject:[self objectFromDate:date format:format] forPath:path];
}

- (BOOL)setValue:(id)value map:(NSDictionary*)map forPath:(NSString*)path {
    id object = map[value];
    return [self setObject:object forPath:path];
}

- (BOOL)setColor:(UIColor*)color forPath:(NSString*)path {
    return [self setObject:[self objectFromColor:color] forPath:path];
}

#pragma mark - Getters

- (NSDate*)dateAtPath:(NSString*)path {
    id object = [self objectAtPath:path];
    if(object == nil) {
        [NSException raise:GLBJsonException format:@"Invalid cast Date from %@", object];
    }
    return [self dateFromObject:object];
}

- (NSDate*)dateAtPath:(NSString*)path or:(NSDate*)or {
    id object = [self objectAtPath:path];
    return [self dateFromObject:object or:or];
}

- (NSDate*)dateAtPath:(NSString*)path formats:(NSArray< NSString* >*)formats {
    id object = [self objectAtPath:path];
    if(object == nil) {
        [NSException raise:GLBJsonException format:@"Invalid cast Date from %@", object];
    }
    return [self dateFromObject:object formats:formats];
}

- (NSDate*)dateAtPath:(NSString*)path formats:(NSArray< NSString* >*)formats or:(NSDate*)or {
    id object = [self objectAtPath:path];
    return [self dateFromObject:object formats:formats or:or];
}

- (id)valueAtPath:(NSString*)path map:(NSDictionary*)map {
    id object = [self objectAtPath:path];
    if(object == nil) {
        [NSException raise:GLBJsonException format:@"Invalid cast Value from %@", object];
    }
    id result = map[object];
    if(result == nil) {
        [NSException raise:GLBJsonException format:@"Invalid cast Value from %@", object];
    }
    return result;
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

- (UIColor*)colorAtPath:(NSString*)path {
    id object = [self objectAtPath:path];
    if(object == nil) {
        [NSException raise:GLBJsonException format:@"Invalid cast Color from %@", object];
    }
    return [self colorFromObject:object];
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

- (id)objectFromDate:(NSDate*)date format:(NSString*)format {
    if(date == nil) {
        return nil;
    }
    if(format == nil) {
        return @([date glb_unixTimestamp]);
    }
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = format;
    return [dateFormatter stringFromDate:date];
}

- (id)objectFromColor:(UIColor*)color {
    if(color == nil) {
        return nil;
    }
    return color.glb_stringValue;
}

#pragma mark - From object

- (NSDate*)dateFromObject:(id)object {
    NSDate* date = [self dateFromObject:object or:nil];
    if(date == nil) {
        [NSException raise:GLBJsonException format:@"Invalid cast Date from %@", object];
    }
    return date;
}

- (NSDate*)dateFromObject:(id)object or:(NSDate*)or {
    NSDate* date = nil;
    if([object glb_isNumber] == YES) {
        date = [NSDate glb_dateWithUnixTimestamp:[object unsignedLongValue]];
    } else if([object glb_isString] == YES) {
        NSNumber* number = [object glb_number];
        if(number != nil) {
            date = [NSDate glb_dateWithUnixTimestamp:[number unsignedLongValue]];
        }
    }
    if(date == nil) {
        date = or;
    }
    return date;
}

- (NSDate*)dateFromObject:(id)object formats:(NSArray< NSString* > *)formats {
    NSDate* date = [self dateFromObject:object formats:formats or:nil];
    if(date == nil) {
        [NSException raise:GLBJsonException format:@"Invalid cast Date from %@", object];
    }
    return date;
}

- (NSDate*)dateFromObject:(id)object formats:(NSArray< NSString* > *)formats or:(NSDate*)or {
    NSDate* date = nil;
    if([object glb_isString] == YES) {
        NSDateFormatter* dateFormatter = [NSDateFormatter new];
        for(NSString* format in formats) {
            dateFormatter.dateFormat = format;
            NSDate* varDate = [dateFormatter dateFromString:object];
            if(varDate != nil) {
                date = varDate;
                break;
            }
        }
        if(date == nil) {
            NSNumber* number = [object glb_number];
            if(number != nil) {
                date = [NSDate glb_dateWithUnixTimestamp:[number unsignedLongValue]];
            }
        }
    } else if([object glb_isNumber] == YES) {
        date = [NSDate glb_dateWithUnixTimestamp:[object unsignedLongValue]];
    }
    if(date == nil) {
        date = or;
    }
    return date;
}

- (UIColor*)colorFromObject:(id)object {
    UIColor* color = [self colorAtPath:object or:nil];
    if(color == nil) {
        [NSException raise:GLBJsonException format:@"Invalid cast Color from %@", object];
    }
    return color;
}

- (UIColor*)colorFromObject:(id)object or:(UIColor*)or {
    UIColor* color = nil;
    if([object glb_isString] == YES) {
        color = [UIColor glb_colorWithString:object];
    }
    if(color == nil) {
        color = or;
    }
    return or;
}

@end

/*--------------------------------------------------*/

NSExceptionName GLBJsonException = @"GLBJsonException";

/*--------------------------------------------------*/
