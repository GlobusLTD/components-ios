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

#import "NSObject+GLBNS.h"

/*--------------------------------------------------*/

/**
 * @file NSData+GLBNS.h
 * @class NSData+GLBNS
 * @classdesign It is a category.
 * @helps NSData
 * @brief Converting methods.
 * @discussion A couple useful methods for NSData class to convert into different presentation for later use.
 * @remark Very useful methods ;)
 * @version 0.1
 */
@interface NSData (GLB_NS) < GLBObjectDebugProtocol >

/**
 * @brief String to hex.
 * @discussion Create hex string from NSData. Hexadecimal notation is used as a human-friendly representation of binary values.
 * @return Hex string.
 * @code
 * NSString *str = @"string";
 * NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
 * NSString *hexString = [data glb_hexString];
 * @endcode
 */
- (NSString* _Nullable)glb_hexString;

/**
 * @brief Convert NSData to base 64 String.
 * @discussion Encode the binary data into characters.
 * @return Base 64 string.
 * @code
 * NSString *str = @"string";
 * NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
 * NSString *base64String = [data glb_base64String];
 * @endcode
 */
- (NSString* _Nullable)glb_base64String;

@end

/*--------------------------------------------------*/
