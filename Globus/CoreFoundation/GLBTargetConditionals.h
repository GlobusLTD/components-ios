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
#ifndef GLB_TARGET_CONDITIONS_H
#define GLB_TARGET_CONDITIONS_H
/*--------------------------------------------------*/

#include <TargetConditionals.h>
#include <tgmath.h>
#include <objc/runtime.h>

/*--------------------------------------------------*/

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

/*--------------------------------------------------*/
/* Detect target iOS                                */
/*--------------------------------------------------*/

#if defined(TARGET_OS_IOS)
#   if (TARGET_OS_IOS == 1)
#       define GLB_TARGET_IOS 1
#   endif
#else
#   if (TARGET_OS_IPHONE == 1)
#       define GLB_TARGET_IOS 1
#   endif
#endif

#if defined(TARGET_OS_SIMULATOR)
#   if (TARGET_OS_SIMULATOR == 1)
#       define GLB_TARGET_IOS_SIMULATOR 1
#   endif
#else
#   if (TARGET_IPHONE_SIMULATOR == 1)
#       define GLB_TARGET_IOS_SIMULATOR 1
#   endif
#endif

/*--------------------------------------------------*/
/* Detect target WatchOS                            */
/*--------------------------------------------------*/

#if defined(TARGET_OS_WATCH)
#   if (TARGET_OS_WATCH == 1)
#       define GLB_TARGET_WATCHOS 1
#   endif
#else
#   if (TARGET_OS_NANO == 1)
#       define GLB_TARGET_WATCHOS 1
#   endif
#endif

/*--------------------------------------------------*/
/* Macros                                           */
/*--------------------------------------------------*/

#define GLB_DEPRECATED __attribute__((deprecated))

/*--------------------------------------------------*/

#define GLB_XSTR(STR)                               #STR
#define GLB_STR(STR)                                GLB_XSTR(STR)

/*--------------------------------------------------*/

#define GLB_EXIST_CLASS(NAME)                       (objc_getClass(GLB_STR(NAME)) != nil)

/*--------------------------------------------------*/

#define GLB_DEG_TO_RAD                              0.0174532925f

/*--------------------------------------------------*/

#define GLB_COS(X)                                  __tg_cos(__tg_promote1((X))(X))
#define GLB_SIN(X)                                  __tg_sin(__tg_promote1((X))(X))
#define GLB_ATAN2(X, Y)                             __tg_atan2(__tg_promote2((X), (Y))(X), __tg_promote2((X), (Y))(Y))
#define GLB_POW(X, Y)                               __tg_pow(__tg_promote2((X), (Y))(X), __tg_promote2((X), (Y))(Y))
#define GLB_SQRT(X)                                 __tg_sqrt(__tg_promote1((X))(X))
#define GLB_FABS(X)                                 __tg_fabs(__tg_promote1((X))(X))
#define GLB_CEIL(X)                                 __tg_ceil(__tg_promote1((X))(X))
#define GLB_FLOOR(X)                                __tg_floor(__tg_promote1((X))(X))

/*--------------------------------------------------*/
/* Types                                            */
/*--------------------------------------------------*/

typedef void(^GLBSimpleBlock)();

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
