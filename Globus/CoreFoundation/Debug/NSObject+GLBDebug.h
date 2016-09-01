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

#import "NSPointerArray+GLBNS.h"
#import "NSString+GLBNS.h"
#import "NSData+GLBNS.h"

/*--------------------------------------------------*/

@protocol GLBObjectDebugProtocol < NSObject >

@required
- (void)glb_debugString:(NSMutableString* _Nonnull)string context:(NSPointerArray* _Nonnull)context indent:(NSUInteger)indent root:(BOOL)root;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface NSObject (GLB_NSDebug) < GLBObjectDebugProtocol >

- (NSString* _Nullable)glb_debug;
- (NSString* _Nullable)glb_debugContext:(NSPointerArray* _Nullable)context indent:(NSUInteger)indent root:(BOOL)root;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface NSDictionary< KeyType, ObjectType > (GLB_NSDebug) < GLBObjectDebugProtocol >
@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface NSArray< __covariant ObjectType > (GLB_NSDebug) < GLBObjectDebugProtocol >
@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface NSOrderedSet< __covariant ObjectType > (GLB_NSDebug) < GLBObjectDebugProtocol >
@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface NSSet< __covariant ObjectType > (GLB_NSDebug) < GLBObjectDebugProtocol >
@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface NSPointerArray (GLB_NSDebug) < GLBObjectDebugProtocol >
@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface NSString (GLB_NSDebug) < GLBObjectDebugProtocol >
@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface NSNumber (GLB_NSDebug) < GLBObjectDebugProtocol >
@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface NSDate (GLB_NSDebug) < GLBObjectDebugProtocol >
@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface NSNull (GLB_NSDebug) < GLBObjectDebugProtocol >
@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface NSData (GLB_NSDebug) < GLBObjectDebugProtocol >
@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface NSURL (GLB_NSDebug) < GLBObjectDebugProtocol >
@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface NSError (GLB_NSDebug) < GLBObjectDebugProtocol >
@end

/*--------------------------------------------------*/
