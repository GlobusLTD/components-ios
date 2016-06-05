/*--------------------------------------------------*/

#import "NSNull+GLBNS.h"
#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSNull (GLB_NS)

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    [string appendFormat:@"<NSNull>"];
}

@end

/*--------------------------------------------------*/
