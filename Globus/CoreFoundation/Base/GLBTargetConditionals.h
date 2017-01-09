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

/*--------------------------------------------------*/

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

/*--------------------------------------------------*/

#include <objc/runtime.h>

/*--------------------------------------------------*/

#include <tgmath.h>

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

#define GLB_DEPRECATED                              __attribute__((deprecated))
#define GLB_DEPRECATED_MSG(MSG)                     __attribute__((deprecated(MSG)))

#if defined(GLB_TARGET_IOS)
#   define GLB_UNAVAILABLE_IOS                      __attribute__((unavailable("Unavailable for iOS")))
#else
#   define GLB_UNAVAILABLE_IOS
#endif

#if defined(GLB_TARGET_IOS_SIMULATOR)
#   define GLB_UNAVAILABLE_IOS_SIMULATOR            __attribute__((unavailable("Unavailable for iOS Simulator")))
#else
#   define GLB_UNAVAILABLE_IOS_SIMULATOR
#endif

#if defined(GLB_TARGET_WATCHOS)
#   define GLB_UNAVAILABLE_WATCHOS                  __attribute__((unavailable("Unavailable for watchOS")))
#else
#   define GLB_UNAVAILABLE_WATCHOS
#endif

#define GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(NAME) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wobjc-designated-initializers\"") \
- (instancetype)NAME \
    { do { \
        NSAssert2(NO, @"%@ is not the designated initializer for instances of %@.", NSStringFromSelector(_cmd), NSStringFromClass([self class])); \
        return nil; \
    } while (0); \
} \
_Pragma("clang diagnostic pop")

/*--------------------------------------------------*/

#define GLB_XSTR(STR)                               #STR
#define GLB_STR(STR)                                GLB_XSTR(STR)

/*--------------------------------------------------*/

#define GLB_EXIST_CLASS(NAME)                       (objc_getClass(GLB_STR(NAME)) != nil)

/*--------------------------------------------------*/

#define GLB_DEG_TO_RAD                              0.0174532925f

/*--------------------------------------------------*/

#if (CGFLOAT_IS_DOUBLE == 1)
#define GLB_EPSILON                                 DBL_EPSILON
#else
#define GLB_EPSILON                                 FLT_EPSILON
#endif

