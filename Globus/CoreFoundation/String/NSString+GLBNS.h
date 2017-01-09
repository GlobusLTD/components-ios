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

+ (instancetype _Nonnull)glb_stringWithData:(NSData* _Nonnull)data encoding:(NSStringEncoding)encoding;

- (NSString* _Nonnull)glb_stringByUppercaseFirstCharacterString;
- (NSString* _Nonnull)glb_stringByLowercaseFirstCharacterString;

- (NSString* _Nonnull)glb_stringByMD5;
- (NSString* _Nonnull)glb_stringBySHA256;

- (NSString* _Nullable)glb_stringByDecodingURLFormat;
- (NSString* _Nullable)glb_stringByEncodingURLFormat;
- (NSDictionary* _Nonnull)glb_dictionaryFromQueryComponents;

- (BOOL)glb_isEmail;

- (NSData* _Nonnull)glb_dataHmacSha1WithKey:(NSString* _Nonnull)key;

- (BOOL)glb_bool;
- (NSNumber* _Nullable)glb_number;
- (NSDate* _Nullable)glb_dateWithFormat:(NSString* _Nonnull)format;

- (NSArray* _Nonnull)glb_charactersArray;

- (UInt32)glb_crc32;

@end

/*--------------------------------------------------*/

@interface NSMutableString (GLB_NS)

+ (instancetype _Nonnull)glb_stringWithString:(NSString* _Nonnull)string repeat:(NSUInteger)repeat;

- (void)glb_appendString:(NSString* _Nonnull)string repeat:(NSUInteger)repeat;

@end

/*--------------------------------------------------*/
