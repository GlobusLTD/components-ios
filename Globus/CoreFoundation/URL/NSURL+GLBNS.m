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

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    [self.absoluteString glb_debugString:string context:context indent:indent root:root];
}

@end

/*--------------------------------------------------*/
