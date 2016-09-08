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
 * @file NSArray+GLBNS.h
 * @class NSArray+GLBNS
 * @classdesign It is a category.
 * @helps NSArray
 * @brief NSArray category.
 * @discussion It is extension for NSArray class. Advantages is that the operations of mutation are applied to immutable arrays.
 * @remark Very useful methods ;)
 * @version 0.1
 */
@interface NSArray< __covariant ObjectType > (GLB_NS)

/**
 * @brief Adds an object to the immutable array.
 * @discussion You can add new object into the end of the immutable array.
 * @param The original array.
 * @param The object.
 * @return New immutable array.
 * @code
 * [NSArray glb_arrayWithArray:@[a, b, c] addingObject:obj];
 * @endcode
 */
+ (_Nullable instancetype)glb_arrayWithArray:(NSArray< ObjectType >* _Nullable)array addingObject:(ObjectType _Nonnull)object;

/**
 * @brief Adds an array to the immutable array.
 * @discussion You can add the objects contained in another given array into the end of the immutable array.
 * @param The original array.
 * @param The second array.
 * @return New immutable array.
 * @code
 * [NSArray glb_arrayWithArray:@[a, b, c] addingObjectsFromArray:@[d, e, f]];
 * @endcode
 */
+ (_Nullable instancetype)glb_arrayWithArray:(NSArray< ObjectType >* _Nullable)array addingObjectsFromArray:(NSArray< ObjectType >* _Nonnull)addingObjects;

/**
 * @brief Removes all occurrences in the array of a given object.
 * @discussion This method find and remove all occurences an object from a given array.
 * @param The original array.
 * @param The object to remove from the array.
 * @return New immutable array.
 * @code
 * [NSArray glb_arrayWithArray:@[a, b, c] removingObject:object];
 * @endcode
 */
+ (_Nullable instancetype)glb_arrayWithArray:(NSArray< ObjectType >* _Nullable)array removingObject:(ObjectType _Nonnull)object;

/**
 * @brief Removes all occurrences in the array of a given objects form second array.
 * @discussion This method find and remove all occurences for every object of the second array from a given array.
 * @param The original array.
 * @param The second array.
 * @return New immutable array.
 * @code
 * [NSArray glb_arrayWithArray:@[a, b, c] removingObjectsInArray:@[c, b]];
 * @endcode
 */
+ (_Nullable instancetype)glb_arrayWithArray:(NSArray< ObjectType >* _Nullable)array removingObjectsInArray:(NSArray< ObjectType >* _Nonnull)removingObjects;

/**
 * @brief Replaces an object at index in the array.
 * @discussion This method find, remove an old object and insert a new one into the array.
 * @param The object.
 * @param The index.
 * @return New immutable array.
 * @code
 * [array glb_arrayByReplaceObject:object atIndex:index];
 * @endcode
 */
- (NSArray< ObjectType >* _Nullable)glb_arrayByReplaceObject:(_Nonnull ObjectType)object atIndex:(NSUInteger)index;

/**
 * @brief Removes an object in the array at index.
 * @discussion This method remove an object in array at index.
 * @param The index of removing object.
 * @return New immutable array.
 * @code
 * [NSArray glb_arrayByRemovedObjectAtIndex:index];
 * @endcode
 */
- (NSArray< ObjectType >* _Nullable)glb_arrayByRemovedObjectAtIndex:(NSUInteger)index;

/**
 * @brief Removes all occurrences in the array of a given object.
 * @discussion This method find and remove all occurences an object from an array.
 * @param The object to remove from the array.
 * @return New immutable array.
 * @code
 * [NSArray glb_arrayByRemovedObject:object];
 * @endcode
 */
- (NSArray< ObjectType >* _Nullable)glb_arrayByRemovedObject:(_Nonnull ObjectType)object;

/**
 * @brief Removes all occurrences in the array of a given objects in array.
 * @discussion This method find and remove all occurences for every object of an given array from the array.
 * @param The array.
 * @return New immutable array.
 * @code
 * [NSArray glb_arrayByRemovedObjectsFromArray:@[a, b]];
 * @endcode
 */
- (NSArray< ObjectType >* _Nullable)glb_arrayByRemovedObjectsFromArray:(NSArray< ObjectType >* _Nonnull)array;

