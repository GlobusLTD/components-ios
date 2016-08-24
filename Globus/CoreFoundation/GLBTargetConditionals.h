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
