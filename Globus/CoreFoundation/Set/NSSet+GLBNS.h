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

@interface NSSet< __covariant ObjectType > (GLB_NS)

+ (instancetype _Nonnull)glb_setWithSet:(NSSet< ObjectType >* _Nonnull)set addingObject:(ObjectType _Nonnull)object;
+ (instancetype _Nonnull)glb_setWithSet:(NSSet< ObjectType >* _Nonnull)set addingObjectsFromSet:(NSSet< ObjectType >* _Nonnull)addingObjects;
+ (instancetype _Nonnull)glb_setWithSet:(NSSet< ObjectType >* _Nonnull)set removingObject:(ObjectType _Nonnull)object;
+ (instancetype _Nonnull)glb_setWithSet:(NSSet< ObjectType >* _Nonnull)set removingObjectsInSet:(NSSet< ObjectType >* _Nonnull)removingObjects;

- (instancetype _Nonnull)glb_setByRemovedObject:(ObjectType _Nonnull)object;
- (instancetype _Nonnull)glb_setByRemovedObjectsFromSet:(NSSet< ObjectType >* _Nonnull)set;

- (instancetype _Nonnull)glb_setByObjectClass:(Class _Nonnull)objectClass;
- (instancetype _Nonnull)glb_setByObjectProtocol:(Protocol* _Nonnull)objectProtocol;

- (BOOL)glb_containsObjectsInSet:(NSSet< ObjectType >* _Nonnull)objectsSet;

- (void)glb_each:(void(^ _Nonnull)(ObjectType _Nonnull object))block;
- (void)glb_each:(void(^ _Nonnull)(ObjectType _Nonnull object))block options:(NSEnumerationOptions)options;
- (NSSet* _Nonnull)glb_map:(id _Nullable(^ _Nonnull)(ObjectType _Nonnull object))block;
- (NSDictionary* _Nonnull)glb_groupBy:(id _Nullable(^ _Nonnull)(ObjectType _Nonnull object))block;
- (NSSet< ObjectType >* _Nonnull)glb_select:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))block;
- (NSSet< ObjectType >* _Nonnull)glb_reject:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))block;
- (ObjectType _Nullable)glb_find:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))block;

@end

/*--------------------------------------------------*/

@interface NSMutableSet (GLBNS)
@end

/*--------------------------------------------------*/
