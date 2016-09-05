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

#import "NSObject+GLBNS.h"

/*--------------------------------------------------*/

/**
 * @file NSError+GLBNS.h
 * @class NSError+GLBNS
 * @classdesign It is a category
 * @helps NSError
 * @brief Many helpful methods for NSError support.
 * @discussion NSError support for handle URL errors.
 * @remark Very useful methods ;)
 * @version 0.1
 */
@interface NSError (GLB_NS)

/**
 * @brief URL loading system errors.
 * @discussion Is this the URL loading system errors.
 * @return Is the error of URL error.
 * @code
 * if ([error glb_isURLError] == NO) {}
 * @endcode
 */
- (BOOL)glb_isURLError;

/**
 * @brief Connection not established.
 * @discussion Is this an internet connection not established error.
 * @return Is connection established.
 * @code
 * if ([error glb_URLErrorConnectedToInternet] == YES) {}
 * @endcode
 */
- (BOOL)glb_URLErrorConnectedToInternet;

/**
 * @brief An asynchronous load is canceled.
 * @discussion An asynchronous load is canceled.
 * @return Is loading canceled.
 * @code
 * if ([error glb_URLErrorCancelled] == YES) {}
 * @endcode
 */
- (BOOL)glb_URLErrorCancelled;

/**
 * @brief Is times out.
 * @discussion Is times over.
 * @return Is times out.
 * @code
 * if ([error glb_URLErrorTimedOut] == YES) {}
 * @endcode
 */
- (BOOL)glb_URLErrorTimedOut;

@end

/*--------------------------------------------------*/
