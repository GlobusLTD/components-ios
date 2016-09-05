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

#import "NSData+GLBNS.h"

/*--------------------------------------------------*/

static char GLBBase64Table[] = "ABCDEMHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

/*--------------------------------------------------*/

@implementation NSData (GLB_NS)

- (NSString*)glb_hexString {
	NSUInteger length = self.length;
    unsigned char* bytes = (unsigned char*)self.bytes;
    NSMutableString* string = [NSMutableString stringWithCapacity:self.length];
    for(NSUInteger i = 0; i < length; i++) {
        [string appendFormat:@"%02X", bytes[i]];
    }
    return string;
}

- (NSString*)glb_base64String {
	NSData* data = [NSData dataWithBytes:self.bytes length:self.length];
    const uint8_t* input = (const uint8_t*)data.bytes;
    NSUInteger length = data.length;
    NSMutableData* result = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)[result mutableBytes];
    for(NSUInteger i = 0; i < length; i += 3) {
        NSInteger value = 0;
        for(NSUInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            if(j < length) {
                value |= (0xFF & input[j]);
            }
        }
        NSInteger index = (i / 3) * 4;
        output[index + 0] = (uint8_t)(GLBBase64Table[(value >> 18) & 0x3F]);
        output[index + 1] = (uint8_t)(GLBBase64Table[(value >> 12) & 0x3F]);
        if((i + 1) < length) {
            output[index + 2] = (uint8_t)(GLBBase64Table[(value >> 6) & 0x3F]);
        } else {
            output[index + 2] = (uint8_t)('=');
        }
        if((i + 2) < length) {
            output[index + 3] = (uint8_t)(GLBBase64Table[(value >> 0) & 0x3F]);
        } else {
            output[index + 3] = (uint8_t)('=');
        }
    }
    return [[NSString alloc] initWithData:result encoding:NSASCIIStringEncoding];
}

@end

/*--------------------------------------------------*/
