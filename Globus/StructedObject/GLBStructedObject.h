/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

@interface GLBStructedObject : NSObject

@property(nonatomic, nullable, readonly, strong) id rootObject;
@property(nonatomic, readonly) BOOL isRootObjectDictionary;
@property(nonatomic, readonly) BOOL isRootObjectArray;

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithRootObject:(nullable id)rootObject NS_SWIFT_NAME(init(rootObject:)) NS_DESIGNATED_INITIALIZER;

#pragma mark - Setters

- (BOOL)setObject:(nullable id)object
          forPath:(nonnull NSString*)path NS_SWIFT_NAME(set(object:forPath:));

- (BOOL)setRootDictionary:(nullable NSDictionary*)rootDictionary NS_SWIFT_NAME(set(rootDictionary:));

- (BOOL)setDictionary:(nullable NSDictionary*)dictionary
              forPath:(nonnull NSString*)path NS_SWIFT_NAME(set(dictionary:forPath:));

- (BOOL)setRootArray:(nullable NSArray*)rootArray NS_SWIFT_NAME(set(rootArray:));

- (BOOL)setArray:(nullable NSArray*)array
         forPath:(nonnull NSString*)path NS_SWIFT_NAME(set(array:forPath:));

- (BOOL)setBoolean:(BOOL)value
           forPath:(nonnull NSString*)path NS_SWIFT_NAME(set(value:forPath:));

- (BOOL)setInt:(NSInteger)value
       forPath:(nonnull NSString*)path NS_SWIFT_NAME(set(value:forPath:));

- (BOOL)setUInt:(NSUInteger)value
        forPath:(nonnull NSString*)path NS_SWIFT_NAME(set(value:forPath:));

- (BOOL)setFloat:(float)value
         forPath:(nonnull NSString*)path NS_SWIFT_NAME(set(value:forPath:));

- (BOOL)setDouble:(double)value
         forPath:(nonnull NSString*)path NS_SWIFT_NAME(set(value:forPath:));

- (BOOL)setNumber:(nullable NSNumber*)number
          forPath:(nonnull NSString*)path NS_SWIFT_NAME(set(number:forPath:));

- (BOOL)setDecimalNumber:(nullable NSDecimalNumber*)decimalNumber
                 forPath:(nonnull NSString*)path NS_SWIFT_NAME(set(decimalNumber:forPath:));

- (BOOL)setString:(nullable NSString*)string
          forPath:(nonnull NSString*)path NS_SWIFT_NAME(set(string:forPath:));

- (BOOL)setUrl:(nullable NSURL*)url
       forPath:(nonnull NSString*)path NS_SWIFT_NAME(set(url:forPath:));

#pragma mark - Getters

- (nullable id)objectAtPath:(nonnull NSString*)path NS_SWIFT_NAME(object(atPath:));

- (nullable NSDictionary*)rootDictionary NS_SWIFT_NAME(rootDictionary());

- (nullable NSDictionary*)dictionaryAtPath:(nonnull NSString*)path NS_SWIFT_NAME(dictionary(atPath:));

- (nullable NSArray*)rootArray NS_SWIFT_NAME(rootArray());

- (nullable NSArray*)arrayAtPath:(nonnull NSString*)path NS_SWIFT_NAME(array(atPath:));

- (BOOL)booleanAtPath:(nonnull NSString*)path
                   or:(BOOL)or NS_SWIFT_NAME(boolean(atPath:or:));

- (NSInteger)intAtPath:(nonnull NSString*)path
                    or:(NSInteger)or NS_SWIFT_NAME(int(atPath:or:));

- (NSUInteger)uintAtPath:(nonnull NSString*)path
                      or:(NSUInteger)or NS_SWIFT_NAME(uint(atPath:or:));

- (float)floatAtPath:(nonnull NSString*)path
                  or:(float)or NS_SWIFT_NAME(float(atPath:or:));

- (double)doubleAtPath:(nonnull NSString*)path
                    or:(double)or NS_SWIFT_NAME(double(atPath:or:));

- (nullable NSNumber*)numberAtPath:(nonnull NSString*)path
                                or:(nullable NSNumber*)or NS_SWIFT_NAME(number(atPath:or:));

- (nullable NSNumber*)decimalNumberAtPath:(nonnull NSString*)path
                                       or:(nullable NSDecimalNumber*)or NS_SWIFT_NAME(decimalNumber(atPath:or:));

- (nullable NSString*)stringAtPath:(nonnull NSString*)path
                                 or:(nullable NSString*)or NS_SWIFT_NAME(string(atPath:or:));

- (nullable NSURL*)urlAtPath:(nonnull NSString*)path
                           or:(nullable NSURL*)or NS_SWIFT_NAME(url(atPath:or:));

#pragma mark - To object

- (nullable id)objectFromBoolean:(BOOL)value NS_SWIFT_NAME(object(value:));

- (nullable id)objectFromInt:(NSInteger)value NS_SWIFT_NAME(object(value:));

- (nullable id)objectFromUInt:(NSUInteger)value NS_SWIFT_NAME(object(value:));

- (nullable id)objectFromFloat:(float)value NS_SWIFT_NAME(object(value:));

- (nullable id)objectFromDouble:(double)value NS_SWIFT_NAME(object(value:));

- (nullable id)objectFromNumber:(nullable NSNumber*)number NS_SWIFT_NAME(object(number:));

- (nullable id)objectFromDecimalNumber:(nullable NSDecimalNumber*)decimalNumber NS_SWIFT_NAME(object(decimalNumber:));

- (nullable id)objectFromString:(nullable NSString*)string NS_SWIFT_NAME(object(string:));

- (nullable id)objectFromUrl:(nullable NSURL*)url NS_SWIFT_NAME(object(url:));

#pragma mark - From object

- (BOOL)booleanFromObject:(nullable id)object
                       or:(BOOL)or NS_SWIFT_NAME(boolean(from:or:));

- (NSInteger)intFromObject:(nullable id)object
                        or:(NSInteger)or NS_SWIFT_NAME(int(from:or:));

- (NSUInteger)uintFromObject:(nullable id)object
                          or:(NSUInteger)or NS_SWIFT_NAME(uint(from:or:));

- (float)floatFromObject:(nullable id)object
                      or:(float)or NS_SWIFT_NAME(float(from:or:));

- (double)doubleFromObject:(nullable id)object
                        or:(double)or NS_SWIFT_NAME(double(from:or:));

- (nullable NSNumber*)numberFromObject:(nullable id)object
                                    or:(nullable NSNumber*)or NS_SWIFT_NAME(number(from:or:));

- (nullable NSDecimalNumber*)decimalNumberFromObject:(nullable id)object
                                                  or:(nullable NSDecimalNumber*)or NS_SWIFT_NAME(decimalNumber(from:or:));

- (nullable NSString*)stringFromObject:(nullable id)object
                                    or:(nullable NSString*)or NS_SWIFT_NAME(string(from:or:));

- (nullable NSURL*)urlFromObject:(nullable id)object
                               or:(nullable NSURL*)or NS_SWIFT_NAME(url(from:or:));

@end

/*--------------------------------------------------*/
