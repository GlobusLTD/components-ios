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

- (BOOL)glb_boolForKey:(_Nonnull KeyType)key orDefault:(BOOL)defaultValue;
- (NSInteger)glb_integerForKey:(_Nonnull KeyType)key orDefault:(NSInteger)defaultValue;
- (NSUInteger)glb_unsignedIntegerForKey:(_Nonnull KeyType)key orDefault:(NSUInteger)defaultValue;
- (float)glb_floatForKey:(_Nonnull KeyType)key orDefault:(float)defaultValue;
- (double)glb_doubleForKey:(_Nonnull KeyType)key orDefault:(double)defaultValue;
- (NSNumber* _Nullable)glb_numberForKey:(_Nonnull KeyType)key orDefault:(NSNumber* _Nullable)defaultValue;
- (NSString* _Nullable)glb_stringForKey:(_Nonnull KeyType)key orDefault:(NSString* _Nullable)defaultValue;
- (NSArray* _Nullable)glb_arrayForKey:(_Nonnull KeyType)key orDefault:(NSArray* _Nullable)defaultValue;
- (NSDictionary* _Nullable)glb_dictionaryForKey:(_Nonnull KeyType)key orDefault:(NSDictionary* _Nullable)defaultValue;
- (NSDate* _Nullable)glb_dateForKey:(_Nonnull KeyType)key orDefault:(NSDate* _Nullable)defaultValue;
- (NSData* _Nullable)glb_dataForKey:(_Nonnull KeyType)key orDefault:(NSData* _Nullable)defaultValue;
- (_Nullable ObjectType)glb_objectForKey:(_Nonnull KeyType)key orDefault:(_Nullable ObjectType)defaultValue;

- (NSString* _Nullable)glb_stringFromQueryComponents;

- (void)glb_each:(void(^ _Nonnull)(_Nonnull KeyType key, _Nonnull ObjectType value))block;
- (void)glb_eachWithIndex:(void(^ _Nonnull)(_Nonnull KeyType key, _Nonnull ObjectType value, NSUInteger index))block;
- (void)glb_eachKey:(void(^ _Nonnull)(_Nonnull KeyType key))block;
- (void)glb_eachKeyWithIndex:(void(^ _Nonnull)(_Nonnull KeyType key, NSUInteger index))block;
- (void)glb_eachValue:(void(^ _Nonnull)(_Nonnull ObjectType value))block;
- (void)glb_eachValueWithIndex:(void(^ _Nonnull)(_Nonnull ObjectType value, NSUInteger index))block;
- (NSArray* _Nullable)glb_map:(_Nullable id(^ _Nonnull)(_Nonnull KeyType key, _Nonnull ObjectType value))block;
- (_Nullable ObjectType)glb_findObject:(BOOL(^ _Nonnull)(_Nonnull KeyType key, _Nonnull ObjectType value))block;
- (_Nullable ObjectType)glb_findObjectByKey:(BOOL(^ _Nonnull)(_Nonnull KeyType key))block;
- (BOOL)glb_hasKey:(_Nonnull KeyType)key;

@end

/*--------------------------------------------------*/
