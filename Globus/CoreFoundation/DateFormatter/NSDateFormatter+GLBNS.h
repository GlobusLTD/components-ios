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

#import "NSObject+GLBNS.h"

/*--------------------------------------------------*/

@interface NSDateFormatter (GLB_NS) < GLBObjectDebugProtocol >

+ (_Nullable instancetype)glb_dateFormatterWithFormat:(NSString* _Nonnull)format;
+ (_Nullable instancetype)glb_dateFormatterWithFormat:(NSString* _Nonnull)format locale:(NSLocale* _Nullable)locale;
+ (_Nullable instancetype)glb_dateFormatterWithFormatTemplate:(NSString* _Nonnull)formatTemplate;
+ (_Nullable instancetype)glb_dateFormatterWithFormatTemplate:(NSString* _Nonnull)formatTemplate locale:(NSLocale* _Nullable)locale;

@end

/*--------------------------------------------------*/