/**
 * @brief Finds all objects of a given class in the array.
 * @discussion This method will finds all occurrences of a specific object which is kind a class and return a new array with its.
 * @param The array.
 * @return New immutable array.
 * @code
 * [NSArray glb_arrayByObjectClass:class];
 * @endcode
 */
- (NSArray< ObjectType >* _Nullable)glb_arrayByObjectClass:(_Nonnull Class)objectClass;

/**
 * @brief Finds all objects conforms a given protocol.
 * @discussion This method will finds all occurrences of a specific objects which conforms a certain protocol and return a new array with its.
 * @param The object of protocol.
 * @return New immutable array.
 * @code
 * [NSArray glb_arrayByObjectProtocol:protocol];
 * @endcode
 */
- (NSArray< ObjectType >* _Nullable)glb_arrayByObjectProtocol:(Protocol* _Nonnull)objectProtocol;

/**
 * @brief Finds the first object of certain class.
 * @discussion This method will finds first occurrence of a specific object which is kind a given class and return it.
 * @param The class.
 * @return Found object.
 * @code
 * id obj = [array glb_firstObjectIsClass:class];
 * @endcode
 */
- (_Nullable ObjectType)glb_firstObjectIsClass:(_Nonnull Class)objectClass;

/**
 * @brief Finds the last object of certain class.
 * @discussion This method will finds last occurrence of a specific object which is kind a given class and return it.
 * @param The class.
 * @return Found object.
 * @code
 * id obj = [array glb_firstObjectIsClass:class];
 * @endcode
 */
- (_Nullable ObjectType)glb_lastObjectIsClass:(_Nonnull Class)objectClass;

/**
 * @brief Finds the first object of certain protocol.
 * @discussion This method will finds first occurrence of a specific object which is conforms a given protocol and return it.
 * @param The protocol.
 * @return Found object.
 * @code
 * id obj = [array glb_firstObjectIsProtocol:protocol];
 * @endcode
 */
- (_Nullable ObjectType)glb_firstObjectIsProtocol:(Protocol* _Nonnull)objectProtocol;

/**
 * @brief Finds the last object of certain protocol.
 * @discussion This method will finds last occurrence of a specific object which is conforms a given protocol and return it.
 * @param The protocol.
 * @return Found object.
 * @code
 * id obj = [array glb_lastObjectIsProtocol:protocol];
 * @endcode
 */
- (_Nullable ObjectType)glb_lastObjectIsProtocol:(Protocol* _Nonnull)objectProtocol;

/**
 * @brief Is there a given objects or not.
 * @discussion This method will search every object of a given array in original array.
 * @param The array.
 * @return Is there or not.
 * @code
 * [array glb_containsObjectsInArray:@[a, b, c]];
 * @endcode
 */
- (BOOL)glb_containsObjectsInArray:(NSArray< ObjectType >* _Nonnull)objectsArray;

/**
 * @brief Index of object next to the given object.
 * @discussion Index of object next to the given object.
 * @param The object.
 * @return Index.
 * @code
 * [array glb_nextIndexOfObject:object];
 * @endcode
 */
- (NSUInteger)glb_nextIndexOfObject:(_Nonnull ObjectType)object;

/**
 * @brief Index of object previouse to the given object.
 * @discussion Index of object previouse to the given object.
 * @param The object.
 * @return Index.
 * @code
 * [array glb_prevIndexOfObject:object];
 * @endcode
 */
- (NSUInteger)glb_prevIndexOfObject:(_Nonnull ObjectType)object;

/**
 * @brief Object next to the given object.
 * @discussion Object next to the given object.
 * @param The object.
 * @return The next object.
 * @code
 * [array glb_nextObjectOfObject:object];
 * @endcode
 */
- (_Nullable ObjectType)glb_nextObjectOfObject:(_Nonnull ObjectType)object;

/**
 * @brief Index of object previouse to the given object.
 * @discussion Index of object previouse to the given object.
 * @param The object.
 * @return The previoues object.
 * @code
 * [array glb_prevObjectOfObject:object];
 * @endcode
 */
- (_Nullable ObjectType)glb_prevObjectOfObject:(_Nonnull ObjectType)object;

/**
 * @brief Iterate every elements of an original array.
 * @discussion You will get every element of an original array in the block.
 * @param The block with object and its index.
 * @code
 * [array glb_each:^(ObjectType* object){
 *     if ("it is right object") {
 *         //do what you want
 *     }
 * }];
 * @endcode
 */
