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
        return [NSJSONSerialization dataWithJSONObject:self.rootObject options:0 error:nil];
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

- (NSDate*)dateAtPath:(NSString*)path or:(NSDate*)or {
    id object = [self objectAtPath:path];
    return [self dateFromObject:object or:or];
}

- (NSDate*)dateAtPath:(NSString*)path formats:(NSArray< NSString* >*)formats or:(NSDate*)or {
    id object = [self objectAtPath:path];
    return [self dateFromObject:object formats:formats or:or];
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

- (NSDate*)dateFromObject:(id)object or:(NSDate*)or {
    if([object glb_isNumber] == YES) {
        NSDate* date = [NSDate glb_dateWithUnixTimestamp:[object unsignedLongValue]];
        if(date != nil) {
            return date;
        }
    }
    return or;
}

- (NSDate*)dateFromObject:(id)object formats:(NSArray< NSString* > *)formats or:(NSDate*)or {
    if([object glb_isString] == YES) {
        NSDateFormatter* dateFormatter = [NSDateFormatter new];
        for(NSString* format in formats) {
            dateFormatter.dateFormat = format;
            NSDate* date = [dateFormatter dateFromString:object];
            if(date != nil) {
                return date;
            }
        }
        NSNumber* ts = [object glb_number];
        if(ts != nil) {
            NSDate* date = [NSDate glb_dateWithUnixTimestamp:[ts unsignedLongValue]];
            if(date != nil) {
                return date;
            }
        }
    } else if([object glb_isNumber] == YES) {
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
