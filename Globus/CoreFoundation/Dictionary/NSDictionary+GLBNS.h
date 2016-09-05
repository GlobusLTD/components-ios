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
#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

/**
 * @file NSDictionary+GLBNS.h
 * @class NSDictionary+GLBNS
 * @classdesign It is a category
 * @helps NSDictionary
 * @brief Many helpful methods for NSDictionary support.
 * @discussion NSDictionary support for easily create, manage and work.
 * @remark Very useful methods ;)
 * @version 0.1
 */
@interface NSDictionary< KeyType, ObjectType > (GLB_NS)

/**
 * @brief Get the bool value for given key.
 * @discussion Get the boolean value for given key or return the default value if the key does not exist or if it can not be converted.
 * @param The key name.
 * @param The default value.
 * @return BOOL or default.
 * @code
 * BOOL b = [dictionary glb_boolForKey:@"key" orDefault:NO];
 * @endcode
 */
- (BOOL)glb_boolForKey:(_Nonnull KeyType)key orDefault:(BOOL)defaultValue;

/**
 * @brief Get the integer value for given key.
 * @discussion Get the integer value for given key or return the default value if the key does not exist or if it can not be converted.
 * @param The key name.
 * @param The default value.
 * @return NSInteger or default.
 * @code
 * NSInteger i = [dictionary glb_integerForKey:@"key" orDefault:0];
 * @endcode
 */
- (NSInteger)glb_integerForKey:(_Nonnull KeyType)key orDefault:(NSInteger)defaultValue;

/**
 * @brief Get the unsigned integer value for given key.
 * @discussion Get the unsigned integer value for given key or return the default value if the key does not exist or if it can not be converted.
 * @param The key name.
 * @param The default value.
 * @return NSUInteger or default.
 * @code
 * NSUInteger i = [dictionary glb_unsignedIntegerForKey:@"key" orDefault:0];
 * @endcode
 */
- (NSUInteger)glb_unsignedIntegerForKey:(_Nonnull KeyType)key orDefault:(NSUInteger)defaultValue;

/**
 * @brief Get the float value for given key.
 * @discussion Get the float value for given key or return the default value if the key does not exist or if it can not be converted.
 * @param The key name.
 * @param The default value.
 * @return float or default.
 * @code
 * float f = [dictionary glb_floatForKey:@"key" orDefault:0.0f];
 * @endcode
 */
- (float)glb_floatForKey:(_Nonnull KeyType)key orDefault:(float)defaultValue;

/**
 * @brief Get the double value for given key.
 * @discussion Get the double value for given key or return the default value if the key does not exist or if it can not be converted.
 * @param The key name.
 * @param The default value.
 * @return double or default.
 * @code
 * double d = [dictionary glb_doubleForKey:@"key" orDefault:0.0f];
 * @endcode
 */
- (double)glb_doubleForKey:(_Nonnull KeyType)key orDefault:(double)defaultValue;

/**
 * @brief Get the number value for given key.
 * @discussion Get the number value for given key or return the default value if the key does not exist or if it can not be converted.
 * @param The key name.
 * @param The default value.
 * @return NSNumber or default.
 * @code
 * NSNumber* n = [dictionary glb_numberForKey:@"key" orDefault:0.0f];
 * @endcode
 */
- (NSNumber* _Nullable)glb_numberForKey:(_Nonnull KeyType)key orDefault:(NSNumber* _Nullable)defaultValue;

/**
 * @brief Get the string value for given key.
 * @discussion Get the string value for given key or return the default value if the key does not exist or if it can not be converted.
 * @param The key name.
 * @param The default value.
 * @return NSString or default.
 * @code
 * NSString* s = [dictionary glb_stringForKey:@"key" orDefault:@""];
 * @endcode
 */
- (NSString* _Nullable)glb_stringForKey:(_Nonnull KeyType)key orDefault:(NSString* _Nullable)defaultValue;

/**
 * @brief Get the array for given key.
 * @discussion Get the array for given key or return the default value if the key does not existor if it can not be converted.
 * @param The key name.
 * @param The default value.
 * @return NSArray or default.
 * @code
 * NSArray* a = [dictionary glb_arrayForKey:@"key" orDefault:@[]];
 * @endcode
 */
- (NSArray* _Nullable)glb_arrayForKey:(_Nonnull KeyType)key orDefault:(NSArray* _Nullable)defaultValue;

/**
 * @brief Get the dictionary for given key.
 * @discussion Get the dictionary for given key or return the default value if the key does not exist or if it can not be converted.
 * @param The key name.
 * @param The default value.
 * @return NSDictionary or default.
 * @code
 * NSDictionary* d = [dictionary glb_dictionaryForKey:@"key" orDefault:@[]];
 * @endcode
 */
- (NSDictionary* _Nullable)glb_dictionaryForKey:(_Nonnull KeyType)key orDefault:(NSDictionary* _Nullable)defaultValue;

/**
 * @brief Get the date for given key.
 * @discussion Get the date for given key or return the default value if the key does not exist or if it can not be converted.
 * @param The key name.
 * @param The default value.
 * @return NSDate or default.
 * @code
 * NSDate* d = [dictionary glb_dateForKey:@"key" orDefault:NSDate.date];
 * @endcode
 */
- (NSDate* _Nullable)glb_dateForKey:(_Nonnull KeyType)key orDefault:(NSDate* _Nullable)defaultValue;

/**
 * @brief Get the data for given key.
 * @discussion Get the data for given key or return the default value if the key does not exist or if it can not be converted.
 * @param The key name.
 * @param The default value.
 * @return NSData or default.
 * @code
 * NSData* d = [dictionary glb_dateForKey:@"key" orDefault:NSData.data];
 * @endcode
 */
