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
 * @file NSOrderedSet+GLBNS.h
 * @class NSOrderedSet+GLBNS
 * @classdesign It is a category.
 * @helps NSOrderedSet
 * @brief NSOrderedSet category.
 * @discussion It is extension for NSOrderedSet class. Advantages is that the operations of mutation are applied to immutable orderedSet.
 * @remark Very useful methods ;)
 * @version 0.1
 */
@interface NSOrderedSet< __covariant ObjectType > (GLB_NS)

/**
 * @brief Adds an object to the immutable orderedSet.
 * @discussion You can add new object into the end of the immutable orderedSet.
 * @param The original orderedSet.
 * @param The object.
 * @return New immutable orderedSet.
 * @code
 * [NSOrderedSet glb_orderedSetWithOrderedSet:orderedSet addingObject:obj];
 * @endcode
 */
+ (instancetype _Nullable)glb_orderedSetWithOrderedSet:(NSOrderedSet< ObjectType >* _Nullable)orderedSet addingObject:(_Nonnull ObjectType)object;

/**
 * @brief Adds a orderedSet to the immutable orderedSet.
 * @discussion You can add the objects contained in another given orderedSet into the end of the immutable orderedSet.
 * @param The original orderedSet.
 * @param The second orderedSet.
 * @return New immutable orderedSet.
 * @code
 * [NSOrderedSet glb_orderedSetWithOrderedSet:orderedSet1 addingObjectsFromOrderedSet:orderedSet2];
 * @endcode
 */
+ (instancetype _Nullable)glb_orderedSetWithOrderedSet:(NSOrderedSet< ObjectType >* _Nullable)orderedSet addingObjectsFromOrderedSet:(NSOrderedSet< ObjectType >* _Nonnull)addingObjects;

/**
 * @brief Removes occurrence in the orderedSet of a given object.
 * @discussion This method find and remove occurence an object from a given orderedSet.
 * @param The original orderedSet.
 * @param The object to remove from the orderedSet.
 * @return New immutable orderedSet.
 * @code
 * [NSOrderedSet glb_orderedSetWithOrderedSet:orderedSet removingObject:object];
 * @endcode
 */
+ (instancetype _Nullable)glb_orderedSetWithOrderedSet:(NSOrderedSet< ObjectType >* _Nullable)orderedSet removingObject:(_Nonnull ObjectType)object;

/**
 * @brief Removes occurrence in the orderedSet of a given objects form second orderedSet.
 * @discussion This method find and remove occurence for every object of the second orderedSet from a given orderedSet.
 * @param The original orderedSet.
 * @param The second orderedSet.
 * @return New immutable orderedSet.
 * @code
 * [NSOrderedSet glb_orderedSetWithOrderedSet:orderedSet1 removingObjectsInOrderedSet:orderedSet2];
 * @endcode
 */
+ (instancetype _Nullable)glb_orderedSetWithOrderedSet:(NSOrderedSet< ObjectType >* _Nullable)orderedSet removingObjectsInOrderedSet:(NSOrderedSet< ObjectType >* _Nonnull)removingObjects;

/**
 * @brief Replaces an object at index in the orderedSet.
 * @discussion This method find, remove an old object and insert a new one into the orderedSet.
 * @param The object.
 * @param The index.
 * @return New immutable orderedSet.
 * @code
 * [OrderedSet glb_orderedSetByReplaceObject:object atIndex:index];
 * @endcode
 */
- (NSOrderedSet< ObjectType >* _Nullable)glb_orderedSetByReplaceObject:(_Nonnull ObjectType)object atIndex:(NSUInteger)index;

/**
 * @brief Removes an object in the orderedSet at index.
 * @discussion This method remove an object in orderedSet at index.
 * @param The index of removing object.
 * @return New immutable orderedSet.
 * @code
 * [NSOrderedSet glb_orderedSetByRemovedObjectAtIndex:index];
 * @endcode
 */
