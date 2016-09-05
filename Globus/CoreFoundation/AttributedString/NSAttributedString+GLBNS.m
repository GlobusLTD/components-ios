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

#import "NSAttributedString+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSAttributedString (GLBNS)

@end

/*--------------------------------------------------*/

@implementation NSMutableAttributedString (GLBNS)

- (NSRange)glb_appendString:(NSString*)string attributes:(NSDictionary*)attributes {
    NSUInteger location = self.length;
    [self appendAttributedString:[[NSAttributedString alloc] initWithString:string attributes:attributes]];
    return NSMakeRange(location, string.length);
}

@end

/*--------------------------------------------------*/