#define GLB_ACOS(X)                                 __tg_acos((CGFloat)(X))
#define GLB_ASIN(X)                                 __tg_asin((CGFloat)(X))
#define GLB_ATAN(X)                                 __tg_atan((CGFloat)(X))
#define GLB_ACOSH(X)                                __tg_acosh((CGFloat)(X))
#define GLB_ASINH(X)                                __tg_asinh((CGFloat)(X))
#define GLB_ATANH(X)                                __tg_atanh((CGFloat)(X))
#define GLB_COS(X)                                  __tg_cos((CGFloat)(X))
#define GLB_SIN(X)                                  __tg_sin((CGFloat)(X))
#define GLB_TAN(X)                                  __tg_tan((CGFloat)(X))
#define GLB_COSH(X)                                 __tg_cosh((CGFloat)(X))
#define GLB_SINH(X)                                 __tg_sinh((CGFloat)(X))
#define GLB_TANH(X)                                 __tg_tanh((CGFloat)(X))
#define GLB_EXP(X)                                  __tg_exp((CGFloat)(X))
#define GLB_LOG(X)                                  __tg_log((CGFloat)(X))
#define GLB_POW(X, Y)                               __tg_pow((CGFloat)(X), (CGFloat)(Y))
#define GLB_SQRT(X)                                 __tg_sqrt((CGFloat)(X))
#define GLB_FABS(X)                                 __tg_fabs((CGFloat)(X))
#define GLB_ATAN2(X, Y)                             __tg_atan2((CGFloat)(X), (CGFloat)(Y))
#define GLB_CBRT(X)                                 __tg_cbrt((CGFloat)(X))
#define GLB_CEIL(X)                                 __tg_ceil((CGFloat)(X))
#define GLB_COPYSIGN(X, Y)                          __tg_copysign((CGFloat)(X), (CGFloat)(Y))
#define GLB_ERF(X)                                  __tg_erf((CGFloat)(X))
#define GLB_ERFC(X)                                 __tg_erfc((CGFloat)(X))
#define GLB_EXP2(X)                                 __tg_exp2((CGFloat)(X))
#define GLB_EXPM1(X)                                __tg_expm1((CGFloat)(X))
#define GLB_FDIM(X, Y)                              __tg_fdim((CGFloat)(X), (CGFloat)(Y))
#define GLB_FLOOR(X)                                __tg_floor((CGFloat)(X))
#define GLB_FMA(X, Y, Z)                            __tg_fma((CGFloat)(X), (CGFloat)(Y), (CGFloat)(Z))
#define GLB_FMAX(X, Y)                              __tg_fmax((CGFloat)(X), (CGFloat)(Y))
#define GLB_FMIN(X, Y)                              __tg_fmin((CGFloat)(X), (CGFloat)(Y))
#define GLB_FMOD(X, Y)                              __tg_fmod((CGFloat)(X), (CGFloat)(Y))
#define GLB_FREXP(X, Y)                             __tg_frexp((CGFloat)(X), Y)
#define GLB_HYPOT(X, Y)                             __tg_hypot((CGFloat)(X), (CGFloat)(Y))
#define GLB_ILOGB(X)                                __tg_ilogb((CGFloat)(X))
#define GLB_LDEXP(X, Y)                             __tg_ldexp((CGFloat)(X), Y)
#define GLB_LGAMMA(X)                               __tg_lgamma((CGFloat)(X))
#define GLB_LLRINT(X)                               __tg_llrint((CGFloat)(X))
#define GLB_LLROUND(X)                              __tg_llround((CGFloat)(X))
#define GLB_LOG10(X)                                __tg_log10((CGFloat)(X))
#define GLB_LOG1P(X)                                __tg_log1p((CGFloat)(X))
#define GLB_LOG2(X)                                 __tg_log2((CGFloat)(X))
#define GLB_LOGB(X)                                 __tg_logb((CGFloat)(X))
#define GLB_LRINT(X)                                __tg_lrint((CGFloat)(X))
#define GLB_LROUND(X)                               __tg_lround((CGFloat)(X))
#define GLB_NEARBYINT(X)                            __tg_nearbyint((CGFloat)(X))
#define GLB_NEXTAFTER(X, Y)                         __tg_nextafter((CGFloat)(X), (CGFloat)(Y))
#define GLB_NEXTTOWARD(X, Y)                        __tg_nexttoward((CGFloat)(X), (Y))
#define GLB_REMAINDER(X, Y)                         __tg_remainder((CGFloat)(X), (CGFloat)(Y)
#define GLB_REMQUO(X, Y, Z)                         __tg_remquo((CGFloat)(X), (CGFloat)(Y), (Z))
#define GLB_RINT(X)                                 __tg_rint((CGFloat)(X))
#define GLB_ROUND(X)                                __tg_round((CGFloat)(X))
#define GLB_SCALBN(X, Y)                            __tg_scalbn((CGFloat)(X), Y)
#define GLB_SCALBLN(X, Y)                           __tg_scalbln((CGFloat)(X), Y)
#define GLB_TGAMMA(X)                               __tg_tgamma((CGFloat)(X))
#define GLB_TRUNC(X)                                __tg_trunc((CGFloat)(X))
#define GLB_CARG(X)                                 __tg_carg((CGFloat)(X))
#define GLB_CIMAG(X)                                __tg_cimag((CGFloat)(X))
#define GLB_CONJ(X)                                 __tg_conj((CGFloat)(X))
#define GLB_CPROJ(X)                                __tg_cproj((CGFloat)(X))
#define GLB_CREAL(X)                                __tg_creal((CGFloat)(X))

/*--------------------------------------------------*/
/* Types                                            */
/*--------------------------------------------------*/

typedef void(^GLBSimpleBlock)();

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