- (NSOrderedSet< ObjectType >* _Nullable)glb_orderedSetByRemovedObjectAtIndex:(NSUInteger)index;

/**
 * @brief Removes all occurrences in the orderedSet of a given object.
 * @discussion This method find and remove all occurences an object from an orderedSet.
 * @param The object to remove from the orderedSet.
 * @return New immutable orderedSet.
 * @code
 * [NSOrderedSet glb_orderedSetByRemovedObject:object];
 * @endcode
 */
- (NSOrderedSet< ObjectType >* _Nullable)glb_orderedSetByRemovedObject:(_Nonnull ObjectType)object;

/**
 * @brief Removes occurrence in the orderedSet of a given objects in orderedSet.
 * @discussion This method find and remove occurence for every object of an given orderedSet from the orderedSet.
 * @param The orderedSet.
 * @return New immutable orderedSet.
 * @code
 * [NSOrderedSet glb_orderedSetByRemovedObjectsFromOrderedSet:orderedSet]];
 * @endcode
 */
- (NSOrderedSet< ObjectType >* _Nullable)glb_orderedSetByRemovedObjectsFromOrderedSet:(NSOrderedSet< ObjectType >* _Nonnull)orderedSet;

/**
 * @brief Finds all objects of a given class in the orderedSet.
 * @discussion This method will finds all occurrences of a specific object which is kind a class and return a new orderedSet with its.
 * @param The orderedSet.
 * @return New immutable orderedSet.
 * @code
 * [NSOrderedSet glb_orderedSetByObjectClass:class];
 * @endcode
 */
- (NSOrderedSet< ObjectType >* _Nullable)glb_orderedSetByObjectClass:(_Nonnull Class)objectClass;

/**
 * @brief Finds all objects conforms a given protocol.
 * @discussion This method will finds all occurrences of a specific objects which conforms a certain protocol and return a new orderedSet with its.
 * @param The object of protocol.
 * @return New immutable orderedSet.
 * @code
 * [NSOrderedSet glb_orderedSetByObjectProtocol:protocol];
 * @endcode
 */
- (NSOrderedSet< ObjectType >* _Nullable)glb_orderedSetByObjectProtocol:(Protocol* _Nonnull)objectProtocol;

/**
 * @brief Finds the first object of certain class.
 * @discussion This method will finds first occurrence of a specific object which is kind a given class and return it.
 * @param The class.
 * @return Found object.
 * @code
 * id obj = [orderedSet glb_firstObjectIsClass:class];
 * @endcode
 */
- (_Nullable ObjectType)glb_firstObjectIsClass:(_Nonnull Class)objectClass;

/**
 * @brief Finds the last object of certain class.
 * @discussion This method will finds last occurrence of a specific object which is kind a given class and return it.
 * @param The class.
 * @return Found object.
 * @code
 * id obj = [orderedSet glb_firstObjectIsClass:class];
 * @endcode
 */
- (_Nullable ObjectType)glb_lastObjectIsClass:(_Nonnull Class)objectClass;

/**
 * @brief Finds the first object of certain protocol.
 * @discussion This method will finds first occurrence of a specific object which is conforms a given protocol and return it.
 * @param The protocol.
 * @return Found object.
 * @code
 * id obj = [orderedSet glb_firstObjectIsProtocol:protocol];
 * @endcode
 */
- (_Nullable ObjectType)glb_firstObjectIsProtocol:(Protocol* _Nonnull)objectProtocol;

/**
 * @brief Finds the last object of certain protocol.
 * @discussion This method will finds last occurrence of a specific object which is conforms a given protocol and return it.
 * @param The protocol.
 * @return Found object.
 * @code
 * id obj = [orderedSet glb_lastObjectIsProtocol:protocol];
 * @endcode
 */
- (_Nullable ObjectType)glb_lastObjectIsProtocol:(Protocol* _Nonnull)objectProtocol;

