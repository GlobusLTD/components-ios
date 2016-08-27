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

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

typedef NS_ENUM(uint8_t, GLBObjectPackType) {
    GLBObjectPackTypeUnknown,
    GLBObjectPackTypeInt8,
    GLBObjectPackTypeUInt8,
    GLBObjectPackTypeInt16,
    GLBObjectPackTypeUInt16,
    GLBObjectPackTypeInt32,
    GLBObjectPackTypeUInt32,
    GLBObjectPackTypeInt64,
    GLBObjectPackTypeUInt64,
    GLBObjectPackTypeReal32,
    GLBObjectPackTypeReal64,
    GLBObjectPackTypeString,
    GLBObjectPackTypeArray,
    GLBObjectPackTypeDictionary,
};

/*--------------------------------------------------*/

@protocol GLBObjectDebugProtocol < NSObject >

@required
- (void)glb_debugString:(NSMutableString* _Nonnull)string context:(NSPointerArray* _Nonnull)context indent:(NSUInteger)indent root:(BOOL)root;

@end

/*--------------------------------------------------*/

@interface NSObject (GLB_NS) < GLBObjectDebugProtocol >

+ (NSString* _Nonnull)glb_className;
- (NSString* _Nonnull)glb_className;

+ (NSData* _Nullable)glb_packObject:(_Nonnull id)object;
+ (void)glb_packObject:(_Nonnull id)object stream:(NSOutputStream* _Nonnull)stream;

+ (_Nullable id)glb_unpackFromData:(NSData* _Nonnull)data;
+ (_Nullable id)glb_unpackFromStream:(NSInputStream* _Nonnull)stream;

- (NSString* _Nullable)glb_debug;
- (NSString* _Nullable)glb_debugContext:(NSPointerArray* _Nullable)context indent:(NSUInteger)indent root:(BOOL)root;

@end

/*--------------------------------------------------*/
