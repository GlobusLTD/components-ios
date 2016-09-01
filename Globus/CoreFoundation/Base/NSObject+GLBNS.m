/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSObject (GLB_NS)

+ (NSString*)glb_className {
    return NSStringFromClass(self.class);
}

- (NSString*)glb_className {
    return NSStringFromClass(self.class);
}

@end

/*--------------------------------------------------*/