- (void)glb_each:(void(^ _Nonnull)(_Nonnull ObjectType object))block;

/**
 * @brief Iterate every elements of an original array but only in a given range.
 * @discussion You will get every element of an original array in the block but only in a given range.
 * @param The block with object.
 * @param The actual range.
 * @code
 * [array glb_each:^(ObjectType* object){
 *     if ("it is right object") {
 *         //do what you want
 *     } range:NSMakeRange(0,10)];
 * @endcode
 */
- (void)glb_each:(void(^ _Nonnull)(_Nonnull ObjectType object))block range:(NSRange)range;

/**
 * @brief Iterate every elements of an original array.
 * @discussion You will get every element of an original array in the block.
 * @param The block with object and its index.
 * @code
 * [array glb_each:^(ObjectType* object, NSUInteger index){
 *     if ("it is right object") {
 *         //do what you want
 *     }];
 * @endcode
 */
- (void)glb_eachWithIndex:(void(^ _Nonnull)(_Nonnull ObjectType object, NSUInteger index))block;

/**
 * @brief Iterate every elements of an original array but only in a given range.
 * @discussion You will get every element of an original array in the block but only in a given range.
 * @param The block with object and its index.
 * @param The actual range.
 * @code
 * [array glb_each:^(ObjectType* object, NSUInteger index){
 *     if ("it is right object") {
 *         //do what you want
 *     }     range:NSMakeRange(0,10)];
 * @endcode
 */
- (void)glb_eachWithIndex:(void(^ _Nonnull)(_Nonnull ObjectType object, NSUInteger index))block range:(NSRange)range;

/**
 * @brief Iterate every elements of an original array with options.
 * @discussion You will get every element of an original array in the block in forward or revers direction.
 * @param The block with object.
 * @param Options is NSEnumerationOptions.
 * @code
 * [array glb_each:^(ObjectType* object, NSUInteger index){
 *     if ("it is right object") {
 *         //do what you want
 *     }   options:NSEnumerationConcurrent];
 * @endcode
 */
- (void)glb_each:(void(^ _Nonnull)(_Nonnull ObjectType object))block options:(NSEnumerationOptions)options;

/**
 * @brief Iterate every elements of an original array but only in a given range with options.
 * @discussion You will get every element of an original array in the block but only in a given range in forward or revers direction.
 * @param The block with object.
 * @param The actual range.
 * @param Options is NSEnumerationOptions.
 * @code
 * [array glb_each:^(ObjectType* object, NSUInteger index){
 *     if ("it is right object") {
 *         //do what you want
 *     }     range:NSMakeRange(0,10) 
 *         options:NSEnumerationConcurrent];
 * @endcode
 */
- (void)glb_each:(void(^ _Nonnull)(_Nonnull ObjectType object))block range:(NSRange)range options:(NSEnumerationOptions)options;

/**
 * @brief Iterate every elements of an original array with options.
 * @discussion You will get every element of an original array in the block in forward or revers direction.
 * @param The block with object and its index.
 * @param Options is NSEnumerationOptions.
 * @code
 * [array glb_eachWithIndex:^(ObjectType* object, NSUInteger index){
 *     if ("it is right object") {
 *         //do what you want
 *     } options:NSEnumerationConcurrent];
 * @endcode
 */
- (void)glb_eachWithIndex:(void(^ _Nonnull)(_Nonnull ObjectType object, NSUInteger index))block options:(NSEnumerationOptions)options;

/**
 * @brief Iterate every elements of an original array but only in a given range.
 * @discussion You will get every element of an original array in the block but only in a given range in forward or revers direction.
 * @param The block with object and its index.
 * @param The actual range.
 * @param Options is NSEnumerationOptions.
 * @code
 * [array glb_eachWithIndex:^(ObjectType* object, NSUInteger index){
 *     if ("it is right object") {
 *         //do what you want
 *     }              range:NSMakeRange(0,10) options:NSEnumerationConcurrent];
 * @endcode
 */
- (void)glb_eachWithIndex:(void(^ _Nonnull)(_Nonnull ObjectType object, NSUInteger index))block range:(NSRange)range options:(NSEnumerationOptions)options;

