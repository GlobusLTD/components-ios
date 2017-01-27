/****************************************************/
/*                                                  */
/* This file is part of the Globus Componetns iOS   */
/* Copyright 2014-2016 Globus-Ltd.                  */
/* http://www.globus-ltd.com                        */
/* Created by Alexander Trifonov                    */
/*                                                  */
/* For the full copyright and license information,  */
/* please view the LICENSE file that contained      */
/* MIT License and was distributed with             */
/* this source code.                                */
/*                                                  */
/****************************************************/

#import "NSObject+GLBNS.h"

/*--------------------------------------------------*/

@interface NSOrderedSet< __covariant ObjectType > (GLB_NS)

+ (nonnull instancetype)glb_orderedSetWithOrderedSet:(nonnull NSOrderedSet< ObjectType >*)orderedSet addingObject:(nonnull ObjectType)object;
+ (nonnull instancetype)glb_orderedSetWithOrderedSet:(nonnull NSOrderedSet< ObjectType >*)orderedSet addingObjectsFromOrderedSet:(nonnull NSOrderedSet< ObjectType >*)addingObjects;
+ (nonnull instancetype)glb_orderedSetWithOrderedSet:(nonnull NSOrderedSet< ObjectType >*)orderedSet removingObject:(nonnull ObjectType)object;
+ (nonnull instancetype)glb_orderedSetWithOrderedSet:(nonnull NSOrderedSet< ObjectType >*)orderedSet removingObjectsInOrderedSet:(nonnull NSOrderedSet< ObjectType >*)removingObjects;

- (nonnull instancetype)glb_orderedSetByReplaceObject:(nonnull ObjectType)object atIndex:(NSUInteger)index;

- (nonnull instancetype)glb_orderedSetByRemovedObjectAtIndex:(NSUInteger)index;
- (nonnull instancetype)glb_orderedSetByRemovedObject:(nonnull ObjectType)object;
- (nonnull instancetype)glb_orderedSetByRemovedObjectsFromOrderedSet:(nonnull NSOrderedSet< ObjectType >*)orderedSet;

- (nonnull instancetype)glb_orderedSetByObjectClass:(nonnull Class)objectClass;
- (nonnull instancetype)glb_orderedSetByObjectProtocol:(nonnull Protocol*)objectProtocol;

- (nullable ObjectType)glb_firstObjectIsClass:(nonnull Class)objectClass;
- (nullable ObjectType)glb_lastObjectIsClass:(nonnull Class)objectClass;

- (nullable ObjectType)glb_firstObjectIsProtocol:(nonnull Protocol*)objectProtocol;
- (nullable ObjectType)glb_lastObjectIsProtocol:(nonnull Protocol*)objectProtocol;

- (BOOL)glb_containsObjectsInOrderedSet:(nonnull NSOrderedSet< ObjectType >*)objectsOrderedSet;

- (NSUInteger)glb_nextIndexOfObject:(nonnull ObjectType)object;
- (NSUInteger)glb_prevIndexOfObject:(nonnull ObjectType)object;

- (nullable ObjectType)glb_nextObjectOfObject:(nonnull ObjectType)object;
- (nullable ObjectType)glb_prevObjectOfObject:(nonnull ObjectType)object;

- (void)glb_each:(void(^ _Nonnull)(ObjectType _Nonnull object))block;
- (void)glb_each:(void(^ _Nonnull)(ObjectType _Nonnull object))block range:(NSRange)range;
- (void)glb_eachWithIndex:(void(^ _Nonnull)(ObjectType _Nonnull object, NSUInteger index))block;
- (void)glb_eachWithIndex:(void(^ _Nonnull)(ObjectType _Nonnull object, NSUInteger index))block range:(NSRange)range;
- (void)glb_each:(void(^ _Nonnull)(ObjectType _Nonnull object))block options:(NSEnumerationOptions)options;
- (void)glb_each:(void(^ _Nonnull)(ObjectType _Nonnull object))block range:(NSRange)range options:(NSEnumerationOptions)options;
- (void)glb_eachWithIndex:(void(^ _Nonnull)(ObjectType _Nonnull object, NSUInteger index))block options:(NSEnumerationOptions)options;
- (void)glb_eachWithIndex:(void(^ _Nonnull)(ObjectType _Nonnull object, NSUInteger index))block range:(NSRange)range options:(NSEnumerationOptions)options;
- (nullable NSOrderedSet*)glb_map:(id _Nullable(^ _Nonnull)(ObjectType _Nonnull object))block;
- (nullable NSDictionary*)glb_groupBy:(id _Nullable(^ _Nonnull)(ObjectType _Nonnull object))block;
- (nullable NSOrderedSet< ObjectType >*)glb_select:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))block;
- (nullable NSOrderedSet< ObjectType >*)glb_reject:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))block;
- (nullable ObjectType)glb_find:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))block;
- (nullable ObjectType)glb_find:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))block options:(NSEnumerationOptions)options;
- (nullable ObjectType)glb_find:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))block  range:(NSRange)range options:(NSEnumerationOptions)options;

@end

/*--------------------------------------------------*/

@interface NSMutableOrderedSet (GLBNS)

- (void)glb_moveObjectAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

- (void)glb_removeFirstObjectsByCount:(NSUInteger)count;
- (void)glb_removeLastObjectsByCount:(NSUInteger)count;

@end

/*--------------------------------------------------*/
