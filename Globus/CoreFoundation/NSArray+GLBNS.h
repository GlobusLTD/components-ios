/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"

/*--------------------------------------------------*/

@interface NSArray< __covariant ObjectType > (GLB_NS) < GLBObjectDebugProtocol >

+ (_Nullable instancetype)glb_arrayWithArray:(NSArray< ObjectType >* _Nullable)array addingObject:(ObjectType _Nonnull)object;
+ (_Nullable instancetype)glb_arrayWithArray:(NSArray< ObjectType >* _Nullable)array addingObjectsFromArray:(NSArray< ObjectType >* _Nonnull)addingObjects;
+ (_Nullable instancetype)glb_arrayWithArray:(NSArray< ObjectType >* _Nullable)array removingObject:(ObjectType _Nonnull)object;
+ (_Nullable instancetype)glb_arrayWithArray:(NSArray< ObjectType >* _Nullable)array removingObjectsInArray:(NSArray< ObjectType >* _Nonnull)removingObjects;

- (NSArray< ObjectType >* _Nullable)glb_arrayByReplaceObject:(_Nonnull ObjectType)object atIndex:(NSUInteger)index;

- (NSArray< ObjectType >* _Nullable)glb_arrayByRemovedObjectAtIndex:(NSUInteger)index;
- (NSArray< ObjectType >* _Nullable)glb_arrayByRemovedObject:(_Nonnull ObjectType)object;
- (NSArray< ObjectType >* _Nullable)glb_arrayByRemovedObjectsFromArray:(NSArray< ObjectType >* _Nonnull)array;

- (NSArray< ObjectType >* _Nullable)glb_arrayByObjectClass:(_Nonnull Class)objectClass;
- (NSArray< ObjectType >* _Nullable)glb_arrayByObjectProtocol:(Protocol* _Nonnull)objectProtocol;

- (_Nullable ObjectType)glb_firstObjectIsClass:(_Nonnull Class)objectClass;
- (_Nullable ObjectType)glb_lastObjectIsClass:(_Nonnull Class)objectClass;

- (_Nullable ObjectType)glb_firstObjectIsProtocol:(Protocol* _Nonnull)objectProtocol;
- (_Nullable ObjectType)glb_lastObjectIsProtocol:(Protocol* _Nonnull)objectProtocol;

- (BOOL)glb_containsObjectsInArray:(NSArray< ObjectType >* _Nonnull)objectsArray;

- (NSUInteger)glb_nextIndexOfObject:(_Nonnull ObjectType)object;
- (NSUInteger)glb_prevIndexOfObject:(_Nonnull ObjectType)object;

- (_Nullable ObjectType)glb_nextObjectOfObject:(_Nonnull ObjectType)object;
- (_Nullable ObjectType)glb_prevObjectOfObject:(_Nonnull ObjectType)object;

- (void)glb_each:(void(^ _Nonnull)(_Nonnull ObjectType object))block;
- (void)glb_each:(void(^ _Nonnull)(_Nonnull ObjectType object))block range:(NSRange)range;
- (void)glb_eachWithIndex:(void(^ _Nonnull)(_Nonnull ObjectType object, NSUInteger index))block;
- (void)glb_eachWithIndex:(void(^ _Nonnull)(_Nonnull ObjectType object, NSUInteger index))block range:(NSRange)range;
- (void)glb_each:(void(^ _Nonnull)(_Nonnull ObjectType object))block options:(NSEnumerationOptions)options;
- (void)glb_each:(void(^ _Nonnull)(_Nonnull ObjectType object))block range:(NSRange)range options:(NSEnumerationOptions)options;
- (void)glb_eachWithIndex:(void(^ _Nonnull)(_Nonnull ObjectType object, NSUInteger index))block options:(NSEnumerationOptions)options;
- (void)glb_eachWithIndex:(void(^ _Nonnull)(_Nonnull ObjectType object, NSUInteger index))block range:(NSRange)range options:(NSEnumerationOptions)options;
- (NSArray< ObjectType >* _Nullable)glb_duplicates:(id _Nullable(^ _Nonnull)(_Nonnull ObjectType object1, _Nonnull ObjectType object2))block;
- (NSArray* _Nullable)glb_map:(_Nullable id(^ _Nonnull)(_Nonnull ObjectType object))block;
- (NSDictionary* _Nullable)glb_groupBy:(_Nullable id(^ _Nonnull)(_Nonnull ObjectType object))block;
- (NSArray< ObjectType >* _Nullable)glb_select:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block;
- (NSArray< ObjectType >* _Nullable)glb_reject:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block;
- (_Nullable ObjectType)glb_find:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block;
- (NSArray< ObjectType >* _Nullable)glb_reverse;
- (NSArray< ObjectType >* _Nullable)glb_intersectionWithArray:(NSArray< ObjectType >* _Nonnull)array;
- (NSArray< ObjectType >* _Nullable)glb_intersectionWithArrays:(NSArray< ObjectType >* _Nonnull)firstArray, ... NS_REQUIRES_NIL_TERMINATION;
- (NSArray< ObjectType >* _Nullable)glb_unionWithArray:(NSArray< ObjectType >* _Nonnull)array;
- (NSArray< ObjectType >* _Nullable)glb_unionWithArrays:(NSArray< ObjectType >* _Nonnull)firstArray, ... NS_REQUIRES_NIL_TERMINATION;
- (NSArray< ObjectType >* _Nullable)glb_relativeComplement:(NSArray< ObjectType >* _Nonnull)array;
- (NSArray< ObjectType >* _Nullable)glb_relativeComplements:(NSArray< ObjectType >* _Nonnull)firstArray, ... NS_REQUIRES_NIL_TERMINATION;
- (NSArray< ObjectType >* _Nullable)glb_symmetricDifference:(NSArray< ObjectType >* _Nonnull)array;

@end

/*--------------------------------------------------*/

@interface NSMutableArray (GLBNS)

- (void)glb_moveObjectAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

- (void)glb_removeFirstObjectsByCount:(NSUInteger)count;
- (void)glb_removeLastObjectsByCount:(NSUInteger)count;

@end

/*--------------------------------------------------*/