/**
 * @brief Is there a given objects or not.
 * @discussion This method will search every object of a given orderedSet in original orderedSet.
 * @param The orderedSet.
 * @return Is there or not.
 * @code
 * [orderedSet glb_containsObjectsInOrderedSet:orderedSet];
 * @endcode
 */
- (BOOL)glb_containsObjectsInOrderedSet:(NSOrderedSet< ObjectType >* _Nonnull)objectsOrderedSet;

/**
 * @brief Index of object next to the given object.
 * @discussion Index of object next to the given object.
 * @param The object.
 * @return Index.
 * @code
 * [orderedSet glb_nextIndexOfObject:object];
 * @endcode
 */
- (NSUInteger)glb_nextIndexOfObject:(_Nonnull ObjectType)object;

/**
 * @brief Index of object previouse to the given object.
 * @discussion Index of object previouse to the given object.
 * @param The object.
 * @return Index.
 * @code
 * [orderedSet glb_prevIndexOfObject:object];
 * @endcode
 */
- (NSUInteger)glb_prevIndexOfObject:(_Nonnull ObjectType)object;

/**
 * @brief Object next to the given object.
 * @discussion Object next to the given object.
 * @param The object.
 * @return The next object.
 * @code
 * [orderedSet glb_nextObjectOfObject:object];
 * @endcode
 */
- (_Nullable ObjectType)glb_nextObjectOfObject:(_Nonnull ObjectType)object;

/**
 * @brief Index of object previouse to the given object.
 * @discussion Index of object previouse to the given object.
 * @param The object.
 * @return The previoues object.
 * @code
 * [orderedSet glb_prevObjectOfObject:object];
 * @endcode
 */
- (_Nullable ObjectType)glb_prevObjectOfObject:(_Nonnull ObjectType)object;

/**
 * @brief Iterate every elements of an original orderedSet.
 * @discussion You will get every element of an original orderedSet in the block.
 * @param The block with object and its index.
 * @code
 * [orderedSet glb_each:^(ObjectType* object){
 *     if ("it is right object") {
 *         //do what you want
 *     }
 * }];
 * @endcode
 */
- (void)glb_each:(void(^ _Nonnull)(_Nonnull ObjectType object))block;

/**
 * @brief Iterate every elements of an original orderedSet but only in a given range.
 * @discussion You will get every element of an original orderedSet in the block but only in a given range.
 * @param The block with object.
 * @param The actual range.
 * @code
 * [orderedSet glb_each:^(ObjectType* object){
 *     if ("it is right object") {
 *         //do what you want
 *     } range:NSMakeRange(0,10)];
 * @endcode
 */
- (void)glb_each:(void(^ _Nonnull)(_Nonnull ObjectType object))block range:(NSRange)range;

/**
 * @brief Iterate every elements of an original orderedSet.
 * @discussion You will get every element of an original orderedSet in the block.
 * @param The block with object and its index.
 * @code
 * [orderedSet glb_each:^(ObjectType* object, NSUInteger index){
 *     if ("it is right object") {
 *         //do what you want
 *     }];
 * @endcode
 */
- (void)glb_eachWithIndex:(void(^ _Nonnull)(_Nonnull ObjectType object, NSUInteger index))block;

/**
 * @brief Iterate every elements of an original orderedSet but only in a given range.
 * @discussion You will get every element of an original orderedSet in the block but only in a given range.
 * @param The block with object and its index.
 * @param The actual range.
 * @code
 * [orderedSet glb_each:^(ObjectType* object, NSUInteger index){
 *     if ("it is right object") {
 *         //do what you want
 *     }     range:NSMakeRange(0,10)];
 * @endcode
 */
- (void)glb_eachWithIndex:(void(^ _Nonnull)(_Nonnull ObjectType object, NSUInteger index))block range:(NSRange)range;

