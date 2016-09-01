/*--------------------------------------------------*/

#import "UINib+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

static NSMutableDictionary< NSString*, UINib* >* GLBNibCache = nil;

/*--------------------------------------------------*/

@implementation UINib (GLB_UI)

+ (UINib*)glb_nibWithName:(NSString*)name bundle:(NSBundle*)bundle {
    UINib* nib = [self glb_cacheNibForName:name];
    if(nib == nil) {
        if(bundle == nil) {
            bundle = NSBundle.mainBundle;
        }
        NSMutableArray* nibNames = [NSMutableArray array];
        NSFileManager* fileManager = NSFileManager.defaultManager;
        if(UIDevice.glb_isIPhone) {
            NSString* modelBaseName = [NSString stringWithFormat:@"%@%@", name, @"-iPhone"];
            switch(UIDevice.glb_model) {
                case GLBDeviceModelPhone6Plus:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", modelBaseName, @"-6Plus"]];
                case GLBDeviceModelPhone6:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", modelBaseName, @"-6"]];
                case GLBDeviceModelPhone5S:
                case GLBDeviceModelPhone5C:
                case GLBDeviceModelPhone5:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", modelBaseName, @"-5"]];
                case GLBDeviceModelPhone4S:
                case GLBDeviceModelPhone4:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", modelBaseName, @"-4"]];
                case GLBDeviceModelPhone3GS:
                case GLBDeviceModelPhone3G:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", modelBaseName, @"-3"]];
                default:
                    break;
            }
            [nibNames addObject:modelBaseName];
        } else if(UIDevice.glb_isIPad) {
            NSString* modelBaseName = [NSString stringWithFormat:@"%@%@", name, @"-iPad"];
            switch(UIDevice.glb_model) {
                case GLBDeviceModelPadAir2:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", modelBaseName, @"-Air2"]];
                case GLBDeviceModelPadAir1:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", modelBaseName, @"-Air1"]];
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", modelBaseName, @"-Air"]];
                    break;
                case GLBDeviceModelPadMini3:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", modelBaseName, @"-Mini3"]];
                case GLBDeviceModelPadMini2:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", modelBaseName, @"-Mini2"]];
                case GLBDeviceModelPadMini1:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", modelBaseName, @"-Mini1"]];
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", modelBaseName, @"-Mini"]];
                    break;
                case GLBDeviceModelPad4:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", modelBaseName, @"-4"]];
                case GLBDeviceModelPad3:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", modelBaseName, @"-3"]];
                case GLBDeviceModelPad2:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", modelBaseName, @"-2"]];
                case GLBDeviceModelPad1:
                    [nibNames addObject:[NSString stringWithFormat:@"%@%@", modelBaseName, @"-1"]];
                    break;
                default:
                    break;
            }
            [nibNames addObject:modelBaseName];
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
    UINib* nib = [self glb_nibWithName:NSStringFromClass(aClass) bundle:bundle];
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
    return [self glb_cacheNibForName:NSStringFromClass(aClass)];
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
#endif
/*--------------------------------------------------*/
