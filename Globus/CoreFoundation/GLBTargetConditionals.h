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
#ifndef GLB_TARGET_CONDITIONS_H
#define GLB_TARGET_CONDITIONS_H
/*--------------------------------------------------*/

#include <TargetConditionals.h>

/*--------------------------------------------------*/

#import <Foundation/Foundation.h>

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

#define GLB_DEPRECATED __attribute__((deprecated))

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
