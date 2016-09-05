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

#import "NSURL+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSURL (GLB_NS)

- (NSDictionary*)glb_queryComponents {
    return self.query.glb_dictionaryFromQueryComponents;
}

- (NSDictionary*)glb_fragmentComponents {
    return self.fragment.glb_dictionaryFromQueryComponents;
}

@end

/*--------------------------------------------------*/
