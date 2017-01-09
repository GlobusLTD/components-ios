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

#import "NSStream+GLBNS.h"

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

@interface NSObject (GLB_NSPack)

+ (NSData* _Nullable)glb_packObject:(id _Nonnull)object;
+ (void)glb_packObject:(id _Nonnull)object stream:(NSOutputStream* _Nonnull)stream;

+ (id _Nullable)glb_unpackFromData:(NSData* _Nonnull)data;
+ (id _Nullable)glb_unpackFromStream:(NSInputStream* _Nonnull)stream;

@end

/*--------------------------------------------------*/
