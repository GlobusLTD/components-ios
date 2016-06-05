/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"

/*--------------------------------------------------*/

@interface NSURL (GLB_NS) < GLBObjectDebugProtocol >

- (NSDictionary* _Nullable)glb_queryComponents;
- (NSDictionary* _Nullable)glb_fragmentComponents;

@end

/*--------------------------------------------------*/
