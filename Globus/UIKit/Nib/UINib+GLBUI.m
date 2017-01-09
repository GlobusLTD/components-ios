/*--------------------------------------------------*/

#import "UINib+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

static NSMutableDictionary< NSString*, UINib* >* GLBNibCache = nil;

/*--------------------------------------------------*/

@implementation UINib (GLB_UI)

+ (UINib*)glb_nibWithName:(NSString*)name {
    return [self glb_nibWithName:name bundle:NSBundle.mainBundle];
}

+ (UINib*)glb_nibWithClass:(Class)aClass {
    NSBundle* bundle = [NSBundle bundleForClass:aClass];
    return [self glb_nibWithClass:aClass bundle:bundle];
}

+ (UINib*)glb_nibWithName:(NSString*)name bundle:(NSBundle*)bundle {
    UINib* nib = [self glb_cacheNibForName:name];
    if(nib == nil) {
        if(bundle == nil) {
            bundle = NSBundle.mainBundle;
        }
        NSMutableArray* nibNames = [NSMutableArray array];
        NSFileManager* fileManager = NSFileManager.defaultManager;
        if(UIDevice.glb_isIPhone) {
            NSString* phoneModelBaseName = [NSString stringWithFormat:@"%@%@", name, @"-iPhone"];
            switch(UIDevice.glb_model) {
                case GLBDeviceModelPhone7Plus:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", phoneModelBaseName, @"-7Plus"]];
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", phoneModelBaseName, @"-7+"]];
                case GLBDeviceModelPhone7:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", phoneModelBaseName, @"-7"]];
                case GLBDeviceModelPhone6Plus:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", phoneModelBaseName, @"-6Plus"]];
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", phoneModelBaseName, @"-6+"]];
                case GLBDeviceModelPhone6:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", phoneModelBaseName, @"-6"]];
                case GLBDeviceModelPhoneSE:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", phoneModelBaseName, @"-SE"]];
                case GLBDeviceModelPhone5S:
                case GLBDeviceModelPhone5C:
                case GLBDeviceModelPhone5:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", phoneModelBaseName, @"-5"]];
                case GLBDeviceModelPhone4S:
                case GLBDeviceModelPhone4:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", phoneModelBaseName, @"-4"]];
                case GLBDeviceModelPhone3GS:
                case GLBDeviceModelPhone3G:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", phoneModelBaseName, @"-3"]];
                default:
                    break;
            }
            [nibNames addObject:phoneModelBaseName];
            
            NSString* podModelBaseName = [NSString stringWithFormat:@"%@%@", name, @"-iPod"];
            switch(UIDevice.glb_model) {
                case GLBDeviceModelPod6:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", phoneModelBaseName, @"-6"]];
                case GLBDeviceModelPod5:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", phoneModelBaseName, @"-5"]];
                case GLBDeviceModelPod4:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", phoneModelBaseName, @"-4"]];
                case GLBDeviceModelPod3:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", phoneModelBaseName, @"-3"]];
                case GLBDeviceModelPod2:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", phoneModelBaseName, @"-2"]];
                case GLBDeviceModelPod1:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", phoneModelBaseName, @"-1"]];
                default:
                    break;
            }
            [nibNames addObject:podModelBaseName];
        } else if(UIDevice.glb_isIPad) {
            NSString* padModelBaseName = [NSString stringWithFormat:@"%@%@", name, @"-iPad"];
            switch(UIDevice.glb_model) {
                case GLBDeviceModelPadPro129:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", padModelBaseName, @"-Pro129"]];
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", padModelBaseName, @"-Pro"]];
                    break;
                case GLBDeviceModelPadPro97:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", padModelBaseName, @"-Pro97"]];
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", padModelBaseName, @"-Pro"]];
                    break;
                case GLBDeviceModelPadAir2:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", padModelBaseName, @"-Air2"]];
                case GLBDeviceModelPadAir1:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", padModelBaseName, @"-Air1"]];
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", padModelBaseName, @"-Air"]];
                    break;
                case GLBDeviceModelPadMini4:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", padModelBaseName, @"-Mini4"]];
                case GLBDeviceModelPadMini3:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", padModelBaseName, @"-Mini3"]];
                case GLBDeviceModelPadMini2:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", padModelBaseName, @"-Mini2"]];
                case GLBDeviceModelPadMini1:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", padModelBaseName, @"-Mini1"]];
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", padModelBaseName, @"-Mini"]];
                    break;
                case GLBDeviceModelPad4:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", padModelBaseName, @"-4"]];
                case GLBDeviceModelPad3:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", padModelBaseName, @"-3"]];
                case GLBDeviceModelPad2:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", padModelBaseName, @"-2"]];
                case GLBDeviceModelPad1:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", padModelBaseName, @"-1"]];
                    break;
                default:
                    break;
            }
            [nibNames addObject:padModelBaseName];
        }
        [nibNames addObject:name];
        
        NSString* existNibName = nil;
        for(NSString* nibName in nibNames) {
            if([fileManager fileExistsAtPath:[bundle pathForResource:nibName ofType:@"nib"]]) {
                existNibName = nibName;
                break;
            }
        }
        if(existNibName != nil) {
            nib = [self nibWithNibName:existNibName bundle:bundle];
        }
        if(nib != nil) {
            [self glb_setCacheForName:name nib:nib];
        }
    }
    return nib;
}

+ (UINib*)glb_nibWithClass:(Class)aClass bundle:(NSBundle*)bundle {
    NSString* name = nil;
    if([aClass conformsToProtocol:@protocol(GLBNibExtension)] == YES) {
        name = [aClass nibName];
        if(bundle == nil) {
            bundle = [aClass nibBundle];
        }
    }
    if(name == nil) {
        name = NSStringFromClass(aClass);
    }
    UINib* nib = [self glb_nibWithName:name bundle:bundle];
    if((nib == nil) && (aClass.superclass != nil)) {
        nib = [self glb_nibWithClass:aClass.superclass bundle:bundle];
    }
    return nib;
}

+ (void)glb_setCacheForName:(NSString*)name nib:(UINib*)nib {
    if(GLBNibCache == nil) {
        GLBNibCache = [NSMutableDictionary dictionary];
    }
    GLBNibCache[name] = nib;
}

+ (UINib*)glb_cacheNibForName:(NSString*)name {
    return GLBNibCache[name];
}

+ (UINib*)glb_cacheNibForClass:(Class)aClass {
    NSString* name = nil;
    if([aClass conformsToProtocol:@protocol(GLBNibExtension)] == YES) {
        name = [aClass nibName];
    }
    if(name == nil) {
        name = NSStringFromClass(aClass);
    }
    return [self glb_cacheNibForName:name];
}

+ (void)glb_removeCacheForName:(NSString*)name {
    [GLBNibCache removeObjectForKey:name];
}

- (id)glb_instantiateWithClass:(Class)aClass owner:(id)owner options:(NSDictionary*)options {
    NSArray* content = [self instantiateWithOwner:owner options:options];
    for(id item in content) {
        if([item isKindOfClass:aClass] == YES) {
            return item;
        }
    }
    return nil;
}

@end

/*--------------------------------------------------*/


@implementation UIResponder (GLBNib)

+ (UINib*)glb_nib {
    return [UINib glb_nibWithClass:self.class];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
