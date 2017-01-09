/*--------------------------------------------------*/

#import "GLBStructedObject.h"

/*--------------------------------------------------*/

@interface GLBJson : GLBStructedObject

+ (instancetype _Nonnull)jsonWithRootObject:(id _Nullable)rootObject NS_SWIFT_UNAVAILABLE("Use init(rootObject:)");
+ (instancetype _Nonnull)jsonWithData:(NSData* _Nonnull)data NS_SWIFT_UNAVAILABLE("Use init(data:)");
+ (instancetype _Nonnull)jsonWithString:(NSString* _Nonnull)string NS_SWIFT_UNAVAILABLE("Use init(string:)");
+ (instancetype _Nonnull)jsonWithString:(NSString* _Nonnull)string encoding:(NSStringEncoding)encoding NS_SWIFT_UNAVAILABLE("Use init(string:encoding:)");

- (instancetype _Nonnull)init NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithRootObject:(id _Nullable)rootObject NS_SWIFT_NAME(init(rootObject:)) NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithData:(NSData* _Nonnull)data NS_SWIFT_NAME(init(data:));
- (instancetype _Nonnull)initWithString:(NSString* _Nonnull)string NS_SWIFT_NAME(init(string:));
- (instancetype _Nonnull)initWithString:(NSString* _Nonnull)string encoding:(NSStringEncoding)encoding NS_SWIFT_NAME(init(string:encoding:));

- (NSData* _Nullable)toData NS_SWIFT_NAME(toData());
- (NSString* _Nullable)toString NS_SWIFT_NAME(toString());
- (NSString* _Nullable)toStringEncoding:(NSStringEncoding)encoding NS_SWIFT_NAME(toString(encoding:));

#pragma mark - Setters

- (BOOL)setDate:(NSDate* _Nullable)date
        forPath:(NSString* _Nonnull)path NS_SWIFT_NAME(set(date:forPath:));

- (BOOL)setDate:(NSDate* _Nullable)date
         format:(NSString* _Nonnull)format
        forPath:(NSString* _Nonnull)path NS_SWIFT_NAME(set(date:format:forPath:));

- (BOOL)setValue:(id _Nonnull)value
             map:(NSDictionary* _Nonnull)map
         forPath:(NSString* _Nonnull)path NS_SWIFT_NAME(set(value:map:forPath:));

- (BOOL)setColor:(UIColor* _Nullable)color
         forPath:(NSString* _Nonnull)path NS_SWIFT_NAME(set(color:forPath:));

#pragma mark - Getters

- (NSDate* _Nullable)dateAtPath:(NSString* _Nonnull)path
                             or:(NSDate* _Nullable)or NS_SWIFT_NAME(date(atPath:or:));

- (NSDate* _Nullable)dateAtPath:(NSString* _Nonnull)path
                        formats:(NSArray< NSString* >* _Nonnull)formats
                             or:(NSDate* _Nullable)or NS_SWIFT_NAME(date(atPath:formats:or:));

- (id _Nullable)valueAtPath:(NSString* _Nonnull)path
                        map:(NSDictionary* _Nonnull)map
                         or:(id _Nullable)or NS_SWIFT_NAME(value(atPath:map:or:));

- (UIColor* _Nullable)colorAtPath:(NSString* _Nonnull)path
                               or:(UIColor* _Nullable)or NS_SWIFT_NAME(color(atPath:or:));

#pragma mark - To object

- (id _Nullable)objectFromDate:(NSDate* _Nullable)date NS_SWIFT_NAME(object(date:));

- (id _Nullable)objectFromDate:(NSDate* _Nullable)date
                        format:(NSString* _Nonnull)format NS_SWIFT_NAME(object(date:format:));

- (id _Nullable)objectFromColor:(UIColor* _Nullable)color NS_SWIFT_NAME(object(color:));

#pragma mark - From object

- (NSDate* _Nullable)dateFromObject:(id _Nullable)object
                                 or:(NSDate* _Nullable)or NS_SWIFT_NAME(date(from:or:));

- (NSDate* _Nullable)dateFromObject:(id _Nullable)object
                            formats:(NSArray< NSString* >* _Nonnull)formats
                                 or:(NSDate* _Nullable)or NS_SWIFT_NAME(date(from:formats:or:));

- (UIColor* _Nullable)colorFromObject:(id _Nullable)object
                                   or:(UIColor* _Nullable)or NS_SWIFT_NAME(color(from:or:));

@end

/*--------------------------------------------------*/
