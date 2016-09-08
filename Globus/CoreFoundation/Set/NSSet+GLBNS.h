/****************************************************/
/*                                                  */
/* This file is part of the Globus Components iOS   */
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

/**
 * @file NSSet+GLBNS.h
 * @class NSSet+GLBNS
 * @classdesign It is a category.
 * @helps NSSet
 * @brief NSSet category.
 * @discussion It is extension for NSSet class. Advantages is that the operations of mutation are applied to immutable set.
 * @remark Very useful methods ;)
 * @version 0.1
 */
@interface NSSet< __covariant ObjectType > (GLB_NS)

/**
 * @brief Adds an object to the immutable set.
 * @discussion You can add new object into the original immutable set.
 * @param The original set.
 * @param The object.
 * @return New immutable set.
 * @code
 * [NSSet glb_setWithSet:set addingObject:obj];
 * @endcode
 */
+ (instancetype _Nullable)glb_setWithSet:(NSSet< ObjectType >* _Nullable)set addingObject:(_Nonnull ObjectType)object;

/**
 * @brief Adds a set to the immutable set.
 * @discussion You can add the objects contained in another given set into original immutable set.
 * @param The original set.
 * @param The second set.
 * @return New immutable set.
 * @code
 * [NSSet glb_setWithSet:set1 addingObjectsFromSet:set2];
 * @endcode
 */
+ (instancetype _Nullable)glb_setWithSet:(NSSet< ObjectType >* _Nullable)set addingObjectsFromSet:(NSSet< ObjectType >* _Nonnull)addingObjects;

/**
 * @brief Removes occurrence in the set of a given object.
 * @discussion This method find and remove occurence an object from a given set.
 * @param The original set.
 * @param The object to remove from the set.
 * @return New immutable set.
 * @code
 * [NSSet glb_setWithSet:set removingObject:object];
 * @endcode
 */
+ (instancetype _Nullable)glb_setWithSet:(NSSet< ObjectType >* _Nullable)set removingObject:(_Nonnull ObjectType)object;

/**
 * @brief Removes occurrence in the set of a given objects form second set.
 * @discussion This method find and remove occurence for every object of the second set from a given set.
 * @param The original set.
 * @param The second set.
 * @return New immutable set.
 * @code
 * [NSSet glb_setWithSet:set1 removingObjectsInSet:set2];
 * @endcode
 */
+ (instancetype _Nullable)glb_setWithSet:(NSSet< ObjectType >* _Nullable)set removingObjectsInSet:(NSSet< ObjectType >* _Nonnull)removingObjects;

/**
 * @brief Removes all occurrences in the set of a given object.
 * @discussion This method find and remove all occurences an object from an set.
 * @param The object to remove from the set.
 * @return New immutable set.
 * @code
 * [NSSet glb_setByRemovedObject:object];
 * @endcode
 */
- (NSSet< ObjectType >* _Nullable)glb_setByRemovedObject:(_Nonnull ObjectType)object;

/**
 * @brief Removes occurrence in the set of a given objects in set.
 * @discussion This method find and remove occurence for every object of an given set from the set.
 * @param The set.
 * @return New immutable set.
 * @code
 * [NSSet glb_setByRemovedObjectsFromSet:set]];
 * @endcode
 */
- (NSSet< ObjectType >* _Nullable)glb_setByRemovedObjectsFromSet:(NSSet< ObjectType >* _Nonnull)set;

/**
 * @brief Finds all objects of a given class in the set.
 * @discussion This method will finds all occurrences of a specific object which is kind a class and return a new set with its.
 * @param The set.
 * @return New immutable set.
 * @code
 * [NSSet glb_setByObjectClass:class];
 * @endcode
 */
- (NSSet< ObjectType >* _Nullable)glb_setByObjectClass:(_Nonnull Class)objectClass;

/**
 * @brief Finds all objects conforms a given protocol.
 * @discussion This method will finds all occurrences of a specific objects which conforms a certain protocol and return a new set with its.
 * @param The object of protocol.
 * @return New immutable set.
 * @code
 * [NSSet glb_setByObjectProtocol:protocol];
 * @endcode
 */
- (NSSet< ObjectType >* _Nullable)glb_setByObjectProtocol:(Protocol* _Nonnull)objectProtocol;

