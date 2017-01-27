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

+ (nonnull instancetype)glb_setWithSet:(nonnull NSSet< ObjectType >*)set addingObject:(nonnull ObjectType)object;
+ (nonnull instancetype)glb_setWithSet:(nonnull NSSet< ObjectType >*)set addingObjectsFromSet:(nonnull NSSet< ObjectType >*)addingObjects;
+ (nonnull instancetype)glb_setWithSet:(nonnull NSSet< ObjectType >*)set removingObject:(nonnull ObjectType)object;
+ (nonnull instancetype)glb_setWithSet:(nonnull NSSet< ObjectType >*)set removingObjectsInSet:(nonnull NSSet< ObjectType >*)removingObjects;

- (nonnull instancetype)glb_setByRemovedObject:(nonnull ObjectType)object;
- (nonnull instancetype)glb_setByRemovedObjectsFromSet:(nonnull NSSet< ObjectType >*)set;

- (nonnull instancetype)glb_setByObjectClass:(nonnull Class)objectClass;
- (nonnull instancetype)glb_setByObjectProtocol:(nonnull Protocol*)objectProtocol;

- (BOOL)glb_containsObjectsInSet:(nonnull NSSet< ObjectType >*)objectsSet;

- (void)glb_each:(void(^ _Nonnull)(ObjectType _Nonnull object))block;
- (void)glb_each:(void(^ _Nonnull)(ObjectType _Nonnull object))block options:(NSEnumerationOptions)options;
- (nonnull NSSet*)glb_map:(id _Nullable(^ _Nonnull)(ObjectType _Nonnull object))block;
- (nonnull NSDictionary*)glb_groupBy:(id _Nullable(^ _Nonnull)(ObjectType _Nonnull object))block;
- (nonnull NSSet< ObjectType >*)glb_select:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))block;
- (nonnull NSSet< ObjectType >*)glb_reject:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))block;
- (nullable ObjectType)glb_find:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))block;

@end

/*--------------------------------------------------*/

@interface NSMutableSet (GLBNS)
@end

/*--------------------------------------------------*/
