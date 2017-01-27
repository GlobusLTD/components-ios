/*--------------------------------------------------*/

#import "UIDevice+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import <sys/utsname.h>

/*--------------------------------------------------*/

@implementation UIDevice (GLB_UI)

+ (CGFloat)glb_systemVersion {
    static NSNumber* systemVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemVersion = @(self.currentDevice.systemVersion.floatValue);
    });
    return systemVersion.floatValue;
}

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

+ (BOOL)glb_isSimulator {
#ifdef GLB_TARGET_IOS_SIMULATOR
    return YES;
#else
    return NO;
#endif
}

+ (BOOL)glb_isIPhone {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

+ (BOOL)glb_isIPad {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

+ (void)glb_setOrientation:(UIInterfaceOrientation)orientation {
    [UIDevice.currentDevice setValue:@(orientation) forKey:@"orientation"];
}

+ (NSString*)glb_deviceTypeString {
    static NSString* deviceType = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        struct utsname systemInfo;
        uname(&systemInfo);
        deviceType = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    });
    return deviceType;
}

+ (NSString*)glb_deviceVersionString {
    static NSString* deviceVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString* deviceType = self.glb_deviceTypeString;
        NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]{1,},[0-9]{1,}" options:(NSRegularExpressionOptions)0 error:nil];
        NSRange rangeOfVersion = [regex rangeOfFirstMatchInString:deviceType options:(NSMatchingOptions)0 range:NSMakeRange(0, deviceType.length)];
        if((rangeOfVersion.location != NSNotFound) && (rangeOfVersion.length > 0)) {
            deviceVersion = [deviceType substringWithRange:rangeOfVersion];
        }
    });
    return deviceVersion;
}

+ (GLBDeviceFamily)glb_family {
    static GLBDeviceFamily family = GLBDeviceFamilyUnknown;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#ifdef GLB_TARGET_IOS_SIMULATOR
        family = GLBDeviceFamilySimulator;
#else
        NSDictionary* modelManifest = @{
            @"iPhone": @(GLBDeviceFamilyPhone),
            @"iPad": @(GLBDeviceFamilyPad),
            @"iPod": @(GLBDeviceFamilyPod),
        };
        NSString* deviceType = self.glb_deviceTypeString;
        [modelManifest enumerateKeysAndObjectsUsingBlock:^(NSString* string, NSNumber* number, BOOL* stop) {
            if([deviceType hasPrefix:string] == YES) {
                family = (GLBDeviceFamily)(number.unsignedIntegerValue);
                *stop = YES;
            }
        }];
#endif
    });
    return family;
}

