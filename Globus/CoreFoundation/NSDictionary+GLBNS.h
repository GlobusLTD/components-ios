/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

@interface NSDictionary< KeyType, ObjectType > (GLB_NS)

- (BOOL)glb_boolForKey:(_Nonnull KeyType)key orDefault:(BOOL)defaultValue;
- (NSInteger)glb_integerForKey:(_Nonnull KeyType)key orDefault:(NSInteger)defaultValue;
- (NSUInteger)glb_unsignedIntegerForKey:(_Nonnull KeyType)key orDefault:(NSUInteger)defaultValue;
- (float)glb_floatForKey:(_Nonnull KeyType)key orDefault:(float)defaultValue;
- (double)glb_doubleForKey:(_Nonnull KeyType)key orDefault:(double)defaultValue;
- (NSNumber* _Nullable)glb_numberForKey:(_Nonnull KeyType)key orDefault:(NSNumber* _Nullable)defaultValue;
- (NSString* _Nullable)glb_stringForKey:(_Nonnull KeyType)key orDefault:(NSString* _Nullable)defaultValue;
- (NSArray* _Nullable)glb_arrayForKey:(_Nonnull KeyType)key orDefault:(NSArray* _Nullable)defaultValue;
- (NSDictionary* _Nullable)glb_dictionaryForKey:(_Nonnull KeyType)key orDefault:(NSDictionary* _Nullable)defaultValue;
- (NSDate* _Nullable)glb_dateForKey:(_Nonnull KeyType)key orDefault:(NSDate* _Nullable)defaultValue;
- (NSData* _Nullable)glb_dataForKey:(_Nonnull KeyType)key orDefault:(NSData* _Nullable)defaultValue;

- (NSString* _Nullable)glb_stringFromQueryComponents;

- (void)glb_each:(void(^ _Nonnull)(_Nonnull KeyType key, _Nonnull ObjectType value))block;
- (void)glb_eachWithIndex:(void(^ _Nonnull)(_Nonnull KeyType key, _Nonnull ObjectType value, NSUInteger index))block;
- (void)glb_eachKey:(void(^ _Nonnull)(_Nonnull KeyType key))block;
- (void)glb_eachKeyWithIndex:(void(^ _Nonnull)(_Nonnull KeyType key, NSUInteger index))block;
- (void)glb_eachValue:(void(^ _Nonnull)(_Nonnull ObjectType value))block;
- (void)glb_eachValueWithIndex:(void(^ _Nonnull)(_Nonnull ObjectType value, NSUInteger index))block;
- (NSArray* _Nullable)glb_map:(_Nullable id(^ _Nonnull)(_Nonnull KeyType key, _Nonnull ObjectType value))block;
- (_Nullable id)glb_findObjectByKey:(BOOL(^ _Nonnull)(_Nonnull KeyType key))block;
- (BOOL)glb_hasKey:(_Nonnull KeyType)key;

@end

/*--------------------------------------------------*/
