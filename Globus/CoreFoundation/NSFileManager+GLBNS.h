/**
 * This file is part of the GLB (the library of globus-ltd)
 * Copyright 2014-2016 Globus-LTD. http://www.globus-ltd.com
 * Created by Alexander Trifonov
 *
 * For the full copyright and license information, please view the LICENSE
 * file that contained MIT License
 * and was distributed with this source code.
 */

/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

@interface NSFileManager (GLB_NS)

+ (NSString* _Nullable)glb_documentDirectory;
+ (NSString* _Nullable)glb_libraryDirectory;
+ (NSString* _Nullable)glb_cachesDirectory;

@end

/*--------------------------------------------------*/
