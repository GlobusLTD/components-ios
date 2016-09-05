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
 * @file NSFileManager+GLBNS.h
 * @class NSFileManager+GLBNS
 * @classdesign It is a category
 * @helps NSFileManager
 * @brief Many helpful methods for NSFileManager support.
 * @discussion NSFileManager support for directory handle.
 * @remark Very useful methods ;)
 * @version 0.1
 */
@interface NSFileManager (GLB_NS)

/**
 * @brief Document directory.
 * @discussion Creates a path string for the document directory.
 * @return Document directory path string.
 * @code
 * NSString* s = [NSFileManager glb_documentDirectory];
 * @endcode
 */
+ (NSString* _Nullable)glb_documentDirectory;

/**
 * @brief Library directory.
 * @discussion Various user-visible documentation, support, and configuration files (/Library).
 * @return Library directory path string.
 * @code
 * NSString* s = [NSFileManager glb_libraryDirectory];
 * @endcode
 */
+ (NSString* _Nullable)glb_libraryDirectory;

/**
 * @brief Cache directory.
 * @discussion Location of cache files.
 * @return Cache directory path string.
 * @code
 * NSString* s = [NSFileManager glb_cachesDirectory];
 * @endcode
 */
+ (NSString* _Nullable)glb_cachesDirectory;

@end

/*--------------------------------------------------*/