/**
 * @brief Looking for duplicates.
 * @discussion In the block you will have two objects so you have to make comparison and return object if it's a duplicate or nil if it's not.
 * @param The block with two objects.
 * @return A new array.
 * @code
 * array2 = [array1 glb_duplicates:^id (ObjectType* object1, ObjectType* object2){}];
 * @endcode
 */
- (NSArray< ObjectType >* _Nullable)glb_duplicates:(id _Nullable(^ _Nonnull)(_Nonnull ObjectType object1, _Nonnull ObjectType object2))block;

/**
 * @brief Compile a new array from given one.
 * @discussion In the block you will have every object of original array. You can do any operation with it and make a decision what to include to resulted array.
 * @param The block with object.
 * @return A new array.
 * @code
 * array2 = [array1 glb_map:^id (ObjectType* object){
 * if (object.field is right) {
 *     //make what you need and
 *     return what you need;
 * }
 * }];
 * @endcode
 */
- (NSArray* _Nullable)glb_map:(_Nullable id(^ _Nonnull)(_Nonnull ObjectType object))block;

/**
 * @brief Compile a dictionary of groups from original array.
 * @discussion In the block you will have every object of original array. You have to make a decision which group the item belongs and include to resulted dictionary key. Dictionary will contain several arrays.
 * @param The block with object.
 * @return A dictionary.
 * @code
 * dictionary = [array glb_groupBy:^id (ObjectType* object){
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
 * @discussion In the block you will have object so you have to make a decision needed or not the object. If object is needed you have to return YES so the object will be included to the result array.
 * @param The block with object.
 * @return A new array with selected items.
 * @code
 * array2 = [array1 glb_select:^id (ObjectType* object){
 *     if ("it is right object") {
 *         return YES;
 *     }
 * return NO;
 * }];
 * @endcode
 */
- (NSArray< ObjectType >* _Nullable)glb_select:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block;

/**
 * @brief Looking for objects with specified condition and remove it.
 * @discussion In the block you will have object so you have to make a decision needed or not the object. If object not needed you have to return YES so the object will NOT be included to the result array.
 * @param The block with object.
 * @return A new array with removed objects.
 * @code
 * array2 = [array1 glb_reject:^id (ObjectType* object){
 *     if ("it is right object") {
 *         return NO;
 *     }
 * return YES;
 * }];
 * @endcode
 */
- (NSArray< ObjectType >* _Nullable)glb_reject:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block;

/**
 * @brief Looking for object with specified condition.
 * @discussion In the block you will have object so you have to make a decision needed or not the object.
 * @param The block with object.
 * @return An object.
 * @code
 * ObjectType* object = [array1 glb_find:^id (ObjectType* obj){
 *     if ("it is right obj") {
 *         return YES;
 *     }
 * return NO;
 * }];
 * @endcode
 */
- (_Nullable ObjectType)glb_find:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block;

/**
 * @brief Looking for object with specified condition with options.
 * @discussion In the block you will have every object of the array so you have to make a decision needed or not the object and enumerate in forward or reverse direction.
 * @param The block with object.
 * @param Options is NSEnumerationOptions.
 * @return An object.
 * @code
 * ObjectType* object = [array1 glb_find:^id (ObjectType* obj){
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
 * @discussion In the block you will have every object of the array so you have to make a decision needed or not the object and enumerate in forward or reverse direction in a given range.
 * @param The block with object.
 * @param The actual range.
 * @param Options is NSEnumerationOptions.
 * @return An object.
 * @code
 * ObjectType* object = [array1 glb_find:^id (ObjectType* obj){
 *     if ("it is right obj") {
 *         return YES;
 *     }
 * return NO;
 *                               } range:NSMakeRange(0,10) 
 *                               options:NSEnumerationConcurrent];
 * @endcode
 */
- (_Nullable ObjectType)glb_find:(BOOL(^ _Nonnull)(_Nonnull ObjectType object))block range:(NSRange)range options:(NSEnumerationOptions)options;

/**
 * @brief Reverse the array.
 * @discussion Reserse the array. The first object move to the end, the second object move to position of previous to last element.
 * @return An object.
 * @code
 * array2 = [array1 glb_reverse];
 * @endcode
 */
- (NSArray< ObjectType >* _Nullable)glb_reverse;

/**
 * @brief Intersection of two arrays.
 * @discussion Will be found all objects which present in both arrays.
 * @return A new array.
 * @code
 * array3 = [array1 glb_intersectionWithArray:array2];
 * @endcode
 */
