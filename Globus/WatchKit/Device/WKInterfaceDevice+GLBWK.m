/*--------------------------------------------------*/

#import "WKInterfaceDevice+GLBWK.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_WATCHOS)
/*--------------------------------------------------*/

@implementation WKInterfaceDevice (GLB_WK)

+ (NSString*)glb_systemVersionString {
    static NSString* systemVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemVersion = self.currentDevice.systemVersion;
    });
    return systemVersion;
}

+ (NSComparisonResult)glb_compareSystemVersion:(NSString*)requiredVersion {
    return [self.glb_systemVersionString compare:requiredVersion options:NSNumericSearch];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