/**
 * @brief Iterate every elements of an original orderedSet with options.
 * @discussion You will get every element of an original orderedSet in the block in forward or revers direction.
 * @param The block with object.
 * @param Options is NSEnumerationOptions.
 * @code
 * [orderedSet glb_each:^(ObjectType* object, NSUInteger index){
 *     if ("it is right object") {
 *         //do what you want
 *     }   options:NSEnumerationConcurrent];
 * @endcode
 */
- (void)glb_each:(void(^ _Nonnull)(_Nonnull ObjectType object))block options:(NSEnumerationOptions)options;

/**
 * @brief Iterate every elements of an original orderedSet but only in a given range with options.
 * @discussion You will get every element of an original orderedSet in the block but only in a given range in forward or revers direction.
 * @param The block with object.
 * @param The actual range.
 * @param Options is NSEnumerationOptions.
 * @code
 * [orderedSet glb_each:^(ObjectType* object, NSUInteger index){
 *     if ("it is right object") {
 *         //do what you want
 *     }     range:NSMakeRange(0,10)
 *         options:NSEnumerationConcurrent];
 * @endcode
 */
- (void)glb_each:(void(^ _Nonnull)(_Nonnull ObjectType object))block range:(NSRange)range options:(NSEnumerationOptions)options;

/**
 * @brief Iterate every elements of an original orderedSet with options.
 * @discussion You will get every element of an original orderedSet in the block in forward or revers direction.
 * @param The block with object and its index.
 * @param Options is NSEnumerationOptions.
 * @code
 * [orderedSet glb_eachWithIndex:^(ObjectType* object, NSUInteger index){
 *     if ("it is right object") {
 *         //do what you want
 *     } options:NSEnumerationConcurrent];
 * @endcode
 */
- (void)glb_eachWithIndex:(void(^ _Nonnull)(_Nonnull ObjectType object, NSUInteger index))block options:(NSEnumerationOptions)options;

/**
 * @brief Iterate every elements of an original orderedSet but only in a given range.
 * @discussion You will get every element of an original orderedSet in the block but only in a given range in forward or revers direction.
 * @param The block with object and its index.
 * @param The actual range.
 * @param Options is NSEnumerationOptions.
 * @code
 * [orderedSet glb_eachWithIndex:^(ObjectType* object, NSUInteger index){
 *     if ("it is right object") {
 *         //do what you want
 *     }              range:NSMakeRange(0,10) options:NSEnumerationConcurrent];
 * @endcode
 */
- (void)glb_eachWithIndex:(void(^ _Nonnull)(_Nonnull ObjectType object, NSUInteger index))block range:(NSRange)range options:(NSEnumerationOptions)options;

/**
 * @brief Compile a new orderedSet from given one.
 * @discussion In the block you will have every object of original orderedSet. You can do any operation with it and make a decision what to include to resulted orderedSet.
 * @param The block with object.
 * @return A new orderedSet.
 * @code
 * orderedSet2 = [orderedSet1 glb_map:^id (ObjectType* object){
 * if (object.field is right) {
 *     //make what you need and
 *     return what you need;
 * }
 * }];
 * @endcode
 */
- (NSOrderedSet* _Nullable)glb_map:(_Nullable id(^ _Nonnull)(_Nonnull ObjectType object))block;

/**
 * @brief Compile a dictionary of groups from original orderedSet.
 * @discussion In the block you will have every object of original orderedSet. You have to make a decision which group the item belongs and include to resulted dictionary key. Dictionary will contain several orderedSets.
 * @param The block with object.
 * @return A dictionary.
 * @code
 * dictionary = [orderedSet glb_groupBy:^id (ObjectType* object){
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
 * @discussion In the block you will have object so you have to make a decision needed or not the object. If object is needed you have to return YES so the object will be included to the result orderedSet.
 * @param The block with object.
 * @return A new orderedSet with selected items.
 * @code
 * orderedSet2 = [orderedSet1 glb_select:^id (ObjectType* object){
 *     if ("it is right object") {
 *         return YES;
 *     }
 * return NO;
 * }];
 * @endcode
 */
- (NSOrderedSet< ObjectType >* _Nullable)glb_select:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block;

