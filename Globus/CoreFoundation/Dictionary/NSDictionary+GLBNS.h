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

- (BOOL)glb_boolForKey:(KeyType _Nonnull)key orDefault:(BOOL)defaultValue;
- (NSInteger)glb_integerForKey:(KeyType _Nonnull)key orDefault:(NSInteger)defaultValue;
- (NSUInteger)glb_unsignedIntegerForKey:(KeyType _Nonnull)key orDefault:(NSUInteger)defaultValue;
- (float)glb_floatForKey:(KeyType _Nonnull)key orDefault:(float)defaultValue;
- (double)glb_doubleForKey:(KeyType _Nonnull)key orDefault:(double)defaultValue;
- (NSNumber* _Nullable)glb_numberForKey:(KeyType _Nonnull)key orDefault:(NSNumber* _Nullable)defaultValue;
- (NSString* _Nullable)glb_stringForKey:(KeyType _Nonnull)key orDefault:(NSString* _Nullable)defaultValue;
- (NSArray* _Nullable)glb_arrayForKey:(KeyType _Nonnull)key orDefault:(NSArray* _Nullable)defaultValue;
- (NSDictionary* _Nullable)glb_dictionaryForKey:(KeyType _Nonnull)key orDefault:(NSDictionary* _Nullable)defaultValue;
- (NSDate* _Nullable)glb_dateForKey:(KeyType _Nonnull)key orDefault:(NSDate* _Nullable)defaultValue;
- (NSData* _Nullable)glb_dataForKey:(KeyType _Nonnull)key orDefault:(NSData* _Nullable)defaultValue;
- (ObjectType _Nullable)glb_objectForKey:(KeyType _Nonnull)key orDefault:(ObjectType _Nullable)defaultValue;

- (NSString* _Nullable)glb_stringFromQueryComponents;

- (void)glb_each:(void(^ _Nonnull)(KeyType _Nonnull key, ObjectType _Nonnull value))block;
- (void)glb_eachWithIndex:(void(^ _Nonnull)(KeyType _Nonnull key, ObjectType _Nonnull value, NSUInteger index))block;
- (void)glb_eachKey:(void(^ _Nonnull)(KeyType _Nonnull key))block;
- (void)glb_eachKeyWithIndex:(void(^ _Nonnull)(KeyType _Nonnull key, NSUInteger index))block;
- (void)glb_eachValue:(void(^ _Nonnull)(ObjectType _Nonnull value))block;
- (void)glb_eachValueWithIndex:(void(^ _Nonnull)(ObjectType _Nonnull value, NSUInteger index))block;
- (NSArray* _Nonnull)glb_map:(id _Nullable(^ _Nonnull)(KeyType _Nonnull key, ObjectType _Nonnull value))block;
- (ObjectType _Nullable)glb_findObject:(BOOL(^ _Nonnull)(KeyType _Nonnull key, ObjectType _Nonnull value))block;
- (ObjectType _Nullable)glb_findObjectByKey:(BOOL(^ _Nonnull)(KeyType _Nonnull key))block;
- (BOOL)glb_hasKey:(KeyType _Nonnull)key;

@end

/*--------------------------------------------------*/
