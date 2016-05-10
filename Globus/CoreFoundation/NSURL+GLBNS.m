/*--------------------------------------------------*/

#import "NSURL+GLBNS.h"
#import "NSString+GLBNS.h"

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
