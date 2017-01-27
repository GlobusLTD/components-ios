/*--------------------------------------------------*/

#import "GLBStructedObject.h"

/*--------------------------------------------------*/

#include "GLBUI.h"

/*--------------------------------------------------*/

@interface GLBPack : GLBStructedObject

+ (nonnull instancetype)packWithRootObject:(nullable id)rootObject NS_SWIFT_UNAVAILABLE("Use init(rootObject:)");
+ (nonnull instancetype)packWithData:(nonnull NSData*)data NS_SWIFT_UNAVAILABLE("Use init(data:)");

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithRootObject:(nullable id)rootObject NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithData:(nonnull NSData*)data;

- (nullable NSData*)toData;

#pragma mark - Setters

- (BOOL)setDate:(nullable NSDate*)date
        forPath:(nonnull NSString*)path NS_SWIFT_NAME(set(date:forPath:));

- (BOOL)setValue:(nullable id)value
             map:(nonnull NSDictionary*)map
         forPath:(nonnull NSString*)path NS_SWIFT_NAME(set(value:map:forPath:));

- (BOOL)setColor:(nullable UIColor*)color
         forPath:(nonnull NSString*)path NS_SWIFT_NAME(set(color:forPath:));

#pragma mark - Getters

- (nullable NSDate*)dateAtPath:(nonnull NSString*)path
                             or:(nullable NSDate*)or NS_SWIFT_NAME(date(atPath:or:));

- (nullable id)valueAtPath:(nonnull NSString*)path
                        map:(nonnull NSDictionary*)map
                         or:(nullable id)or NS_SWIFT_NAME(value(atPath:map:or:));

- (nullable UIColor*)colorAtPath:(nonnull NSString*)path
                               or:(nullable UIColor*)or NS_SWIFT_NAME(color(atPath:or:));

#pragma mark - To object

- (nullable id)objectFromDate:(nullable NSDate*)date NS_SWIFT_NAME(object(date:));

- (nullable id)objectFromColor:(nullable UIColor*)color NS_SWIFT_NAME(object(color:));

#pragma mark - From object

- (nullable NSDate*)dateFromObject:(nullable id)object
                                 or:(nullable NSDate*)or NS_SWIFT_NAME(date(from:or:));

- (nullable UIColor*)colorFromObject:(nullable id)object
                                   or:(nullable UIColor*)or NS_SWIFT_NAME(color(from:or:));

@end

/*--------------------------------------------------*/
