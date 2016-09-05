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
 * @file NSHTTPCookieStorage+GLBNS.h
 * @class NSHTTPCookieStorage+GLBNS
 * @classdesign It is a category
 * @helps NSHTTPCookieStorage
 * @brief Many helpful methods for NSHTTPCookieStorage support.
 * @discussion NSHTTPCookieStorage support for coockie handle.
 * @remark Very useful methods ;)
 * @version 0.1
 */
@interface NSHTTPCookieStorage (GLB_NS)

/**
 * @brief Clear cookies.
 * @discussion Clear cookies cache.
 * @param URL string
 * @code
 * [NSHTTPCookieStorage glb_clearCookieWithDomain:urlString];
 * @endcode
 */
+ (void)glb_clearCookieWithDomain:(NSString* _Nonnull)domain;

@end

/*--------------------------------------------------*/
