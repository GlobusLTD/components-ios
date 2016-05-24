/*--------------------------------------------------*/

#import "GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef NS_ENUM(NSInteger, GLBDeviceFamily) {
    GLBDeviceFamilyUnknown = 0,
    GLBDeviceFamilyPhone,
    GLBDeviceFamilyPad,
    GLBDeviceFamilyPod,
    GLBDeviceFamilySimulator,
};

typedef NS_ENUM(NSInteger, GLBDeviceModel) {
    GLBDeviceModelUnknown = 0,
    GLBDeviceModelSimulatorPhone,
    GLBDeviceModelSimulatorPad,
    GLBDeviceModelSimulatorPadPro,
    GLBDeviceModelPhone1,
    GLBDeviceModelPhone3G,
    GLBDeviceModelPhone3GS,
    GLBDeviceModelPhone4,
    GLBDeviceModelPhone4S,
    GLBDeviceModelPhone5,
    GLBDeviceModelPhone5C,
    GLBDeviceModelPhone5S,
    GLBDeviceModelPhone6,
    GLBDeviceModelPhone6Plus,
    GLBDeviceModelPad1,
    GLBDeviceModelPad2,
    GLBDeviceModelPad3,
    GLBDeviceModelPad4,
    GLBDeviceModelPadMini1,
    GLBDeviceModelPadMini2,
    GLBDeviceModelPadMini3,
    GLBDeviceModelPadAir1,
    GLBDeviceModelPadAir2,
    GLBDeviceModelPadPro129,
    GLBDeviceModelPadPro97,
    GLBDeviceModelPod1,
    GLBDeviceModelPod2,
    GLBDeviceModelPod3,
    GLBDeviceModelPod4,
    GLBDeviceModelPod5,
};

typedef NS_ENUM(NSInteger, GLBDeviceDisplay) {
    GLBDeviceDisplayUnknown = 0,
    GLBDeviceDisplayPad,
    GLBDeviceDisplayPadPro,
    GLBDeviceDisplayPhone35Inch,
    GLBDeviceDisplayPhone4Inch,
    GLBDeviceDisplayPhone47Inch,
    GLBDeviceDisplayPhone55Inch,
};

/*--------------------------------------------------*/

@interface UIDevice (GLB_UI)

+ (CGFloat)glb_systemVersion;

+ (BOOL)glb_isSimulator;
+ (BOOL)glb_isIPhone;
+ (BOOL)glb_isIPad;

+ (void)glb_setOrientation:(UIInterfaceOrientation)orientation;

+ (NSString* _Nullable)glb_deviceTypeString;
+ (NSString* _Nullable)glb_deviceVersionString;

+ (GLBDeviceFamily)glb_family;
+ (GLBDeviceModel)glb_model;
+ (GLBDeviceDisplay)glb_display;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
