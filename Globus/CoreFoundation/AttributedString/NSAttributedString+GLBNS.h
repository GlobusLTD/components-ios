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

@interface NSAttributedString (GLBNS)

@end

/*--------------------------------------------------*/

@interface NSMutableAttributedString (GLBNS)

- (NSRange)glb_appendString:(nonnull NSString*)string attributes:(nonnull NSDictionary*)attributes;

@end

/*--------------------------------------------------*/