- (NSData* _Nullable)glb_dataForKey:(_Nonnull KeyType)key orDefault:(NSData* _Nullable)defaultValue;

/**
 * @brief Turn the dictionary to the string.
 * @discussion Turn all keys and values of the dictionary into a string of the form %@=%@.
 * @return NSString like %@=%@.
 * @code
 * NSString* s = [dictionary glb_stringFromQueryComponents];
 * @endcode
 */
- (NSString* _Nullable)glb_stringFromQueryComponents;

/**
 * @brief Iterate every pair of the key and the object.
 * @discussion You will get every element and its key of an original dictionary in the block.
 * @param The block with key and object.
 * @code
 * [dictionary glb_each:^(id  _Nonnull key, id  _Nonnull value){
 *     if ("it is right object") {
 *         //do what you want
 *     }
 * }];
 * @endcode
 */
- (void)glb_each:(void(^ _Nonnull)(_Nonnull KeyType key, _Nonnull ObjectType value))block;

/**
 * @brief Iterate every pair of the key and the object with its index.
 * @discussion You will get every element, its key and its index of an original dictionary in the block.
 * @param The block with key, object and index.
 * @code
 * [dictionary glb_eachWithIndex:^(id  _Nonnull key, id  _Nonnull value, NSUInteger index){
 *     if ("it is right object") {
 *         //do what you want
 *     }
 * }];
 * @endcode
 */
- (void)glb_eachWithIndex:(void(^ _Nonnull)(_Nonnull KeyType key, _Nonnull ObjectType value, NSUInteger index))block;

/**
 * @brief Iterate every key.
 * @discussion You will get every key of an original dictionary in the block.
 * @param The block with key.
 * @code
 * [dictionary glb_eachKey:^(id  _Nonnull key){
 *     if ("it is right object") {
 *         //do what you want
 *     }
 * }];
 * @endcode
 */
- (void)glb_eachKey:(void(^ _Nonnull)(_Nonnull KeyType key))block;

/**
 * @brief Iterate every key with its index.
 * @discussion You will get every key with its index of an original dictionary in the block.
 * @param The block with key and index.
 * @code
 * [dictionary glb_eachKeyWithIndex:^(id  _Nonnull key, NSUInteger index){
 *     if ("it is right object") {
 *         //do what you want
 *     }
 * }];
 * @endcode
 */
- (void)glb_eachKeyWithIndex:(void(^ _Nonnull)(_Nonnull KeyType key, NSUInteger index))block;

/**
 * @brief Iterate every value.
 * @discussion You will get every value of an original dictionary in the block.
 * @param The block with value.
 * @code
 * [dictionary glb_eachValue:^(id  _Nonnull value){
 *     if ("it is right object") {
 *         //do what you want
 *     }
 * }];
 * @endcode
 */
- (void)glb_eachValue:(void(^ _Nonnull)(_Nonnull ObjectType value))block;

/**
 * @brief Iterate every value with its index.
 * @discussion You will get every value with its index of an original dictionary in the block.
 * @param The block with key and index.
 * @code
 * [dictionary glb_eachValueWithIndex:^(id  _Nonnull value, NSUInteger index){
 *     if ("it is right object") {
 *         //do what you want
 *     }
 * }];
 * @endcode
 */
- (void)glb_eachValueWithIndex:(void(^ _Nonnull)(_Nonnull ObjectType value, NSUInteger index))block;

/**
 * @brief Compile a new array from a given dictionary.
 * @discussion In the block you will have every object of original dictionary. You can do any operation with it and make a decision what to include to resulted array.
 * @param The block with object.
 * @return A new array.
 * @code
 * array = [dictionary glb_map:^id _Nullable(id  _Nonnull key, id  _Nonnull value){
 *     if (object is right) {
 *         //make what you want
 *         return what you need;
 *     }
 * }];
 * @endcode
 */
- (NSArray* _Nullable)glb_map:(_Nullable id(^ _Nonnull)(_Nonnull KeyType key, _Nonnull ObjectType value))block;

/**
 * @brief Looking for object with specified condition.
 * @discussion In the block you will have object and its key so you have to make a decision needed or not the object.
 * @param The block with object.
 * @return An object.
 * @code
 * ObjectType* object = [array glb_findObject:^BOOL(id  _Nonnull key, id  _Nonnull value){
 *     if ("it is right obj") {
 *         return YES;
 *     }
 * return NO;
 * }];
 * @endcode
 */
- (_Nullable ObjectType)glb_findObject:(BOOL(^ _Nonnull)(_Nonnull KeyType key, _Nonnull ObjectType value))block;

/**
 * @brief Looking for object with specified condition.
 * @discussion In the block you will have key so you have to make a decision needed or not the object.
 * @param The block with object.
 * @return An object.
 * @code
 * ObjectType* object = [dictionary glb_findObjectByKey:^BOOL(id  _Nonnull key){
 *     if ("it is right key") {
 *         return YES;
 *     }
 * return NO;
 * }];
 * @endcode
 */
- (_Nullable ObjectType)glb_findObjectByKey:(BOOL(^ _Nonnull)(_Nonnull KeyType key))block;

/**
 * @brief Has a key or not.
 * @discussion Has the dictionary a given key or not.
 * @param Key.
 * @return Has a key or not.
 * @code
 * if ([dictionary glb_hasKey:@"key"] == YES) { }
 * @endcode
 */
- (BOOL)glb_hasKey:(_Nonnull KeyType)key;

@end

/*--------------------------------------------------*/