- (NSArray< ObjectType >* _Nullable)glb_intersectionWithArray:(NSArray< ObjectType >* _Nonnull)array;

/**
 * @brief Intersection with many arrays.
 * @discussion Will be found all objects which present in all arrays.
 * @return A new array.
 * @code
 * array5 = [array1 glb_intersectionWithArrays:@[array2, array3, array4, nil]];
 * @endcode
 */
- (NSArray< ObjectType >* _Nullable)glb_intersectionWithArrays:(NSArray< ObjectType >* _Nonnull)firstArray, ... NS_REQUIRES_NIL_TERMINATION;

/**
 * @brief Union with of two arrays.
 * @discussion Will be created a new array of two original arrays without duplicates.
 * @param A second array.
 * @return A new array.
 * @code
 * array3 = [array1 glb_unionWithArray:array2];
 * @endcode
 */
- (NSArray< ObjectType >* _Nullable)glb_unionWithArray:(NSArray< ObjectType >* _Nonnull)array;

/**
 * @brief Union with many arrays.
 * @discussion Will be created a new array of all original arrays without duplicates.
 * @param A second array.
 * @return A new array.
 * @code
 * array5 = [array1 glb_unionWithArrays:@[array2, array3, array4, nil]];
 * @endcode
 */
- (NSArray< ObjectType >* _Nullable)glb_unionWithArrays:(NSArray< ObjectType >* _Nonnull)firstArray, ... NS_REQUIRES_NIL_TERMINATION;

/**
 * @brief The array that contains elements in second but not in original.
 * @discussion Given two arrays, array of result will contain exactly those elements belonging to Second but not to Original.
 * @param A second array.
 * @return A new array.
 * @code
 * array3 = [array1 glb_relativeComplement:array2];
 * @endcode
 */
- (NSArray< ObjectType >* _Nullable)glb_relativeComplement:(NSArray< ObjectType >* _Nonnull)array;

/**
 * @brief The array that contains elements in sequince of arrays but not in original array.
 * @discussion Given many arrays, array of result will contain exactly those elements belonging to all arrays but not to original.
 * @param A second array.
 * @return A new array.
 * @code
 * array5 = [array1 glb_relativeComplements:@[array2, array3, array4, nil]];
 * @endcode
 */
- (NSArray< ObjectType >* _Nullable)glb_relativeComplements:(NSArray< ObjectType >* _Nonnull)firstArray, ... NS_REQUIRES_NIL_TERMINATION;

/**
 * @brief Union with two arrays with unique objects.
 * @discussion Is the array of elements which are in either of the arrays and not in their intersection. In other words without elements which included in both arrays.
 * @param A second array.
 * @return A new array.
 * @code
 * array3 = [array1 glb_symmetricDifference:array2];
 * @endcode
 */
- (NSArray< ObjectType >* _Nullable)glb_symmetricDifference:(NSArray< ObjectType >* _Nonnull)array;

@end

/*--------------------------------------------------*/

/**
 * @file NSArray+GLBNS.h
 * @header NSMutableArray+GLBNS.h
 * @class NSMutableArray+GLBNS
 * @classdesign It is a category.
 * @helps NSMutableArray
 * @brief NSMutableArray category.
 * @discussion It is extension for NSMutableArray class.
 * @remark Very useful methods ;)
 * @version 0.1
 */
@interface NSMutableArray (GLBNS)

/**
 * @brief Move object to the new position.
 * @discussion Move object to the new position.
 * @param Old index of moving object.
 * @param New index of moving object.
 * @code
 * [array glb_moveObjectAtIndex:1 toIndex:10];
 * @endcode
 */
- (void)glb_moveObjectAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

/**
 * @brief Remove several objects.
 * @discussion Remove several objects from original array from beginning.
 * @param Count of objects.
 * @code
 * [array glb_removeFirstObjectsByCount:10];
 * @endcode
 */
- (void)glb_removeFirstObjectsByCount:(NSUInteger)count;

/**
 * @brief Remove several objects.
 * @discussion Remove several objects from original array from end.
 * @param Count of objects.
 * @code
 * [array glb_removeLastObjectsByCount:10];
 * @endcode
 */
- (void)glb_removeLastObjectsByCount:(NSUInteger)count;

@end

/*--------------------------------------------------*/
