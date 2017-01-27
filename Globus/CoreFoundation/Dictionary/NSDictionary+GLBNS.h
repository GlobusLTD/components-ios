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
#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

@interface NSDictionary< KeyType, ObjectType > (GLB_NS)

- (BOOL)glb_boolForKey:(nonnull KeyType)key orDefault:(BOOL)defaultValue;
- (NSInteger)glb_integerForKey:(nonnull KeyType)key orDefault:(NSInteger)defaultValue;
- (NSUInteger)glb_unsignedIntegerForKey:(nonnull KeyType)key orDefault:(NSUInteger)defaultValue;
- (float)glb_floatForKey:(nonnull KeyType)key orDefault:(float)defaultValue;
- (double)glb_doubleForKey:(nonnull KeyType)key orDefault:(double)defaultValue;
- (nullable NSNumber*)glb_numberForKey:(nonnull KeyType)key orDefault:(nullable NSNumber*)defaultValue;
- (nullable NSString*)glb_stringForKey:(nonnull KeyType)key orDefault:(nullable NSString*)defaultValue;
- (nullable NSArray*)glb_arrayForKey:(nonnull KeyType)key orDefault:(nullable NSArray*)defaultValue;
- (nullable NSDictionary*)glb_dictionaryForKey:(nonnull KeyType)key orDefault:(nullable NSDictionary*)defaultValue;
- (nullable NSDate*)glb_dateForKey:(nonnull KeyType)key orDefault:(nullable NSDate*)defaultValue;
- (nullable NSData*)glb_dataForKey:(nonnull KeyType)key orDefault:(nullable NSData*)defaultValue;
- (nullable ObjectType)glb_objectForKey:(nonnull KeyType)key orDefault:(nullable ObjectType)defaultValue;

- (nullable NSString*)glb_stringFromQueryComponents;

- (void)glb_each:(void(^ _Nonnull)(KeyType _Nonnull key, ObjectType _Nonnull value))block;
- (void)glb_eachWithIndex:(void(^ _Nonnull)(KeyType _Nonnull key, ObjectType _Nonnull value, NSUInteger index))block;
- (void)glb_eachKey:(void(^ _Nonnull)(KeyType _Nonnull key))block;
- (void)glb_eachKeyWithIndex:(void(^ _Nonnull)(KeyType _Nonnull key, NSUInteger index))block;
- (void)glb_eachValue:(void(^ _Nonnull)(ObjectType _Nonnull value))block;
- (void)glb_eachValueWithIndex:(void(^ _Nonnull)(ObjectType _Nonnull value, NSUInteger index))block;
- (nonnull NSArray*)glb_map:(id _Nullable(^ _Nonnull)(KeyType _Nonnull key, ObjectType _Nonnull value))block;
- (nullable ObjectType)glb_findObject:(BOOL(^ _Nonnull)(KeyType _Nonnull key, ObjectType _Nonnull value))block;
- (nullable ObjectType)glb_findObjectByKey:(BOOL(^ _Nonnull)(KeyType _Nonnull key))block;
- (BOOL)glb_hasKey:(nonnull KeyType)key;

@end

/*--------------------------------------------------*/
