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

@interface NSFileManager (GLB_NS)

+ (NSString* _Nonnull)glb_documentDirectory;
+ (NSString* _Nonnull)glb_libraryDirectory;
+ (NSString* _Nonnull)glb_cachesDirectory;

@end

/*--------------------------------------------------*/
