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

/*--------------------------------------------------*/

@interface NSString (GLB_NS)

+ (nonnull instancetype)glb_stringWithData:(nonnull NSData*)data encoding:(NSStringEncoding)encoding;

- (nonnull NSString*)glb_stringByUppercaseFirstCharacterString;
- (nonnull NSString*)glb_stringByLowercaseFirstCharacterString;

- (nonnull NSString*)glb_stringByMD5;
- (nonnull NSString*)glb_stringBySHA256;

- (nullable NSString*)glb_stringByDecodingURLFormat;
- (nullable NSString*)glb_stringByEncodingURLFormat;
- (nonnull NSDictionary*)glb_dictionaryFromQueryComponents;

- (BOOL)glb_isEmail;

- (nonnull NSData*)glb_dataHmacSha1WithKey:(nonnull NSString*)key;

- (BOOL)glb_bool;
- (nullable NSNumber*)glb_number;
- (nullable NSDecimalNumber*)glb_decimalNumber;
- (nullable NSDate*)glb_dateWithFormat:(nonnull NSString*)format;

- (nonnull NSArray*)glb_charactersArray;

- (UInt32)glb_crc32;

@end

/*--------------------------------------------------*/

@interface NSMutableString (GLB_NS)

+ (nonnull instancetype)glb_stringWithString:(nonnull NSString*)string repeat:(NSUInteger)repeat;

- (void)glb_appendString:(nonnull NSString*)string repeat:(NSUInteger)repeat;

@end

/*--------------------------------------------------*/
