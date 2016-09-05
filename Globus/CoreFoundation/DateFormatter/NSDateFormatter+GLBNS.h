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
 * @file NSDateFormatter+GLBNS.h
 * @class NSDateFormatter+GLBNS
 * @classdesign It is a category
 * @helps NSDateFormatter
 * @brief Many helpful methods for NSDateFormatter support.
 * @discussion NSDateFormatter support for easily create, manage and work.
 * @remark Very useful methods ;)
 * @version 0.1
 */
@interface NSDateFormatter (GLB_NS)

/**
 * @brief Create NSDateFormatter with given format and current locale.
 * @discussion Create NSDateFormatter instance with given format and current locale.
 * @param String of format.
 * @return NSDateFormatter instance
 * @code
 * NSDateFormatter* formatter = [NSDateFormatter glb_dateFormatterWithFormat:@"dd-MM-yyyy"];
 * @endcode
 */
+ (_Nullable instancetype)glb_dateFormatterWithFormat:(NSString* _Nonnull)format;

/**
 * @brief Create NSDateFormatter with given format and given locale.
 * @discussion Create NSDateFormatter instance with given format in the necessary locale.
 * @param String of format.
 * @param Necessary locale.
 * @return NSDateFormatter instance
 * @code
 * NSDateFormatter* formatter = [NSDateFormatter glb_dateFormatterWithFormat:@"dd-MM-yyyy" locale:NSLocale.currentLocale];
 * @endcode
 */
+ (_Nullable instancetype)glb_dateFormatterWithFormat:(NSString* _Nonnull)format locale:(NSLocale* _Nullable)locale;

/**
 * @brief Create a NSDateFormatter with the right format to the current locale from a given template of format.
 * @discussion Create a NSDateFormatter instance with the right format to the current locale from a given template of format.
 * @param String of template of format.
 * @return NSDateFormatter instance
 * @code
 * NSDateFormatter* formatter = [NSDateFormatter glb_dateFormatterWithFormatTemplate:@"dd-MM-yyyy"];
 * @endcode
 */
+ (_Nullable instancetype)glb_dateFormatterWithFormatTemplate:(NSString* _Nonnull)formatTemplate;

/**
 * @brief Create a NSDateFormatter with the right format and the necessary locale from a given template of format.
 * @discussion Create a NSDateFormatter instance with the right format and the necessary locale from a given template of format.
 * @param String of template of format.
 * @param Necessary locale.
 * @return NSDateFormatter instance
 * @code
 * NSDateFormatter* formatter = [NSDateFormatter glb_dateFormatterWithFormatTemplate:@"dd-MM-yyyy" locale:NSLocale.currentLocale];
 * @endcode
 */
+ (_Nullable instancetype)glb_dateFormatterWithFormatTemplate:(NSString* _Nonnull)formatTemplate locale:(NSLocale* _Nullable)locale;

@end

/*--------------------------------------------------*/
