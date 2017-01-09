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

+ (instancetype _Nonnull)glb_orderedSetWithOrderedSet:(NSOrderedSet< ObjectType >* _Nonnull)orderedSet addingObject:(ObjectType _Nonnull)object;
+ (instancetype _Nonnull)glb_orderedSetWithOrderedSet:(NSOrderedSet< ObjectType >* _Nonnull)orderedSet addingObjectsFromOrderedSet:(NSOrderedSet< ObjectType >* _Nonnull)addingObjects;
+ (instancetype _Nonnull)glb_orderedSetWithOrderedSet:(NSOrderedSet< ObjectType >* _Nonnull)orderedSet removingObject:(ObjectType _Nonnull)object;
+ (instancetype _Nonnull)glb_orderedSetWithOrderedSet:(NSOrderedSet< ObjectType >* _Nonnull)orderedSet removingObjectsInOrderedSet:(NSOrderedSet< ObjectType >* _Nonnull)removingObjects;

- (instancetype _Nonnull)glb_orderedSetByReplaceObject:(ObjectType _Nonnull)object atIndex:(NSUInteger)index;

- (instancetype _Nonnull)glb_orderedSetByRemovedObjectAtIndex:(NSUInteger)index;
- (instancetype _Nonnull)glb_orderedSetByRemovedObject:(ObjectType _Nonnull)object;
- (instancetype _Nonnull)glb_orderedSetByRemovedObjectsFromOrderedSet:(NSOrderedSet< ObjectType >* _Nonnull)orderedSet;

- (instancetype _Nonnull)glb_orderedSetByObjectClass:(Class _Nonnull)objectClass;
- (instancetype _Nonnull)glb_orderedSetByObjectProtocol:(Protocol* _Nonnull)objectProtocol;

- (ObjectType _Nullable)glb_firstObjectIsClass:(Class _Nonnull)objectClass;
- (ObjectType _Nullable)glb_lastObjectIsClass:(Class _Nonnull)objectClass;

- (ObjectType _Nullable)glb_firstObjectIsProtocol:(Protocol* _Nonnull)objectProtocol;
- (ObjectType _Nullable)glb_lastObjectIsProtocol:(Protocol* _Nonnull)objectProtocol;

- (BOOL)glb_containsObjectsInOrderedSet:(NSOrderedSet< ObjectType >* _Nonnull)objectsOrderedSet;

- (NSUInteger)glb_nextIndexOfObject:(ObjectType _Nonnull)object;
- (NSUInteger)glb_prevIndexOfObject:(ObjectType _Nonnull)object;

- (ObjectType _Nullable)glb_nextObjectOfObject:(ObjectType _Nonnull)object;
- (ObjectType _Nullable)glb_prevObjectOfObject:(ObjectType _Nonnull)object;

- (void)glb_each:(void(^ _Nonnull)(ObjectType _Nonnull object))block;
- (void)glb_each:(void(^ _Nonnull)(ObjectType _Nonnull object))block range:(NSRange)range;
- (void)glb_eachWithIndex:(void(^ _Nonnull)(ObjectType _Nonnull object, NSUInteger index))block;
- (void)glb_eachWithIndex:(void(^ _Nonnull)(ObjectType _Nonnull object, NSUInteger index))block range:(NSRange)range;
- (void)glb_each:(void(^ _Nonnull)(ObjectType _Nonnull object))block options:(NSEnumerationOptions)options;
- (void)glb_each:(void(^ _Nonnull)(ObjectType _Nonnull object))block range:(NSRange)range options:(NSEnumerationOptions)options;
- (void)glb_eachWithIndex:(void(^ _Nonnull)(ObjectType _Nonnull object, NSUInteger index))block options:(NSEnumerationOptions)options;
- (void)glb_eachWithIndex:(void(^ _Nonnull)(ObjectType _Nonnull object, NSUInteger index))block range:(NSRange)range options:(NSEnumerationOptions)options;
- (NSOrderedSet* _Nullable)glb_map:(id _Nullable(^ _Nonnull)(ObjectType _Nonnull object))block;
- (NSDictionary* _Nullable)glb_groupBy:(id _Nullable(^ _Nonnull)(ObjectType _Nonnull object))block;
- (NSOrderedSet< ObjectType >* _Nullable)glb_select:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))block;
- (NSOrderedSet< ObjectType >* _Nullable)glb_reject:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))block;
- (ObjectType _Nullable)glb_find:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))block;
- (ObjectType _Nullable)glb_find:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))block options:(NSEnumerationOptions)options;
- (ObjectType _Nullable)glb_find:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))block  range:(NSRange)range options:(NSEnumerationOptions)options;

@end

/*--------------------------------------------------*/

@interface NSMutableOrderedSet (GLBNS)

- (void)glb_moveObjectAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

- (void)glb_removeFirstObjectsByCount:(NSUInteger)count;
- (void)glb_removeLastObjectsByCount:(NSUInteger)count;

@end

/*--------------------------------------------------*/
