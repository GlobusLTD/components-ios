/**
 * This file is part of the GLB (the library of globus-ltd)
 * Copyright 2014-2016 Globus-LTD. http://www.globus-ltd.com
 * Created by Alexander Trifonov
 *
 * For the full copyright and license information, please view the LICENSE
 * file that contained MIT License
 * and was distributed with this source code.
 */

/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"

/*--------------------------------------------------*/

@interface NSOrderedSet< __covariant ObjectType > (GLB_NS) < GLBObjectDebugProtocol >

+ (instancetype _Nullable)glb_orderedSetWithOrderedSet:(NSOrderedSet< ObjectType >* _Nullable)orderedSet addingObject:(_Nonnull ObjectType)object;
+ (instancetype _Nullable)glb_orderedSetWithOrderedSet:(NSOrderedSet< ObjectType >* _Nullable)orderedSet addingObjectsFromOrderedSet:(NSOrderedSet< ObjectType >* _Nonnull)addingObjects;
+ (instancetype _Nullable)glb_orderedSetWithOrderedSet:(NSOrderedSet< ObjectType >* _Nullable)orderedSet removingObject:(_Nonnull ObjectType)object;
+ (instancetype _Nullable)glb_orderedSetWithOrderedSet:(NSOrderedSet< ObjectType >* _Nullable)orderedSet removingObjectsInOrderedSet:(NSOrderedSet< ObjectType >* _Nonnull)removingObjects;

- (NSOrderedSet< ObjectType >* _Nullable)glb_orderedSetByReplaceObject:(_Nonnull ObjectType)object atIndex:(NSUInteger)index;

- (NSOrderedSet< ObjectType >* _Nullable)glb_orderedSetByRemovedObjectAtIndex:(NSUInteger)index;
- (NSOrderedSet< ObjectType >* _Nullable)glb_orderedSetByRemovedObject:(_Nonnull ObjectType)object;
- (NSOrderedSet< ObjectType >* _Nullable)glb_orderedSetByRemovedObjectsFromOrderedSet:(NSOrderedSet< ObjectType >* _Nonnull)orderedSet;

- (NSOrderedSet< ObjectType >* _Nullable)glb_orderedSetByObjectClass:(_Nonnull Class)objectClass;
- (NSOrderedSet< ObjectType >* _Nullable)glb_orderedSetByObjectProtocol:(Protocol* _Nonnull)objectProtocol;

- (_Nullable ObjectType)glb_firstObjectIsClass:(_Nonnull Class)objectClass;
- (_Nullable ObjectType)glb_lastObjectIsClass:(_Nonnull Class)objectClass;

- (_Nullable ObjectType)glb_firstObjectIsProtocol:(Protocol* _Nonnull)objectProtocol;
- (_Nullable ObjectType)glb_lastObjectIsProtocol:(Protocol* _Nonnull)objectProtocol;

- (BOOL)glb_containsObjectsInOrderedSet:(NSOrderedSet< ObjectType >* _Nonnull)objectsOrderedSet;

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
- (NSOrderedSet* _Nullable)glb_map:(_Nullable id(^ _Nonnull)(_Nonnull ObjectType object))block;
- (NSDictionary* _Nullable)glb_groupBy:(_Nullable id(^ _Nonnull)(_Nonnull ObjectType object))block;
- (NSOrderedSet< ObjectType >* _Nullable)glb_select:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block;
- (NSOrderedSet< ObjectType >* _Nullable)glb_reject:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block;
- (ObjectType _Nullable)glb_find:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block;
- (_Nullable ObjectType)glb_find:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block options:(NSEnumerationOptions)options;
- (_Nullable ObjectType)glb_find:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block  range:(NSRange)range options:(NSEnumerationOptions)options;

@end

/*--------------------------------------------------*/

@interface NSMutableOrderedSet (GLBNS)

- (void)glb_moveObjectAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

- (void)glb_removeFirstObjectsByCount:(NSUInteger)count;
- (void)glb_removeLastObjectsByCount:(NSUInteger)count;

@end

/*--------------------------------------------------*/
