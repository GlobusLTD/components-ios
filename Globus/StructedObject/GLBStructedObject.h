/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

@interface GLBStructedObject : NSObject

@property(nonatomic, nullable, readonly, strong) id rootObject;
@property(nonatomic, readonly, assign) BOOL isRootObjectDictionary;
@property(nonatomic, readonly, assign) BOOL isRootObjectArray;

- (instancetype _Nonnull)init NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithRootObject:(id _Nullable)rootObject NS_SWIFT_NAME(init(rootObject:)) NS_DESIGNATED_INITIALIZER;

#pragma mark - Setters

- (BOOL)setObject:(id _Nullable)object
          forPath:(NSString* _Nonnull)path NS_SWIFT_NAME(set(object:forPath:));

- (BOOL)setRootDictionary:(NSDictionary* _Nullable)rootDictionary NS_SWIFT_NAME(set(rootDictionary:));

- (BOOL)setDictionary:(NSDictionary* _Nullable)dictionary
              forPath:(NSString* _Nonnull)path NS_SWIFT_NAME(set(dictionary:forPath:));

- (BOOL)setRootArray:(NSArray* _Nullable)rootArray NS_SWIFT_NAME(set(rootArray:));

- (BOOL)setArray:(NSArray* _Nullable)array
         forPath:(NSString* _Nonnull)path NS_SWIFT_NAME(set(array:forPath:));

- (BOOL)setBoolean:(BOOL)value
           forPath:(NSString* _Nonnull)path NS_SWIFT_NAME(set(value:forPath:));

- (BOOL)setInt:(NSInteger)value
       forPath:(NSString* _Nonnull)path NS_SWIFT_NAME(set(value:forPath:));

- (BOOL)setUInt:(NSUInteger)value
        forPath:(NSString* _Nonnull)path NS_SWIFT_NAME(set(value:forPath:));

- (BOOL)setFloat:(float)value
         forPath:(NSString* _Nonnull)path NS_SWIFT_NAME(set(value:forPath:));

- (BOOL)setDouble:(double)value
         forPath:(NSString* _Nonnull)path NS_SWIFT_NAME(set(value:forPath:));

- (BOOL)setNumber:(NSNumber* _Nullable)number
          forPath:(NSString* _Nonnull)path NS_SWIFT_NAME(set(number:forPath:));

- (BOOL)setString:(NSString* _Nullable)string
          forPath:(NSString* _Nonnull)path NS_SWIFT_NAME(set(string:forPath:));

- (BOOL)setUrl:(NSURL* _Nullable)url
       forPath:(NSString* _Nonnull)path NS_SWIFT_NAME(set(url:forPath:));

#pragma mark - Getters

- (id _Nullable)objectAtPath:(NSString* _Nonnull)path NS_SWIFT_NAME(object(atPath:));

- (NSDictionary* _Nullable)rootDictionary NS_SWIFT_NAME(rootDictionary());

- (NSDictionary* _Nullable)dictionaryAtPath:(NSString* _Nonnull)path NS_SWIFT_NAME(dictionary(atPath:));

- (NSArray* _Nullable)rootArray NS_SWIFT_NAME(rootArray());

- (NSArray* _Nullable)arrayAtPath:(NSString* _Nonnull)path NS_SWIFT_NAME(array(atPath:));

- (BOOL)booleanAtPath:(NSString* _Nonnull)path
                   or:(BOOL)or NS_SWIFT_NAME(boolean(atPath:or:));

- (NSInteger)intAtPath:(NSString* _Nonnull)path
                    or:(NSInteger)or NS_SWIFT_NAME(int(atPath:or:));

- (NSUInteger)uintAtPath:(NSString* _Nonnull)path
                      or:(NSUInteger)or NS_SWIFT_NAME(uint(atPath:or:));

- (float)floatAtPath:(NSString* _Nonnull)path
                  or:(float)or NS_SWIFT_NAME(float(atPath:or:));

- (double)doubleAtPath:(NSString* _Nonnull)path
                    or:(double)or NS_SWIFT_NAME(double(atPath:or:));

- (NSNumber* _Nullable)numberAtPath:(NSString* _Nonnull)path
                                 or:(NSNumber* _Nullable)or NS_SWIFT_NAME(number(atPath:or:));

- (NSString* _Nullable)stringAtPath:(NSString* _Nonnull)path
                                 or:(NSString* _Nullable)or NS_SWIFT_NAME(string(atPath:or:));

- (NSURL* _Nullable)urlAtPath:(NSString* _Nonnull)path
                           or:(NSURL* _Nullable)or NS_SWIFT_NAME(url(atPath:or:));

#pragma mark - To object

- (id _Nullable)objectFromBoolean:(BOOL)value NS_SWIFT_NAME(object(value:));

- (id _Nullable)objectFromInt:(NSInteger)value NS_SWIFT_NAME(object(value:));

- (id _Nullable)objectFromUInt:(NSUInteger)value NS_SWIFT_NAME(object(value:));

- (id _Nullable)objectFromFloat:(float)value NS_SWIFT_NAME(object(value:));

- (id _Nullable)objectFromDouble:(double)value NS_SWIFT_NAME(object(value:));

- (id _Nullable)objectFromNumber:(NSNumber* _Nullable)number NS_SWIFT_NAME(object(number:));

- (id _Nullable)objectFromString:(NSString* _Nullable)string NS_SWIFT_NAME(object(string:));

- (id _Nullable)objectFromUrl:(NSURL* _Nullable)url NS_SWIFT_NAME(object(url:));

#pragma mark - From object

- (BOOL)booleanFromObject:(id _Nullable)object
                       or:(BOOL)or NS_SWIFT_NAME(boolean(from:or:));

- (NSInteger)intFromObject:(id _Nullable)object
                        or:(NSInteger)or NS_SWIFT_NAME(int(from:or:));

- (NSUInteger)uintFromObject:(id _Nullable)object
                          or:(NSUInteger)or NS_SWIFT_NAME(uint(from:or:));

- (float)floatFromObject:(id _Nullable)object
                      or:(float)or NS_SWIFT_NAME(float(from:or:));

- (double)doubleFromObject:(id _Nullable)object
                        or:(double)or NS_SWIFT_NAME(double(from:or:));

- (NSNumber* _Nullable)numberFromObject:(id _Nullable)object
                                     or:(NSNumber* _Nullable)or NS_SWIFT_NAME(number(from:or:));

- (NSString* _Nullable)stringFromObject:(id _Nullable)object
                                     or:(NSString* _Nullable)or NS_SWIFT_NAME(string(from:or:));

- (NSURL* _Nullable)urlFromObject:(id _Nullable)object
                               or:(NSURL* _Nullable)or NS_SWIFT_NAME(url(from:or:));

@end

/*--------------------------------------------------*/
