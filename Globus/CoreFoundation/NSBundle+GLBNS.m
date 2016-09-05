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

#import "NSBundle+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSBundle (GLB_NS)

- (id)glb_objectForInfoDictionaryKey:(NSString*)key defaultValue:(id)defaultValue {
    id value = [self objectForInfoDictionaryKey:key];
    if(value == nil) {
        return defaultValue;
    }
    return value;
}

@end

/*--------------------------------------------------*/
