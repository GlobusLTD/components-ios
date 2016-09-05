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
 * @file NSBundle+GLBNS.h
 * @class NSBundle+GLBNS
 * @classdesign It is a category
 * @helps NSBundle
 * @brief An NSBundle object helps you access the code and resources in a bundle directory on disk.
 * @discussion Useful methods to work with resourses on disk. For example, to read images, default data etc.
 * @remark Very useful methods ;)
 * @version 0.1
 */
@interface NSBundle (GLB_NS)

/**
 * @brief Access to Info.plist fields. The value with key and default value for that.
 * @discussion Simpliest way to read from Info.plist file. If in the receiver's property list (Info.plist) no value for the given key will be returned default value.
 * @param Key.
 * @return Value with key or default value.
 */
- (_Nullable id)glb_objectForInfoDictionaryKey:(NSString* _Nullable)key defaultValue:(_Nullable id)defaultValue;

@end

/*--------------------------------------------------*/
