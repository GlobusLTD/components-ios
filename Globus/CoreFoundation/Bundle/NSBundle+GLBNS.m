/*--------------------------------------------------*/

#import "NSBundle+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSBundle (GLB_NS)

+ (instancetype)glb_bundleWithName:(NSString*)name {
    return [self glb_bundleWithName:name rootBundle:NSBundle.mainBundle];
}

+ (instancetype)glb_bundleWithName:(NSString*)name rootBundle:(NSBundle*)rootBundle {
    NSString* path = [NSString stringWithFormat:@"%@/%@.bundle", rootBundle.bundlePath, name];
    return [NSBundle bundleWithPath:path];
}

+ (instancetype)glb_bundleWithClass:(Class)aClass {
    NSBundle* bundle = nil;
    while((bundle == nil) && (aClass != nil)) {
        bundle = [self glb_bundleWithName:NSStringFromClass(aClass)];
        aClass = aClass.superclass;
    }
    return bundle;
}

- (id)glb_objectForInfoDictionaryKey:(NSString*)key defaultValue:(id)defaultValue {
    id value = [self objectForInfoDictionaryKey:key];
    if(value == nil) {
        return defaultValue;
    }
    return value;
}

@end

/*--------------------------------------------------*/
