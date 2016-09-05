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

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

/**
 * @file NSObject+GLBNS.h
 * @class NSObject+GLBNS
 * @classdesign It is a category.
 * @helps NSObject
 * @brief NSObject category.
 * @discussion It is extension for a NSObject class. Advantages is that the methods are simple to use.
 * @remark Very useful methods ;)
 * @version 0.1
 */
@interface NSObject (GLB_NS)

/**
 * @brief Returns the name of a class as a string.
 * @discussion Returns the name of a class as a string.
 * @return A string containing the name of aClass. If aClass is nil, returns nil.
 * @code
 * [NSArray glb_className];
 * @endcode
 */
+ (NSString* _Nonnull)glb_className;

/**
 * @brief Returns the name of a class as a string.
 * @discussion Returns the name of a class as a string.
 * @return A string containing the name of aClass. If aClass is nil, returns nil.
 * @code
 * [NSArray glb_className];
 * @endcode
 */
- (NSString* _Nonnull)glb_className;

@end

/*--------------------------------------------------*/