/**
 * @brief Looking for objects with specified condition and remove it.
 * @discussion In the block you will have object so you have to make a decision needed or not the object. If object not needed you have to return YES so the object will NOT be included to the result orderedSet.
 * @param The block with object.
 * @return A new orderedSet with removed objects.
 * @code
 * orderedSet2 = [orderedSet1 glb_reject:^id (ObjectType* object){
 *     if ("it is right object") {
 *         return NO;
 *     }
 * return YES;
 * }];
 * @endcode
 */
- (NSOrderedSet< ObjectType >* _Nullable)glb_reject:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block;

/**
 * @brief Looking for object with specified condition.
 * @discussion In the block you will have object so you have to make a decision needed or not the object.
 * @param The block with object.
 * @return An object.
 * @code
 * ObjectType* object = [orderedSet1 glb_find:^id (ObjectType* obj){
 *     if ("it is right obj") {
 *         return YES;
 *     }
 * return NO;
 * }];
 * @endcode
 */
- (ObjectType _Nullable)glb_find:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block;

/**
 * @brief Looking for object with specified condition with options.
 * @discussion In the block you will have every object of the orderedSet so you have to make a decision needed or not the object and enumerate in forward or reverse direction.
 * @param The block with object.
 * @param Options is NSEnumerationOptions.
 * @return An object.
 * @code
 * ObjectType* object = [orderedSet1 glb_find:^id (ObjectType* obj){
 *     if ("it is right obj") {
 *         return YES;
 *     }
 * return NO;
 *                             } options:NSEnumerationConcurrent];
 * @endcode
 */
- (_Nullable ObjectType)glb_find:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block options:(NSEnumerationOptions)options;

/**
 * @brief Looking for object with specified condition and options in a given range.
 * @discussion In the block you will have every object of the orderedSet so you have to make a decision needed or not the object and enumerate in forward or reverse direction in a given range.
 * @param The block with object.
 * @param The actual range.
 * @param Options is NSEnumerationOptions.
 * @return An object.
 * @code
 * ObjectType* object = [orderedSet1 glb_find:^id (ObjectType* obj){
 *     if ("it is right obj") {
 *         return YES;
 *     }
 * return NO;
 *                               } range:NSMakeRange(0,10)
 *                               options:NSEnumerationConcurrent];
 * @endcode
 */
- (_Nullable ObjectType)glb_find:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block range:(NSRange)range options:(NSEnumerationOptions)options;

@end

/*--------------------------------------------------*/

/**
 * @file NSOrderedSet+GLBNS.h
 * @header NSOrderedSet+GLBNS.h
 * @class NSMutableOrderedSet+GLBNS
 * @classdesign It is a category.
 * @helps NSMutableOrderedSet
 * @brief NSMutableOrderedSet category.
 * @discussion It is extension for NSMutableOrderedSet class.
 * @remark Very useful methods ;)
 * @version 0.1
 */
@interface NSMutableOrderedSet (GLBNS)

/**
 * @brief Move object to the new position.
 * @discussion Move object to the new position.
 * @param Old index of moving object.
 * @param New index of moving object.
 * @code
 * [orderedSet glb_moveObjectAtIndex:1 toIndex:10];
 * @endcode
 */- (void)glb_moveObjectAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

/**
 * @brief Remove several objects.
 * @discussion Remove several objects from original orderedSet from beginning.
 * @param Count of objects.
 * @code
 * [orderedSet glb_removeFirstObjectsByCount:10];
 * @endcode
 */
- (void)glb_removeFirstObjectsByCount:(NSUInteger)count;

/**
 * @brief Remove several objects.
 * @discussion Remove several objects from original orderedSet from end.
 * @param Count of objects.
 * @code
 * [orderedSet glb_removeLastObjectsByCount:10];
 * @endcode
 */
- (void)glb_removeLastObjectsByCount:(NSUInteger)count;

@end

/*--------------------------------------------------*/
