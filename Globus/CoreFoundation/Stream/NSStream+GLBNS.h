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

@interface NSInputStream (GLB_NS)

- (int8_t)glb_int8;
- (uint8_t)glb_uint8;
- (int16_t)glb_int16;
- (uint16_t)glb_uint16;
- (int32_t)glb_int32;
- (uint32_t)glb_uint32;
- (int64_t)glb_int64;
- (uint64_t)glb_uint64;
- (float)glb_real32;
- (double)glb_real64;
- (NSString* _Nullable)glb_string;
- (NSData* _Nullable)glb_data;

@end

/*--------------------------------------------------*/

@interface NSOutputStream (GLBNS)

- (void)glb_int8:(int8_t)value;
- (void)glb_uint8:(uint8_t)value;
- (void)glb_int16:(int16_t)value;
- (void)glb_uint16:(uint16_t)value;
- (void)glb_int32:(int32_t)value;
- (void)glb_uint32:(uint32_t)value;
- (void)glb_int64:(int64_t)value;
- (void)glb_uint64:(uint64_t)value;
- (void)glb_real32:(float)value;
- (void)glb_real64:(double)value;
- (void)glb_string:(NSString* _Nonnull)value;
- (void)glb_data:(NSData* _Nonnull)value;

@end

/*--------------------------------------------------*/
