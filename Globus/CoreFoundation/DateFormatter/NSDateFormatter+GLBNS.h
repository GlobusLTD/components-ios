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

@interface NSDateFormatter (GLB_NS)

+ (nonnull instancetype)glb_dateFormatterWithFormat:(nonnull NSString*)format;
+ (nonnull instancetype)glb_dateFormatterWithFormat:(nonnull NSString*)format locale:(nullable NSLocale*)locale;
+ (nonnull instancetype)glb_dateFormatterWithFormatTemplate:(nonnull NSString*)formatTemplate;
+ (nonnull instancetype)glb_dateFormatterWithFormatTemplate:(nonnull NSString*)formatTemplate locale:(nullable NSLocale*)locale;

@end

/*--------------------------------------------------*/
