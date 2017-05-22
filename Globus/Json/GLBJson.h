/*--------------------------------------------------*/

#import "GLBStructedObject.h"

/*--------------------------------------------------*/

#include "GLBUI.h"

/*--------------------------------------------------*/

@interface GLBJson : GLBStructedObject

+ (nonnull instancetype)jsonWithRootObject:(nullable id)rootObject NS_SWIFT_UNAVAILABLE("Use init(rootObject:)");
+ (nonnull instancetype)jsonWithData:(nonnull NSData*)data NS_SWIFT_UNAVAILABLE("Use init(data:)");
+ (nonnull instancetype)jsonWithString:(nonnull NSString*)string NS_SWIFT_UNAVAILABLE("Use init(string:)");
+ (nonnull instancetype)jsonWithString:(nonnull NSString*)string encoding:(NSStringEncoding)encoding NS_SWIFT_UNAVAILABLE("Use init(string:encoding:)");

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithRootObject:(nullable id)rootObject NS_SWIFT_NAME(init(rootObject:)) NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithData:(nonnull NSData*)data NS_SWIFT_NAME(init(data:));
- (nonnull instancetype)initWithString:(nonnull NSString*)string NS_SWIFT_NAME(init(string:));
- (nonnull instancetype)initWithString:(nonnull NSString*)string encoding:(NSStringEncoding)encoding NS_SWIFT_NAME(init(string:encoding:));

- (nullable NSData*)toData NS_SWIFT_NAME(toData());
- (nullable NSString*)toString NS_SWIFT_NAME(toString());
- (nullable NSString*)toStringEncoding:(NSStringEncoding)encoding NS_SWIFT_NAME(toString(encoding:));

#pragma mark - Setters

- (BOOL)setDate:(nullable NSDate*)date
        forPath:(nonnull NSString*)path NS_SWIFT_NAME(set(date:forPath:));

- (BOOL)setDate:(nullable NSDate*)date
         format:(nonnull NSString*)format
        forPath:(nonnull NSString*)path NS_SWIFT_NAME(set(date:format:forPath:));

- (BOOL)setValue:(nullable id)value
             map:(nonnull NSDictionary*)map
         forPath:(nonnull NSString*)path NS_SWIFT_NAME(set(value:map:forPath:));

- (BOOL)setColor:(nullable UIColor*)color
         forPath:(nonnull NSString*)path NS_SWIFT_NAME(set(color:forPath:));

#pragma mark - Getters

- (nonnull NSDate*)dateAtPath:(nonnull NSString*)path NS_SWIFT_NAME(date(atPath:));

- (nullable NSDate*)dateAtPath:(nonnull NSString*)path
                            or:(nullable NSDate*)or NS_SWIFT_NAME(date(atPath:or:));

- (nonnull NSDate*)dateAtPath:(nonnull NSString*)path
                       formats:(nonnull NSArray< NSString* >*)formats NS_SWIFT_NAME(date(atPath:formats:));

- (nullable NSDate*)dateAtPath:(nonnull NSString*)path
                       formats:(nonnull NSArray< NSString* >*)formats
                            or:(nullable NSDate*)or NS_SWIFT_NAME(date(atPath:formats:or:));

- (nonnull id)valueAtPath:(nonnull NSString*)path
                      map:(nonnull NSDictionary*)map NS_SWIFT_NAME(value(atPath:map:));

- (nullable id)valueAtPath:(nonnull NSString*)path
                       map:(nonnull NSDictionary*)map
                        or:(nullable id)or NS_SWIFT_NAME(value(atPath:map:or:));

- (nonnull UIColor*)colorAtPath:(nonnull NSString*)path NS_SWIFT_NAME(color(atPath:));

- (nullable UIColor*)colorAtPath:(nonnull NSString*)path
                              or:(nullable UIColor*)or NS_SWIFT_NAME(color(atPath:or:));

#pragma mark - To object

- (nullable id)objectFromDate:(nullable NSDate*)date NS_SWIFT_NAME(object(date:));

- (nullable id)objectFromDate:(nullable NSDate*)date
                       format:(nonnull NSString*)format NS_SWIFT_NAME(object(date:format:));

- (nullable id)objectFromColor:(nullable UIColor*)color NS_SWIFT_NAME(object(color:));

#pragma mark - From object

- (nonnull NSDate*)dateFromObject:(nullable id)object NS_SWIFT_NAME(date(from:));

- (nullable NSDate*)dateFromObject:(nullable id)object
                                or:(nullable NSDate*)or NS_SWIFT_NAME(date(from:or:));

- (nonnull NSDate*)dateFromObject:(nullable id)object
                           formats:(nonnull NSArray< NSString* >*)formats NS_SWIFT_NAME(date(from:formats:));

- (nullable NSDate*)dateFromObject:(nullable id)object
                           formats:(nonnull NSArray< NSString* >*)formats
                                or:(nullable NSDate*)or NS_SWIFT_NAME(date(from:formats:or:));

- (nonnull UIColor*)colorFromObject:(nullable id)object NS_SWIFT_NAME(color(from:));

- (nullable UIColor*)colorFromObject:(nullable id)object
                                  or:(nullable UIColor*)or NS_SWIFT_NAME(color(from:or:));

@end

/*--------------------------------------------------*/

extern NSExceptionName _Nonnull GLBJsonException;

/*--------------------------------------------------*/
