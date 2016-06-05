/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"

/*--------------------------------------------------*/

@interface NSData (GLB_NS) < GLBObjectDebugProtocol >

- (NSString* _Nullable)glb_hexString;
- (NSString* _Nullable)glb_base64String;

@end

/*--------------------------------------------------*/
