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

@interface NSSet< __covariant ObjectType > (GLB_NS) < GLBObjectDebugProtocol >

+ (instancetype _Nullable)glb_setWithSet:(NSSet< ObjectType >* _Nullable)set addingObject:(_Nonnull ObjectType)object;
+ (instancetype _Nullable)glb_setWithSet:(NSSet< ObjectType >* _Nullable)set addingObjectsFromSet:(NSSet< ObjectType >* _Nonnull)addingObjects;
+ (instancetype _Nullable)glb_setWithSet:(NSSet< ObjectType >* _Nullable)set removingObject:(_Nonnull ObjectType)object;
+ (instancetype _Nullable)glb_setWithSet:(NSSet< ObjectType >* _Nullable)set removingObjectsInSet:(NSSet< ObjectType >* _Nonnull)removingObjects;

- (NSSet< ObjectType >* _Nullable)glb_setByRemovedObject:(_Nonnull ObjectType)object;
- (NSSet< ObjectType >* _Nullable)glb_setByRemovedObjectsFromSet:(NSSet< ObjectType >* _Nonnull)set;

- (NSSet< ObjectType >* _Nullable)glb_setByObjectClass:(_Nonnull Class)objectClass;
- (NSSet< ObjectType >* _Nullable)glb_setByObjectProtocol:(Protocol* _Nonnull)objectProtocol;

- (BOOL)glb_containsObjectsInSet:(NSSet< ObjectType >* _Nonnull)objectsSet;

- (void)glb_each:(void(^ _Nonnull)(_Nonnull ObjectType object))block;
- (void)glb_each:(void(^ _Nonnull)(_Nonnull ObjectType object))block options:(NSEnumerationOptions)options;
- (NSSet* _Nullable)glb_map:(_Nullable id(^ _Nonnull)(_Nonnull ObjectType object))block;
- (NSDictionary* _Nullable)glb_groupBy:(_Nullable id(^ _Nonnull)(_Nonnull ObjectType object))block;
- (NSSet< ObjectType >* _Nullable)glb_select:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block;
- (NSSet< ObjectType >* _Nullable)glb_reject:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block;
- (ObjectType _Nullable)glb_find:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block;

@end

/*--------------------------------------------------*/

@interface NSMutableSet (GLBNS)
@end

/*--------------------------------------------------*/
