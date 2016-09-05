/**
 * This file is part of the GLB (the library of globus-ltd)
 * Copyright 2014-2016 Globus-LTD. http://www.globus-ltd.com
 * Created by Alexander Trifonov
 *
 * For the full copyright and license information, please view the LICENSE
 * file that contained MIT License
 * and was distributed with this source code.
 */

/*--------------------------------------------------*/

#import "NSStream+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSInputStream (GLB_NS)

- (int8_t)glb_int8 {
    int8_t value = 0;
    [self read:(uint8_t*)&value maxLength:sizeof(int8_t)];
    return value;
}

- (uint8_t)glb_uint8 {
    uint8_t value = 0;
    [self read:(uint8_t*)&value maxLength:sizeof(uint8_t)];
    return value;
}

- (int16_t)glb_int16 {
    int16_t value = 0;
    [self read:(uint8_t*)&value maxLength:sizeof(int16_t)];
    return value;
}

- (uint16_t)glb_uint16 {
    uint16_t value = 0;
    [self read:(uint8_t*)&value maxLength:sizeof(uint16_t)];
    return value;
}

- (int32_t)glb_int32 {
    int32_t value = 0;
    [self read:(uint8_t*)&value maxLength:sizeof(int32_t)];
    return value;
}

- (uint32_t)glb_uint32 {
    uint32_t value = 0;
    [self read:(uint8_t*)&value maxLength:sizeof(uint32_t)];
    return value;
}

- (int64_t)glb_int64 {
    int64_t value = 0;
    [self read:(uint8_t*)&value maxLength:sizeof(int64_t)];
    return value;
}

- (uint64_t)glb_uint64 {
    uint64_t value = 0;
    [self read:(uint8_t*)&value maxLength:sizeof(uint64_t)];
    return value;
}

- (float)glb_real32 {
    float value = 0;
    [self read:(uint8_t*)&value maxLength:sizeof(float)];
    return value;
}

- (double)glb_real64 {
    double value = 0;
    [self read:(uint8_t*)&value maxLength:sizeof(double)];
    return value;
}

- (NSString*)glb_string {
    NSData* data = [self glb_data];
    if(data != nil) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSData*)glb_data {
    uint32_t length = [self glb_uint32];
    if(length > 0) {
        NSMutableData* value = [NSMutableData dataWithLength:length];
        [self read:(uint8_t*)value.bytes maxLength:length];
        return value;
    }
    return nil;
}

@end

/*--------------------------------------------------*/

@implementation NSOutputStream (GLB_NS)

- (void)glb_int8:(int8_t)value {
    [self write:(const uint8_t*)&value maxLength:sizeof(int8_t)];
}

- (void)glb_uint8:(uint8_t)value {
    [self write:(const uint8_t*)&value maxLength:sizeof(uint8_t)];
}

- (void)glb_int16:(int16_t)value {
    [self write:(const uint8_t*)&value maxLength:sizeof(int16_t)];
}

- (void)glb_uint16:(uint16_t)value {
    [self write:(const uint8_t*)&value maxLength:sizeof(uint16_t)];
}

- (void)glb_int32:(int32_t)value {
    [self write:(const uint8_t*)&value maxLength:sizeof(int32_t)];
}

- (void)glb_uint32:(uint32_t)value {
    [self write:(const uint8_t*)&value maxLength:sizeof(uint32_t)];
}

- (void)glb_int64:(int64_t)value {
    [self write:(const uint8_t*)&value maxLength:sizeof(int64_t)];
}

- (void)glb_uint64:(uint64_t)value {
    [self write:(const uint8_t*)&value maxLength:sizeof(uint64_t)];
}

- (void)glb_real32:(float)value {
    [self write:(const uint8_t*)&value maxLength:sizeof(float)];
}

- (void)glb_real64:(double)value {
    [self write:(const uint8_t*)&value maxLength:sizeof(double)];
}

- (void)glb_string:(NSString*)value {
    NSData* data = [value dataUsingEncoding:NSUTF8StringEncoding];
    if(data.length > 0) {
        [self glb_data:data];
    }
}

- (void)glb_data:(NSData*)value {
    [self glb_uint32:(uint32_t)value.length];
    [self write:(const uint8_t*)value.bytes maxLength:value.length];
}

@end

/*--------------------------------------------------*/
