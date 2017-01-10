/*--------------------------------------------------*/

#import "GLBStructedObject.h"

/*--------------------------------------------------*/

#include "GLBUI.h"

/*--------------------------------------------------*/

@interface GLBPack : GLBStructedObject

+ (instancetype _Nonnull)packWithRootObject:(id _Nullable)rootObject NS_SWIFT_UNAVAILABLE("Use init(rootObject:)");
+ (instancetype _Nonnull)packWithData:(NSData* _Nonnull)data NS_SWIFT_UNAVAILABLE("Use init(data:)");

- (instancetype _Nonnull)init NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithRootObject:(id _Nullable)rootObject NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithData:(NSData* _Nonnull)data;

- (NSData* _Nullable)toData;

#pragma mark - Setters

- (BOOL)setDate:(NSDate* _Nullable)date
        forPath:(NSString* _Nonnull)path NS_SWIFT_NAME(set(date:forPath:));

- (BOOL)setValue:(id _Nullable)value
             map:(NSDictionary* _Nonnull)map
         forPath:(NSString* _Nonnull)path NS_SWIFT_NAME(set(value:map:forPath:));

- (BOOL)setColor:(UIColor* _Nullable)color
         forPath:(NSString* _Nonnull)path NS_SWIFT_NAME(set(color:forPath:));

#pragma mark - Getters

- (NSDate* _Nullable)dateAtPath:(NSString* _Nonnull)path
                             or:(NSDate* _Nullable)or NS_SWIFT_NAME(date(atPath:or:));

- (id _Nullable)valueAtPath:(NSString* _Nonnull)path
                        map:(NSDictionary* _Nonnull)map
                         or:(id _Nullable)or NS_SWIFT_NAME(value(atPath:map:or:));

- (UIColor* _Nullable)colorAtPath:(NSString* _Nonnull)path
                               or:(UIColor* _Nullable)or NS_SWIFT_NAME(color(atPath:or:));

#pragma mark - To object

- (id _Nullable)objectFromDate:(NSDate* _Nullable)date NS_SWIFT_NAME(object(date:));

- (id _Nullable)objectFromColor:(UIColor* _Nullable)color NS_SWIFT_NAME(object(color:));

#pragma mark - From object

- (NSDate* _Nullable)dateFromObject:(id _Nullable)object
                                 or:(NSDate* _Nullable)or NS_SWIFT_NAME(date(from:or:));

- (UIColor* _Nullable)colorFromObject:(id _Nullable)object
                                   or:(UIColor* _Nullable)or NS_SWIFT_NAME(color(from:or:));

@end

/*--------------------------------------------------*/
