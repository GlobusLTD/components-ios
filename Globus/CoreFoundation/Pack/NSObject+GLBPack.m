/*--------------------------------------------------*/

#import "NSObject+GLBPack.h"

/*--------------------------------------------------*/

@implementation NSObject (GLB_NSPack)

+ (NSData*)glb_packObject:(id)object {
    NSData* data = nil;
    NSOutputStream* stream = [NSOutputStream outputStreamToMemory];
    if(stream != nil) {
        [stream open];
        [self glb_packObject:object stream:stream];
        data = [stream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
        [stream close];
    }
    return data;
}

+ (void)glb_packObject:(id)object stream:(NSOutputStream*)stream {
    if([object isKindOfClass:NSNumber.class] == YES) {
        NSNumber* number = object;
        CFNumberType numberType = CFNumberGetType((__bridge CFNumberRef)number);
        switch(numberType) {
            case kCFNumberSInt8Type:
            case kCFNumberCharType:
                [stream glb_uint8:GLBObjectPackTypeInt8];
                [stream glb_int8:number.charValue];
                break;
            case kCFNumberSInt16Type:
            case kCFNumberShortType:
                [stream glb_uint8:GLBObjectPackTypeInt16];
                [stream glb_int16:number.shortValue];
                break;
            case kCFNumberSInt32Type:
            case kCFNumberIntType:
            case kCFNumberCFIndexType:
            case kCFNumberNSIntegerType:
                [stream glb_uint8:GLBObjectPackTypeInt32];
                [stream glb_int32:number.intValue];
                break;
            case kCFNumberSInt64Type:
            case kCFNumberLongType:
            case kCFNumberLongLongType:
                [stream glb_uint8:GLBObjectPackTypeInt64];
                [stream glb_int64:number.longValue];
                break;
            case kCFNumberFloat32Type:
            case kCFNumberFloatType:
            case kCFNumberCGFloatType:
                [stream glb_uint8:GLBObjectPackTypeReal32];
                [stream glb_real32:number.floatValue];
                break;
            case kCFNumberFloat64Type:
            case kCFNumberDoubleType:
                [stream glb_uint8:GLBObjectPackTypeReal64];
                [stream glb_real64:number.doubleValue];
                break;
            default:
                break;
        }
    } else if([object isKindOfClass:NSString.class] == YES) {
        [stream glb_uint8:GLBObjectPackTypeString];
        [stream glb_string:object];
    } else if([object isKindOfClass:NSArray.class] == YES) {
        NSArray* array = object;
        [stream glb_uint8:GLBObjectPackTypeArray];
        [stream glb_uint32:(uint32_t)array.count];
        for(id item in array) {
            [self glb_packObject:item stream:stream];
        }
    } else if([object isKindOfClass:NSDictionary.class] == YES) {
        NSDictionary* dictionary = object;
        [stream glb_uint8:GLBObjectPackTypeDictionary];
        [stream glb_uint32:(uint32_t)dictionary.count];
        [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
            [self glb_packObject:key stream:stream];
            [self glb_packObject:obj stream:stream];
        }];
    } else {
        [stream glb_uint8:GLBObjectPackTypeUnknown];
    }
}

+ (id)glb_unpackFromData:(NSData*)data {
    id object = nil;
    NSInputStream* stream = [NSInputStream inputStreamWithData:data];
    if(stream != nil) {
        [stream open];
        object = [self glb_unpackFromStream:stream];
        [stream close];
    }
    return object;
}

+ (id)glb_unpackFromStream:(NSInputStream*)stream {
    GLBObjectPackType type = [stream glb_uint8];
    switch(type) {
        case GLBObjectPackTypeInt8:
            return @([stream glb_int8]);
        case GLBObjectPackTypeUInt8:
            return @([stream glb_uint8]);
        case GLBObjectPackTypeInt16:
            return @([stream glb_int16]);
        case GLBObjectPackTypeUInt16:
            return @([stream glb_uint16]);
        case GLBObjectPackTypeInt32:
            return @([stream glb_int32]);
        case GLBObjectPackTypeUInt32:
            return @([stream glb_uint32]);
        case GLBObjectPackTypeInt64:
            return @([stream glb_int64]);
        case GLBObjectPackTypeUInt64:
            return @([stream glb_uint64]);
        case GLBObjectPackTypeReal32:
            return @([stream glb_real32]);
        case GLBObjectPackTypeReal64:
            return @([stream glb_real64]);
        case GLBObjectPackTypeString:
            return [stream glb_string];
        case GLBObjectPackTypeArray: {
            uint32_t length = [stream glb_uint32];
            NSMutableArray* array = [NSMutableArray arrayWithCapacity:length];
            for(uint32_t i = 0; i < length; i++) {
                id item = [self glb_unpackFromStream:stream];
                if(item != nil) {
                    [array addObject:item];
                }
            }
            return array;
        }
        case GLBObjectPackTypeDictionary: {
            uint32_t length = [stream glb_uint32];
            NSMutableDictionary* dictionary = [NSMutableDictionary dictionaryWithCapacity:length];
            for(uint32_t i = 0; i < length; i++) {
                id key = [self glb_unpackFromStream:stream];
                id value = [self glb_unpackFromStream:stream];
                if((key != nil) && (value != nil)) {
                    dictionary[key] = value;
                }
            }
            return dictionary;
        }
        default:
            break;
    }
    return nil;
}

@end

/*--------------------------------------------------*/
