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

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

@interface NSObject (GLB_NS)

+ (nonnull NSString*)glb_className;
- (nonnull NSString*)glb_className;

- (BOOL)glb_isNull;
- (BOOL)glb_isNumber;
- (BOOL)glb_isDecimalNumber;
- (BOOL)glb_isString;
- (BOOL)glb_isUrl;

- (BOOL)glb_isArray;
- (BOOL)glb_isSet;
- (BOOL)glb_isOrderedSet;
- (BOOL)glb_isDictionary;

- (BOOL)glb_isMutableArray;
- (BOOL)glb_isMutableSet;
- (BOOL)glb_isMutableOrderedSet;
- (BOOL)glb_isMutableDictionary;

@end

/*--------------------------------------------------*/