+ (GLBDeviceModel)glb_model {
    static GLBDeviceModel model = GLBDeviceModelUnknown;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#ifdef GLB_TARGET_IOS_SIMULATOR
        switch(UI_USER_INTERFACE_IDIOM()) {
            case UIUserInterfaceIdiomPhone:
                switch(self.glb_display) {
                    case GLBDeviceDisplayPhone35Inch: model = GLBDeviceModelPhone4S; break;
                    case GLBDeviceDisplayPhone4Inch: model = GLBDeviceModelPhone5S; break;
                    case GLBDeviceDisplayPhone47Inch: model = GLBDeviceModelPhone6; break;
                    case GLBDeviceDisplayPhone55Inch: model = GLBDeviceModelPhone6Plus; break;
                    default: model = GLBDeviceModelSimulatorPhone; break;
                }
                break;
            case UIUserInterfaceIdiomPad: model = GLBDeviceModelSimulatorPad; break;
            default: break;
        }
#else
        NSDictionary* familyModelManifest = @{
            @(GLBDeviceFamilyPhone): @{
                @"1,1": @(GLBDeviceModelPhone1),
                @"1,2": @(GLBDeviceModelPhone3G),
                @"2,1": @(GLBDeviceModelPhone3GS),
                @"3,1": @(GLBDeviceModelPhone4),
                @"3,2": @(GLBDeviceModelPhone4),
                @"3,3": @(GLBDeviceModelPhone4),
                @"4,1": @(GLBDeviceModelPhone4S),
                @"5,1": @(GLBDeviceModelPhone5),
                @"5,2": @(GLBDeviceModelPhone5),
                @"5,3": @(GLBDeviceModelPhone5C),
                @"5,4": @(GLBDeviceModelPhone5C),
                @"6,1": @(GLBDeviceModelPhone5S),
                @"6,2": @(GLBDeviceModelPhone5S),
                @"7,1": @(GLBDeviceModelPhone6Plus),
                @"7,2": @(GLBDeviceModelPhone6),
                @"8,1": @(GLBDeviceModelPhone6S),
                @"8,2": @(GLBDeviceModelPhone6SPlus),
                @"8,4": @(GLBDeviceModelPhoneSE),
                @"9,1": @(GLBDeviceModelPhone7),
                @"9,2": @(GLBDeviceModelPhone7Plus),
                @"9,3": @(GLBDeviceModelPhone7),
                @"9,4": @(GLBDeviceModelPhone7Plus),
            },
            @(GLBDeviceFamilyPad): @{
                @"1,1": @(GLBDeviceModelPad1),
                @"2,1": @(GLBDeviceModelPad2),
                @"2,2": @(GLBDeviceModelPad2),
                @"2,3": @(GLBDeviceModelPad2),
                @"2,4": @(GLBDeviceModelPad2),
                @"2,5": @(GLBDeviceModelPadMini1),
                @"2,6": @(GLBDeviceModelPadMini1),
                @"2,7": @(GLBDeviceModelPadMini1),
                @"3,1": @(GLBDeviceModelPad3),
                @"3,2": @(GLBDeviceModelPad3),
                @"3,3": @(GLBDeviceModelPad3),
                @"3,4": @(GLBDeviceModelPad4),
                @"3,5": @(GLBDeviceModelPad4),
                @"3,6": @(GLBDeviceModelPad4),
                @"4,1": @(GLBDeviceModelPadAir1),
                @"4,2": @(GLBDeviceModelPadAir1),
                @"4,3": @(GLBDeviceModelPadAir1),
                @"4,4": @(GLBDeviceModelPadMini2),
                @"4,5": @(GLBDeviceModelPadMini2),
                @"4,6": @(GLBDeviceModelPadMini2),
                @"4,7": @(GLBDeviceModelPadMini3),
                @"4,8": @(GLBDeviceModelPadMini3),
                @"4,9": @(GLBDeviceModelPadMini3),
                @"5,1": @(GLBDeviceModelPadMini4),
                @"5,2": @(GLBDeviceModelPadMini4),
                @"5,3": @(GLBDeviceModelPadAir2),
                @"5,4": @(GLBDeviceModelPadAir2),
                @"6,3": @(GLBDeviceModelPadPro97),
                @"6,4": @(GLBDeviceModelPadPro97),
                @"6,7": @(GLBDeviceModelPadPro129),
                @"6,8": @(GLBDeviceModelPadPro129),
            },
            @(GLBDeviceFamilyPod): @{
                @"1,1": @(GLBDeviceModelPod1),
                @"2,1": @(GLBDeviceModelPod2),
                @"3,1": @(GLBDeviceModelPod3),
                @"4,1": @(GLBDeviceModelPod4),
                @"5,1": @(GLBDeviceModelPod5),
                @"7,1": @(GLBDeviceModelPod6),
            },
        };
        NSDictionary* modelManifest = familyModelManifest[@(self.glb_family)];
        if(modelManifest != nil) {
            NSNumber* modelType = modelManifest[self.glb_deviceVersionString];
            if(modelType != nil) {
                model = (GLBDeviceModel)modelType.unsignedIntegerValue;
            }
        }
#endif
    });
    return model;
}

+ (GLBDeviceDisplay)glb_display {
    static GLBDeviceDisplay displayType = GLBDeviceDisplayUnknown;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGRect screenRect = UIScreen.mainScreen.bounds;
        CGFloat screenWidth = MAX(screenRect.size.width, screenRect.size.height);
        CGFloat screenHeight = MIN(screenRect.size.width, screenRect.size.height);
        switch(UI_USER_INTERFACE_IDIOM()) {
            case UIUserInterfaceIdiomPhone:
                if((screenWidth >= 736) && (screenHeight >= 414)) {
                    displayType = GLBDeviceDisplayPhone55Inch;
                } else if((screenWidth >= 667) && (screenHeight >= 375)) {
                    displayType = GLBDeviceDisplayPhone47Inch;
                } else if((screenWidth >= 568) && (screenHeight >= 320)) {
                    displayType = GLBDeviceDisplayPhone4Inch;
                } else if((screenWidth >= 480) && (screenHeight >= 320)) {
                    displayType = GLBDeviceDisplayPhone35Inch;
                }
                break;
            case UIUserInterfaceIdiomPad:
                if((screenWidth >= 1366) && (screenHeight >= 1024)) {
                    displayType = GLBDeviceDisplayPadPro;
                } else if((screenWidth >= 1024) && (screenHeight >= 768)) {
                    displayType = GLBDeviceDisplayPad;
                }

                break;
            default: break;
        }
    });
    return displayType;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
