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

/*--------------------------------------------------*/

#import "NSDateFormatter+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSDateFormatter (GLB_NS)

+ (instancetype)glb_dateFormatterWithFormat:(NSString*)format {
    return [self glb_dateFormatterWithFormat:format locale:NSLocale.currentLocale];
}

+ (instancetype)glb_dateFormatterWithFormat:(NSString*)format locale:(NSLocale*)locale {
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = format;
    dateFormatter.locale = locale;
    return dateFormatter;
}

+ (instancetype)glb_dateFormatterWithFormatTemplate:(NSString*)formatTemplate {
    return [self glb_dateFormatterWithFormatTemplate:formatTemplate locale:NSLocale.currentLocale];
}

+ (instancetype)glb_dateFormatterWithFormatTemplate:(NSString*)formatTemplate locale:(NSLocale*)locale {
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:formatTemplate options:0 locale:locale];
    dateFormatter.locale = locale;
    return dateFormatter;
}

@end

/*--------------------------------------------------*/
