/*--------------------------------------------------*/

#import "UIDevice+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import <sys/utsname.h>

/*--------------------------------------------------*/

static NSNumber* GLB_SystemVersion = nil;
static NSString* GLB_SystemVersionString = nil;
static NSString* GLB_DeviceTypeString = nil;
static NSString* GLB_DeviceVersionString = nil;
static GLBDeviceFamily GLB_DeviceFamily = GLBDeviceFamilyUnknown;
static GLBDeviceModel GLB_DeviceModel = GLBDeviceModelUnknown;

/*--------------------------------------------------*/

@implementation UIDevice (GLB_UI)

+ (CGFloat)glb_systemVersion {
    if(GLB_SystemVersion == nil) {
        GLB_SystemVersion = @(self.currentDevice.systemVersion.floatValue);
    }
    return GLB_SystemVersion.floatValue;
}

+ (NSString*)glb_systemVersionString {
    if(GLB_SystemVersionString == nil) {
        GLB_SystemVersionString = self.currentDevice.systemVersion;
    }
    return GLB_SystemVersionString;
}

+ (NSComparisonResult)glb_compareSystemVersion:(NSString*)requiredVersion {
    return [self.glb_systemVersionString compare:requiredVersion options:NSNumericSearch];
}

+ (BOOL)glb_isSimulator {
#ifdef GLB_SIMULATOR
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
    if(GLB_DeviceTypeString == nil) {
        struct utsname systemInfo;
        uname(&systemInfo);
        GLB_DeviceTypeString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    }
    return GLB_DeviceTypeString;
}

+ (NSString*)glb_deviceVersionString {
    if(GLB_DeviceVersionString == nil) {
        NSString* deviceType = self.glb_deviceTypeString;
        NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]{1,},[0-9]{1,}" options:0 error:nil];
        NSRange rangeOfVersion = [regex rangeOfFirstMatchInString:deviceType options:0 range:NSMakeRange(0, deviceType.length)];
        if((rangeOfVersion.location != NSNotFound) && (rangeOfVersion.length > 0)) {
            GLB_DeviceVersionString = [deviceType substringWithRange:rangeOfVersion];
        }
    }
    return GLB_DeviceVersionString;
}

+ (GLBDeviceFamily)glb_family {
    if(GLB_DeviceFamily == GLBDeviceFamilyUnknown) {
#ifdef GLB_SIMULATOR
        GLB_DeviceFamily = GLBDeviceFamilySimulator;
#else
        NSDictionary* modelManifest = @{
            @"iPhone": @(GLBDeviceFamilyPhone),
            @"iPad": @(GLBDeviceFamilyPad),
            @"iPod": @(GLBDeviceFamilyPod),
        };
        NSString* deviceType = self.glb_deviceTypeString;
        [modelManifest enumerateKeysAndObjectsUsingBlock:^(NSString* string, NSNumber* number, BOOL* stop) {
            if([deviceType hasPrefix:string]) {
                GLB_DeviceFamily = (GLBDeviceFamily)number.unsignedIntegerValue;
                *stop = YES;
            }
        }];
#endif
    }
    return GLB_DeviceFamily;
}

+ (GLBDeviceModel)glb_model {
    if(GLB_DeviceModel == GLBDeviceModelUnknown) {
#ifdef GLB_SIMULATOR
        switch(UI_USER_INTERFACE_IDIOM()) {
            case UIUserInterfaceIdiomPhone:
                switch(self.glb_display) {
                    case GLBDeviceDisplayPhone35Inch: GLB_DeviceModel = GLBDeviceModelPhone4S; break;
                    case GLBDeviceDisplayPhone4Inch: GLB_DeviceModel = GLBDeviceModelPhone5S; break;
                    case GLBDeviceDisplayPhone47Inch: GLB_DeviceModel = GLBDeviceModelPhone6; break;
                    case GLBDeviceDisplayPhone55Inch: GLB_DeviceModel = GLBDeviceModelPhone6Plus; break;
                    default: GLB_DeviceModel = GLBDeviceModelSimulatorPhone; break;
                }
                break;
            case UIUserInterfaceIdiomPad: GLB_DeviceModel = GLBDeviceModelSimulatorPad; break;
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
            },
        };
        NSDictionary* modelManifest = familyModelManifest[@(self.glb_family)];
        if(modelManifest != nil) {
            NSNumber* modelType = modelManifest[self.glb_deviceVersionString];
            if(modelType != nil) {
                GLB_DeviceModel = (GLBDeviceModel)modelType.unsignedIntegerValue;
            }
        }
#endif
    }
    return GLB_DeviceModel;
}

+ (GLBDeviceDisplay)glb_display {
    static GLBDeviceDisplay displayType = GLBDeviceDisplayUnknown;
    if(displayType == GLBDeviceDisplayUnknown) {
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
    }
    return displayType;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
