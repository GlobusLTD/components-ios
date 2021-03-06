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
#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

@interface NSURL (GLB_NS)

- (nullable NSDictionary*)glb_queryComponents;
- (nullable NSDictionary*)glb_fragmentComponents;

@end

/*--------------------------------------------------*/