/**
 * @brief Is there a given objects or not.
 * @discussion This method will search every object of a given set in original set.
 * @param The set.
 * @return Is there or not.
 * @code
 * [set glb_containsObjectsInSet:set];
 * @endcode
 */
- (BOOL)glb_containsObjectsInSet:(NSSet< ObjectType >* _Nonnull)objectsSet;

/**
 * @brief Iterate every elements of an original set.
 * @discussion You will get every element of an original set in the block.
 * @param The block with objects.
 * @code
 * [set glb_each:^(ObjectType* object){
 *     if ("it is right object") {
 *         //do what you want
 *     }
 * }];
 * @endcode
 */
- (void)glb_each:(void(^ _Nonnull)(_Nonnull ObjectType object))block;

/**
 * @brief Iterate every elements of an original set with options.
 * @discussion You will get every element of an original set in the block in forward or revers direction.
 * @param The block with object.
 * @param Options is NSEnumerationOptions.
 * @code
 * [set glb_each:^(ObjectType* object){
 *     if ("it is right object") {
 *         //do what you want
 *     }   options:NSEnumerationConcurrent];
 * @endcode
 */
- (void)glb_each:(void(^ _Nonnull)(_Nonnull ObjectType object))block options:(NSEnumerationOptions)options;

/**
 * @brief Compile a new set from given one.
 * @discussion In the block you will have every object of original set. You can do any operation with it and make a decision what to include to resulted set.
 * @param The block with object.
 * @return A new set.
 * @code
 * set2 = [set1 glb_map:^id (ObjectType* object){
 * if (object.field is right) {
 *     //make what you need and
 *     return what you need;
 * }
 * }];
 * @endcode
 */
- (NSSet* _Nullable)glb_map:(_Nullable id(^ _Nonnull)(_Nonnull ObjectType object))block;

/**
 * @brief Compile a dictionary of groups from original set.
 * @discussion In the block you will have every object of original set. You have to make a decision which group the item belongs and include to resulted dictionary key. Dictionary will contain several sets.
 * @param The block with object.
 * @return A dictionary.
 * @code
 * dictionary = [set glb_groupBy:^id (ObjectType* object){
 *     if ("it is right object") {
 *         return @"Key1";
 *     }
 * return @"Default Key";
 * }];
 * @endcode
 */
- (NSDictionary* _Nullable)glb_groupBy:(_Nullable id(^ _Nonnull)(_Nonnull ObjectType object))block;

/**
 * @brief Looking for objects with specified condition.
 * @discussion In the block you will have object so you have to make a decision needed or not the object. If object is needed you have to return YES so the object will be included to the result set.
 * @param The block with object.
 * @return A new set with selected items.
 * @code
 * set2 = [set1 glb_select:^id (ObjectType* object){
 *     if ("it is right object") {
 *         return YES;
 *     }
 * return NO;
 * }];
 * @endcode
 */
- (NSSet< ObjectType >* _Nullable)glb_select:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block;

/**
 * @brief Looking for objects with specified condition and remove it.
 * @discussion In the block you will have object so you have to make a decision needed or not the object. If object not needed you have to return YES so the object will NOT be included to the result set.
 * @param The block with object.
 * @return A new set with removed objects.
 * @code
 * set2 = [set1 glb_reject:^id (ObjectType* object){
 *     if ("it is right object") {
 *         return NO;
 *     }
 * return YES;
 * }];
 * @endcode
 */
- (NSSet< ObjectType >* _Nullable)glb_reject:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block;

/**
 * @brief Looking for object with specified condition.
 * @discussion In the block you will have object so you have to make a decision needed or not the object.
 * @param The block with object.
 * @return An object.
 * @code
 * ObjectType* object = [set1 glb_find:^id (ObjectType* obj){
 *     if ("it is right obj") {
 *         return YES;
 *     }
 * return NO;
 * }];
 * @endcode
 */
- (ObjectType _Nullable)glb_find:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block;

@end

/*--------------------------------------------------*/

/**
 * @file NSSet+GLBNS.h
 * @header NSSet+GLBNS.h
 * @class NSMutableSet+GLBNS
 * @classdesign It is a category.
 * @helps NSMutableSet
 * @brief NSMutableSet category.
 * @discussion It is extension for NSMutableSet class.
 * @remark Very useful methods ;)
 * @version 0.1
 */
@interface NSMutableSet (GLBNS)
@end

/*--------------------------------------------------*/
