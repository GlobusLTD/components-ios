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

/**
 * @file NSAttributedString+GLBNS.h
 * @class NSAttributedString+GLBNS
 * @classdesign It is a category.
 * @helps NSAttributedString
 * @brief NSAttributedString category.
 * @discussion It is extension for NSAttributedString class.
 * @remark Very useful methods ;)
 * @version 0.1
 */
@interface NSAttributedString (GLBNS)

@end

/*--------------------------------------------------*/

/**
 * @file NSMutableAttributedString+GLBNS.h
 * @class NSMutableAttributedString+GLBNS
 * @classdesign It is a category.
 * @helps NSMutableAttributedString
 * @brief NSMutableAttributedString category.
 * @discussion It is extension for NSMutableAttributedString class.
 * @remark Very useful methods ;)
 * @version 0.1
 */
@interface NSMutableAttributedString (GLBNS)

/**
 * @brief Adds the characters to the end of the receiver.
 * @discussion Your current string will be concatenated with given string. Adds the characters and attributes of a given attributed string to the end of the receiver.
 * @param The second string.
 * @param The attribetes dictionary.
 * @return The range of given string in new one.
 * @code
 * NSRange range = [string glb_appendString:secondString attributes:attributesDictionary];
 * @endcode
 */
- (NSRange)glb_appendString:(NSString* _Nonnull)string attributes:(NSDictionary* _Nonnull)attributes;

@end

/*--------------------------------------------------*/
