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

#import "NSFileManager+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSFileManager (GLB_NS)

+ (NSString*)glb_documentDirectory {
    static NSString* result = nil;
    if(result == nil) {
        NSArray* directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        if(directories.count > 0) {
            result = directories.firstObject;
        }
    }
    return result;
}

+ (NSString*)glb_libraryDirectory {
    static NSString* result = nil;
    if(result == nil) {
        NSArray* directories = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        if(directories.count > 0) {
            result = directories.firstObject;
        }
    }
    return result;
}

+ (NSString*)glb_cachesDirectory {
    static NSString* result = nil;
    if(result == nil) {
        NSArray* directories = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        if(directories.count > 0) {
            result = directories.firstObject;
        }
    }
    return result;
}

@end

/*--------------------------------------------------*/
